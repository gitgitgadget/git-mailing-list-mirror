From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v12 09/13] ref-filter: add option to match literal pattern
Date: Wed, 19 Aug 2015 00:07:28 +0530
Message-ID: <1439923052-7373-10-git-send-email-Karthik.188@gmail.com>
References: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 18 20:38:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRllr-0008Tk-Uu
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 20:38:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754050AbbHRSh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2015 14:37:56 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34230 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754015AbbHRShy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2015 14:37:54 -0400
Received: by paccq16 with SMTP id cq16so94604832pac.1
        for <git@vger.kernel.org>; Tue, 18 Aug 2015 11:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bQEYE6FGr5KHPkAytb24irV5t5FkpeafLwVbFiwAyv4=;
        b=J7n/soRadlmzL/4GZUxkfSmRMB9BJ6CjjR4M6iovEDyEiADYgaSsjJdwYCxluZuwG1
         ecrdHm76fNbhjEnAFcsHaOxkQwRwJg/Wa144ojst9MoMwgpVVZQmb8bJU1aq/g9SgfhA
         YgQPCkNH79F4HaBAulPlRYC5Xqdev9D6x8cnP5WGgYT0ds1RJa5upIUFdYdBtfkw7iu6
         W2QBoskvu2VDbGH6U3VY7St+9fu9RaEaAfeeDCbhSZQCuopvR3xQstzfZumIm6vPNelg
         SPFLT0roizTYuuGzGyCDprUfbG4JqRjVUDejnw7f/JmnNnTQnwWWshJ5BKAGY5C/xcEb
         ZGhA==
X-Received: by 10.68.201.105 with SMTP id jz9mr11698561pbc.86.1439923073551;
        Tue, 18 Aug 2015 11:37:53 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id i9sm18858190pbq.44.2015.08.18.11.37.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Aug 2015 11:37:52 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276141>

From: Karthik Nayak <karthik.188@gmail.com>

Since 'ref-filter' only has an option to match path names add an
option for plain fnmatch pattern-matching.

This is to support the pattern matching options which are used in `git
tag -l` and `git branch -l` where we can match patterns like `git tag
-l foo*` which would match all tags which has a "foo*" pattern.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/for-each-ref.c |  1 +
 ref-filter.c           | 40 +++++++++++++++++++++++++++++++++++++---
 ref-filter.h           |  3 ++-
 3 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index e4a4f8a..3ad6a64 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -68,6 +68,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 
 	filter.name_patterns = argv;
+	filter.match_as_path = 1;
 	filter_refs(&array, &filter, FILTER_REFS_ALL | FILTER_REFS_INCLUDE_BROKEN);
 	ref_array_sort(sorting, &array);
 
diff --git a/ref-filter.c b/ref-filter.c
index 67c7846..665221b 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1033,9 +1033,33 @@ static int commit_contains(struct ref_filter *filter, struct commit *commit)
 
 /*
  * Return 1 if the refname matches one of the patterns, otherwise 0.
+ * A pattern can be a literal prefix (e.g. a refname "refs/heads/master"
+ * matches a pattern "refs/heads/mas") or a wildcard (e.g. the same ref
+ * matches "refs/heads/mas*", too).
+ */
+static int match_pattern(const char **patterns, const char *refname)
+{
+	/*
+	 * When no '--format' option is given we need to skip the prefix
+	 * for matching refs of tags and branches.
+	 */
+	(void)(skip_prefix(refname, "refs/tags/", &refname) ||
+	       skip_prefix(refname, "refs/heads/", &refname) ||
+	       skip_prefix(refname, "refs/remotes/", &refname) ||
+	       skip_prefix(refname, "refs/", &refname));
+
+	for (; *patterns; patterns++) {
+		if (!wildmatch(*patterns, refname, 0, NULL))
+			return 1;
+	}
+	return 0;
+}
+
+/*
+ * Return 1 if the refname matches one of the patterns, otherwise 0.
  * A pattern can be path prefix (e.g. a refname "refs/heads/master"
- * matches a pattern "refs/heads/") or a wildcard (e.g. the same ref
- * matches "refs/heads/m*",too).
+ * matches a pattern "refs/heads/" but not "refs/heads/m") or a
+ * wildcard (e.g. the same ref matches "refs/heads/m*", too).
  */
 static int match_name_as_path(const char **pattern, const char *refname)
 {
@@ -1056,6 +1080,16 @@ static int match_name_as_path(const char **pattern, const char *refname)
 	return 0;
 }
 
+/* Return 1 if the refname matches one of the patterns, otherwise 0. */
+static int filter_pattern_match(struct ref_filter *filter, const char *refname)
+{
+	if (!*filter->name_patterns)
+		return 1; /* No pattern always matches */
+	if (filter->match_as_path)
+		return match_name_as_path(filter->name_patterns, refname);
+	return match_pattern(filter->name_patterns, refname);
+}
+
 /*
  * Given a ref (sha1, refname), check if the ref belongs to the array
  * of sha1s. If the given ref is a tag, check if the given tag points
@@ -1159,7 +1193,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	if (!(kind & filter->kind))
 		return 0;
 
-	if (*filter->name_patterns && !match_name_as_path(filter->name_patterns, refname))
+	if (!filter_pattern_match(filter, refname))
 		return 0;
 
 	if (filter->points_at.nr && !match_points_at(&filter->points_at, oid->hash, refname))
diff --git a/ref-filter.h b/ref-filter.h
index 5aa2f40..8241066 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -58,7 +58,8 @@ struct ref_filter {
 	} merge;
 	struct commit *merge_commit;
 
-	unsigned int with_commit_tag_algo : 1;
+	unsigned int with_commit_tag_algo : 1,
+		match_as_path : 1;
 	unsigned int kind,
 		lines;
 };
-- 
2.5.0
