From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/3] merge-recursive: Small code cleanup
Date: Mon,  6 Sep 2010 14:47:49 -0600
Message-ID: <1283806070-22027-3-git-send-email-newren@gmail.com>
References: <AANLkTimz8qSwefp137-D+vEbsf6soG51u0im9EC911_O@mail.gmail.com>
Cc: gitster@pobox.com, oinksocket@letterboxes.org,
	ken.schalk@intel.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 22:46:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsiaM-00008F-Qx
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 22:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755354Ab0IFUqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 16:46:35 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50283 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755353Ab0IFUqd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 16:46:33 -0400
Received: by pwi3 with SMTP id 3so1173033pwi.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 13:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=yhxAaXD7k2cXORgJGbxEnZ7aMo1zf2vUsb+d+cCW+U4=;
        b=PskjP/qyNaWVz3bA2XwMPWU8wcpDz+NoaAWW+xoTEz6TI0SM/KO+/VTcVEHDBc3H4D
         OXYmrI5ZDyOZ/vmAjs0AZIDRqeEztYsKfnKAOQvt+LrTapJ6hXrmDcRyF9oPTXLPi033
         8UzIzmyC73v9Pz0rm7MZhjgT+nduL6sJO0SzY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WjLd+f/EqHNGuooa4H6UNRxLoOx1obmHqTIis6GrHDGM379dspRtSqqlM6gIPZbjvX
         CKY6jZ+4pCphzD2r82vJzo+vLP2y164QsmjfP8GviK2ER9W2PrrVhtNC3NQn/Wp3KtYf
         DURB5yTV2KfSpx/FxHL3IXxafysdXj8uSF65Y=
Received: by 10.114.24.15 with SMTP id 15mr4133560wax.122.1283805992831;
        Mon, 06 Sep 2010 13:46:32 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id d39sm11973876wam.4.2010.09.06.13.46.30
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 13:46:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc0.170.g5cfb0.dirty
In-Reply-To: <AANLkTimz8qSwefp137-D+vEbsf6soG51u0im9EC911_O@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155617>

process_renames() had a variable named "stage" and derived variables
src_other and dst_other whose purpose was not entirely clear to me.  Make
the name of stage slightly more descriptive and add a brief comment
explaining what is occurring.

Also, in d5af510 (RE: [PATCH] Avoid rename/add conflict when contents are
identical 2010-09-01), a separate if-block was added to provide a special
case for the rename/add conflict case that can be resolved (namely when
the contents on the destination side are identical).  However, as a
separate if block, it's not immediately obvious that its code is related to
the subsequent code checking for a rename/add conflict.  We can combine and
simplify the check slightly.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c |   34 ++++++++++++++++++++--------------
 1 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index c574698..5e2886a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -923,15 +923,26 @@ static int process_renames(struct merge_options *o,
 			/* Renamed in 1, maybe changed in 2 */
 			struct string_list_item *item;
 			/* we only use sha1 and mode of these */
-			struct diff_filespec src_other, dst_other;
-			int try_merge, stage = a_renames == renames1 ? 3: 2;
+			struct diff_filespec src_other, dst_other, dst_renamed;
+			int try_merge;
 
-			remove_file(o, 1, ren1_src, o->call_depth || stage == 3);
+			/*
+			 * unpack_trees loads entries from common-commit
+			 * into stage 1, from head-commit into stage 2, and
+			 * from merge-commit into stage 3.  We keep track
+			 * of which side corresponds to the rename.
+			 */
+			int renamed_stage = a_renames == renames1 ? 2 : 3;
+			int other_stage =   a_renames == renames1 ? 3 : 2;
+
+			remove_file(o, 1, ren1_src, o->call_depth || renamed_stage == 2);
 
-			hashcpy(src_other.sha1, ren1->src_entry->stages[stage].sha);
-			src_other.mode = ren1->src_entry->stages[stage].mode;
-			hashcpy(dst_other.sha1, ren1->dst_entry->stages[stage].sha);
-			dst_other.mode = ren1->dst_entry->stages[stage].mode;
+			hashcpy(src_other.sha1, ren1->src_entry->stages[other_stage].sha);
+			src_other.mode = ren1->src_entry->stages[other_stage].mode;
+			hashcpy(dst_other.sha1, ren1->dst_entry->stages[other_stage].sha);
+			dst_other.mode = ren1->dst_entry->stages[other_stage].mode;
+			hashcpy(dst_renamed.sha1, ren1->dst_entry->stages[renamed_stage].sha);
+			dst_renamed.mode = ren1->dst_entry->stages[renamed_stage].mode;
 
 			try_merge = 0;
 
@@ -955,13 +966,8 @@ static int process_renames(struct merge_options *o,
 							ren1->pair->two : NULL,
 							branch1 == o->branch1 ?
 							NULL : ren1->pair->two, 1);
-			} else if ((dst_other.mode == ren1->pair->two->mode) &&
-				   sha_eq(dst_other.sha1, ren1->pair->two->sha1)) {
-				/* Added file on the other side
-				   identical to the file being
-				   renamed: clean merge */
-				update_file(o, 1, ren1->pair->two->sha1, ren1->pair->two->mode, ren1_dst);
-			} else if (!sha_eq(dst_other.sha1, null_sha1)) {
+			} else if (!sha_eq(dst_other.sha1, null_sha1) &&
+				   !sha_eq(dst_other.sha1, dst_renamed.sha1)) {
 				const char *new_path;
 				clean_merge = 0;
 				try_merge = 1;
-- 
1.7.3.rc0.170.g5cfb0.dirty
