Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E9E51FAE2
	for <e@80x24.org>; Mon,  5 Mar 2018 10:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933379AbeCEK5P (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 05:57:15 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:28014 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934421AbeCEK4p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 05:56:45 -0500
Received: from lindisfarne.localdomain ([92.22.16.137])
        by smtp.talktalk.net with SMTP
        id snnHeF8dCGrhCsnnPesOzn; Mon, 05 Mar 2018 10:56:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1520247403;
        bh=A7FHUp6J2AtnhPUaFxDMTPeRmINpfYLtBseTJMEX3OY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=lRwuxo5wAeQXezt8K2gq4BtjtU5qQhIgBjvW1rj3CPml80pFR8Oh7VLeo2NkfNme7
         TiwM0Ay1LL66kwoltj27HtTQtnyR8xbYAQNhl4kSjzOUIl2Tp8PgBEfQcfqpnt9U9z
         gGy81Sn9kfI988sh54XMLNZRI9hVg+aLG4T8KY6o=
X-Originating-IP: [92.22.16.137]
X-Spam: 0
X-OAuthority: v=2.3 cv=SORsqtnH c=1 sm=1 tr=0 a=nWy375ASyxHoIYnPohIYMA==:117
 a=nWy375ASyxHoIYnPohIYMA==:17 a=evINK-nbAAAA:8 a=jIkynP5I9sAo3PriuZ8A:9
 a=5_9UY9oGGU5zQeG0:21 a=DYTXFpXuwx9TLzfG:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 5/9] t3701: add failing test for pathological context lines
Date:   Mon,  5 Mar 2018 10:56:26 +0000
Message-Id: <20180305105630.14407-6-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180305105630.14407-1-phillip.wood@talktalk.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180305105630.14407-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfHvdS/u3qzIAn2FhxfLdMTZ1addBy7zr/qN/Rb2bTbaxRTz2Uy8cPgwXCCNKTngXR7sNuKJiqdMkTBpqBc9/SirXoVcA57PRYCe+uIS5jNzjy0e3OuBy
 0InUZ4NZ16NNMqEAovEZ/JSj/qAmt7lRiiv50Q81NALa1GNNfEPSb6/XyClecepeO+UgXAlEmgU/0rt/TOBqEZSZtFIwOVBstALp+3TgwfnR5/bGq02XtiSh
 OobO5fNb7WcBBu+AX1lFYjHg/X16AJyAlolDzC3Wr3HDQDgqEI54xoCSzi5a4Onw6hPo0ZzJGyeGkC4aWiRcdOwR9PTMfitAS74rjQr/PdA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When a hunk is skipped by add -i the offsets of subsequent hunks are
not adjusted to account for any missing insertions due to the skipped
hunk. Most of the time this does not matter as apply uses the context
lines to apply the subsequent hunks in the correct place, however in
pathological cases the context lines will match at the now incorrect
offset and the hunk will be applied in the wrong place. The offsets of
hunks following an edited hunk that has had the number of insertions
or deletions changed also need to be updated in the same way. Add
failing tests to demonstrate this.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    changes since v2:
     - removed test_set_editor as it is already set
    
    changes since v1:
     - changed edit test to use the existing fake editor and to strip
       the hunk header and some context lines as well as deleting an
       insertion
     - style fixes

 t/t3701-add-interactive.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index f95714230b..094eeca405 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -531,4 +531,34 @@ test_expect_success 'status ignores dirty submodules (except HEAD)' '
 	! grep dirty-otherwise output
 '
 
+test_expect_success 'set up pathological context' '
+	git reset --hard &&
+	test_write_lines a a a a a a a a a a a >a &&
+	git add a &&
+	git commit -m a &&
+	test_write_lines c b a a a a a a a b a a a a >a &&
+	test_write_lines     a a a a a a a b a a a a >expected-1 &&
+	test_write_lines   b a a a a a a a b a a a a >expected-2 &&
+	# check editing can cope with missing header and deleted context lines
+	# as well as changes to other lines
+	test_write_lines +b " a" >patch
+'
+
+test_expect_failure 'add -p works with pathological context lines' '
+	git reset &&
+	printf "%s\n" n y |
+	git add -p &&
+	git cat-file blob :a >actual &&
+	test_cmp expected-1 actual
+'
+
+test_expect_failure 'add -p patch editing works with pathological context lines' '
+	git reset &&
+	# n q q below is in case edit fails
+	printf "%s\n" e y    n q q |
+	git add -p &&
+	git cat-file blob :a >actual &&
+	test_cmp expected-2 actual
+'
+
 test_done
-- 
2.16.2

