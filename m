From: Johannes Sixt <j6t@kdbg.org>
Subject: untracked symlinks are less precious than untracked files?
Date: Wed, 2 Feb 2011 20:25:05 +0100
Message-ID: <201102022025.06140.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 02 20:25:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkiKM-0003nL-60
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 20:25:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755096Ab1BBTZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Feb 2011 14:25:10 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:24612 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755079Ab1BBTZI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Feb 2011 14:25:08 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 95E6D130052
	for <git@vger.kernel.org>; Wed,  2 Feb 2011 20:25:06 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 5164019F6C2
	for <git@vger.kernel.org>; Wed,  2 Feb 2011 20:25:06 +0100 (CET)
User-Agent: KMail/1.9.10
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165927>

While I was poking around in t6035-merge-dir-to-symlink.sh, I noticed this:

diff --git a/t/t6035-merge-dir-to-symlink.sh b/t/t6035-merge-dir-to-symlink.sh
index 92e02d5..46b401b 100755
--- a/t/t6035-merge-dir-to-symlink.sh
+++ b/t/t6035-merge-dir-to-symlink.sh
@@ -5,21 +5,22 @@ test_description='merging when a directory was replaced with 
a symlink'
 
 test_expect_success SYMLINKS 'create a commit where dir a/b changed to 
symlink' '
 	mkdir -p a/b/c a/b-2/c &&
 	> a/b/c/d &&
 	> a/b-2/c/d &&
 	> a/x &&
 	git add -A &&
 	git commit -m base &&
 	git tag start &&
 	rm -rf a/b &&
-	ln -s b-2 a/b &&
+	# ln -s b-2 a/b &&
+	>a/b &&
 	git add -A &&
 	git commit -m "dir to symlink"
 '
 
 test_expect_success SYMLINKS 'keep a/b-2/c/d across checkout' '
 	git checkout HEAD^0 &&
 	git reset --hard master &&
 	git rm --cached a/b &&
 	git commit -m "untracked symlink remains" &&
 	 git checkout start^0 &&

With this change, where a symlink is replaced by a regular file, the 'git 
checkout start^0' fails. At this time, a/b is untracked. When it is a 
symlink, it is replaced by a directory. When it is a file, the test fails:

error: The following untracked working tree files would be overwritten by 
checkout:
        a/b

Is it by design that symlinks are less precious than files, or is it an 
oversight?

-- Hannes
