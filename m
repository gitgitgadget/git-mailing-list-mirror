Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7A0F1F403
	for <e@80x24.org>; Mon, 11 Jun 2018 09:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932603AbeFKJqO (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 05:46:14 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:29454 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932375AbeFKJqN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 05:46:13 -0400
Received: from lindisfarne.localdomain ([92.22.39.132])
        by smtp.talktalk.net with SMTP
        id SJOnfoyaZoI6LSJOsf0cqF; Mon, 11 Jun 2018 10:46:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1528710371;
        bh=jPuHQ1dj4SrG9doyrBF5ro2wEtJdf1MJGPgzVuyIKeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=e+l6OEEOZ3P5G1iuiPW/27KaNI78TRy140ZWKXIegA1I04qabOk8wEUgl/Ox/ds9c
         /73lsB7YjJhNUaSy+3zcKiiwWi1P/ArFvXUs23la3UWvKg4xTJmvJZQfdBI5xb8kZ5
         bx9lKVKCN5ooJUJDJUWK9gv+X/LhFPQNpkiXgC5U=
X-Originating-IP: [92.22.39.132]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=AATg4WxWBR3MjRzlB3y0Ow==:117
 a=AATg4WxWBR3MjRzlB3y0Ow==:17 a=evINK-nbAAAA:8 a=uZvujYp8AAAA:8
 a=BuKuawrqAAAA:8 a=pGLkceISAAAA:8 a=GFyt6VsIdW5IA6qW_IUA:9
 a=psvcW0wbT93QcpVU:21 a=Ff-XBQ_a308CMb05:21 a=YC1BiALGhb4A:10
 a=RfR_gqz1fSpA9VikTjo0:22 a=SLzB8X_8jTLwj6mN0q5r:22 a=eKlGAUe3kD_U_C7IkE-G:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin Agren <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Oliver Joseph Ash <oliverjash@gmail.com>,
        Mahmoud Al-Qudsi <mqudsi@neosmart.net>,
        Jeff Felchner <jfelchner1@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2] add -p: fix counting empty context lines in edited patches
Date:   Mon, 11 Jun 2018 10:46:02 +0100
Message-Id: <20180611094602.17469-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180601174644.13055-1-phillip.wood@talktalk.net>
References: <20180601174644.13055-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfICARig7c5PujpbaJl+xDxr3JHsKpRAL6wgypg5MPZ+MtsXszoRvW+hczb7Y3+5LTneSPAW6j6/NRmxWth+g+0XJSWlr1e05ztvcyipV3XPmxMr3Td01
 RvWC5e5++iJ+9UqvLA9fYXYYOhnmwddG6p2KPJd2uzy3ow7gVFwbc1fRy8KfctMHAaj6XiKjI0w7MtT4pNaY1kdSRsodjzPPlxNR2pGIVybGRfi4PwUyhcrk
 WIK73sWdykGPTpGN7+P8dX8JfZTWcSroG9Gzqzzd/mUWuVrZGdKlhkULkLwwFzRL0XKELlrls8ClphNO6w1NGXqh0KCnEODFliGXJG2i5zoUHX8ao5UkSVbG
 vy4+ANkrV9OMw6JUyBl+ZUPh9orZhFzEbaUK+jBwyFul3QpfQirVpyWlex04wBQdfT+Daf+K
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

Fix the regression by counting lines that consist solely of a newline
as well as lines starting with a space as context lines and add a test
to prevent future regressions.

[1] http://pubs.opengroup.org/onlinepubs/9699919799/utilities/diff.html

Reported-by: Mahmoud Al-Qudsi <mqudsi@neosmart.net>
Reported-by: Oliver Joseph Ash <oliverjash@gmail.com>
Reported-by: Jeff Felchner <jfelchner1@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Thanks for the feedback, the only changes since v1 are to fix the
commit message to match what was in pu and to change '$_' to '$mode'
in the comparison as I think that is clearer. In the end I decided to
leave the tests as they are.

 git-add--interactive.perl  |  2 +-
 t/t3701-add-interactive.sh | 43 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index ab022ec073..8361ef45e7 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1047,7 +1047,7 @@ sub recount_edited_hunk {
 			$o_cnt++;
 		} elsif ($mode eq '+') {
 			$n_cnt++;
-		} elsif ($mode eq ' ') {
+		} elsif ($mode eq ' ' or $mode eq "\n") {
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

