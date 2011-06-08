From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 48/48] merge-recursive: Fix working copy handling for rename/rename/add/add
Date: Wed,  8 Jun 2011 01:31:18 -0600
Message-ID: <1307518278-23814-49-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:31:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDEn-0006q0-F5
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755258Ab1FHHap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:30:45 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35036 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755233Ab1FHHab (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:30:31 -0400
Received: by mail-pw0-f46.google.com with SMTP id 15so118980pwi.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=s9eC1RpC1up3u0kvxH9G2PID2N+n7vTOdRISS0SW6S0=;
        b=O6sq+zjPk8008kr5rYyoUqWX5CeG3/SkdAoTHIwc02ExKKuJrDX/9sVbhDUDzZf6on
         AR2b/LuHWigRVT5+XuGndRWbLCRycEWTIFeywpqb13PMPTn84OVnBUo5mrYcwCNDPzDq
         9SxL3Ee4HtRs0U+TfHsyZbQ0xhzpIl3efhptU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YVkRaSDWFgJJqXVDo8L+KubB9TSJ3FlumhUG1QtUehX80JYBMcAB5ETYDslV4Qzq6r
         IfnXs7E9UgZ6d0C+ll8UDz77GM/4Dvt6+8e+ubOrybcXnuym43ngMoSDjyJUU4bYSVWG
         ddBiQIHtVJupMdrkYR/BC+TNexyLmsblwte9E=
Received: by 10.68.21.130 with SMTP id v2mr692801pbe.338.1307518231612;
        Wed, 08 Jun 2011 00:30:31 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.30.29
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:30:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175330>

If either side of a rename/rename(1to2) conflict is itself also involved
in a rename/add-dest conflict, then we need to make sure both the rename
and the added file appear in the working copy.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                    |   73 ++++++++++++++++++++++------------
 t/t6039-merge-rename-corner-cases.sh |   11 +++++-
 2 files changed, 58 insertions(+), 26 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 0cfc215..612a8cb 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1075,6 +1075,52 @@ static struct diff_filespec* filespec_from_entry(struct diff_filespec *target,
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
@@ -1082,10 +1128,6 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 	struct diff_filespec *one = ci->pair1->one;
 	struct diff_filespec *a = ci->pair1->two;
 	struct diff_filespec *b = ci->pair2->two;
-	const char *dst_name_a = a->path;
-	const char *dst_name_b = b->path;
-	char *del[2];
-	int delp = 0;
 
 	output(o, 1, "CONFLICT (rename/rename): "
 	       "Rename \"%s\"->\"%s\" in branch \"%s\" "
@@ -1093,16 +1135,6 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
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
@@ -1120,18 +1152,9 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
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
diff --git a/t/t6039-merge-rename-corner-cases.sh b/t/t6039-merge-rename-corner-cases.sh
index d2d93e7..9db1663 100755
--- a/t/t6039-merge-rename-corner-cases.sh
+++ b/t/t6039-merge-rename-corner-cases.sh
@@ -444,11 +444,20 @@ test_expect_success 'rename/rename/add-dest merge still knows about conflicting
 	test 5 -eq $(git ls-files -s | wc -l) &&
 	test 2 -eq $(git ls-files -u b | wc -l) &&
 	test 2 -eq $(git ls-files -u c | wc -l) &&
+	test 4 -eq $(git ls-files -o | wc -l) &&
 
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
 
 test_expect_success 'setup simple rename/rename (1to2) conflict' '
-- 
1.7.6.rc0.62.g2d69f
