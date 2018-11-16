Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BCAE1F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 11:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeKPVQO (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 16:16:14 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:16377 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389395AbeKPVQH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 16:16:07 -0500
Received: from lindisfarne.localdomain ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id NbuxgXotudJAeNbv4gYs23; Fri, 16 Nov 2018 11:04:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1542366254;
        bh=eazfnetZH52KSFkQJUHL/5kvUmZ+NMraOfOj77keDmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=GQrVqT6LZ8Qobn0VGv48/c42fa5MTpUOKM30aIwszfiEMQ082fS2YmKzrcHdUhCcQ
         ZHJQ6Dbbd+m9dYLXsc6qL0u8fMVLre2cC5Jy1Q3fpGrK9HSmZBjIOrZbsTFa5Bsato
         r29PRs9AkBRQqT/zQfIE6kTf8UzyRTLu663ZBJGA=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=V8BTL9vi c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=evINK-nbAAAA:8 a=ioI-Af86GgaukeXSdK4A:9
 a=OQC4kkoGxv4seSed:21 a=W8cGizMelwwJeWFe:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v1 5/9] diff --color-moved-ws: fix false positives
Date:   Fri, 16 Nov 2018 11:03:52 +0000
Message-Id: <20181116110356.12311-6-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181116110356.12311-1-phillip.wood@talktalk.net>
References: <20180924100604.32208-1-phillip.wood@talktalk.net>
 <20181116110356.12311-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfL7V19BxUQEBYag32sT2sGWRZKebsYdbnJXvS/cr8UoW3Swculn5o6u/gJA0q/seu5fIGW2Q7yfxiCwk+XWKfG+g3eiyB2dR8zA5iYlPOaMbz1JPuU2+
 pves/nf+v3Efjt5lmBQ/lv823Bh58uB/LFj1Xz66VkZxTQo04dgRsMsZNooLwGe2LdQy6V+PMb9nT9eyct+MnXaQkmXAuy1LwvSLjZLil9p6lYqOx60sPjU3
 TEFLjXWZtEnCpNqTeZe2xA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

'diff --color-moved-ws=allow-indentation-change' can color lines as
moved when they are in fact different. For example in commit
1a07e59c3e ("Update messages in preparation for i18n", 2018-07-21) the
lines

-               die (_("must end with a color"));
+               die(_("must end with a color"));

are colored as moved even though they are different.

This is because if there is a fuzzy match for the first line of
a potential moved block the line is marked as moved before the
potential match is checked to see if it actually matches. The fix is
to delay marking the line as moved until after we have checked that
there really is at least one matching potential moved block.

Note that the test modified in the last commit still fails because
adding an unmoved line between two moved blocks that are already
separated by unmoved lines changes the color of the block following the
addition. This should not be the case and will be fixed in the next
commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index 9b9811988b..53a7ab5aca 100644
--- a/diff.c
+++ b/diff.c
@@ -1104,10 +1104,10 @@ static void mark_color_as_moved(struct diff_options *o,
 			continue;
 		}
 
-		l->flags |= DIFF_SYMBOL_MOVED_LINE;
-
-		if (o->color_moved == COLOR_MOVED_PLAIN)
+		if (o->color_moved == COLOR_MOVED_PLAIN) {
+			l->flags |= DIFF_SYMBOL_MOVED_LINE;
 			continue;
+		}
 
 		if (o->color_moved_ws_handling &
 		    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
@@ -1141,10 +1141,13 @@ static void mark_color_as_moved(struct diff_options *o,
 			block_length = 0;
 		}
 
-		block_length++;
+		if (pmb_nr) {
+			block_length++;
 
-		if (flipped_block && o->color_moved != COLOR_MOVED_BLOCKS)
-			l->flags |= DIFF_SYMBOL_MOVED_LINE_ALT;
+			l->flags |= DIFF_SYMBOL_MOVED_LINE;
+			if (flipped_block && o->color_moved != COLOR_MOVED_BLOCKS)
+				l->flags |= DIFF_SYMBOL_MOVED_LINE_ALT;
+		}
 	}
 	adjust_last_block(o, n, block_length);
 
-- 
2.19.1

