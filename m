From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Strange O(N^3) behavior in "git filter-branch"
Date: Thu, 14 Jul 2011 11:24:57 +0200
Message-ID: <4E1EB5E9.1070902@alum.mit.edu>
References: <4E1E97C3.3030306@alum.mit.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090705090401060501070505"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 11:26:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhIAX-0002IP-Nu
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 11:25:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245Ab1GNJZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 05:25:01 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:39215 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521Ab1GNJZA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 05:25:00 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BE9C83.dip.t-dialin.net [84.190.156.131])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p6E9Ov1U022566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 14 Jul 2011 11:24:58 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <4E1E97C3.3030306@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177105>

This is a multi-part message in MIME format.
--------------090705090401060501070505
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 07/14/2011 09:16 AM, Michael Haggerty wrote:
> I have noticed that "git filter-branch" gets pathologically slow when it
> operates on a repository that has many references in a complicated
> directory hierarchy.  The time seems to go like O(N^3), where N is the
> number of references being rewritten.

Correction and new information...

Correction: The test script that I attached to the last email was
configured incorrectly.  [Note to self: thunderbird reads attached files
at the moment the email is *sent*, not the moment that the attachment is
added in the compose window.]  The corrected script is attached.

New information: Once I have "primed" a git repository using the
attached script, a command like the following takes about 90 ms:

    git rev-parse refs/heads/a4/b1/c0414^0

strace reveals that it is calling stat64() then lstat64() on every
directory and every file under .git/refs.  By contrast,

    git rev-parse refs/heads/a4/b1/c0414

goes more or less straight to the file
.git/refs/tags/refs/heads/a4/b1/c0414, and finishes in a few milliseconds.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/

--------------090705090401060501070505
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


N = 1000

#REF_STYLE = 'flat'
#REF_STYLE = 'subdir'
REF_STYLE = 'shard'

ACTION = 'filter'
#ACTION = 'add_refs'
#ACTION = 'move_refs'

PACK_REFS = True


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
    if REF_STYLE == 'flat':
        return 'refs/heads/b%s' % (name,)
    elif REF_STYLE == 'subdir':
        return 'refs/heads/a/b/c%s' % (name,)
    elif REF_STYLE == 'shard':
        return 'refs/heads/a%s/b%s/c%s' % (name[-1], name[-2], name,)


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
        if ACTION != 'filter':
            run(['git', 'update-ref', 'refs/tags/%04d' % (i,), 'HEAD'])
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

    if PACK_REFS:
        pack_refs()

    t = time.time()
    if ACTION == 'filter':
        filter()
    elif ACTION == 'add_refs':
        add_refs()
    elif ACTION == 'move_refs':
        move_refs()
    print 'time to process: %.3f s' % (time.time() - t,)


main(sys.argv[1:])


--------------090705090401060501070505--
