Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECFD220D0A
	for <e@80x24.org>; Wed, 31 May 2017 10:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751042AbdEaKmf (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 06:42:35 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:55386 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750912AbdEaKmd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 06:42:33 -0400
Received: from lindisfarne.localdomain ([92.22.34.189])
        by smtp.talktalk.net with SMTP
        id G154d4KIzcpskG15Dd2uBo; Wed, 31 May 2017 11:42:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1496227351; bh=d9FIXEPdbGiXevqOUP8WWbmfbnumli3IvT1usGj0ViU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=EpGoX+3ANVQW5BiZHmiB1tda8iIvKxFYWEKJA4S5pm32Hsb7VQJ7Ve5hBvjswBLwr
         3kWYDAsI2XpZT6kzh0zkgIwK9V4OTATKYxrGvnnrC16g+2b4DEwQV6AnfcGKMqOroK
         krB3WXmORF0bbmFCyMp/K45RTKk5mc/PVkgBValk=
X-Originating-IP: [92.22.34.189]
X-Spam: 0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=vjpdqwq13QoU7KiiDtdC/A==:117
 a=vjpdqwq13QoU7KiiDtdC/A==:17 a=evINK-nbAAAA:8 a=A1X0JdhQAAAA:8
 a=dgagaqHjV1splgjRBkMA:9 a=eaufEaEzfsujeFOS:21 a=G8l2dtZ3Ef9Js8V9:21
 a=RfR_gqz1fSpA9VikTjo0:22 a=Df3jFdWbhGDLdZNm0fyq:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 3/3] rebase: Add tests for console output with conflicting stash
Date:   Wed, 31 May 2017 11:42:13 +0100
Message-Id: <20170531104213.16944-4-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170531104213.16944-1-phillip.wood@talktalk.net>
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfLSUERm0rKSBZi0W1vBbl3oK73Iu1j3r6/E1E7SqZWU/xO0RzJAZgxJAFecoSXdlXt3ivrT2Mx+yN3uNqnWbne8tintOEumkRKq8RAKNHxjPHHiMo2gY
 JhM9rwY3mq7Hg3DgbNBIjtwuPsC0AtnUcHmLEF0GMr/gOVVs5DB21ENPU2j2JrzxzrC7vsIaPf8nk6ahzd3kZRFypxAXr30fViB0Bo+xIzsqYjuvXi6Hf9zp
 SV1gnSfe73XvnXR6MKtEsD9WphJyV110ub8TyJBDNFkYdP7AIbHqpFADFi28mgL9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Check that the console output is what we expect when restoring
autostashed changes fails.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3420-rebase-autostash.sh       | 10 +++++++++-
 t/t3420/expected-fail-am          |  8 ++++++++
 t/t3420/expected-fail-interactive |  6 ++++++
 t/t3420/expected-fail-merge       | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index 886be63c6d13e1ac4197a1b185659fb3d7d7eb26..4ff0d7aebd66b0ce091ceb11986b3928503c8c5f 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -148,7 +148,7 @@ testrebase() {
 		test_when_finished git branch -D rebased-feature-branch &&
 		echo dirty >file4 &&
 		git add file4 &&
-		git rebase$type unrelated-onto-branch &&
+		git rebase$type unrelated-onto-branch >tmp 2>&1 &&
 		test_path_is_missing $dotest &&
 		git reset --hard &&
 		grep unrelated file4 &&
@@ -157,6 +157,14 @@ testrebase() {
 		git stash pop &&
 		grep dirty file4
 	'
+
+	test_expect_success "rebase$type: check output with conflicting stash" '
+		suffix=${type#\ -} && suffix=${suffix:--am} &&
+		sed -f $TEST_DIRECTORY/t3420/remove-ids.sed tmp \
+			>actual-fail$suffix &&
+		test_cmp $TEST_DIRECTORY/t3420/expected-fail$suffix \
+			actual-fail$suffix
+	'
 }
 
 test_expect_success "rebase: fast-forward rebase" '
diff --git a/t/t3420/expected-fail-am b/t/t3420/expected-fail-am
new file mode 100644
index 0000000000000000000000000000000000000000..1d643fa2ef7e67f1ad1a49a02e81d2d6c66e6920
--- /dev/null
+++ b/t/t3420/expected-fail-am
@@ -0,0 +1,8 @@
+Created autostash: XXX
+HEAD is now at XXX third commit
+First, rewinding head to replay your work on top of it...
+Applying: second commit
+Applying: third commit
+Applying autostash resulted in conflicts.
+Your changes are safe in the stash.
+You can run "git stash pop" or "git stash drop" at any time.
diff --git a/t/t3420/expected-fail-interactive b/t/t3420/expected-fail-interactive
new file mode 100644
index 0000000000000000000000000000000000000000..9d1dd5264237e8f58e1960c6c0fb5b736df6f86d
--- /dev/null
+++ b/t/t3420/expected-fail-interactive
@@ -0,0 +1,6 @@
+Created autostash: XXX
+HEAD is now at XXX third commit
+Rebasing (1/2)\rRebasing (2/2)\rSuccessfully rebased and updated refs/heads/rebased-feature-branch.
+Applying autostash resulted in conflicts.
+Your changes are safe in the stash.
+You can run "git stash pop" or "git stash drop" at any time.
diff --git a/t/t3420/expected-fail-merge b/t/t3420/expected-fail-merge
new file mode 100644
index 0000000000000000000000000000000000000000..5dcb2ff3acdb93f55131d67ae227d231e097a2a2
--- /dev/null
+++ b/t/t3420/expected-fail-merge
@@ -0,0 +1,32 @@
+Created autostash: XXX
+HEAD is now at XXX third commit
+First, rewinding head to replay your work on top of it...
+Merging unrelated-onto-branch with HEAD~1
+Merging:
+XXX unrelated commit
+XXX second commit
+found 1 common ancestor:
+XXX initial commit
+[detached HEAD XXX] second commit
+ Author: A U Thor <author@example.com>
+ Date: Thu Apr 7 15:14:13 2005 -0700
+ 2 files changed, 2 insertions(+)
+ create mode 100644 file1
+ create mode 100644 file2
+Committed: 0001 second commit
+Merging unrelated-onto-branch with HEAD~0
+Merging:
+XXX second commit
+XXX third commit
+found 1 common ancestor:
+XXX second commit
+[detached HEAD XXX] third commit
+ Author: A U Thor <author@example.com>
+ Date: Thu Apr 7 15:15:13 2005 -0700
+ 1 file changed, 1 insertion(+)
+ create mode 100644 file3
+Committed: 0002 third commit
+All done.
+Applying autostash resulted in conflicts.
+Your changes are safe in the stash.
+You can run "git stash pop" or "git stash drop" at any time.
-- 
2.13.0

