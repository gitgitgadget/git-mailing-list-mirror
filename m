From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 38/48] merge-recursive: Introduce a merge_file convenience function
Date: Wed,  8 Jun 2011 01:31:08 -0600
Message-ID: <1307518278-23814-39-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:31:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDEi-0006q0-Ju
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755189Ab1FHHaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:30:14 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35036 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755061Ab1FHHaM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:30:12 -0400
Received: by mail-pw0-f46.google.com with SMTP id 15so118980pwi.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=RKUTO738W8BCuVio7LnBT30f2NkW7xQ3RY0MoyEPPYI=;
        b=YWa21IE7NpLKCwCCATF5JsYKHuvBQkPSZguYwjqDZjeQpYf+zLvCUaeAvuJsfXK+nZ
         UJdV9KX6BjfS/v2Fyw+xnjilkpm95ow6i3CzEslF9Uukr4qtZFdMufTiNxHrwmYTpwY8
         eELLZZfbe5dREMs/b8tkdY8ARkNYaB0NHSZJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ih387gKdlZSX+l1HehENhWN6nZ3s5FDtojXeo5bqdFdTzEpGj3B0DJjvJK96ahYE6x
         LXZqp8V7GwxdncFY1RTW0mbZxAu0DB11ltmouQe/Jsoz1ZxU8vy4uERmmpyoFBIg/7XR
         8yrtR/Fwo92U0A8NxI1IXriYhfAlFSlrv1tX4=
Received: by 10.68.28.136 with SMTP id b8mr701730pbh.457.1307518212294;
        Wed, 08 Jun 2011 00:30:12 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.30.10
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:30:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175321>

merge_file previously required diff_filespec arguments, but all callers
only had sha1s and modes.  Rename merge_file to merge_file_1 and introduce
a new merge_file convenience function which takes the sha1s and modes and
creates the temporary diff_filespec variables needed to call merge_file_1.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c |   74 +++++++++++++++++++++++++++-------------------------
 1 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 5a70a87..3a364fa 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -831,12 +831,12 @@ static int merge_3way(struct merge_options *o,
 	return merge_status;
 }
 
-static struct merge_file_info merge_file(struct merge_options *o,
-					 const struct diff_filespec *one,
-					 const struct diff_filespec *a,
-					 const struct diff_filespec *b,
-					 const char *branch1,
-					 const char *branch2)
+static struct merge_file_info merge_file_1(struct merge_options *o,
+					   const struct diff_filespec *one,
+					   const struct diff_filespec *a,
+					   const struct diff_filespec *b,
+					   const char *branch1,
+					   const char *branch2)
 {
 	struct merge_file_info result;
 	result.merge = 0;
@@ -905,6 +905,26 @@ static struct merge_file_info merge_file(struct merge_options *o,
 	return result;
 }
 
+static struct merge_file_info merge_file(struct merge_options *o,
+					 const char *path,
+					 const unsigned char *o_sha, int o_mode,
+					 const unsigned char *a_sha, int a_mode,
+					 const unsigned char *b_sha, int b_mode,
+					 const char *branch1,
+					 const char *branch2)
+{
+	struct diff_filespec one, a, b;
+
+	one.path = a.path = b.path = (char*)path;
+	hashcpy(one.sha1, o_sha);
+	one.mode = o_mode;
+	hashcpy(a.sha1, a_sha);
+	a.mode = a_mode;
+	hashcpy(b.sha1, b_sha);
+	b.mode = b_mode;
+	return merge_file_1(o, &one, &a, &b, branch1, branch2);
+}
+
 static void conflict_rename_delete(struct merge_options *o,
 				   struct diff_filepair *pair,
 				   const char *rename_branch,
@@ -1002,16 +1022,10 @@ static void conflict_rename_rename_2to1(struct merge_options *o,
 	/* Two files were renamed to the same thing. */
 	if (o->call_depth) {
 		struct merge_file_info mfi;
-		struct diff_filespec one, a, b;
-
-		one.path = a.path = b.path = path;
-		hashcpy(one.sha1, null_sha1);
-		one.mode = 0;
-		hashcpy(a.sha1, ren1->pair->two->sha1);
-		a.mode = ren1->pair->two->mode;
-		hashcpy(b.sha1, ren2->pair->two->sha1);
-		b.mode = ren2->pair->two->mode;
-		mfi = merge_file(o, &one, &a, &b, branch1, branch2);
+		mfi = merge_file(o, path, null_sha1, 0,
+				 ren1->pair->two->sha1, ren1->pair->two->mode,
+				 ren2->pair->two->sha1, ren2->pair->two->mode,
+				 branch1, branch2);
 		output(o, 1, "Adding merged %s", path);
 		update_file(o, 0, mfi.sha, mfi.mode, path);
 	} else {
@@ -1198,24 +1212,12 @@ static int process_renames(struct merge_options *o,
 				       ren1_dst, branch2);
 				if (o->call_depth) {
 					struct merge_file_info mfi;
-					struct diff_filespec one, a, b;
-
-					one.path = a.path = b.path =
-						(char *)ren1_dst;
-					hashcpy(one.sha1, null_sha1);
-					one.mode = 0;
-					hashcpy(a.sha1, ren1->pair->two->sha1);
-					a.mode = ren1->pair->two->mode;
-					hashcpy(b.sha1, dst_other.sha1);
-					b.mode = dst_other.mode;
-					mfi = merge_file(o, &one, &a, &b,
-							 branch1,
-							 branch2);
+					mfi = merge_file(o, ren1_dst, null_sha1, 0,
+							 ren1->pair->two->sha1, ren1->pair->two->mode,
+							 dst_other.sha1, dst_other.mode,
+							 branch1, branch2);
 					output(o, 1, "Adding merged %s", ren1_dst);
-					update_file(o, 0,
-						    mfi.sha,
-						    mfi.mode,
-						    ren1_dst);
+					update_file(o, 0, mfi.sha, mfi.mode, ren1_dst);
 					try_merge = 0;
 				} else {
 					char *new_path = unique_path(o, ren1_dst, branch2);
@@ -1388,13 +1390,13 @@ static int merge_content(struct merge_options *o,
 		if (dir_in_way(path, !o->call_depth))
 			df_conflict_remains = 1;
 	}
-	mfi = merge_file(o, &one, &a, &b,
-			 side1 ? side1:o->branch1, side2 ? side2:o->branch2);
+	mfi = merge_file_1(o, &one, &a, &b,
+			   side1 ? side1:o->branch1, side2 ? side2:o->branch2);
 	free(side1);
 	free(side2);
 
 	if (mfi.clean && !df_conflict_remains &&
-	    sha_eq(mfi.sha, a_sha) && mfi.mode == a.mode &&
+	    sha_eq(mfi.sha, a_sha) && mfi.mode == a_mode &&
 	    was_tracked(path)) {
 		output(o, 3, "Skipped %s (merged same as existing)", path);
 		add_cacheinfo(mfi.mode, mfi.sha, path,
-- 
1.7.6.rc0.62.g2d69f
