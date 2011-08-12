From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 49/56] merge-recursive: Fix working copy handling for rename/rename/add/add
Date: Thu, 11 Aug 2011 23:20:22 -0600
Message-ID: <1313126429-17368-50-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:23:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkD4-0005ix-Oj
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:23:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754458Ab1HLFW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:22:28 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:37921 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754377Ab1HLFWV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:22:21 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so837450iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=RbJf1v09Cgsk80Z7geszR1cYxyvUGDvo6vqL3TLnvkc=;
        b=N+B+J80YdyvB+sLdpnTqcC9DR59oyz7sFIBOQyqqqJpLPGqVM1CaFHClsIdFcQBVqg
         r19QNrquzL6LyhbDOlLA/3m+wTJXo4Y+cdEfyK3rKARh6ml4kD3p4LxpL1adTcVwy4Au
         02/VBi3+yC7LFR9aob1Hr7kVj2qHlzQGSGbt0=
Received: by 10.42.177.129 with SMTP id bi1mr565401icb.156.1313126541339;
        Thu, 11 Aug 2011 22:22:21 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.22.19
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:22:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179203>

If either side of a rename/rename(1to2) conflict is itself also involved
in a rename/add-dest conflict, then we need to make sure both the rename
and the added file appear in the working copy.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
No changes since v1.

 merge-recursive.c                    |   73 ++++++++++++++++++++++------------
 t/t6042-merge-rename-corner-cases.sh |   11 +++++-
 2 files changed, 58 insertions(+), 26 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 8ddd520..05c8aa0 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1086,6 +1086,52 @@ static struct diff_filespec *filespec_from_entry(struct diff_filespec *target,
 	return target;
 }
 
+static void handle_file(struct merge_options *o,
+			struct diff_filespec *rename,
+			int stage,
+			struct rename_conflict_info *ci)
+{
+	char *dst_name = rename->path;
+	struct stage_data *dst_entry;
+	const char *cur_branch, *other_branch;
+	struct diff_filespec other;
+	struct diff_filespec *add;
+
+	if (stage == 2) {
+		dst_entry = ci->dst_entry1;
+		cur_branch = ci->branch1;
+		other_branch = ci->branch2;
+	} else {
+		dst_entry = ci->dst_entry2;
+		cur_branch = ci->branch2;
+		other_branch = ci->branch1;
+	}
+
+	add = filespec_from_entry(&other, dst_entry, stage ^ 1);
+	if (stage == 2)
+		update_stages(rename->path, NULL, rename, add);
+	else
+		update_stages(rename->path, NULL, add, rename);
+
+	if (add) {
+		char *add_name = unique_path(o, rename->path, other_branch);
+		update_file(o, 0, add->sha1, add->mode, add_name);
+
+		remove_file(o, 0, rename->path, 0);
+		dst_name = unique_path(o, rename->path, cur_branch);
+	} else {
+		if (dir_in_way(rename->path, !o->call_depth)) {
+			dst_name = unique_path(o, rename->path, cur_branch);
+			output(o, 1, "%s is a directory in %s adding as %s instead",
+			       rename->path, other_branch, dst_name);
+		}
+	}
+	update_file(o, 0, rename->sha1, rename->mode, dst_name);
+
+	if (dst_name != rename->path)
+		free(dst_name);
+}
+
 static void conflict_rename_rename_1to2(struct merge_options *o,
 					struct rename_conflict_info *ci)
 {
@@ -1093,10 +1139,6 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 	struct diff_filespec *one = ci->pair1->one;
 	struct diff_filespec *a = ci->pair1->two;
 	struct diff_filespec *b = ci->pair2->two;
-	const char *dst_name_a = a->path;
-	const char *dst_name_b = b->path;
-	char *del[2];
-	int delp = 0;
 
 	output(o, 1, "CONFLICT (rename/rename): "
 	       "Rename \"%s\"->\"%s\" in branch \"%s\" "
@@ -1104,16 +1146,6 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 	       one->path, a->path, ci->branch1,
 	       one->path, b->path, ci->branch2,
 	       o->call_depth ? " (left unresolved)" : "");
-	if (dir_in_way(a->path, !o->call_depth)) {
-		dst_name_a = del[delp++] = unique_path(o, a->path, ci->branch1);
-		output(o, 1, "%s is a directory in %s adding as %s instead",
-		       a->path, ci->branch2, dst_name_a);
-	}
-	if (dir_in_way(b->path, !o->call_depth)) {
-		dst_name_b = del[delp++] = unique_path(o, b->path, ci->branch2);
-		output(o, 1, "%s is a directory in %s adding as %s instead",
-		       b->path, ci->branch1, dst_name_b);
-	}
 	if (o->call_depth) {
 		struct merge_file_info mfi;
 		mfi = merge_file(o, one->path,
@@ -1131,18 +1163,9 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 		remove_file_from_cache(a->path);
 		remove_file_from_cache(b->path);
 	} else {
-		struct diff_filespec other;
-		update_stages(a->path, NULL,
-			      a, filespec_from_entry(&other, ci->dst_entry1, 3));
-
-		update_stages(b->path, NULL,
-			      filespec_from_entry(&other, ci->dst_entry2, 2), b);
-
-		update_file(o, 0, a->sha1, a->mode, dst_name_a);
-		update_file(o, 0, b->sha1, b->mode, dst_name_b);
+		handle_file(o, a, 2, ci);
+		handle_file(o, b, 3, ci);
 	}
-	while (delp--)
-		free(del[delp]);
 }
 
 static void conflict_rename_rename_2to1(struct merge_options *o,
diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index 6875919..32591f9 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -558,12 +558,21 @@ test_expect_success 'rename/rename/add-dest merge still knows about conflicting
 	test 5 -eq $(git ls-files -s | wc -l) &&
 	test 2 -eq $(git ls-files -u b | wc -l) &&
 	test 2 -eq $(git ls-files -u c | wc -l) &&
+	test 4 -eq $(git ls-files -o | wc -l) &&
 
 	test $(git rev-parse :1:a) = $(git rev-parse A:a) &&
 	test $(git rev-parse :2:b) = $(git rev-parse C:b) &&
 	test $(git rev-parse :3:b) = $(git rev-parse B:b) &&
 	test $(git rev-parse :2:c) = $(git rev-parse C:c) &&
-	test $(git rev-parse :3:c) = $(git rev-parse B:c)
+	test $(git rev-parse :3:c) = $(git rev-parse B:c) &&
+
+	test $(git hash-object c~HEAD) = $(git rev-parse C:c) &&
+	test $(git hash-object c~B\^0) = $(git rev-parse B:c) &&
+	test $(git hash-object b~HEAD) = $(git rev-parse C:b) &&
+	test $(git hash-object b~B\^0) = $(git rev-parse B:b) &&
+
+	test ! -f b &&
+	test ! -f c
 '
 
 test_done
-- 
1.7.6.100.gac5c1
