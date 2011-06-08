From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 43/48] merge-recursive: Create function for merging with branchname:file markers
Date: Wed,  8 Jun 2011 01:31:13 -0600
Message-ID: <1307518278-23814-44-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:31:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDEo-0006q0-Ho
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755294Ab1FHHa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:30:57 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:37577 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755206Ab1FHHaW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:30:22 -0400
Received: by mail-px0-f179.google.com with SMTP id 2so191910pxi.10
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=LOk5MD4VXZdjjYEJWnlINOnqGqUf+ODY3zPMy4QupZc=;
        b=YBGxVkZ5b09yXoGzpCieFAkd6jeSXR+g3Tauj0KCXUI4DzvWUtmg3q6Vvm5hhEKIvq
         TIEnds1/71mmNVXJpQ+0YldRRwDGnNYVMXtKvk1VyjtZXsDSyJa3stac/D2mO2PeV7or
         cK5eCcwXAUbIbQvSoAmNXb90UzloUAW81136g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Q1cA1Y/rBub4bTYpYuhqlIcw9ax1zXSiZVkuJGOPsbPYmD5Bl0NjSql4P2D7ph0Lgo
         sGKH+KOvrmlat2D7OF5pOSmw7mmey5xn9GRXYtCb0Mxqkbvp9d8KCD7x+tDjpT1kbUBl
         XkYgtd9ZUyFRemxZ8u5Ef84xi1w0ZMdOH+FjU=
Received: by 10.68.30.137 with SMTP id s9mr581252pbh.146.1307518221815;
        Wed, 08 Jun 2011 00:30:21 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.30.20
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:30:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175329>

We want to be able to reuse the code to do a three-way file content merge
and have the conflict markers use both branchname and filename.  Split it
out into a separate function.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c |   51 ++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index fdf67a3..b8fd686 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -929,6 +929,36 @@ static struct merge_file_info merge_file_1(struct merge_options *o,
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
@@ -1405,7 +1435,7 @@ static int merge_content(struct merge_options *o,
 			 struct rename_conflict_info *rename_conflict_info)
 {
 	const char *reason = "content";
-	char *side1 = NULL, *side2 = NULL;
+	const char *path1 = NULL, *path2 = NULL;
 	struct merge_file_info mfi;
 	struct diff_filespec one, a, b;
 	unsigned df_conflict_remains = 0;
@@ -1423,22 +1453,17 @@ static int merge_content(struct merge_options *o,
 	b.mode = b_mode;
 
 	if (rename_conflict_info) {
-		const char *path1 = rename_conflict_info->pair2 ?
-				    rename_conflict_info->pair2->one->path : path;
-		const char *path2 = rename_conflict_info->pair1 ?
-				    rename_conflict_info->pair1->one->path : path;
-		side1 = xmalloc(strlen(o->branch1) + strlen(path1) + 2);
-		side2 = xmalloc(strlen(o->branch2) + strlen(path2) + 2);
-		sprintf(side1, "%s:%s", o->branch1, path1);
-		sprintf(side2, "%s:%s", o->branch2, path2);
+		path1 = rename_conflict_info->pair2 ?
+			rename_conflict_info->pair2->one->path : path;
+		path2 = rename_conflict_info->pair1 ?
+			rename_conflict_info->pair1->one->path : path;
 
 		if (dir_in_way(path, !o->call_depth))
 			df_conflict_remains = 1;
 	}
-	mfi = merge_file_1(o, &one, &a, &b,
-			   side1 ? side1:o->branch1, side2 ? side2:o->branch2);
-	free(side1);
-	free(side2);
+	mfi = merge_file_special_markers(o, &one, &a, &b,
+					 o->branch1, path1,
+					 o->branch2, path2);
 
 	if (mfi.clean && !df_conflict_remains &&
 	    sha_eq(mfi.sha, a_sha) && mfi.mode == a_mode &&
-- 
1.7.6.rc0.62.g2d69f
