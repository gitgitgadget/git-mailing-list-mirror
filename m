From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/4] t4041 (diff-submodule-option): parse digests sensibly
Date: Tue, 27 Nov 2012 14:11:29 +0530
Message-ID: <1354005692-2809-2-git-send-email-artagnon@gmail.com>
References: <1354005692-2809-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 27 09:42:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdGk1-0007q6-Ux
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 09:42:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758355Ab2K0Ilp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 03:41:45 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:36624 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758334Ab2K0Ilo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 03:41:44 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so4142929dak.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 00:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=S7wEVO+kpZZSBEsK1BtCFCMqeo8c+GdO+HU7L5I7eAw=;
        b=ZTR+dHPq+KqZVqRsioxb5CjYLBNbx7wzKWvdVkJNvwP708ryJ7ROVYN3iIkngsOlCp
         651XaivazHhp0M14u8tI2xjmklpPmvxpAJKJHBycg62wT1vI9X1ejWUJLy/aoISykHEi
         0Z41ytWmZ4X6TKtNEwpoDaRVoBFBIduIrrvZrv4z8J8zE+9Iz8rPFRR0WOdJ4a1jiDpC
         GnehTx//Kgcg+fm0cLLGqv1ByX4zIFG3eY5hI1LNGllHq1Oinyr2Y2oyq9xV/f071tLG
         ie6nEhTYw+TyiN8CHvlbzeP9YvZ/sfQ5dVNuLh5VwX6IHLA8qhhad+De3mF493W93tKp
         0Fzw==
Received: by 10.66.73.132 with SMTP id l4mr40892216pav.48.1354005703747;
        Tue, 27 Nov 2012 00:41:43 -0800 (PST)
Received: from localhost.localdomain ([49.206.179.73])
        by mx.google.com with ESMTPS id vi9sm10284793pbc.41.2012.11.27.00.41.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Nov 2012 00:41:43 -0800 (PST)
X-Mailer: git-send-email 1.7.8.1.362.g5d6df.dirty
In-Reply-To: <1354005692-2809-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210545>

`git rev-list --max-count=1 HEAD` is a roundabout way of saying `git
rev-parse --verify HEAD`; replace a bunch of instances of the former
with the latter.  Also, don't unnecessarily `cut -c1-7` the rev-parse
output when the `--short` option is available.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t4041-diff-submodule-option.sh |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index 5377639..cfb71e5 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -21,7 +21,7 @@ add_file () {
 		test_tick &&
 		git commit -m "Add $name"
 	done >/dev/null
-	git rev-parse --verify HEAD | cut -c1-7
+	git rev-parse --short --verify HEAD
 	cd "$owd"
 }
 commit_file () {
@@ -33,7 +33,7 @@ test_create_repo sm1 &&
 add_file . foo >/dev/null
 
 head1=$(add_file sm1 foo1 foo2)
-fullhead1=$(cd sm1; git rev-list --max-count=1 $head1)
+fullhead1=$(cd sm1; git rev-parse --verify $head1)
 
 test_expect_success 'added submodule' "
 	git add sm1 &&
@@ -116,8 +116,8 @@ EOF
 	test_cmp expected actual
 "
 
-fullhead2=$(cd sm1; git rev-list --max-count=1 $head2)
 test_expect_success 'modified submodule(forward) --submodule=short' "
+fullhead2=$(cd sm1; git rev-parse --verify $head2)
 	git diff --submodule=short >actual &&
 	cat >expected <<-EOF &&
 diff --git a/sm1 b/sm1
@@ -135,7 +135,7 @@ commit_file sm1 &&
 head3=$(
 	cd sm1 &&
 	git reset --hard HEAD~2 >/dev/null &&
-	git rev-parse --verify HEAD | cut -c1-7
+	git rev-parse --short --verify HEAD
 )
 
 test_expect_success 'modified submodule(backward)' "
@@ -220,8 +220,8 @@ EOF
 rm -f sm1 &&
 test_create_repo sm1 &&
 head6=$(add_file sm1 foo6 foo7)
-fullhead6=$(cd sm1; git rev-list --max-count=1 $head6)
 test_expect_success 'nonexistent commit' "
+fullhead6=$(cd sm1; git rev-parse --verify $head6)
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 Submodule sm1 $head4...$head6 (commits not present)
@@ -318,8 +318,8 @@ EOF
 "
 
 (cd sm1; git commit -mchange foo6 >/dev/null) &&
-head8=$(cd sm1; git rev-parse --verify HEAD | cut -c1-7) &&
 test_expect_success 'submodule is modified' "
+head8=$(cd sm1; git rev-parse --short --verify HEAD) &&
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 Submodule sm1 $head6..$head8:
@@ -461,7 +461,7 @@ EOF
 	test_cmp expected actual
 "
 
-fullhead7=$(cd sm2; git rev-list --max-count=1 $head7)
+fullhead7=$(cd sm2; git rev-parse --verify $head7)
 
 test_expect_success 'given commit --submodule=short' "
 	git diff-index -p --submodule=short HEAD^ >actual &&
-- 
1.7.8.1.362.g5d6df.dirty
