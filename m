From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH v2 1/3] stash bug: stash can lose data in a file removed from
 the index
Date: Sun, 18 Apr 2010 19:27:49 +0100
Message-ID: <20100418182749.GA29329@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 18 20:28:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3ZE6-0006w4-40
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 20:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555Ab0DRS2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 14:28:07 -0400
Received: from relay.pcl-ipout02.plus.net ([212.159.7.100]:37471 "EHLO
	relay.pcl-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752836Ab0DRS2G (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Apr 2010 14:28:06 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEANPrykvUnw4T/2dsb2JhbACbeXG4a4UQBA
Received: from pih-relay06.plus.net ([212.159.14.19])
  by relay.pcl-ipout02.plus.net with ESMTP; 18 Apr 2010 19:28:01 +0100
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay06.plus.net with esmtp (Exim) id 1O3ZDk-0007A3-Gq; Sun, 18 Apr 2010 19:28:01 +0100
Received: from charles by hashpling.plus.com with local (Exim 4.69)
	(envelope-from <charles@hashpling.org>)
	id 1O3ZDh-0007lB-9r; Sun, 18 Apr 2010 19:27:49 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-08-17)
X-Plusnet-Relay: 40641790b1fcd060d70438ecc4f450c5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145227>

If a file is removed from the index and then modified in the working
tree then stash will discard the working tree file with no way to
recover the changes.

This can might be done in one of a number of ways.

git rm file
vi file              # edit a new version
git stash

or with git mv

git mv file newfile
vi file              # make a new file with the old name
git stash

Signed-off-by: Charles Bailey <charles@hashpling.org>
---

Since the last version of this series I've added a number of new cases.
Some worked before but were broken by my last patch. Others highlighted
breakages that I was only in development.

The last two indicate problems that we have when trying to stash changes
where either a path changed from being a tracked directory to a file in
the work tree or was a tracked file and became a directory in the work
tree.

In both circumstances we can still permanently lose user data although
this patch series reduces the number of situations where this can
happen.

 t/t3903-stash.sh |  144 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 144 insertions(+), 0 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 476e5ec..bb026aa 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -228,4 +228,148 @@ test_expect_success 'stash --invalid-option' '
 	test bar,bar2 = $(cat file),$(cat file2)
 '
 
+test_expect_success 'stash rm then recreate' '
+	git reset --hard &&
+	git rm file &&
+	echo bar7 > file &&
+	git stash save "rm then recreate" &&
+	test bar = $(cat file) &&
+	git stash apply &&
+	test bar7 = $(cat file)
+'
+
+test_expect_success 'stash rm and ignore' '
+	git reset --hard &&
+	git rm file &&
+	echo file > .gitignore &&
+	git stash save "rm and ignore" &&
+	test bar = "$(cat file)" &&
+	test file = "$(cat .gitignore)"
+	git stash apply &&
+	! test -r file &&
+	test file = "$(cat .gitignore)"
+'
+
+test_expect_success 'stash rm and ignore (stage .gitignore)' '
+	git reset --hard &&
+	git rm file &&
+	echo file > .gitignore &&
+	git add .gitignore &&
+	git stash save "rm and ignore (stage .gitignore)" &&
+	test bar = "$(cat file)" &&
+	! test -r .gitignore
+	git stash apply &&
+	! test -r file &&
+	test file = "$(cat .gitignore)"
+'
+
+test_expect_success 'stash file to symlink' '
+	git reset --hard &&
+	rm file &&
+	ln -s file2 file &&
+	git stash save "file to symlink" &&
+	test -f file &&
+	test bar = "$(cat file)" &&
+	git stash apply &&
+	test -f file &&
+	test file2 = "$(readlink file)"
+'
+
+test_expect_success 'stash file to symlink (stage rm)' '
+	git reset --hard &&
+	git rm file &&
+	ln -s file2 file &&
+	git stash save "file to symlink (stage rm)" &&
+	test -f file &&
+	test bar = "$(cat file)" &&
+	git stash apply &&
+	test -f file &&
+	test file2 = "$(readlink file)"
+'
+
+test_expect_success 'stash file to symlink (full stage)' '
+	git reset --hard &&
+	rm file &&
+	ln -s file2 file &&
+	git add file &&
+	git stash save "file to symlink (full stage)" &&
+	test -f file &&
+	test bar = "$(cat file)" &&
+	git stash apply &&
+	test -f file &&
+	test file2 = "$(readlink file)"
+'
+
+# This test creates a commit with a symlink used for the following tests
+
+test_expect_success 'stash symlink to file' '
+	git reset --hard &&
+	ln -s file filelink &&
+	git add filelink &&
+	git commit -m "Add symlink" &&
+	rm filelink &&
+	cp file filelink &&
+	git stash save "symlink to file" &&
+	test -h filelink &&
+	test file = "$(readlink filelink)" &&
+	git stash apply &&
+	! test -h filelink &&
+	test bar = "$(cat file)"
+'
+
+test_expect_success 'stash symlink to file (stage rm)' '
+	git reset --hard &&
+	git rm filelink &&
+	cp file filelink &&
+	git stash save "symlink to file (stage rm)" &&
+	test -h filelink &&
+	test file = "$(readlink filelink)" &&
+	git stash apply &&
+	! test -h filelink &&
+	test bar = "$(cat file)"
+'
+
+test_expect_success 'stash symlink to file (full stage)' '
+	git reset --hard &&
+	rm filelink &&
+	cp file filelink &&
+	git add filelink &&
+	git stash save "symlink to file (full stage)" &&
+	test -h filelink &&
+	test file = "$(readlink filelink)" &&
+	git stash apply &&
+	! test -h filelink &&
+	test bar = "$(cat file)"
+'
+
+test_expect_failure 'stash directory to file' '
+	git reset --hard &&
+	mkdir dir &&
+	echo foo >dir/file &&
+	git add dir/file &&
+	git commit -m "Add file in dir" &&
+	rm dir/file &&
+	rmdir dir &&
+	echo bar >dir &&
+	git stash save "directory to file" &&
+	test -d dir &&
+	test foo = "$(cat dir/file)" &&
+	test_must_fail git stash apply &&
+	test bar = "$(cat dir)" &&
+	git reset --soft HEAD^
+'
+
+test_expect_failure 'stash file to directory' '
+	git reset --hard &&
+	rm file &&
+	mkdir file &&
+	echo foo >file/file &&
+	git stash save "file to directory" &&
+	test -f file &&
+	test bar = "$(cat file)" &&
+	git stash apply &&
+	test -f file/file &&
+	test foo = "$(cat file/file)"
+'
+
 test_done
-- 
1.7.1.rc1.241.g4e72f
