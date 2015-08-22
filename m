From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v13 08/12] ref-filter: add option to match literal pattern
Date: Sat, 22 Aug 2015 09:09:44 +0530
Message-ID: <1440214788-1309-9-git-send-email-Karthik.188@gmail.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 05:40:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSzfC-0002LY-SU
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 05:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176AbbHVDkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 23:40:07 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35220 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753159AbbHVDkG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 23:40:06 -0400
Received: by pacdd16 with SMTP id dd16so56493050pac.2
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 20:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D83ylhq7xXCpPwaxOdtbBwPzptFnci4NvF+jnv1uCas=;
        b=vtHvZZoIzOdOc2l1q07N0nmCqK01fXZ8ucq0sitpVqw3601OiMr78DDJoejXlrgCAK
         qehFJ6xe6+vqx9b+7B+e1Haq++76JfCqP+oIVPCPyNqGDQkCgqsivsQk8/C24o3iYr9Z
         0isjBrukOLczOIJc1DyzueUJUTx9tM2EkW0JomNMICMBTG8U60nfrh/VlQeyNGRxA22v
         W/mAFNoBQRTbQJOYmiFxt9i1kenzW3meL2e5XB9u+RhQW4PeDwBjnsbjhsdQbG0Efg5b
         TZqafshQQrVyFjV5HOA6t862/+EAHHY+SxcyNMINjFr75s5Kn3HhcxGlEd8G/+N+l0xT
         kYSA==
X-Received: by 10.66.156.196 with SMTP id wg4mr23723487pab.65.1440214805402;
        Fri, 21 Aug 2015 20:40:05 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id e4sm9393515pdd.45.2015.08.21.20.40.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Aug 2015 20:40:04 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276369>

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
index b4a7d72..f8b8fb7 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1055,9 +1055,33 @@ static int commit_contains(struct ref_filter *filter, struct commit *commit)
 
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
@@ -1078,6 +1102,16 @@ static int match_name_as_path(const char **pattern, const char *refname)
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
@@ -1181,7 +1215,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
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
