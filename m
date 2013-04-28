From: Ilya Basin <basinilya@gmail.com>
Subject: [PATCH 2/3] git-svn-test: don't test for possible bug "Failed to strip path", try #2
Date: Mon, 29 Apr 2013 00:10:53 +0400
Message-ID: <488064812.20130429001053@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 8bit
Cc: Eric Wong <normalperson@yhbt.net>
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 28 22:12:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWXxc-0005Ib-Ox
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 22:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756563Ab3D1UMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Apr 2013 16:12:32 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:36195 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756344Ab3D1UMb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Apr 2013 16:12:31 -0400
Received: by mail-la0-f48.google.com with SMTP id eo20so4894766lab.35
        for <git@vger.kernel.org>; Sun, 28 Apr 2013 13:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:x-mailer:x-priority:message-id:to:cc:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=+wp9jN1SIFYZ37WrQcZtvtMUANpO675anj22Tq8GoN8=;
        b=AXEGe4ZsmGHt1ijryctk1I/wmotpfRGS4EobhU/2mZeFE9dZXGd6NKcWH+WsosQdAo
         AnbG1VIikKulRMTpxgQOXdCpEtN1zpz+qyNkP3l7CcDotAGxIKQzakUGmOfsFVXEL3aS
         GwsjOrSz5sy+iaHnh+U67ZOd+7aKIjsCk90PiQHe6MkAC4HDIaKS83Na0uQTO5uYL6x/
         Bw89fYflpBuL0kXRv9T4d2BqiGHrOh+90wBJ0IkydeZ4Qkg93JoAtY9aUlcnF8EciWb0
         aE+fw2xjZ55T8ztiENSWUIS9ojURZIcrq9Zhc+nwq++GfkjKlnt8UKAZGDFN5qAU+zl5
         kyeQ==
X-Received: by 10.112.134.70 with SMTP id pi6mr25443982lbb.72.1367179950196;
        Sun, 28 Apr 2013 13:12:30 -0700 (PDT)
Received: from [192.168.0.78] (92-100-235-219.dynamic.avangarddsl.ru. [92.100.235.219])
        by mx.google.com with ESMTPSA id r9sm5020647lbr.3.2013.04.28.13.12.28
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 28 Apr 2013 13:12:29 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222752>

In the previous commit a showcase was added to
t9160-git-svn-preserve-empty-dirs.sh for the "Failed to strip path" bug.
Now the flag --stdlayout should be enough.
---
 t/t9160-git-svn-preserve-empty-dirs.sh | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/t/t9160-git-svn-preserve-empty-dirs.sh b/t/t9160-git-svn-preserve-empty-dirs.sh
index 1b5a286..43b1852 100755
--- a/t/t9160-git-svn-preserve-empty-dirs.sh
+++ b/t/t9160-git-svn-preserve-empty-dirs.sh
@@ -51,21 +51,13 @@ test_expect_success 'initialize source svn repo containing empty dirs' '
 		echo "Conflict file" > 5/.placeholder &&
 		mkdir 6/.placeholder &&
 		svn_cmd add 5/.placeholder 6/.placeholder &&
-		svn_cmd commit -m "Placeholder Namespace conflict" &&
-
-		echo x > fil.txt &&
-		svn_cmd add fil.txt &&
-		svn_cmd commit -m "this commit should not kill git-svn"
+		svn_cmd commit -m "Placeholder Namespace conflict"
 	) &&
 	rm -rf "$SVN_TREE"
 '
 
 test_expect_success 'clone svn repo with --preserve-empty-dirs --stdlayout' '
-	git svn clone "$svnrepo" --preserve-empty-dirs --stdlayout "$GIT_REPO" || (
-		cd "$GIT_REPO"
-		git svn fetch # fetch the rest can succeed even if clone failed
-		false # this test still failed
-	)
+	git svn clone "$svnrepo" --preserve-empty-dirs --stdlayout "$GIT_REPO"
 '
 
 # "$GIT_REPO"/1 should only contain the placeholder file.
@@ -89,11 +81,11 @@ test_expect_success 'add entry to previously empty directory' '
 	test -f "$GIT_REPO"/4/a/b/c/foo
 '
 
-# The HEAD~3 commit should not have introduced .gitignore placeholder files.
+# The HEAD~2 commit should not have introduced .gitignore placeholder files.
 test_expect_success 'remove non-last entry from directory' '
 	(
 		cd "$GIT_REPO" &&
-		git checkout HEAD~3
+		git checkout HEAD~2
 	) &&
 	test_must_fail test -f "$GIT_REPO"/2/.gitignore &&
 	test_must_fail test -f "$GIT_REPO"/3/.gitignore
-- 
1.8.1.5
