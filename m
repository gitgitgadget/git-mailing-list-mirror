From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 39/56] merge-recursive: Introduce a merge_file convenience function
Date: Thu, 11 Aug 2011 23:20:12 -0600
Message-ID: <1313126429-17368-40-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:22:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkCN-0005Kt-GI
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754321Ab1HLFWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:22:11 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:62901 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754182Ab1HLFWD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:22:03 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so834922iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ziL8SP8cXVKGmC+oUFss5Jfljywls9bwe4S/bUNZrAs=;
        b=ApnZSugTfFBLQpv/PrvhnKHbLuihu2wqGmB9urJVuddfNBsr6S09WNbnNbOuJ75Ohm
         8DLxhvvhJuHyBvif6/MT1JY3uDvf+rsg/dtIrRFDnHbZPC22y6qzWN0pqANXFWXDwL7r
         VR0j/W3b2S9jsk0ZUxh42tV8+EP+8zSMqcn0k=
Received: by 10.42.132.10 with SMTP id b10mr567625ict.76.1313126522436;
        Thu, 11 Aug 2011 22:22:02 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.22.00
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:22:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179192>

merge_file previously required diff_filespec arguments, but all callers
only had sha1s and modes.  Rename merge_file to merge_file_1 and introduce
a new merge_file convenience function which takes the sha1s and modes and
creates the temporary diff_filespec variables needed to call merge_file_1.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
No changes since v1.

 merge-recursive.c |   72 +++++++++++++++++++++++++++-------------------------
 1 files changed, 37 insertions(+), 35 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index a0dc0bf..76a451c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -846,12 +846,12 @@ static int merge_3way(struct merge_options *o,
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
@@ -920,6 +920,26 @@ static struct merge_file_info merge_file(struct merge_options *o,
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
+	one.path = a.path = b.path = (char *)path;
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
@@ -1017,16 +1037,10 @@ static void conflict_rename_rename_2to1(struct merge_options *o,
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
@@ -1213,24 +1227,12 @@ static int process_renames(struct merge_options *o,
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
@@ -1408,8 +1410,8 @@ static int merge_content(struct merge_options *o,
 		if (dir_in_way(path, !o->call_depth))
 			df_conflict_remains = 1;
 	}
-	mfi = merge_file(o, &one, &a, &b,
-			 side1 ? side1 : o->branch1, side2 ? side2 : o->branch2);
+	mfi = merge_file_1(o, &one, &a, &b,
+			   side1 ? side1 : o->branch1, side2 ? side2 : o->branch2);
 	free(side1);
 	free(side2);
 
-- 
1.7.6.100.gac5c1
