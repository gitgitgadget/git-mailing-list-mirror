From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/7] rerere: scan $GIT_DIR/rr-cache/$ID when instantiating a rerere_id
Date: Mon, 14 Sep 2015 16:57:25 -0700
Message-ID: <1442275050-30497-3-git-send-email-gitster@pobox.com>
References: <1442275050-30497-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 01:57:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zbdd2-0006Ie-HG
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 01:57:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588AbbINX5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 19:57:40 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35931 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbbINX5e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 19:57:34 -0400
Received: by padhk3 with SMTP id hk3so157173172pad.3
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 16:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=bpEfD62X5fM/ZuwFzLeXFdmDvxPKsCUhW89UWdr5ifM=;
        b=D+eEVvHAYhW5A3JspCJK2gWc2OaFmO0P+iauQUybEx69exdOm/u52w1cMhTbzIfgLg
         Ktvf+5uoxidOFd2ygSu8u+yLtkVsVtkdc4k3DRYYhCQSV1E/3ai4t7hTH/dSLrOTzIh0
         4qxnkjlTKIF5P2VFtUj625ISPykuAd6v/D8MmCov7rlMeSWlS8yBlzMgEqiRsu+osNT9
         PESh5pCxQG1Xwo+ZDp2ZbvlHMp8Pc4eL72zf5RnEWGImNsn58IBm+XrXkAFxb0iPR7CI
         R8GZqDRLTD9sHuR7Pmy0bTGZEqjMHkxBFu819VGTq02vAHsgwX/Wk9cnlw83HJyczAdR
         BSMA==
X-Received: by 10.66.243.70 with SMTP id ww6mr40872882pac.88.1442275054486;
        Mon, 14 Sep 2015 16:57:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:1935:6a7f:d949:928e])
        by smtp.gmail.com with ESMTPSA id ki3sm18343853pbc.9.2015.09.14.16.57.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 14 Sep 2015 16:57:33 -0700 (PDT)
X-Mailer: git-send-email 2.6.0-rc2-164-gdcd5d00
In-Reply-To: <1442275050-30497-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277879>

This will help fixing bootstrap corner-case issues, e.g. having an
empty $GIT_DIR/rr-cache/$ID directory would fail to record a
preimage, in later changes in this series.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/rerere.c b/rerere.c
index a5d8a06..fbdade8 100644
--- a/rerere.c
+++ b/rerere.c
@@ -26,8 +26,11 @@ static char *merge_rr_path;
 static int rerere_dir_nr;
 static int rerere_dir_alloc;
 
+#define RR_HAS_POSTIMAGE 1
+#define RR_HAS_PREIMAGE 2
 static struct rerere_dir {
 	unsigned char sha1[20];
+	unsigned char status;
 } **rerere_dir;
 
 static void free_rerere_dirs(void)
@@ -58,6 +61,27 @@ const char *rerere_path(const struct rerere_id *id, const char *file)
 	return git_path("rr-cache/%s/%s", rerere_id_hex(id), file);
 }
 
+static int is_rr_file(const char *name, const char *filename)
+{
+	return !strcmp(name, filename);
+}
+
+static void scan_rerere_dir(struct rerere_dir *rr_dir)
+{
+	struct dirent *de;
+	DIR *dir = opendir(git_path("rr-cache/%s", sha1_to_hex(rr_dir->sha1)));
+
+	if (!dir)
+		return;
+	while ((de = readdir(dir)) != NULL) {
+		if (is_rr_file(de->d_name, "postimage"))
+			rr_dir->status |= RR_HAS_POSTIMAGE;
+		else if (is_rr_file(de->d_name, "preimage"))
+			rr_dir->status |= RR_HAS_PREIMAGE;
+	}
+	closedir(dir);
+}
+
 static const unsigned char *rerere_dir_sha1(size_t i, void *table)
 {
 	struct rerere_dir **rr_dir = table;
@@ -76,6 +100,7 @@ static struct rerere_dir *find_rerere_dir(const char *hex)
 	if (pos < 0) {
 		rr_dir = xmalloc(sizeof(*rr_dir));
 		hashcpy(rr_dir->sha1, sha1);
+		rr_dir->status = 0;
 		pos = -1 - pos;
 
 		/* Make sure the array is big enough ... */
@@ -85,15 +110,14 @@ static struct rerere_dir *find_rerere_dir(const char *hex)
 		memmove(rerere_dir + pos + 1, rerere_dir + pos,
 			(rerere_dir_nr - pos - 1) * sizeof(*rerere_dir));
 		rerere_dir[pos] = rr_dir;
+		scan_rerere_dir(rr_dir);
 	}
 	return rerere_dir[pos];
 }
 
 static int has_rerere_resolution(const struct rerere_id *id)
 {
-	struct stat st;
-
-	return !stat(rerere_path(id, "postimage"), &st);
+	return (id->collection->status & RR_HAS_POSTIMAGE);
 }
 
 static struct rerere_id *new_rerere_id_hex(char *hex)
@@ -737,6 +761,7 @@ static void do_rerere_one_path(struct string_list_item *rr_item,
 	} else if (!handle_file(path, NULL, NULL)) {
 		/* The user has resolved it. */
 		copy_file(rerere_path(id, "postimage"), path, 0666);
+		id->collection->status |= RR_HAS_POSTIMAGE;
 		fprintf(stderr, "Recorded resolution for '%s'.\n", path);
 	} else {
 		return;
@@ -797,6 +822,7 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 		 * normalized contents to the "preimage" file.
 		 */
 		handle_file(path, NULL, rerere_path(id, "preimage"));
+		id->collection->status |= RR_HAS_PREIMAGE;
 		fprintf(stderr, "Recorded preimage for '%s'\n", path);
 	}
 
-- 
2.6.0-rc2-164-gdcd5d00
