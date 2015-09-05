From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v16 10/14] ref-filter: add option to match literal pattern
Date: Sun,  6 Sep 2015 00:22:11 +0530
Message-ID: <1441479135-5285-11-git-send-email-Karthik.188@gmail.com>
References: <1441479135-5285-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 05 20:53:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYIaD-0002QX-0d
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 20:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879AbbIESw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 14:52:56 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34653 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218AbbIESwd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 14:52:33 -0400
Received: by padhy16 with SMTP id hy16so52764250pad.1
        for <git@vger.kernel.org>; Sat, 05 Sep 2015 11:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0uSdqXmVbujySNzVdnjWxL06wr1deebOVEqjt5kXXlE=;
        b=Y/S2fKuL2yZlOY5Za2eRdvH0dZ51BJRD0vPtoe2wB2oBQYcS+n3sZbp8l7sSftJv7A
         UA1QLITzVPZ0GnzsDm0/qjyiRsqSJvxozGqrxG2qpX10KlKcJ6QgkIX8o0zvLxP8XslQ
         FgxNcnkxBNwH6OAMaNjSF6T/qiLnKqxzY/iARBKbgiiepMV/NHmybl4j16R466SUNBEn
         55ruvFYOhtTQ5yQPluahNJZya7MofJ0GKLcKciPP9nWkiN6TzOdEYOS5E9B8vPEGY0Dp
         CA2RTC+cNv/7C6i+SUFAwTkRxECcSy1TPfmUM/X/WjYkQoh+B7ipRdj4RaNGx5O204I+
         UPxg==
X-Received: by 10.68.218.65 with SMTP id pe1mr23529108pbc.2.1441479152170;
        Sat, 05 Sep 2015 11:52:32 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id ch3sm6583639pbb.18.2015.09.05.11.52.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 05 Sep 2015 11:52:31 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1441479135-5285-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277404>

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
index 40f343b..4e9f6c2 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -68,6 +68,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 
 	filter.name_patterns = argv;
+	filter.match_as_path = 1;
 	filter_refs(&array, &filter, FILTER_REFS_ALL | FILTER_REFS_INCLUDE_BROKEN);
 	ref_array_sort(sorting, &array);
 
diff --git a/ref-filter.c b/ref-filter.c
index 696c0c7..e3024d3 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1167,9 +1167,33 @@ static int commit_contains(struct ref_filter *filter, struct commit *commit)
 
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
@@ -1190,6 +1214,16 @@ static int match_name_as_path(const char **pattern, const char *refname)
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
@@ -1292,7 +1326,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	if (!(kind & filter->kind))
 		return 0;
 
-	if (*filter->name_patterns && !match_name_as_path(filter->name_patterns, refname))
+	if (!filter_pattern_match(filter, refname))
 		return 0;
 
 	if (filter->points_at.nr && !match_points_at(&filter->points_at, oid->hash, refname))
diff --git a/ref-filter.h b/ref-filter.h
index ef25b6e..a5cfa5e 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -59,7 +59,8 @@ struct ref_filter {
 	} merge;
 	struct commit *merge_commit;
 
-	unsigned int with_commit_tag_algo : 1;
+	unsigned int with_commit_tag_algo : 1,
+		match_as_path : 1;
 	unsigned int kind,
 		lines;
 };
-- 
2.5.1
