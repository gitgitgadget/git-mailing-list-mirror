From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 07/11] ref-filter: add option to match literal pattern
Date: Mon, 27 Jul 2015 12:57:11 +0530
Message-ID: <1437982035-6658-7-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZTtAepdO5U8zo62VBn_z4-LcKoguPxVGaAnNZULEwzrQQ@mail.gmail.com>
 <1437982035-6658-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 27 09:27:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJcoy-0000kk-6O
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 09:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbbG0H1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 03:27:31 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:33820 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895AbbG0H13 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 03:27:29 -0400
Received: by pdbbh15 with SMTP id bh15so47356913pdb.1
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 00:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EcB6dneqYkASs6RVe0bgHJOgV704/Yr9QpvlZNSgd6A=;
        b=zzFuMSKHpxU2aWHpKYb/FlNygoruepAMHRCjL/seqYF+WxKlKUpwQoCcFbbBi7jETs
         yC+sM6ma2W4qw08VlEqIDLuwsm5uTfzzODXeQEcCgQNYUrnZTmzbrE0uXMd8wHcMpqZ5
         9Q4CC+Rmd16BpQ1pBu4COgchqa1ADFxZAmYlUyZ1n+Q3Oy5lZVJ/t9rY/KVm9Q9ua8yt
         64Pd9aZ1amRd+iufIrd9DuyH+jPbTplwoNVDb4lPMoq6GIa2hPwPL+ARYz7nrUQ9USW2
         7QBxEpasTyzcYjljHD7+7D3Q2cgS1TVzhs61BRAnIAK5VzSLsUql6nbPX6i37krP5Vcs
         Saig==
X-Received: by 10.70.55.165 with SMTP id t5mr64640435pdp.102.1437982049360;
        Mon, 27 Jul 2015 00:27:29 -0700 (PDT)
Received: from ashley.localdomain ([106.51.241.234])
        by smtp.gmail.com with ESMTPSA id wv4sm27732769pac.2.2015.07.27.00.27.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jul 2015 00:27:28 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1437982035-6658-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274654>

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
 ref-filter.c           | 38 +++++++++++++++++++++++++++++++++++++-
 ref-filter.h           |  3 ++-
 3 files changed, 40 insertions(+), 2 deletions(-)

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
index 26eb26c..597b189 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -946,6 +946,32 @@ static int commit_contains(struct ref_filter *filter, struct commit *commit)
 
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
+	if (skip_prefix(refname, "refs/tags/", &refname))
+		;
+	else if (skip_prefix(refname, "refs/heads/", &refname))
+		;
+	else if (skip_prefix(refname, "refs/remotes/", &refname))
+		;
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
  * matches a pattern "refs/heads/") or a wildcard (e.g. the same ref
  * matches "refs/heads/m*",too).
@@ -969,6 +995,16 @@ static int match_name_as_path(const char **pattern, const char *refname)
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
@@ -1037,7 +1073,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 		return 0;
 	}
 
-	if (*filter->name_patterns && !match_name_as_path(filter->name_patterns, refname))
+	if (!filter_pattern_match(filter, refname))
 		return 0;
 
 	if (filter->points_at.nr && !match_points_at(&filter->points_at, oid->hash, refname))
diff --git a/ref-filter.h b/ref-filter.h
index 5406721..a27745f 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -64,7 +64,8 @@ struct ref_filter {
 	} merge;
 	struct commit *merge_commit;
 
-	unsigned int with_commit_tag_algo : 1;
+	unsigned int with_commit_tag_algo : 1,
+		match_as_path : 1;
 	unsigned int lines;
 };
 
-- 
2.4.6
