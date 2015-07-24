From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 06/10] ref-filter: add option to match literal pattern
Date: Sat, 25 Jul 2015 00:34:41 +0530
Message-ID: <1437764685-8633-7-git-send-email-Karthik.188@gmail.com>
References: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 24 21:05:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIiHx-0003eN-Fd
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 21:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754882AbbGXTFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 15:05:41 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33810 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754757AbbGXTFb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 15:05:31 -0400
Received: by pacan13 with SMTP id an13so18830522pac.1
        for <git@vger.kernel.org>; Fri, 24 Jul 2015 12:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U7ZF7kmjJrXTvzlpZAPFQMu7G8PycjHzCWgFse6dhq0=;
        b=P0BZxox/VmPGpwMBQjVqgt0Q2N8YiObdosWK+T7ZIo6Yj12SvVrwmQ3cY+251jVG5o
         bPMzhjQJ/5M6m0Ac2Yi3uL/noK6ZAu37gG3rvPq0ngY3kVtI6pa2w6WlT8j+yWH1Loau
         5BnRnInjTn9MuaPuxJT03FKshZybN+RGAi7LGCd+Z0c6VvQF2dWt3feI7D1F/G09JQtL
         YCcc8uaBXG8kXlbja2+jw5EuQwClDImxMXtSVZCSsKBQVeak9UWKd46BsuTyZPtaa08i
         BS1RDLHM6rNQYzgoWK4/Tonw/eHPEnaVRkO5uJp+ixaJq57WVmURPdxOXeHmAsErZdj2
         qm3Q==
X-Received: by 10.66.119.174 with SMTP id kv14mr22740885pab.115.1437764730821;
        Fri, 24 Jul 2015 12:05:30 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id ns14sm15922915pdb.17.2015.07.24.12.05.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Jul 2015 12:05:29 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274583>

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
 ref-filter.c           | 37 ++++++++++++++++++++++++++++++++++++-
 ref-filter.h           |  3 ++-
 3 files changed, 39 insertions(+), 2 deletions(-)

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
index 8f2148f..0a64b84 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -951,6 +951,31 @@ static int commit_contains(struct ref_filter *filter, struct commit *commit)
 
 /*
  * Return 1 if the refname matches one of the patterns, otherwise 0.
+ * A pattern can be a literal prefix (e.g. a refname "refs/heads/master"
+ * matches a pattern "refs/heads/mas") or a wildcard (e.g. the same ref
+ * matches "refs/heads/mas*", too).
+ */
+static int match_pattern(const char **patterns, const char *refname)
+{
+	for (; *patterns; patterns++) {
+		/*
+		 * When no '--format' option is given we need to skip the prefix
+		 * for matching refs of tags and branches.
+		 */
+		if (!starts_with(*patterns, "refs/tags/"))
+			skip_prefix(refname, "refs/tags/", &refname);
+		if (!starts_with(*patterns, "refs/heads/"))
+			skip_prefix(refname, "refs/heads/", &refname);
+		if (!starts_with(*patterns, "refs/remotes/"))
+			skip_prefix(refname, "refs/remotes/", &refname);
+		if (!wildmatch(*patterns, refname, 0, NULL))
+			return 1;
+	}
+	return 0;
+}
+
+/*
+ * Return 1 if the refname matches one of the patterns, otherwise 0.
  * A pattern can be path prefix (e.g. a refname "refs/heads/master"
  * matches a pattern "refs/heads/") or a wildcard (e.g. the same ref
  * matches "refs/heads/m*",too).
@@ -974,6 +999,16 @@ static int match_name_as_path(const char **pattern, const char *refname)
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
@@ -1042,7 +1077,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 		return 0;
 	}
 
-	if (*filter->name_patterns && !match_name_as_path(filter->name_patterns, refname))
+	if (!filter_pattern_match(filter, refname))
 		return 0;
 
 	if (filter->points_at.nr && !match_points_at(&filter->points_at, oid->hash, refname))
diff --git a/ref-filter.h b/ref-filter.h
index a12fe0c..f1933e0 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -62,7 +62,8 @@ struct ref_filter {
 	} merge;
 	struct commit *merge_commit;
 
-	unsigned int with_commit_tag_algo : 1;
+	unsigned int with_commit_tag_algo : 1,
+		match_as_path : 1;
 	unsigned int lines;
 };
 
-- 
2.4.6
