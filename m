From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 43/56] merge-recursive: Record more data needed for merging with dual renames
Date: Thu, 11 Aug 2011 23:20:16 -0600
Message-ID: <1313126429-17368-44-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:22:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkCO-0005Kt-28
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991Ab1HLFWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:22:12 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39648 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116Ab1HLFWK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:22:10 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so835125iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=4TTutgoOQanmefLtcmL5maXnKg5a2WE8pNWBHyno28E=;
        b=U8g9uX5PaD6zCkbHmrBF+hYWoFdy2w/g2FLhT9ZgLkpKQEYD1Z7jp+ByZ1/xup9/b4
         pTZ//OQeJuoThF4c/nl2n44ObPN/zW7M6RXpAYhCvwU1/95giZnNSGeIEEuWXv4dFw2x
         XTSGXDFMat/soySbicmTE2PY9xAm1S/hMQMTk=
Received: by 10.231.12.201 with SMTP id y9mr1060625iby.61.1313126529906;
        Thu, 11 Aug 2011 22:22:09 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.22.08
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:22:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179199>

When two different files are renamed to one, we need to be able to do
three-way merges for both of those files.  To do that, we need to record
the sha1sum of the (possibly modified) file on the unrenamed side.  Modify
setup_rename_conflict_info() to take this extra information and record it
when the rename_type is RENAME_TWO_FILES_TO_ONE.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
No changes since v1.

 merge-recursive.c |   42 +++++++++++++++++++++++++++++++++++++++---
 1 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 77c2c41..63f3aa0 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -79,6 +79,8 @@ struct rename_conflict_info {
 	const char *branch2;
 	struct stage_data *dst_entry1;
 	struct stage_data *dst_entry2;
+	struct diff_filespec ren1_other;
+	struct diff_filespec ren2_other;
 };
 
 /*
@@ -100,7 +102,10 @@ static inline void setup_rename_conflict_info(enum rename_type rename_type,
 					      const char *branch1,
 					      const char *branch2,
 					      struct stage_data *dst_entry1,
-					      struct stage_data *dst_entry2)
+					      struct stage_data *dst_entry2,
+					      struct merge_options *o,
+					      struct stage_data *src_entry1,
+					      struct stage_data *src_entry2)
 {
 	struct rename_conflict_info *ci = xcalloc(1, sizeof(struct rename_conflict_info));
 	ci->rename_type = rename_type;
@@ -118,6 +123,24 @@ static inline void setup_rename_conflict_info(enum rename_type rename_type,
 		ci->pair2 = pair2;
 		dst_entry2->rename_conflict_info = ci;
 	}
+
+	if (rename_type == RENAME_TWO_FILES_TO_ONE) {
+		/*
+		 * For each rename, there could have been
+		 * modifications on the side of history where that
+		 * file was not renamed.
+		 */
+		int ostage1 = o->branch1 == branch1 ? 3 : 2;
+		int ostage2 = ostage1 ^ 1;
+
+		ci->ren1_other.path = pair1->one->path;
+		hashcpy(ci->ren1_other.sha1, src_entry1->stages[ostage1].sha);
+		ci->ren1_other.mode = src_entry1->stages[ostage1].mode;
+
+		ci->ren2_other.path = pair2->one->path;
+		hashcpy(ci->ren2_other.sha1, src_entry2->stages[ostage2].sha);
+		ci->ren2_other.mode = src_entry2->stages[ostage2].mode;
+	}
 }
 
 static int show(struct merge_options *o, int v)
@@ -1160,7 +1183,10 @@ static int process_renames(struct merge_options *o,
 						   branch1,
 						   branch2,
 						   ren1->dst_entry,
-						   ren2->dst_entry);
+						   ren2->dst_entry,
+						   o,
+						   NULL,
+						   NULL);
 		} else if ((lookup = string_list_lookup(renames2Dst, ren1_dst))) {
 			/* Two different files renamed to the same thing */
 			char *ren2_dst;
@@ -1184,7 +1210,11 @@ static int process_renames(struct merge_options *o,
 						   branch1,
 						   branch2,
 						   ren1->dst_entry,
-						   ren2->dst_entry);
+						   ren2->dst_entry,
+						   o,
+						   ren1->src_entry,
+						   ren2->src_entry);
+
 		} else {
 			/* Renamed in 1, maybe changed in 2 */
 			/* we only use sha1 and mode of these */
@@ -1220,6 +1250,9 @@ static int process_renames(struct merge_options *o,
 							   branch1,
 							   branch2,
 							   ren1->dst_entry,
+							   NULL,
+							   o,
+							   NULL,
 							   NULL);
 			} else if ((dst_other.mode == ren1->pair->two->mode) &&
 				   sha_eq(dst_other.sha1, ren1->pair->two->sha1)) {
@@ -1271,6 +1304,9 @@ static int process_renames(struct merge_options *o,
 							   branch1,
 							   NULL,
 							   ren1->dst_entry,
+							   NULL,
+							   o,
+							   NULL,
 							   NULL);
 			}
 		}
-- 
1.7.6.100.gac5c1
