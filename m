Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACB341F97E
	for <e@80x24.org>; Fri, 23 Nov 2018 11:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405324AbeKWWBG (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 17:01:06 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:48849 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403798AbeKWWBG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 17:01:06 -0500
Received: from lindisfarne.localdomain ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id Q9SMg52vNwhzSQ9SUg6d2A; Fri, 23 Nov 2018 11:17:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1542971835;
        bh=yYJ7Ahif/cowGZxPIoz0NM1X//R1L4BRC/xk6MBO3u4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=UMy9YnOksm4n1SMDdsHUDEMCKJZAqA992mfU0WUymcC/CdntLx71SA1YSes5mIYPS
         fl1eTBgo0z8aveeKh/9rvsoTd/48NZDOI+mXD9sOkQnbMf7e4ZfAOQiM/kfbGP0ogu
         7BrxKkALzUMpORcWIkVCukLDyNsT0rlV3ARH1Aw0=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=e8Iot5h/ c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=evINK-nbAAAA:8 a=ioI-Af86GgaukeXSdK4A:9
 a=OQC4kkoGxv4seSed:21 a=W8cGizMelwwJeWFe:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 5/9] diff --color-moved-ws: fix false positives
Date:   Fri, 23 Nov 2018 11:16:54 +0000
Message-Id: <20181123111658.30342-6-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123111658.30342-1-phillip.wood@talktalk.net>
References: <20180924100604.32208-1-phillip.wood@talktalk.net>
 <20181123111658.30342-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfLw6+WDxTp8qxFqLcqj34cyrgCelV8TkrFdlAif5g8XumnUanINE3wpFdT9fkfDpJokPXdyoaBQ2mWmwqmVvOYZt7ktweB/DHY47TGR8SquDw+oPa7+D
 ywMWZJYq4RhvKUvWhHPWqq3xlOpZPwGwEQ4hyA6vTVrtUNCeCOIGkxViGHBqcrmepLGq+ev5ko5v9MfuJoe+HLy+nICttJlE8bEDgROS2AUP2MO/A24WwOEe
 NZ9dviLtSjwEJb0rD5QhUHAgJVMwmKMEimR8FQN4pgzFwImQPswZ/HDj84aA3tHs
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
2.19.1.1690.g258b440b18

