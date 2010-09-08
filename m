From: Elijah Newren <newren@gmail.com>
Subject: [PATCH] merge-recursive: Small code cleanup
Date: Wed,  8 Sep 2010 01:21:22 -0600
Message-ID: <1283930482-10228-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 08 09:20:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtEwt-0000Cl-4b
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 09:20:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757999Ab0IHHT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Sep 2010 03:19:58 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63861 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757513Ab0IHHT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 03:19:57 -0400
Received: by gxk23 with SMTP id 23so2273536gxk.19
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 00:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=pqCVmkTXaIjwSmDEbx4fwzXzc7ZjdO2xr8KMYeBW5Cs=;
        b=TJjvBxjWpKhjgFlWhWAbLpiBzt6VqrZG7Rf5pTgu9v7MKG/KZuBOv2bhV9YnqsuCEa
         0NdYRmHxi3i9o9D716/LhA8z4+DXbhbOoTfTSu6Ore8HRorXejhOFVG/V6SdYSyUM7qN
         BSVnArzP3xkU92cmUvtACzoHZ5mWd99QBFy+U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=aMQu4JdSHGAruESX/7MDXrUtn9PJR1XJztNlo/w+8qV+R4dkOd1ZU8JXq1OgKmMt3M
         dzcVde+livKVr/+gEoILoLXWm7l+mDJyA0idK+AM7tvs92zBDjQTvwJSeXDsm3lsvjK1
         FcY8v+7dgpyteEL4gtIXWRxbdZO9iF81anZJU=
Received: by 10.100.231.16 with SMTP id d16mr741777anh.94.1283930396233;
        Wed, 08 Sep 2010 00:19:56 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id x19sm12956963anc.5.2010.09.08.00.19.53
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 08 Sep 2010 00:19:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.7.gf6a98
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155773>

process_renames() had a variable named "stage" and derived variables
src_other and dst_other whose purpose was not entirely clear to me.  Make
the name of stage slightly more descriptive and add a brief comment
explaining what is occurring.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
Was previously PATCH 2/3 from my "fix resolvable rename + D/F conflict
testcases" series, but I've pulled this patch out since it's not
strictly related.  Also, due to Ken Schalk's response, I've dropped
the piece of the patch he pointed out an issue in.  So now it's just a
smaller cleanup, that is now based on maint.

 merge-recursive.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index fb6aa4a..ba9cbab 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -924,15 +924,23 @@ static int process_renames(struct merge_options *o,
 			struct string_list_item *item;
 			/* we only use sha1 and mode of these */
 			struct diff_filespec src_other, dst_other;
-			int try_merge, stage = a_renames == renames1 ? 3: 2;
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
 
-			hashcpy(src_other.sha1, ren1->src_entry->stages[stage].sha);
-			src_other.mode = ren1->src_entry->stages[stage].mode;
-			hashcpy(dst_other.sha1, ren1->dst_entry->stages[stage].sha);
-			dst_other.mode = ren1->dst_entry->stages[stage].mode;
+			remove_file(o, 1, ren1_src, o->call_depth || renamed_stage == 2);
 
+			hashcpy(src_other.sha1, ren1->src_entry->stages[other_stage].sha);
+			src_other.mode = ren1->src_entry->stages[other_stage].mode;
+			hashcpy(dst_other.sha1, ren1->dst_entry->stages[other_stage].sha);
+			dst_other.mode = ren1->dst_entry->stages[other_stage].mode;
 			try_merge = 0;
 
 			if (string_list_has_string(&o->current_directory_set, ren1_dst)) {
-- 
1.7.2.3.7.gf6a98
