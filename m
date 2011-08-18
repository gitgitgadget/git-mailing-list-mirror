From: Greg Troxel <gdt@ir.bbn.com>
Subject: update-index --index-info producing spurious submodule commits
Date: Thu, 18 Aug 2011 17:53:15 -0400
Message-ID: <rmivctuv12s.fsf@fnord.ir.bbn.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 00:00:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuAdG-0002Bv-QR
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 00:00:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754830Ab1HRWAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 18:00:07 -0400
Received: from fnord.ir.bbn.com ([192.1.100.210]:52413 "EHLO fnord.ir.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754823Ab1HRWAG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 18:00:06 -0400
X-Greylist: delayed 408 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Aug 2011 18:00:05 EDT
Received: by fnord.ir.bbn.com (Postfix, from userid 10853)
	id 044C65414; Thu, 18 Aug 2011 17:53:16 -0400 (EDT)
OpenPGP: id=32611E25
User-Agent: Gnus/5.110018 (No Gnus v0.18) Emacs/23.3 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179634>

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain


For reasons too complicated to go into, I have a repository B which has
essentially been cloned from A, and there has been vast amounts of work
on B (thousands of commits, many branches).   These changes have not
been merged back to A.  I want to merge them back, but there's a
directory foo that has changes in B that I can't release.

So, I ran filter-branch with an index filter

  found the merge base with A
  removed foo
  did ls-tree on foo from merge base
    and updated the index

The theory is to make each commit in B look like no changes to anything
under foo, and otherwise the same.

After doing this, Richard noticed that the root tree of commits had a
foo object, but that it was labeled a commit instead of a tree (but in
fact it is a tree).  He noticed because diffs looked like submodules.

I was able to produce a minimal test case, output below, script
attached.  The below output is with 1.7.5.4 on NetBSD/i386 (and /amd64).
1.7.6 (ubuntu/amd64) has the same problem.

So:

  Am I using "git update-index --index-info" wrong?

  Or is there a bug?

Thanks,
Greg

Notice that "cat-file -p HEAD:" shows a tree before, and a commit
afterwards:


+ git init
Initialized empty Git repository in /usr/home/gdt/GIT_TEST/.git/
+ mkdir foo
+ touch foo/bar
+ git add foo
+ git commit -minitial content
[master (root-commit) 6755919] initial content
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 foo/bar
+ git cat-file -p HEAD
tree 72d67e6de0599f72f1265c925316f91f78395787
author Greg Troxel <gdt@ir.bbn.com> 1313703545 -0400
committer Greg Troxel <gdt@ir.bbn.com> 1313703545 -0400

initial content
+ git cat-file -p HEAD:
040000 tree d87cbcba0e2ede0752bdafc5938da35546803ba5	foo
+ git rm -r foo
rm 'foo/bar'
+ git ls-tree HEAD foo
040000 tree d87cbcba0e2ede0752bdafc5938da35546803ba5	foo
+ git ls-tree HEAD foo
+ git update-index --index-info
+ git diff --staged
diff --git a/foo b/foo
new file mode 160000
index 0000000..d87cbcb
--- /dev/null
+++ b/foo
@@ -0,0 +1 @@
+Subproject commit d87cbcba0e2ede0752bdafc5938da35546803ba5
diff --git a/foo/bar b/foo/bar
deleted file mode 100644
index e69de29..0000000
+ git commit -mmunged foo
[master 3348447] munged foo
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 160000 foo
 delete mode 100644 foo/bar
+ git cat-file -p HEAD
tree 04fbd499dbd01afb3241d7f0af8171fde008bfe3
parent 6755919e289665ec46d270672d29b594f992fa03
author Greg Troxel <gdt@ir.bbn.com> 1313703545 -0400
committer Greg Troxel <gdt@ir.bbn.com> 1313703545 -0400

munged foo
+ git cat-file -p HEAD:
160000 commit d87cbcba0e2ede0752bdafc5938da35546803ba5	foo



--=-=-=
Content-Type: text/plain
Content-Disposition: attachment; filename=git-example

#!/bin/sh

if [ -d .git ]; then
   echo "existing .git"
   exit 1
fi

set -x

git init
mkdir foo
touch foo/bar
git add foo
git commit -m'initial content'
git cat-file -p HEAD
git cat-file -p HEAD:
git rm -r foo
git ls-tree HEAD foo
git ls-tree HEAD foo | git update-index --index-info
git diff --staged
git commit -m'munged foo'
git cat-file -p HEAD
git cat-file -p HEAD:

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iEYEARECAAYFAk5NicsACgkQ+vesoDJhHiVZCwCeJkm528jcdsVrttlvZdruDhf/
StkAnicEjD0GflbIJ1LnxAr+BMzBiHM+
=f1nw
-----END PGP SIGNATURE-----
--==-=-=--
