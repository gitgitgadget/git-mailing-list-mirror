From: Johan Herland <johan@herland.net>
Subject: Re: Why is "git tag --contains" so slow?
Date: Thu, 8 Jul 2010 16:35:25 +0200
Message-ID: <201007081635.25381.johan@herland.net>
References: <20100701121711.GF1333@thunk.org> <20100707174546.GA4979@coredump.intra.peff.net> <11D5771D-EB47-42E9-BCC3-69C8FE1999EC@MIT.EDU>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_tIeNMhUguoZaK1C"
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Will Palmer <wmpalmer@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Jul 08 16:36:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWsCx-0000fa-3q
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 16:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754922Ab0GHOfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 10:35:51 -0400
Received: from smtp.opera.com ([213.236.208.81]:55643 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754820Ab0GHOfu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 10:35:50 -0400
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o68EZPlO002276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 8 Jul 2010 14:35:36 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <11D5771D-EB47-42E9-BCC3-69C8FE1999EC@MIT.EDU>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150579>

--Boundary-00=_tIeNMhUguoZaK1C
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 08 July 2010, Theodore Tso wrote:
> On Jul 7, 2010, at 1:45 PM, Jeff King wrote:
> >     And of course it's just complex, and I tend to shy away from
> >     complexity when I can. The question to me comes back to (1)
> > above. Is massive clock skew a breakage that should produce a few
> > incorrect results, or is it something we should always handle?
>
> Going back to the question that kicked off this thread, I wonder if
> there is some way that cacheing could be used to speed up the all
> cases, or at lest the edge cases, without imposing as much latency as
> tracking the max skew?   i.e., some thing like gitk's gitk.cache
> file.  For bonus points, it could be a cache file that is used by
> both gitk and git tag --contains, git branch --contains, and git
> name-rev.
>
> Does that sound like reasonable idea?

Here's a quick-and-dirty POC which builds a mapping from commits to 
their children and stores it using git notes [1], and then uses that to 
implement 'git tag --contains <commit>' by traversing _forwards_ from 
<commit> and printing all tags we encounter along the way [2].


[1]: The attached "build_childnotes.py" script builds this mapping. 
Invoke as follows:

	git log --all --format="%H,%P" |
	./build_childnotes.py |
	git fast-import

[2]: The attached "git_tag_contains.py" script traverses the notes 
printing out tags along the way. Invoke it as follows:

	git_tag_contains.py <commit>

The second script is way too slow, and really needs to use "git 
cat-file --batch" to not fork a process for every commit in history...


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net

--Boundary-00=_tIeNMhUguoZaK1C
Content-Type: application/x-python;
  name="build_childnotes.py"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="build_childnotes.py"

#!/usr/bin/env python

import sys

child_map = {} # commit -> list of children

for line in sys.stdin:
	commit, parents = line.split(',', 1)
	parents = parents.split()
	for p in parents:
		child_map.setdefault(p, []).append(commit)

print """\
commit refs/notes/children
committer John Doe <johndoe@example.com> 0 +0000
data <<EOF
Build reverse mapping from commits to their children
EOF
"""

for commit, children in child_map.iteritems():
	print "N inline %s" % (commit)
	print "data <<EOF"
	for child in sorted(children):
		print child
	print "EOF"

--Boundary-00=_tIeNMhUguoZaK1C
Content-Type: application/x-python;
  name="git_tag_contains.py"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="git_tag_contains.py"

#!/usr/bin/env python

import sys
import subprocess

commit = subprocess.Popen(
	["git", "rev-parse", "--verify", sys.argv[1] + "^0"],
	stdout = subprocess.PIPE).communicate()[0].strip()

taglister = subprocess.Popen(
	["git", "show-ref", "--tags", "--dereference"],
	stdout = subprocess.PIPE)

rev_tags = {} # sha1 -> tag name

for tagline in taglister.stdout:
	sha1, tagname = tagline.split()
	if tagname.endswith("^{}"):
		tagname = tagname[:-3]
	rev_tags[sha1] = tagname

commits = [commit]
seen = set()

while commits:
	commit = commits.pop(0)
	if commit in seen:
		continue
	seen.add(commit)
	if commit in rev_tags:
		print rev_tags[commit]
	children = subprocess.Popen(
		["git", "notes", "--ref=children", "show", commit],
		stdout = subprocess.PIPE).communicate()[0].strip().split("\n")
	for c in children:
		commits.append(c)

--Boundary-00=_tIeNMhUguoZaK1C--
