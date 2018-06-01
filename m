Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA1D01F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 17:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752778AbeFARrW (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 13:47:22 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:56188 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbeFARrV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 13:47:21 -0400
Received: from lindisfarne.localdomain ([89.242.178.220])
        by smtp.talktalk.net with SMTP
        id Oo8mfOocWdJAeOo8vfelXe; Fri, 01 Jun 2018 18:47:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1527875238;
        bh=Hwxk1QnZ9L2fDn5ep8v3S2W+6PtxLgBPpceWw91kKF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=Z0sWKidn9Njhd4lazhLzmWSdImu/xm8k1phyAdV+gA6QKmMyaIMo89WU53lyepDBV
         BvX+CjVPwEJrW4EPfCJl1O1tTgZVbREkN4NAZGPtbn7OY8C1F7n0+SYP2LezjKRglT
         hlen2po6bV2UwG1tEivae6XqXAzGhHQRA46/dP0I=
X-Originating-IP: [89.242.178.220]
X-Spam: 0
X-OAuthority: v=2.3 cv=V8BTL9vi c=1 sm=1 tr=0 a=LWx0rg1LwuXQXhiU0uNpMw==:117
 a=LWx0rg1LwuXQXhiU0uNpMw==:17 a=evINK-nbAAAA:8 a=uZvujYp8AAAA:8
 a=BuKuawrqAAAA:8 a=pGLkceISAAAA:8 a=CrCOvEtbpGlt6ep1rTYA:9
 a=fhfomss7ogmtelvJ:21 a=jcB5WEOre97vdjv2:21 a=YC1BiALGhb4A:10
 a=RfR_gqz1fSpA9VikTjo0:22 a=SLzB8X_8jTLwj6mN0q5r:22 a=eKlGAUe3kD_U_C7IkE-G:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin Agren <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Oliver Joseph Ash <oliverjash@gmail.com>,
        Mahmoud Al-Qudsi <mqudsi@neosmart.net>,
        Jeff Felchner <jfelchner1@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH] add -p: fix counting empty context lines in edited patches
Date:   Fri,  1 Jun 2018 18:46:44 +0100
Message-Id: <20180601174644.13055-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <01010162c940b8bb-d8139971-3ee2-4cd6-bb19-35126d46753b-000000@us-west-2.amazonses.com>
References: <01010162c940b8bb-d8139971-3ee2-4cd6-bb19-35126d46753b-000000@us-west-2.amazonses.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfNCESaN+jQgqTn5VKlfgrPl2beGhjogQU830MQzthuo2uKLQZ8MHRz7mX98T25V2fKxhhvq/xbjdrj9UkW6+njzHLaiMVJLowGU7XnWAVzMU8NUMooXc
 lRlpVI5sfdqgAK7+CxH5l2H/bF9Q+dSvCTh7zXv9jPv2VuymmpoUVZ6lISDdCLDvMFuUM+UVTDwASNIIpW/+nVe7eB+qUlKojjEtO/YtqfnuOtkbBpfDECVm
 6iTbVl5Qj3firMfMceyLD/9rxaGAWXBEQtOt3k3KlEU2Uzux/w7KUa1BgLGqwye1KpzbnKb38kT07HTg1oM9ST8Btm9A+bTIR8JOjGLmz0cbM1ZmAbEUk5d5
 aVHmH69Nt67hnYBytNZhye6Gwj4K4vbJaFJsbebUKa1E4PhuDeA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

recount_edited_hunk() introduced in commit 2b8ea7f3c7 ("add -p:
calculate offset delta for edited patches", 2018-03-05) required all
context lines to start with a space, empty lines are not counted. This
was intended to avoid any recounting problems if the user had
introduced empty lines at the end when editing the patch. However this
introduced a regression into 'git add -p' as it seems it is common for
editors to strip the trailing whitespace from empty context lines when
patches are edited thereby introducing empty lines that should be
counted. 'git apply' knows how to deal with such empty lines and POSIX
states that whether or not there is an space on an empty context line
is implementation defined [1].

Fix the regression by counting lines consist solely of a newline as
well as lines starting with a space as context lines and add a test to
prevent future regressions.

[1] http://pubs.opengroup.org/onlinepubs/9699919799/utilities/diff.html

Reported-by: Mahmoud Al-Qudsi <mqudsi@neosmart.net>
Reported-by: Oliver Joseph Ash <oliverjash@gmail.com>
Reported-by: Jeff Felchner <jfelchner1@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
My apologies to everyone who was affected by this regression.

 git-add--interactive.perl  |  2 +-
 t/t3701-add-interactive.sh | 43 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index ab022ec073..bb6f249f03 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1047,7 +1047,7 @@ sub recount_edited_hunk {
 			$o_cnt++;
 		} elsif ($mode eq '+') {
 			$n_cnt++;
-		} elsif ($mode eq ' ') {
+		} elsif ($mode eq ' ' or $_ eq "\n") {
 			$o_cnt++;
 			$n_cnt++;
 		}
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index e5c66f7500..f1bb879ea4 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -175,6 +175,49 @@ test_expect_success 'real edit works' '
 	diff_cmp expected output
 '
 
+test_expect_success 'setup file' '
+	test_write_lines a "" b "" c >file &&
+	git add file &&
+	test_write_lines a "" d "" c >file
+'
+
+test_expect_success 'setup patch' '
+	SP=" " &&
+	NULL="" &&
+	cat >patch <<-EOF
+	@@ -1,4 +1,4 @@
+	 a
+	$NULL
+	-b
+	+f
+	$SP
+	c
+	EOF
+'
+
+test_expect_success 'setup expected' '
+	cat >expected <<-EOF
+	diff --git a/file b/file
+	index b5dd6c9..f910ae9 100644
+	--- a/file
+	+++ b/file
+	@@ -1,5 +1,5 @@
+	 a
+	$SP
+	-f
+	+d
+	$SP
+	 c
+	EOF
+'
+
+test_expect_success 'edit can strip spaces from empty context lines' '
+	test_write_lines e n q | git add -p 2>error &&
+	test_must_be_empty error &&
+	git diff >output &&
+	diff_cmp expected output
+'
+
 test_expect_success 'skip files similarly as commit -a' '
 	git reset &&
 	echo file >.gitignore &&
-- 
2.17.0

