From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 19/48] merge-recursive: Remember to free generated unique path names
Date: Wed,  8 Jun 2011 01:30:49 -0600
Message-ID: <1307518278-23814-20-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:30:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDDJ-0005pC-RB
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:30:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754896Ab1FHH3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:29:36 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:37577 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754732Ab1FHH3d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:29:33 -0400
Received: by mail-px0-f179.google.com with SMTP id 2so191910pxi.10
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=LAllFzx1rV+ASXkQZOnuw01w8M7FotJnw30vppg2vPA=;
        b=e/RFTmJIRwHYtTJHsclResxeTBalqDIp5Xqa2bivwmfqYJmIaClxfNDUbTKVfJua2K
         w6IUKPOAlyOyMYR4GUEopdzoIOuMxhtdU5NiU8RfAmXal6L+2O3iGCuVssbGc38iGQxO
         pXUJizxQm8V/To3ttizJ8xXFb56pvNEL6/9eQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=L8t9m4Xvtf+ovrpgXWFmPwMe6gdDidggtM+0FFBlqWqqPuJQgNvMO73XqC3nlSR4l2
         +y4V6hT857MjZnRZnyM4MXaxYoEcwwL0aFCOWiF7OqD4KX7UHPN+PU55t05LuxHBCiNP
         mQWBCV7iAt/4TuLM7r4n2ImVBf6+ds4QIJyWs=
Received: by 10.68.1.137 with SMTP id 9mr590346pbm.475.1307518173765;
        Wed, 08 Jun 2011 00:29:33 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.29.31
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:29:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175301>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c |   21 ++++++++++++++-------
 1 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 317bf23..45675b6 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1072,7 +1072,6 @@ static int process_renames(struct merge_options *o,
 				   renamed: clean merge */
 				update_file(o, 1, ren1->pair->two->sha1, ren1->pair->two->mode, ren1_dst);
 			} else if (!sha_eq(dst_other.sha1, null_sha1)) {
-				const char *new_path;
 				clean_merge = 0;
 				try_merge = 1;
 				output(o, 1, "CONFLICT (rename/add): Rename %s->%s in %s. "
@@ -1101,9 +1100,10 @@ static int process_renames(struct merge_options *o,
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
@@ -1271,13 +1271,14 @@ static int merge_content(struct merge_options *o,
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
@@ -1433,12 +1434,17 @@ static int process_df_entry(struct merge_options *o,
 		}
 	} else if (o_sha && (!a_sha || !b_sha)) {
 		/* Modify/delete; deleted side may have put a directory in the way */
-		const char *new_path = path;
-		if (lstat(path, &st) == 0 && S_ISDIR(st.st_mode))
+		char *new_path;
+		int free_me = 0;
+		if (lstat(path, &st) == 0 && S_ISDIR(st.st_mode)) {
 			new_path = unique_path(o, path, a_sha ? o->branch1 : o->branch2);
+			free_me = 1;
+		}
 		clean_merge = 0;
-		handle_delete_modify(o, path, new_path,
+		handle_delete_modify(o, path, free_me ? new_path : path,
 				     a_sha, a_mode, b_sha, b_mode);
+		if (free_me)
+			free(new_path);
 	} else if (!o_sha && !!a_sha != !!b_sha) {
 		/* directory -> (directory, file) or <nothing> -> (directory, file) */
 		const char *add_branch;
@@ -1461,12 +1467,13 @@ static int process_df_entry(struct merge_options *o,
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
1.7.6.rc0.62.g2d69f
