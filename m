From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 08/10] commit: add for_each_mergetag()
Date: Mon, 07 Jul 2014 08:35:37 +0200
Message-ID: <20140707063540.3708.39506.chriscool@tuxfamily.org>
References: <20140707063342.3708.83493.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 08:36:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X42Xp-0007iA-5h
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jul 2014 08:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962AbaGGGgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 02:36:50 -0400
Received: from [194.158.98.14] ([194.158.98.14]:57018 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751734AbaGGGgh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 02:36:37 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id B12EA36;
	Mon,  7 Jul 2014 08:36:16 +0200 (CEST)
X-git-sha1: 117b6e2c0d6ae8c5142e989a752d470544b6f441 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140707063342.3708.83493.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252950>

In the same way as there is for_each_ref() to
iterate on refs, it might be useful to have
for_each_mergetag() to iterate on the mergetags
of a given commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 commit.c   | 13 +++++++++++++
 commit.h   |  5 +++++
 log-tree.c | 15 ++++-----------
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/commit.c b/commit.c
index 54e157d..0f83ff7 100644
--- a/commit.c
+++ b/commit.c
@@ -1348,6 +1348,19 @@ struct commit_extra_header *read_commit_extra_headers(struct commit *commit,
 	return extra;
 }
 
+void for_each_mergetag(each_mergetag_fn fn, struct commit *commit, void *data)
+{
+	struct commit_extra_header *extra, *to_free;
+
+	to_free = read_commit_extra_headers(commit, NULL);
+	for (extra = to_free; extra; extra = extra->next) {
+		if (strcmp(extra->key, "mergetag"))
+			continue; /* not a merge tag */
+		fn(commit, extra, data);
+	}
+	free_commit_extra_headers(to_free);
+}
+
 static inline int standard_header_field(const char *field, size_t len)
 {
 	return ((len == 4 && !memcmp(field, "tree ", 5)) ||
diff --git a/commit.h b/commit.h
index 4234dae..c81ba85 100644
--- a/commit.h
+++ b/commit.h
@@ -312,6 +312,11 @@ extern struct commit_extra_header *read_commit_extra_headers(struct commit *, co
 
 extern void free_commit_extra_headers(struct commit_extra_header *extra);
 
+typedef void (*each_mergetag_fn)(struct commit *commit, struct commit_extra_header *extra,
+				 void *cb_data);
+
+extern void for_each_mergetag(each_mergetag_fn fn, struct commit *commit, void *data);
+
 struct merge_remote_desc {
 	struct object *obj; /* the named object, could be a tag */
 	const char *name;
diff --git a/log-tree.c b/log-tree.c
index 10e6844..706ed4c 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -413,10 +413,11 @@ static int is_common_merge(const struct commit *commit)
 		&& !commit->parents->next->next);
 }
 
-static void show_one_mergetag(struct rev_info *opt,
+static void show_one_mergetag(struct commit *commit,
 			      struct commit_extra_header *extra,
-			      struct commit *commit)
+			      void *data)
 {
+	struct rev_info *opt = (struct rev_info *)data;
 	unsigned char sha1[20];
 	struct tag *tag;
 	struct strbuf verify_message;
@@ -463,15 +464,7 @@ static void show_one_mergetag(struct rev_info *opt,
 
 static void show_mergetag(struct rev_info *opt, struct commit *commit)
 {
-	struct commit_extra_header *extra, *to_free;
-
-	to_free = read_commit_extra_headers(commit, NULL);
-	for (extra = to_free; extra; extra = extra->next) {
-		if (strcmp(extra->key, "mergetag"))
-			continue; /* not a merge tag */
-		show_one_mergetag(opt, extra, commit);
-	}
-	free_commit_extra_headers(to_free);
+	for_each_mergetag(show_one_mergetag, commit, opt);
 }
 
 void show_log(struct rev_info *opt)
-- 
2.0.0.421.g786a89d.dirty
