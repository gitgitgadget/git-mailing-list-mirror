From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v2 3/5] diffcore-rename.c: move code around to prepare for
 the next patch
Date: Tue, 24 Sep 2013 11:52:53 +0200
Message-ID: <524160F5.9000103@gmail.com>
References: <522FAAC4.2080601@gmail.com> <52416058.90008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 24 11:53:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOPIh-0004G2-Gl
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 11:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753860Ab3IXJwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 05:52:55 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:58408 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487Ab3IXJwy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 05:52:54 -0400
Received: by mail-wi0-f171.google.com with SMTP id hm2so3503610wib.16
        for <git@vger.kernel.org>; Tue, 24 Sep 2013 02:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=mOjzGPJqCY09dCgieqxo1zGnClw3gXjT7LHAFYSRDY0=;
        b=QdIdVKkZoMRkCNkRfmRAjgehYBYyPDn31V71FdlShy9/Qdca9T3Uf7k/UYfSHOZB/E
         KtBmS3fGkJJEcsA/gmYanXwM2hLMqBhzfKRGYMKZsmYgB7xAypF6+J8BB8oBvcDbGAN9
         oANmQrndths9NUe71QZWHutY6KdBJxDnYD1PFHC6GDlvWeWKS1c3V83yKI3C8VSKThGq
         6EFbb2/Zjs3JzZ5wPirK8DgobiKAe2MQrJN6c8WTKA7RZhkO3R3L/iwW1FtA27G3aGdq
         JBS+pB15yhwT79GfZbsfU5YjJtXVr45+K+iS5UqiX3bf4E6dG7Ee/BywyQuBtCaK66/a
         njww==
X-Received: by 10.180.76.48 with SMTP id h16mr17370746wiw.32.1380016373194;
        Tue, 24 Sep 2013 02:52:53 -0700 (PDT)
Received: from [10.1.100.51] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id q5sm5831629wiz.3.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 24 Sep 2013 02:52:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <52416058.90008@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235293>

No actual code changes, just move hash_filespec up and outdent part of
find_identical_files.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 diffcore-rename.c | 98 +++++++++++++++++++++++++++----------------------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 6c7a72f..008a60c 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -248,6 +248,18 @@ struct file_similarity {
 	struct file_similarity *next;
 };
 
+static unsigned int hash_filespec(struct diff_filespec *filespec)
+{
+	unsigned int hash;
+	if (!filespec->sha1_valid) {
+		if (diff_populate_filespec(filespec, 0))
+			return 0;
+		hash_sha1_file(filespec->data, filespec->size, "blob", filespec->sha1);
+	}
+	memcpy(&hash, filespec->sha1, sizeof(hash));
+	return hash;
+}
+
 static int find_identical_files(struct file_similarity *src,
 				struct file_similarity *dst,
 				struct diff_options *options)
@@ -258,46 +270,46 @@ static int find_identical_files(struct file_similarity *src,
 	 * Walk over all the destinations ...
 	 */
 	do {
-		struct diff_filespec *target = dst->filespec;
-		struct file_similarity *p, *best;
-		int i = 100, best_score = -1;
-
-		/*
-		 * .. to find the best source match
-		 */
-		best = NULL;
-		for (p = src; p; p = p->next) {
-			int score;
-			struct diff_filespec *source = p->filespec;
-
-			/* False hash collision? */
-			if (hashcmp(source->sha1, target->sha1))
-				continue;
-			/* Non-regular files? If so, the modes must match! */
-			if (!S_ISREG(source->mode) || !S_ISREG(target->mode)) {
-				if (source->mode != target->mode)
-					continue;
-			}
-			/* Give higher scores to sources that haven't been used already */
-			score = !source->rename_used;
-			if (source->rename_used && options->detect_rename != DIFF_DETECT_COPY)
-				continue;
-			score += basename_same(source, target);
-			if (score > best_score) {
-				best = p;
-				best_score = score;
-				if (score == 2)
-					break;
-			}
+	struct diff_filespec *target = dst->filespec;
+	struct file_similarity *p, *best;
+	int i = 100, best_score = -1;
 
-			/* Too many identical alternatives? Pick one */
-			if (!--i)
-				break;
+	/*
+	 * .. to find the best source match
+	 */
+	best = NULL;
+	for (p = src; p; p = p->next) {
+		int score;
+		struct diff_filespec *source = p->filespec;
+
+		/* False hash collision? */
+		if (hashcmp(source->sha1, target->sha1))
+			continue;
+		/* Non-regular files? If so, the modes must match! */
+		if (!S_ISREG(source->mode) || !S_ISREG(target->mode)) {
+			if (source->mode != target->mode)
+				continue;
 		}
-		if (best) {
-			record_rename_pair(dst->index, best->index, MAX_SCORE);
-			renames++;
+		/* Give higher scores to sources that haven't been used already */
+		score = !source->rename_used;
+		if (source->rename_used && options->detect_rename != DIFF_DETECT_COPY)
+			continue;
+		score += basename_same(source, target);
+		if (score > best_score) {
+			best = p;
+			best_score = score;
+			if (score == 2)
+				break;
 		}
+
+		/* Too many identical alternatives? Pick one */
+		if (!--i)
+			break;
+	}
+	if (best) {
+		record_rename_pair(dst->index, best->index, MAX_SCORE);
+		renames++;
+	}
 	} while ((dst = dst->next) != NULL);
 	return renames;
 }
@@ -343,18 +355,6 @@ static int find_same_files(void *ptr, void *data)
 	return ret;
 }
 
-static unsigned int hash_filespec(struct diff_filespec *filespec)
-{
-	unsigned int hash;
-	if (!filespec->sha1_valid) {
-		if (diff_populate_filespec(filespec, 0))
-			return 0;
-		hash_sha1_file(filespec->data, filespec->size, "blob", filespec->sha1);
-	}
-	memcpy(&hash, filespec->sha1, sizeof(hash));
-	return hash;
-}
-
 static void insert_file_table(struct hash_table *table, int src_dst, int index, struct diff_filespec *filespec)
 {
 	void **pos;
-- 
1.8.4.5.gef01589.dirty
