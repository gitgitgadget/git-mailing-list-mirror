From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 42/48] merge-recursive: Record more data needed for merging with dual renames
Date: Wed,  8 Jun 2011 01:31:12 -0600
Message-ID: <1307518278-23814-43-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:31:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDEj-0006q0-Mc
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755210Ab1FHHaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:30:22 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43667 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755180Ab1FHHaU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:30:20 -0400
Received: by mail-pz0-f46.google.com with SMTP id 9so118978pzk.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=ioRppcftpUt7bOC/lnNgEdyzeYGYrRsQzPElzZsNudg=;
        b=tYOn+av/l0/eXaIiMb2r0T8CS8B2vwNOdneNAX1TGP0+kssUkcVyOxyCBclq9OnlXU
         T6gCJ4x35u70QcY6ZWf70hWBXg1+dllExtPyFOiPXtwN6OFi5dd3BgP6MGrClcyN763f
         ZQjMQlcn5tFV10F9tzmBnjEOaN7vgYuTC7iys=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=czpxNUFX2InfzZ8glLxyNw/MHr8NWOgZoYUw1iq3ecuA0WQOmg3TOxXV3aXsnhoby8
         pRtRl3hS8QVjn16EJ8fmBP65mnMgAwbhcKGGxFrI1VChsNBWvqwGdeu9XWeqeVEdaejW
         i0k0oYbXnRsoLlUCfHSmSMnonwaiYO9oCuDXU=
Received: by 10.68.33.195 with SMTP id t3mr682890pbi.58.1307518219947;
        Wed, 08 Jun 2011 00:30:19 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.30.18
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:30:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175322>

When two different files are renamed to one, we need to be able to do
three-way merges for both of those files.  To do that, we need to record
the sha1sum of the (possibly modified) file on the unrenamed side.  Modify
setup_rename_conflict_info() to take this extra information and record it
when the rename_type is RENAME_TWO_FILES_TO_ONE.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c |   42 +++++++++++++++++++++++++++++++++++++++---
 1 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index dbc1dd3..fdf67a3 100644
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
@@ -1145,7 +1168,10 @@ static int process_renames(struct merge_options *o,
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
@@ -1169,7 +1195,11 @@ static int process_renames(struct merge_options *o,
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
@@ -1205,6 +1235,9 @@ static int process_renames(struct merge_options *o,
 							   branch1,
 							   branch2,
 							   ren1->dst_entry,
+							   NULL,
+							   o,
+							   NULL,
 							   NULL);
 			} else if ((dst_other.mode == ren1->pair->two->mode) &&
 				   sha_eq(dst_other.sha1, ren1->pair->two->sha1)) {
@@ -1256,6 +1289,9 @@ static int process_renames(struct merge_options *o,
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
1.7.6.rc0.62.g2d69f
