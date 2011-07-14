From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Strange O(N^3) behavior in "git filter-branch"
Date: Thu, 14 Jul 2011 09:16:19 +0200
Message-ID: <4E1E97C3.3030306@alum.mit.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010604000300040103000405"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 09:16:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhG9s-0002aT-Ls
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 09:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753507Ab1GNHQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 03:16:23 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:38566 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753366Ab1GNHQW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 03:16:22 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BE9C83.dip.t-dialin.net [84.190.156.131])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p6E7GJLl014646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 14 Jul 2011 09:16:20 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177103>

This is a multi-part message in MIME format.
--------------010604000300040103000405
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I have noticed that "git filter-branch" gets pathologically slow when it
operates on a repository that has many references in a complicated
directory hierarchy.  The time seems to go like O(N^3), where N is the
number of references being rewritten.

I have attached a Python program that I have been using to explore this
behavior.  It creates a simple linear history with hardly any content
but one reference to each commit, then runs "git-filter-branch" on all
branches using a trivial tree-filter.

The times were taken using the "maint" version of git on a notebook
computer with 4Gb of RAM running Linux 2.6.32.  The RAM usage never
seemed to expand unusually.

The part that slows down is the part near the end where it writes

    Ref 'foo' was rewritten
    Ref 'bar' was rewritten
    etc.

These lines come at ever-greater intervals and dominate the time for
running git-filter-branch for N more than 1000 or so.  The time taken
for each iteration of this loop increases quadratically, so the time for
the whole run goes like N^3.  The time that the Nth line appears goes
approximately like

    254.954 + 0.0195578*N + 3.38276e-05*N^2 + 3.45833e-08*N^3

; and the N^3 term starts to dominate around N=1000.  The 1000th step
takes about 270 ms.

To figure out where the time is going, I instrumented git-filter-branch
as shown below, and found the blocks between "1" and "2", "4b" and "5",
and "5" and 6" each take about 90 ms (and therefore almost all of the time).

The slowdown seems to depend crucially on having a complicated hierarchy
of references.  The bad case is lots of subdirectories, like

    refs/heads/a0/b0/c0000
    refs/heads/a1/b0/c0001
    refs/heads/a2/b0/c0002
    ...
    refs/heads/a9/b9/c0999

, where I have basically sharded the references based on their last two
digits.  (It is just as slow if the sharding is based on the most
significant digits.)

On the other hand, if the refs are all in one directory (even a
subdirectory) like

    refs/heads/a/b/c0000
    refs/heads/a/b/c0001
    ...
    refs/heads/a/b/c0999

, then the times go down dramatically, and appear to go from O(N^3) to
O(N^2) (though O(N^2) still seems too slow for this loop!).

If the "git pack-refs" is omitted before "git filter-branch", then the
times become considerably worse, though I have not done systematic tests
on this variation.

I tried to reproduce the slowdown in a simpler scenario using various
loops over "git update-ref", but have so far been unsuccessful.
However, I have also observed a serious slowdown in the context of
making lots of automated fixes to a git repository converted from
Subversion (involving lots of calls to git-update-ref).  The slowdown in
this case could be largely mitigated by running "git pack-refs"
periodically, so it seems that the slowdown is related to the number of
unpacked refs in complicated directory structures.  Unfortunately it
would not be trivial to insert "git pack-refs" in the "git
filter-branch" loop because the loop relies on the presence of unpacked
references to "avoid rewriting a ref twice".

Does anybody have an idea?

Michael

Instrumented git-filter-branch:
> while read ref
> do
> echo 0 @@@
> 	# avoid rewriting a ref twice
> 	test -f "$orig_namespace$ref" && continue
> 
> echo 1 @@@
> 	sha1=$(git rev-parse "$ref"^0)
> echo 2 @@@
> 	rewritten=$(map $sha1)
> 
> echo 3 @@@
> 	test $sha1 = "$rewritten" &&
> 		warn "WARNING: Ref '$ref' is unchanged" &&
> 		continue
> 
> echo 4 @@@
> 	case "$rewritten" in
> 	'')
> echo 4a @@@
> 		echo "Ref '$ref' was deleted"
> 		git update-ref -m "filter-branch: delete" -d "$ref" $sha1 ||
> 			die "Could not delete $ref"
> 	;;
> 	$_x40)
> echo 4b @@@
> 		echo "Ref '$ref' was rewritten"
> 		if ! git update-ref -m "filter-branch: rewrite" \
> 					"$ref" $rewritten $sha1 2>/dev/null; then
> 			if test $(git cat-file -t "$ref") = tag; then
> 				if test -z "$filter_tag_name"; then
> 					warn "WARNING: You said to rewrite tagged commits, but not the corresponding tag."
> 					warn "WARNING: Perhaps use '--tag-name-filter cat' to rewrite the tag."
> 				fi
> 			else
> 				die "Could not rewrite $ref"
> 			fi
> 		fi
> 	;;
> 	*)
> echo 4c @@@
> 		# NEEDSWORK: possibly add -Werror, making this an error
> 		warn "WARNING: '$ref' was rewritten into multiple commits:"
> 		warn "$rewritten"
> 		warn "WARNING: Ref '$ref' points to the first one now."
> 		rewritten=$(echo "$rewritten" | head -n 1)
> 		git update-ref -m "filter-branch: rewrite to first" \
> 				"$ref" $rewritten $sha1 ||
> 			die "Could not rewrite $ref"
> 	;;
> 	esac
> echo 5 @@@
> 	git update-ref -m "filter-branch: backup" "$orig_namespace$ref" $sha1 ||
> 		 exit
> echo 6 @@@
> done < "$tempdir"/heads

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/

--------------010604000300040103000405
Content-Type: text/plain;
 name="filter-time"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="filter-time"

#! /usr/bin/python

import sys
import os
import subprocess
import shutil
import time


GIT_REPO = '/tmp/git-time-test'
FILENAME1 = os.path.join(GIT_REPO, 'a.txt')
FILENAME2 = os.path.join(GIT_REPO, 'b.txt')


N = 3000


def run(*args, **kw):
    if True:
        sys.stderr.write('Running %s\n' % (repr(args),))
    subprocess.check_call(*args, cwd=GIT_REPO, **kw)


def get_refnames(*patterns):
    cmd = ['git', 'for-each-ref', '--format=%(refname)'] + list(patterns)
    if True:
        sys.stderr.write('Running %s\n' % (repr(cmd),))
    p = subprocess.Popen(
        cmd,
        stdout=subprocess.PIPE,
        cwd=GIT_REPO,
        )
    (out, err) = p.communicate()
    return [l.strip() for l in out.splitlines()]


def get_name(i):
    name = '%04d' % (i,)
    #return 'refs/heads/b%s' % (name,)
    return 'refs/heads/a/b/c%s' % (name,)
    #return 'refs/heads/a%s/b%s/c%s' % (name[-1], name[-2], name,)


def make_repo():
    if os.path.exists(GIT_REPO):
        shutil.rmtree(GIT_REPO)

    subprocess.check_call(['git', 'init', GIT_REPO])

    run(['git', 'config', 'user.name', 'Lou User'])
    run(['git', 'config', 'user.email', 'luser@example.com'])

    open(FILENAME1, 'w')
    run(['git', 'add', '-N', FILENAME1])

    for i in range(N):
        open(FILENAME1, 'w').write('%d\n' % (i,))
        run(['git', 'commit', '-a', '-m', 'Commit %d' % (i,)])
        #run(['git', 'update-ref', 'refs/tags/%04d' % (i,), 'HEAD'])
        run(['git', 'update-ref', get_name(i), 'HEAD'])


def pack_refs():
    run(['git', 'pack-refs', '--all', '--prune'])


def filter():
    run(['git', 'filter-branch', '--tree-filter', 'cp a.txt b.txt', '--', '--all'])


def add_refs():
    refnames = get_refnames('refs/tags')

    for refname in refnames:
        assert not refname.endswith('master')
        i = int(refname.rsplit('/', 1)[-1])
        new_refname = get_name(i)
        run(['git', 'update-ref', '-m', 'add ref', new_refname, refname])


def move_refs():
    refnames = get_refnames('refs/tags')

    for refname in refnames:
        assert not refname.endswith('master')
        i = int(refname.rsplit('/', 1)[-1])
        new_refname = get_name(N - 1 - i)
        run(['git', 'update-ref', '-m', 'move ref', new_refname, refname])


def main(args):
    make_repo()
    pack_refs()
    t = time.time()
    filter()
    #add_refs()
    #move_refs()
    print 'time to process: %.3f s' % (time.time() - t,)


main(sys.argv[1:])


--------------010604000300040103000405--
