From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH/RFC 3/5] diffcore-rename.c: move code around to prepare for
 the next patch
Date: Wed, 11 Sep 2013 01:29:34 +0200
Message-ID: <522FAB5E.1060607@gmail.com>
References: <522FAAC4.2080601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 11 01:29:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJXNM-0001H4-9N
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 01:29:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751Ab3IJX3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 19:29:36 -0400
Received: from mail-ea0-f172.google.com ([209.85.215.172]:57835 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512Ab3IJX3f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 19:29:35 -0400
Received: by mail-ea0-f172.google.com with SMTP id r16so4263880ead.3
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 16:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=yIb5KvPTdwbHTJYhskTf2l3i+fJTTC4eLnT5wVVx5s8=;
        b=CZ41fMVDDmHQ2utOdcnLDOIahAGklL9sLL3r5RVgWXrdP0KcpYpkIKPOuVL0iGWfhM
         AHWrXAEXkb4K+ioNnGiY8SzXL09W8m5NqhVHcYhG6mbgAILAoa2/tm4iWL9u4UX8kybS
         Rfg3awe6a+sRsKdJshL8WBZUk5ih5irf/NS9MFvdUX04CwdYVQuRAjhXEqaVRHU2a7ZB
         1ORP1az30phck6IbKoNTMTHqO0gPNu+3oNBPzrFhYj8tvXTTR2BOYAt8zjG3ZiBWNnNW
         StZUbJdzJIpOm/QPBYf10ohXw5n56tRO86MjJ5yyi3O2NU6z2IvCv2m11WZDEVy7G4SU
         jXsw==
X-Received: by 10.14.99.193 with SMTP id x41mr7712990eef.52.1378855774943;
        Tue, 10 Sep 2013 16:29:34 -0700 (PDT)
Received: from [10.1.100.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id m54sm35493147eex.2.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 16:29:34 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <522FAAC4.2080601@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234511>

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
1.8.4.8243.gbcbdefd
