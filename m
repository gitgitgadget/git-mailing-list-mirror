From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [RFC/PATCH] branch: show me the hot branches
Date: Tue, 14 May 2013 01:32:45 +0530
Message-ID: <1368475365-18680-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 13 22:02:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubywp-0004gZ-Mx
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 22:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755183Ab3EMUCL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 16:02:11 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:48412 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755230Ab3EMUCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 16:02:09 -0400
Received: by mail-pa0-f53.google.com with SMTP id kq12so4874914pab.26
        for <git@vger.kernel.org>; Mon, 13 May 2013 13:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:subject:date:message-id:x-mailer;
        bh=k99/JWaLERryLbE0RMYX9+v/g05zdk+CTOL8J0/c+Uk=;
        b=P204BJ0ibrdlx/jJdR8OWpkLLIOoQPnyXqlFdODa6jSopKq8rJb7OEBmxq1ndbTtg8
         M6x6EBArSMYPhrd913UhIQgpDyLvmwn5HDilbzhQYjK3CjJFq1GjorNW4SQNXmAB2bkW
         Ff58AvzhC6dISXqANotJALOjsjwbQqY6QX7xyka5AyY/ogLVHu94N4JvcUIZkb40zyKf
         oBAjVARMJ3wJoljkBckPUCOe9GOfPB1DAcZcbGFDaVUzWNg+RnI2bP5qYPI9H6/HLWdO
         9LL21LRcNGTsLCIgbxoru9Py3Cnb0C+zYGpBV4Ef0vDQxGcAcwvLbzqw57Fm6E9JkKbA
         EsUQ==
X-Received: by 10.68.204.35 with SMTP id kv3mr30954827pbc.87.1368475328386;
        Mon, 13 May 2013 13:02:08 -0700 (PDT)
Received: from localhost.localdomain ([122.164.164.41])
        by mx.google.com with ESMTPSA id wi6sm15150314pbc.22.2013.05.13.13.02.06
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 13 May 2013 13:02:07 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.49.g8d97506.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224198>

Uses commit->date to sort displayed refs.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Just had this idea and wrote it down in five minutes.  The
 implementation is only meant to be indicative.

 Isn't this awesome?

 builtin/branch.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 0836890..8b08563 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -59,6 +59,11 @@ static enum merge_filter {
 } merge_filter;
 static unsigned char merge_filter_ref[20];
 
+static enum sort_strategy {
+	LEXICAL = 0,
+	DATE,
+} sort_strategy;
+
 static struct string_list output = STRING_LIST_INIT_DUP;
 static unsigned int colopts;
 
@@ -406,7 +411,7 @@ static void free_ref_list(struct ref_list *ref_list)
 	free(ref_list->list);
 }
 
-static int ref_cmp(const void *r1, const void *r2)
+static int ref_cmp_lexical(const void *r1, const void *r2)
 {
 	struct ref_item *c1 = (struct ref_item *)(r1);
 	struct ref_item *c2 = (struct ref_item *)(r2);
@@ -416,6 +421,16 @@ static int ref_cmp(const void *r1, const void *r2)
 	return strcmp(c1->name, c2->name);
 }
 
+static int ref_cmp_date(const void *r1, const void *r2)
+{
+	struct ref_item *c1 = (struct ref_item *)(r1);
+	struct ref_item *c2 = (struct ref_item *)(r2);
+
+	if (c1->kind != c2->kind)
+		return c1->kind - c2->kind;
+	return c1->commit->date < c2->commit->date;
+}
+
 static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 		int show_upstream_ref)
 {
@@ -621,7 +636,6 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 
 	memset(&ref_list, 0, sizeof(ref_list));
 	ref_list.kinds = kinds;
-	ref_list.verbose = verbose;
 	ref_list.abbrev = abbrev;
 	ref_list.with_commit = with_commit;
 	if (merge_filter != NO_FILTER)
@@ -629,7 +643,14 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 	cb.ref_list = &ref_list;
 	cb.pattern = pattern;
 	cb.ret = 0;
+
+	if (sort_strategy == DATE && verbose < 1)
+		ref_list.verbose = 1;
+	else
+		ref_list.verbose = verbose;
 	for_each_rawref(append_ref, &cb);
+	ref_list.verbose = verbose;
+
 	if (merge_filter != NO_FILTER) {
 		struct commit *filter;
 		filter = lookup_commit_reference_gently(merge_filter_ref, 0);
@@ -646,7 +667,10 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 			ref_list.maxwidth = calc_maxwidth(&ref_list);
 	}
 
-	qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
+	if (sort_strategy == DATE)
+		qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp_date);
+	else
+		qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp_lexical);
 
 	detached = (detached && (kinds & REF_LOCAL_BRANCH));
 	if (detached && match_patterns(pattern, "HEAD"))
@@ -843,6 +867,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
+	sort_strategy = DATE;
+
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_branch_usage, options);
 
-- 
1.8.3.rc1.49.g8d97506.dirty
