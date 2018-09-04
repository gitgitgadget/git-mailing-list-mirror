Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E15C1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 13:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbeIDSSZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 14:18:25 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:32039 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbeIDSSZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 14:18:25 -0400
Received: from crinan.lan ([92.2.147.78])
        by smtp.talktalk.net with SMTP
        id xBlNfppstbZX5xBlVfFA3j; Tue, 04 Sep 2018 14:53:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1536069190;
        bh=imAfZQyK5bulN/Vl3lINIP0otpSNa7hJ0+PCJeSJv8E=;
        h=From:To:Cc:Subject:Date:Reply-To;
        b=B8TCbO3r8cu8Jlr51AsOAQGIJDp0A2G18II/L4BdDLYPIK6bnPZW6dy8qtkAghkd9
         UQKp435w3KuZG290r7UujnNDh1fFEFki4pLbqsMrcOL9UszXGydm+/GSaMPoLuPLPs
         07aeXngohkfq+ZQO6bPDh9zQsLfPk1tFpsHYSwmc=
X-Originating-IP: [92.2.147.78]
X-Spam: 0
X-OAuthority: v=2.3 cv=Poq9kTE3 c=1 sm=1 tr=0 a=pQayyGo/WMwZmys47m2ZwQ==:117
 a=pQayyGo/WMwZmys47m2ZwQ==:17 a=evINK-nbAAAA:8 a=X3cBoQ2DcMh1XEGe_koA:9
 a=iI17yWtujfi_hL3d:21 a=HaLx8tAPNoupuu5J:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH] diff: fix --color-moved-ws=allow-indentation-change
Date:   Tue,  4 Sep 2018 14:52:58 +0100
Message-Id: <20180904135258.31300-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.18.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfLbwsQpl/ckftLVbl96aua7SdsFr9xwreXWEf+tPMuDIJDqieatb3fQgDeDAFifXG3TtF9KB42+hrO/4vw9k6RsVd0/tAFkWTmz/gC7woZqU84a9RtdR
 StsJL1FbIHQcT+vCvycSi2oVRuTb8OkWwuDxopVEeGCvXC9TH11KRuBRfdHZv+WAYzX97NHxGLUqCNHBNsbr217YEGV0Ik83mqwKiSF5EdI4RWdAxjVxJ0oe
 T/LSh995KjzCi6KCNlAZYjZD0z0Uyzy+lQ9j9PIO/to=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If there is more than one potential moved block and the longest block
is not the first element of the array of potential blocks then the
block is cut short. With --color-moved=blocks this can leave moved
lines unpainted if the shortened block does not meet the block length
requirement. With --color-moved=zebra then in addition to the
unpainted lines the moved color can change in the middle of a single
block.

Fix this by freeing the whitespace delta of the match we're discarding
rather than the one we're keeping.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

While I was working on this I spotted a couple of other issues I don't
have time to fix myself at the moment, so I thought I mention them in
case someone else wants to pick them up

1) I think there is a potential memory leak at the end of
   mark_color_as_moved(). If pmb_nr > 0 then the whitespace deltas
   need freeing before freeing pmb itself.

2) The documentation could be improved to explain that
   allow-indentation-change does not work with indentation that
   contains a mix of tabs and spaces and the motivation for that
   (python?) [I've got some code to add an option that supports that
   which I'll post when I've written some tests after 2.19 is
   released]

 diff.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 145cfbae5..4e8f725bb 100644
--- a/diff.c
+++ b/diff.c
@@ -968,8 +968,13 @@ static void pmb_advance_or_null_multi_match(struct diff_options *o,
 			/* Carry the white space delta forward */
 			pmb[i]->next_line->wsd = pmb[i]->wsd;
 			pmb[i] = pmb[i]->next_line;
-		} else
+		} else {
+			if (pmb[i]->wsd) {
+				free(pmb[i]->wsd->string);
+				FREE_AND_NULL(pmb[i]->wsd);
+			}
 			pmb[i] = NULL;
+		}
 	}
 }
 
@@ -990,10 +995,6 @@ static int shrink_potential_moved_blocks(struct moved_entry **pmb,
 
 		if (lp < pmb_nr && rp > -1 && lp < rp) {
 			pmb[lp] = pmb[rp];
-			if (pmb[rp]->wsd) {
-				free(pmb[rp]->wsd->string);
-				FREE_AND_NULL(pmb[rp]->wsd);
-			}
 			pmb[rp] = NULL;
 			rp--;
 			lp++;
-- 
2.18.0

