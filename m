From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 44/56] merge-recursive: Create function for merging with branchname:file markers
Date: Thu, 11 Aug 2011 23:20:17 -0600
Message-ID: <1313126429-17368-45-git-send-email-newren@gmail.com>
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
	id 1QrkCO-0005Kt-KG
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754375Ab1HLFWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:22:16 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:62901 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754182Ab1HLFWM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:22:12 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so834922iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Fi41odmJTTjUEQ5jyo9/LdRCBtSAcSmGH4uS2a7af4I=;
        b=nbRzM2AIZTsR63Pcq8epAPz7Dwh17BSEaAMeT+DkSp8DZFyH5oDsbwQ42t+8dPTZwx
         M/tdhL38VtG4ckxjduk7kfBO5ysgkbcgiKSOIL5wMo8scjlPYhR4kGmsqf+XecGwC721
         +ISsr2S0m53NffTw6611nrreorKliAmuWYJ/c=
Received: by 10.42.163.71 with SMTP id b7mr495080icy.167.1313126531754;
        Thu, 11 Aug 2011 22:22:11 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.22.10
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:22:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179197>

We want to be able to reuse the code to do a three-way file content merge
and have the conflict markers use both branchname and filename.  Split it
out into a separate function.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
No changes since v1.

 merge-recursive.c |   42 +++++++++++++++++++++++++++++++++---------
 1 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 63f3aa0..390abea 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -944,6 +944,36 @@ static struct merge_file_info merge_file_1(struct merge_options *o,
 	return result;
 }
 
+static struct merge_file_info
+merge_file_special_markers(struct merge_options *o,
+			   const struct diff_filespec *one,
+			   const struct diff_filespec *a,
+			   const struct diff_filespec *b,
+			   const char *branch1,
+			   const char *filename1,
+			   const char *branch2,
+			   const char *filename2)
+{
+	char *side1 = NULL;
+	char *side2 = NULL;
+	struct merge_file_info mfi;
+
+	if (filename1) {
+		side1 = xmalloc(strlen(branch1) + strlen(filename1) + 2);
+		sprintf(side1, "%s:%s", branch1, filename1);
+	}
+	if (filename2) {
+		side2 = xmalloc(strlen(branch2) + strlen(filename2) + 2);
+		sprintf(side2, "%s:%s", branch2, filename2);
+	}
+
+	mfi = merge_file_1(o, one, a, b,
+			   side1 ? side1 : branch1, side2 ? side2 : branch2);
+	free(side1);
+	free(side2);
+	return mfi;
+}
+
 static struct merge_file_info merge_file(struct merge_options *o,
 					 const char *path,
 					 const unsigned char *o_sha, int o_mode,
@@ -1417,7 +1447,6 @@ static int merge_content(struct merge_options *o,
 			 struct rename_conflict_info *rename_conflict_info)
 {
 	const char *reason = "content";
-	char *side1 = NULL, *side2 = NULL;
 	const char *path1 = NULL, *path2 = NULL;
 	struct merge_file_info mfi;
 	struct diff_filespec one, a, b;
@@ -1447,18 +1476,13 @@ static int merge_content(struct merge_options *o,
 		path2 = (rename_conflict_info->pair2 ||
 			 o->branch2 == rename_conflict_info->branch1) ?
 			pair1->two->path : pair1->one->path;
-		side1 = xmalloc(strlen(o->branch1) + strlen(path1) + 2);
-		side2 = xmalloc(strlen(o->branch2) + strlen(path2) + 2);
-		sprintf(side1, "%s:%s", o->branch1, path1);
-		sprintf(side2, "%s:%s", o->branch2, path2);
 
 		if (dir_in_way(path, !o->call_depth))
 			df_conflict_remains = 1;
 	}
-	mfi = merge_file_1(o, &one, &a, &b,
-			   side1 ? side1 : o->branch1, side2 ? side2 : o->branch2);
-	free(side1);
-	free(side2);
+	mfi = merge_file_special_markers(o, &one, &a, &b,
+					 o->branch1, path1,
+					 o->branch2, path2);
 
 	if (mfi.clean && !df_conflict_remains &&
 	    sha_eq(mfi.sha, a_sha) && mfi.mode == a_mode) {
-- 
1.7.6.100.gac5c1
