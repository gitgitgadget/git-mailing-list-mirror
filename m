From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 0/8] port the filtering part of branch.c to use ref-filter APIs
Date: Sun, 20 Sep 2015 23:40:19 +0530
Message-ID: <1442772627-25421-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 20 20:10:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zdj4D-0006Vf-91
	for gcvg-git-2@plane.gmane.org; Sun, 20 Sep 2015 20:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755241AbbITSKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2015 14:10:20 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34472 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755219AbbITSKT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2015 14:10:19 -0400
Received: by pary6 with SMTP id y6so11621670par.1
        for <git@vger.kernel.org>; Sun, 20 Sep 2015 11:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=TEo2eneCY1JOhqTryleqnDPo5rQBIVL4PJRJ0rfy928=;
        b=kcpugBiKymrZzWvfCH6nasjPuWjQPDnXTXcDQS9htae9fAVV77h1n52lyeN/2dOtLj
         lZG5Dc8qQa8tFSgGbusW4BMRI20nJRlcEf03XmrC+in1eazdxuh7ytlTjoXfmNn6YDV7
         7JKPaJnOwXLHck32feA4I9OJWPHjcS96CcS95jS0OnD2XqdlAp44F2DjZhRnwOuCNzy1
         nXRNtb8lInPtPqvwaFDBtK0zVhMJj3VHLsIWkOUpcAi+hUfMpGMvg1/IefNCLIq040sO
         sbjjjE8fVAiSuG2H+dzrczSU/SC3QYZemQEKpQjs4DSuCvTeu9zIwF7TLHqEe+Jc2djX
         8+tg==
X-Received: by 10.68.135.136 with SMTP id ps8mr19728804pbb.123.1442772618994;
        Sun, 20 Sep 2015 11:10:18 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id qr5sm20037916pbb.26.2015.09.20.11.10.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Sep 2015 11:10:18 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278253>

This is part of porting 'branch -l' to use ref-filter APIs

The previous version of this series (v4) can be found here:
thread.gmane.org/gmane.comp.version-control.git/277761

Changes in this version include:
* Now we sort by 'refname' by default, this eliminates the need
for attaching the detached head at the end of the array and printing
it initially.
* Fix broken tests.

Karthik Nayak (8):
  branch: refactor width computation
  branch: bump get_head_description() to the top
  branch: roll show_detached HEAD into regular ref_list
  branch: move 'current' check down to the presentation layer
  branch: drop non-commit error reporting
  branch.c: use 'ref-filter' data structures
  branch.c: use 'ref-filter' APIs
  branch: add '--points-at' option

 Documentation/git-branch.txt |  13 +-
 builtin/branch.c             | 501 +++++++++++++------------------------------
 ref-filter.c                 |   2 +-
 ref-filter.h                 |   6 +-
 t/t1430-bad-ref-name.sh      |  31 ++-
 t/t3203-branch-output.sh     |  20 ++
 6 files changed, 207 insertions(+), 366 deletions(-)

Interdiff:

diff --git a/builtin/branch.c b/builtin/branch.c
index 32a0d11..9065c70 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -480,7 +480,7 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	int maxwidth = 0;
 	const char *remote_prefix = "";
 	struct ref_sorting def_sorting;
-	const char *sort_type = "type";
+	const char *sort_type = "refname";
 
 	/*
 	 * If we are listing more than just remote branches,
@@ -498,13 +498,6 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	if (filter->verbose)
 		maxwidth = calc_maxwidth(&array, strlen(remote_prefix));
 
-	/* Print detached HEAD before sorting and printing the rest */
-	if (filter->kind & FILTER_REFS_DETACHED_HEAD) {
-		format_and_print_ref_item(array.items[array.nr - 1], maxwidth, filter, remote_prefix);
-		free_array_item(array.items[array.nr - 1]);
-		array.nr--;
-	}
-
 	if (!sorting) {
 		def_sorting.next = NULL;
 		def_sorting.atom = parse_ref_filter_atom(sort_type,
diff --git a/ref-filter.c b/ref-filter.c
index c536aea..dbd8fce 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1356,7 +1356,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 }
 
 /*  Free memory allocated for a ref_array_item */
-void free_array_item(struct ref_array_item *item)
+static void free_array_item(struct ref_array_item *item)
 {
 	free((char *)item->symref);
 	free(item);
diff --git a/ref-filter.h b/ref-filter.h
index 9316031..14d435e 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -90,8 +90,6 @@ struct ref_filter_cbdata {
  * filtered refs in the ref_array structure.
  */
 int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int type);
-/*  Clear memory allocated to a ref_array_item */
-void free_array_item(struct ref_array_item *item);
 /*  Clear all memory allocated to ref_array */
 void ref_array_clear(struct ref_array *array);
 /*  Parse format string and sort specifiers */
diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index 070cf06..c465abe 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -139,7 +139,7 @@ test_expect_failure 'push --mirror can delete badly named ref' '
 	) &&
 	git -C src push --mirror "file://$top/dest" &&
 	git -C dest branch >output 2>error &&
-	! grep -e "broken\.\.\.ref" error
+	! grep -e "broken\.\.\.ref" error &&
 	! grep -e "broken\.\.\.ref" output
 '
 
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index c819f3e..f1ae5ff 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -145,8 +145,8 @@ EOF
 
 test_expect_success 'git branch `--sort` option' '
 	cat >expect <<-\EOF &&
-	* (HEAD detached from fromtag)
 	  branch-two
+	* (HEAD detached from fromtag)
 	  branch-one
 	  master
 	EOF
@@ -156,8 +156,8 @@ test_expect_success 'git branch `--sort` option' '
 
 test_expect_success 'git branch --points-at option' '
 	cat >expect <<-\EOF &&
-	  master
 	  branch-one
+	  master
 	EOF
 	git branch --points-at=branch-one >actual &&
 	test_cmp expect actual

-- 
2.5.1
