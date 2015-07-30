From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 07/11] ref-filter: add option to match literal pattern
Date: Thu, 30 Jul 2015 21:05:48 +0530
Message-ID: <1438270552-10333-7-git-send-email-Karthik.188@gmail.com>
References: <CAOLa=ZR6_2NBB4v0Ynq391=8Jk2RZON6R0YG=HKUNwKx249b7Q@mail.gmail.com>
 <1438270552-10333-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 30 17:51:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKq7J-0005AT-Qi
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 17:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816AbbG3Pv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 11:51:27 -0400
Received: from mail-pd0-f193.google.com ([209.85.192.193]:33165 "EHLO
	mail-pd0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142AbbG3PvY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 11:51:24 -0400
Received: by pdbmj9 with SMTP id mj9so2286098pdb.0
        for <git@vger.kernel.org>; Thu, 30 Jul 2015 08:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jZJgs1lwpReGXLHKH9LKp+7F0nVBA7AOel/SKjMxPF8=;
        b=dKgSP2IEA7UGGUjodsPRuKD6rClbVgn8MlkCkqWRp7MW4ELCrFRkRVj3+nnd3OwUxc
         xOZNvCbaoC05G0S3NRsvNnwz0zZ9vDTw1AECwxH1PVFC4GZRHWkwPDt2+4qrLHNSdPXq
         kR1CpB3/WXTH1VsUP8A9xHWOVrSyOPNKiCLIZ2uJ7kNHVWAkQzoyTiq9FqieZ+4XzzRT
         V9ua+v3NKrUGxkA/uddJC/tXcUYCMN+v+LO7k/oZHb9ZjjQ/d6RR6y0rlfaBLbz/Tms7
         FJnt2aXSu1wkEzRQ2hmkd6lutQgsoxLerfgD/FyAKYn2hwsnwiVgFw04uasH+pLKaszI
         QAcw==
X-Received: by 10.70.100.103 with SMTP id ex7mr86141963pdb.91.1438270567438;
        Thu, 30 Jul 2015 08:36:07 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id oq10sm2790985pdb.75.2015.07.30.08.36.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Jul 2015 08:36:06 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1438270552-10333-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275014>

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
 ref-filter.c           | 39 ++++++++++++++++++++++++++++++++++++---
 ref-filter.h           |  3 ++-
 3 files changed, 39 insertions(+), 4 deletions(-)

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
index 2b4a853..65d168e 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -946,9 +946,32 @@ static int commit_contains(struct ref_filter *filter, struct commit *commit)
 
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
+	       skip_prefix(refname, "refs/remotes/", &refname));
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
@@ -969,6 +992,16 @@ static int match_name_as_path(const char **pattern, const char *refname)
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
@@ -1037,7 +1070,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 		return 0;
 	}
 
-	if (*filter->name_patterns && !match_name_as_path(filter->name_patterns, refname))
+	if (!filter_pattern_match(filter, refname))
 		return 0;
 
 	if (filter->points_at.nr && !match_points_at(&filter->points_at, oid->hash, refname))
diff --git a/ref-filter.h b/ref-filter.h
index 2bdae58..b50a036 100644
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
