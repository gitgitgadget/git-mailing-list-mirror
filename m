From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 20/56] merge-recursive: Remember to free generated unique path names
Date: Thu, 11 Aug 2011 23:19:53 -0600
Message-ID: <1313126429-17368-21-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:23:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkDA-0005ix-Ix
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753130Ab1HLFVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:21:18 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:62901 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495Ab1HLFVP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:21:15 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so834922iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=C14aR6lOo+wl4lhkTaKN2uHkeZbgP7IrVm5gqihNFEw=;
        b=WKl20TFP9afeckLw78rGXcM2hAncUX+hd4CsZU7uUFK4hQSpin6bv6ZbMt2WgmxbgI
         I43pZJcWeHXgSrBf4r1+YpF72gZzKyAtZpFf1AJm031CtmG2UzHScx8wdgpwsSsca1I8
         72V/LsiqRRA+3vD82yy+Y2EQBaVPOFISjVwgg=
Received: by 10.231.35.13 with SMTP id n13mr1081533ibd.57.1313126474708;
        Thu, 11 Aug 2011 22:21:14 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.21.12
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:21:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179213>

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
No changes since v1.

 merge-recursive.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 8a5c1a6..b5a8f17 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1063,7 +1063,6 @@ static int process_renames(struct merge_options *o,
 				   renamed: clean merge */
 				update_file(o, 1, ren1->pair->two->sha1, ren1->pair->two->mode, ren1_dst);
 			} else if (!sha_eq(dst_other.sha1, null_sha1)) {
-				const char *new_path;
 				clean_merge = 0;
 				try_merge = 1;
 				output(o, 1, "CONFLICT (rename/add): Rename %s->%s in %s. "
@@ -1092,9 +1091,10 @@ static int process_renames(struct merge_options *o,
 						    ren1_dst);
 					try_merge = 0;
 				} else {
-					new_path = unique_path(o, ren1_dst, branch2);
+					char *new_path = unique_path(o, ren1_dst, branch2);
 					output(o, 1, "Adding as %s instead", new_path);
 					update_file(o, 0, dst_other.sha1, dst_other.mode, new_path);
+					free(new_path);
 				}
 			} else if ((item = string_list_lookup(renames2Dst, ren1_dst))) {
 				ren2 = item->util;
@@ -1262,13 +1262,14 @@ static int merge_content(struct merge_options *o,
 	}
 
 	if (df_conflict_remains) {
-		const char *new_path;
+		char *new_path;
 		update_file_flags(o, mfi.sha, mfi.mode, path,
 				  o->call_depth || mfi.clean, 0);
 		new_path = unique_path(o, path, df_rename_conflict_branch);
 		mfi.clean = 0;
 		output(o, 1, "Adding as %s instead", new_path);
 		update_file_flags(o, mfi.sha, mfi.mode, new_path, 0, 1);
+		free(new_path);
 	} else {
 		update_file(o, mfi.clean, mfi.sha, mfi.mode, path);
 	}
@@ -1424,12 +1425,14 @@ static int process_df_entry(struct merge_options *o,
 		}
 	} else if (o_sha && (!a_sha || !b_sha)) {
 		/* Modify/delete; deleted side may have put a directory in the way */
-		const char *new_path = path;
-		if (lstat(path, &st) == 0 && S_ISDIR(st.st_mode))
-			new_path = unique_path(o, path, a_sha ? o->branch1 : o->branch2);
+		char *renamed = NULL;
+		if (lstat(path, &st) == 0 && S_ISDIR(st.st_mode)) {
+			renamed = unique_path(o, path, a_sha ? o->branch1 : o->branch2);
+		}
 		clean_merge = 0;
-		handle_delete_modify(o, path, new_path,
+		handle_delete_modify(o, path, renamed ? renamed : path,
 				     a_sha, a_mode, b_sha, b_mode);
+		free(renamed);
 	} else if (!o_sha && !!a_sha != !!b_sha) {
 		/* directory -> (directory, file) or <nothing> -> (directory, file) */
 		const char *add_branch;
@@ -1452,12 +1455,13 @@ static int process_df_entry(struct merge_options *o,
 			conf = "directory/file";
 		}
 		if (lstat(path, &st) == 0 && S_ISDIR(st.st_mode)) {
-			const char *new_path = unique_path(o, path, add_branch);
+			char *new_path = unique_path(o, path, add_branch);
 			clean_merge = 0;
 			output(o, 1, "CONFLICT (%s): There is a directory with name %s in %s. "
 			       "Adding %s as %s",
 			       conf, path, other_branch, path, new_path);
 			update_file(o, 0, sha, mode, new_path);
+			free(new_path);
 		} else {
 			output(o, 2, "Adding %s", path);
 			update_file(o, 1, sha, mode, path);
-- 
1.7.6.100.gac5c1
