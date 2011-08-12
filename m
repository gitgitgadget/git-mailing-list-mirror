From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 47/56] merge-recursive: Have conflict_rename_delete reuse modify/delete code
Date: Thu, 11 Aug 2011 23:20:20 -0600
Message-ID: <1313126429-17368-48-git-send-email-newren@gmail.com>
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
	id 1QrkD5-0005ix-At
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:23:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754467Ab1HLFWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:22:30 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:62901 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754381Ab1HLFWR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:22:17 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so834922iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=L9Z2gTsZQ7FN2m+ks04ipMGiQc8DA08z1lsLtsn5Dik=;
        b=NYfIbNDMG9+ib9QlpSJc2CQDtrzi6X2gF4CzqSPo2EK1IQBiEAuWVV/cjFuA3ruRKw
         DedTTJ4nMYaLmNOvp5bomcJSqaPMFTwDn2+nif7dhZCxCa1XHpC7ZOr8Ijr9O2zt6TlL
         kUFh8Ho075cRpVa4gKV+ByJhTvxnVy7uy7tEI=
Received: by 10.231.55.201 with SMTP id v9mr1169499ibg.16.1313126537396;
        Thu, 11 Aug 2011 22:22:17 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.22.15
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:22:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179204>

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
No changes since v1.

 merge-recursive.c |   48 +++++++++++++++++++++++++++++++-----------------
 1 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 17fe7c3..c89a5ce 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1039,24 +1039,38 @@ static void conflict_rename_delete(struct merge_options *o,
 				   const char *rename_branch,
 				   const char *other_branch)
 {
-	char *dest_name = pair->two->path;
-	int df_conflict = 0;
+	const struct diff_filespec *orig = pair->one;
+	const struct diff_filespec *dest = pair->two;
+	const char *path;
+	const unsigned char *a_sha = NULL;
+	const unsigned char *b_sha = NULL;
+	int a_mode = 0;
+	int b_mode = 0;
+
+	if (rename_branch == o->branch1) {
+		a_sha = dest->sha1;
+		a_mode = dest->mode;
+	} else {
+		b_sha = dest->sha1;
+		b_mode = dest->mode;
+	}
 
-	output(o, 1, "CONFLICT (rename/delete): Rename %s->%s in %s "
-	       "and deleted in %s",
-	       pair->one->path, pair->two->path, rename_branch,
-	       other_branch);
-	if (!o->call_depth)
-		update_stages(dest_name, NULL,
-			      rename_branch == o->branch1 ? pair->two : NULL,
-			      rename_branch == o->branch1 ? NULL : pair->two);
-	if (dir_in_way(dest_name, !o->call_depth)) {
-		dest_name = unique_path(o, dest_name, rename_branch);
-		df_conflict = 1;
+	if (o->call_depth) {
+		remove_file_from_cache(dest->path);
+		path = orig->path;
+	} else {
+		path = dest->path;
+		update_stages(dest->path, NULL,
+			      rename_branch == o->branch1 ? dest : NULL,
+			      rename_branch == o->branch1 ? NULL : dest);
 	}
-	update_file(o, 0, pair->two->sha1, pair->two->mode, dest_name);
-	if (df_conflict)
-		free(dest_name);
+
+	handle_change_delete(o,
+			     path,
+			     orig->sha1, orig->mode,
+			     a_sha, a_mode,
+			     b_sha, b_mode,
+			     "rename", "renamed");
 }
 
 static void conflict_rename_rename_1to2(struct merge_options *o,
-- 
1.7.6.100.gac5c1
