From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 05/10] ref-filter: add option to match literal pattern
Date: Thu,  9 Jul 2015 15:57:46 +0530
Message-ID: <1436437671-25600-5-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
 <1436437671-25600-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 09 12:28:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZD94F-0003fD-2r
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 12:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbbGIK20 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 06:28:26 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:36730 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206AbbGIK2K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 06:28:10 -0400
Received: by pdjr16 with SMTP id r16so1970594pdj.3
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 03:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gxpx+tHxKXmEqKEI3Ug90nVqHmCMYXvJbZSHNIwRd7E=;
        b=lgu6LywvKMSUUVgXIs8Y/AfsM6eAmrepvrQjIKASWC8U1IysK+ivWqBWVuVYIswSaU
         L8exa3EBqIZ+oo5fG8PIw/kBmSj0N0bFvzKSypcZz2d4DWUL1S/FqSemcg5NvzpUMwv0
         agSI+95OeG5DIgfKFQ08WJVTSg2Nu8fUGK7fkhjdbZxq0VeFxV5QOunP6dCH+4aP1PbW
         BqZep4MhDPM1Gh8X1F0VQOaIKiRkTaRHYxlaf2wk4zCnH4ZuWmpiApMzkbf407LoajtF
         BAe9BrPY4WM4Cil6MejDy33WYqbufxVDOgIganvrEf1rFAVhOuqW+bpV4zRoafHnrMRR
         vbmw==
X-Received: by 10.68.57.229 with SMTP id l5mr29436169pbq.91.1436437690163;
        Thu, 09 Jul 2015 03:28:10 -0700 (PDT)
Received: from ashley.localdomain ([49.201.133.206])
        by smtp.gmail.com with ESMTPSA id b10sm5449836pdo.84.2015.07.09.03.28.07
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Jul 2015 03:28:09 -0700 (PDT)
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1436437671-25600-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273733>

Since 'ref-filter' only has an option to match path names
add an option for regular pattern matching.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/for-each-ref.c |  1 +
 ref-filter.c           | 25 ++++++++++++++++++++++++-
 ref-filter.h           |  3 ++-
 3 files changed, 27 insertions(+), 2 deletions(-)

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
index 1516cd1..0e19f44 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -956,6 +956,20 @@ static int commit_contains(struct ref_filter *filter, struct commit *commit)
 
 /*
  * Return 1 if the refname matches one of the patterns, otherwise 0.
+ * A pattern can be a literal prefix (e.g. a refname "refs/heads/master"
+ * matches a pattern "refs/heads/m") or a wildcard (e.g. the same ref
+ * matches "refs/heads/m*",too).
+ */
+static int match_pattern(const char **patterns, const char *refname)
+{
+	for (; *patterns; patterns++)
+		if (!wildmatch(*patterns, refname, 0, NULL))
+			return 1;
+	return 0;
+}
+
+/*
+ * Return 1 if the refname matches one of the patterns, otherwise 0.
  * A pattern can be path prefix (e.g. a refname "refs/heads/master"
  * matches a pattern "refs/heads/") or a wildcard (e.g. the same ref
  * matches "refs/heads/m*",too).
@@ -979,6 +993,15 @@ static int match_name_as_path(const char **pattern, const char *refname)
 	return 0;
 }
 
+static int filter_pattern_match(struct ref_filter *filter, const char *refname)
+{
+	if (!*filter->name_patterns)
+		return 1;
+	if (filter->match_as_path)
+		return match_name_as_path(filter->name_patterns, refname);
+	return match_pattern(filter->name_patterns, refname);
+}
+
 /*
  * Given a ref (sha1, refname), check if the ref belongs to the array
  * of sha1s. If the given ref is a tag, check if the given tag points
@@ -1047,7 +1070,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 		return 0;
 	}
 
-	if (*filter->name_patterns && !match_name_as_path(filter->name_patterns, refname))
+	if (!filter_pattern_match(filter, refname))
 		return 0;
 
 	if (filter->points_at.nr && !match_points_at(&filter->points_at, oid->hash, refname))
diff --git a/ref-filter.h b/ref-filter.h
index 5247475..633108c 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -54,7 +54,8 @@ struct ref_filter {
 	} merge;
 	struct commit *merge_commit;
 
-	unsigned int with_commit_tag_algo : 1;
+	unsigned int with_commit_tag_algo : 1,
+		match_as_path : 1;
 	unsigned int lines;
 };
 
-- 
2.4.5
