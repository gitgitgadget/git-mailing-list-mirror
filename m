From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 40/48] merge-recursive: Small cleanups for conflict_rename_rename_1to2
Date: Wed,  8 Jun 2011 01:31:10 -0600
Message-ID: <1307518278-23814-41-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:31:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDEp-0006q0-31
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755299Ab1FHHa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:30:58 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:37577 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754733Ab1FHHaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:30:16 -0400
Received: by mail-px0-f179.google.com with SMTP id 2so191910pxi.10
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=Yj5K4lK6YR5Nyn1oMF8p6hEjN/S3Wls3WvekixiQ/OM=;
        b=kb4LOKqGka6t+cHtaP0wUyBoP23dVU3k39O8sa/aZYSvoEEkoOB4hDBoc5sIfWY4RU
         rmRKp/FhXI7lemUPM3eouCeTY5ONXpkXVlqLNqvcJstMks/wQytTGqyKK0r6guXgHc80
         CsJkO5vdV4PKcAAgL9m3uo/4KCkGdWuayBPhU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gj6d+MnAwBc0i/H8kXRzn8eiwg5BmjZgPt19Ldu3vUfckMeEeGwJI9a0SquhJrNHN9
         Wt/L6T7dxLAv04LEg4MuUKQNzivGcEsYVy94nNE0CfLBlrE+JcXkZyUgZGsg0Wd2+ias
         12h44YBRLsVIDzRMC2fS00ErsqLGQiiGj6388=
Received: by 10.68.35.99 with SMTP id g3mr600637pbj.53.1307518216024;
        Wed, 08 Jun 2011 00:30:16 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.30.14
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:30:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175331>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c |   60 +++++++++++++++++++++++-----------------------------
 1 files changed, 27 insertions(+), 33 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 576e02d..9c0daf5 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -951,58 +951,55 @@ static void conflict_rename_delete(struct merge_options *o,
 }
 
 static void conflict_rename_rename_1to2(struct merge_options *o,
-					struct diff_filepair *pair1,
-					const char *branch1,
-					struct diff_filepair *pair2,
-					const char *branch2)
+					struct rename_conflict_info *ci)
 {
 	/* One file was renamed in both branches, but to different names. */
+	struct diff_filespec *one = ci->pair1->one;
+	struct diff_filespec *a = ci->pair1->two;
+	struct diff_filespec *b = ci->pair2->two;
+	const char *dst_name_a = a->path;
+	const char *dst_name_b = b->path;
 	char *del[2];
 	int delp = 0;
-	const char *src      = pair1->one->path;
-	const char *ren1_dst = pair1->two->path;
-	const char *ren2_dst = pair2->two->path;
-	const char *dst_name1 = ren1_dst;
-	const char *dst_name2 = ren2_dst;
 
 	output(o, 1, "CONFLICT (rename/rename): "
 	       "Rename \"%s\"->\"%s\" in branch \"%s\" "
 	       "rename \"%s\"->\"%s\" in \"%s\"%s",
-	       src, pair1->two->path, branch1,
-	       src, pair2->two->path, branch2,
+	       one->path, a->path, ci->branch1,
+	       one->path, b->path, ci->branch2,
 	       o->call_depth ? " (left unresolved)" : "");
-	if (dir_in_way(ren1_dst, !o->call_depth)) {
-		dst_name1 = del[delp++] = unique_path(o, ren1_dst, branch1);
+	if (dir_in_way(a->path, !o->call_depth)) {
+		dst_name_a = del[delp++] = unique_path(o, a->path, ci->branch1);
 		output(o, 1, "%s is a directory in %s adding as %s instead",
-		       ren1_dst, branch2, dst_name1);
+		       a->path, ci->branch2, dst_name_a);
 	}
-	if (dir_in_way(ren2_dst, !o->call_depth)) {
-		dst_name2 = del[delp++] = unique_path(o, ren2_dst, branch2);
+	if (dir_in_way(b->path, !o->call_depth)) {
+		dst_name_b = del[delp++] = unique_path(o, b->path, ci->branch2);
 		output(o, 1, "%s is a directory in %s adding as %s instead",
-		       ren2_dst, branch1, dst_name2);
+		       b->path, ci->branch1, dst_name_b);
 	}
 	if (o->call_depth) {
 		struct merge_file_info mfi;
-		mfi = merge_file(o, src,
-				 pair1->one->sha1, pair1->one->mode,
-				 pair1->two->sha1, pair1->two->mode,
-				 pair2->two->sha1, pair2->two->mode,
-				 branch1, branch2);
+		mfi = merge_file(o, one->path,
+				 one->sha1, one->mode,
+				 a->sha1, a->mode,
+				 b->sha1, b->mode,
+				 ci->branch1, ci->branch2);
 		/*
 		 * FIXME: For rename/add-source conflicts (if we could detect
 		 * such), this is wrong.  We should instead find a unique
 		 * pathname and then either rename the add-source file to that
 		 * unique path, or use that unique path instead of src here.
 		 */
-		update_file(o, 0, mfi.sha, mfi.mode, src);
-		remove_file_from_cache(ren1_dst);
-		remove_file_from_cache(ren2_dst);
+		update_file(o, 0, mfi.sha, mfi.mode, one->path);
+		remove_file_from_cache(a->path);
+		remove_file_from_cache(b->path);
 	} else {
-		update_stages(ren1_dst, NULL, pair1->two, NULL);
-		update_stages(ren2_dst, NULL, NULL, pair2->two);
+		update_stages(a->path, NULL, a, NULL);
+		update_stages(b->path, NULL, NULL, b);
 
-		update_file(o, 0, pair1->two->sha1, pair1->two->mode, dst_name1);
-		update_file(o, 0, pair2->two->sha1, pair2->two->mode, dst_name2);
+		update_file(o, 0, a->sha1, a->mode, dst_name_a);
+		update_file(o, 0, b->sha1, b->mode, dst_name_b);
 	}
 	while (delp--)
 		free(del[delp]);
@@ -1476,10 +1473,7 @@ static int process_entry(struct merge_options *o,
 			break;
 		case RENAME_ONE_FILE_TO_TWO:
 			clean_merge = 0;
-			conflict_rename_rename_1to2(o, conflict_info->pair1,
-						    conflict_info->branch1,
-						    conflict_info->pair2,
-						    conflict_info->branch2);
+			conflict_rename_rename_1to2(o, conflict_info);
 			break;
 		default:
 			entry->processed = 0;
-- 
1.7.6.rc0.62.g2d69f
