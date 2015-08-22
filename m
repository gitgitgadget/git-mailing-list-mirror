From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 0/8] port the filtering part of ref-filter to branch.c
Date: Sat, 22 Aug 2015 12:21:41 +0530
Message-ID: <1440226309-25415-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 08:51:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZT2eb-0004EU-Nd
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 08:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752351AbbHVGvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2015 02:51:45 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:34870 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbbHVGvo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2015 02:51:44 -0400
Received: by pdob1 with SMTP id b1so34051459pdo.2
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 23:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=k4KhASZSgPgqzSjz2Grt+R+cNFOQ84C87U5SISwz8KE=;
        b=wr/PfyUWAOf0hQZSU2Y86Zv13KBnpHgzD4dAceXwKlhlwGHDs496e0VUrTw3a0zut9
         chVqVnJbvyNJJqT6khjnJu24GCLzYs4kwIyTthcqH1q3ZKaCI5im5Ji45WxoSjwk/Qf5
         hh8LhnqGPK9vZQadSZoGd1WCPi44anqHhOOb3gPgxxG35ro6PFWQ8YXTnFOsOW+fihR4
         /88LorFxDAyRWK0IUlUTH/y/8yzoB/AEaxT8yaepnMf7oaICweXWDk68u9uqh352iXVN
         CqDEn4Bd7m75UyKu9FGIopnl+ECeu9eXXTg0o6SUDJ/NphqvU5Ln1Mo1YH1CrA0Ql8ot
         kLYw==
X-Received: by 10.70.36.138 with SMTP id q10mr25085219pdj.32.1440226303650;
        Fri, 21 Aug 2015 23:51:43 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id hy5sm4412342pac.22.2015.08.21.23.51.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Aug 2015 23:51:42 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276377>

This is a follow up to porting tag.c to use ref-fitler APIs.

v2 of this patch series can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/276147

Changes made in this series:
* Improve comment in 3/8 and fix grammar in 5/8.
* Fix the test in t1430 to check stderr for the broken ref warning.
* Instead of showing the detached head, reducing the no of array elements
and displaying all of the other refs and then free'ing all of the refs. We
now free the detached head ref immediately after displaying so we don't have
to bother about decrementing and incrementing the no of array elements.
* 

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
 builtin/branch.c             | 506 +++++++++++++------------------------------
 ref-filter.c                 |   4 +-
 ref-filter.h                 |   8 +-
 t/t1430-bad-ref-name.sh      |   2 +-
 t/t3203-branch-output.sh     |  20 ++
 6 files changed, 197 insertions(+), 356 deletions(-)

Interdiff:

diff --git a/builtin/branch.c b/builtin/branch.c
index dd2fdbe..32a0d11 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -475,7 +475,7 @@ static int calc_maxwidth(struct ref_array *refs, int remote_bonus)
 
 static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sorting)
 {
-	int i, index;
+	int i;
 	struct ref_array array;
 	int maxwidth = 0;
 	const char *remote_prefix = "";
@@ -493,17 +493,16 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	memset(&array, 0, sizeof(array));
 
 	verify_ref_format("%(refname)%(symref)");
-	filter_refs(&array, filter, filter->kind);
+	filter_refs(&array, filter, filter->kind | FILTER_REFS_INCLUDE_BROKEN);
 
 	if (filter->verbose)
 		maxwidth = calc_maxwidth(&array, strlen(remote_prefix));
 
-	index = array.nr;
-
 	/* Print detached HEAD before sorting and printing the rest */
 	if (filter->kind & FILTER_REFS_DETACHED_HEAD) {
-		format_and_print_ref_item(array.items[index - 1], maxwidth, filter, remote_prefix);
-		array.nr -= 1;
+		format_and_print_ref_item(array.items[array.nr - 1], maxwidth, filter, remote_prefix);
+		free_array_item(array.items[array.nr - 1]);
+		array.nr--;
 	}
 
 	if (!sorting) {
@@ -517,7 +516,6 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	for (i = 0; i < array.nr; i++)
 		format_and_print_ref_item(array.items[i], maxwidth, filter, remote_prefix);
 
-	array.nr = index;
 	ref_array_clear(&array);
 }
 
diff --git a/ref-filter.c b/ref-filter.c
index 112feaa..3cd0c00 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1251,7 +1251,7 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 }
 
 /*  Free memory allocated for a ref_array_item */
-static void free_array_item(struct ref_array_item *item)
+void free_array_item(struct ref_array_item *item)
 {
 	free((char *)item->symref);
 	free(item);
diff --git a/ref-filter.h b/ref-filter.h
index 3e29e5d..3e25d84 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -89,6 +89,8 @@ struct ref_filter_cbdata {
  * filtered refs in the ref_array structure.
  */
 int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int type);
+/*  Clear memory allocated to a ref_array_item */
+void free_array_item(struct ref_array_item *item);
 /*  Clear all memory allocated to ref_array */
 void ref_array_clear(struct ref_array *array);
 /*  Parse format string and sort specifiers */
diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index dcf2931..db3627e 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -38,11 +38,11 @@ test_expect_success 'fast-import: fail on invalid branch name "bad[branch]name"'
 	test_must_fail git fast-import <input
 '
 
-test_expect_failure 'git branch shows badly named ref' '
-       cp .git/refs/heads/master .git/refs/heads/broken...ref &&
-       test_when_finished "rm -f .git/refs/heads/broken...ref" &&
-       git branch >output &&
-       grep -e "broken\.\.\.ref" output
+test_expect_success 'git branch shows badly named ref as warning' '
+	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	git branch 2>output &&
+	grep -e "broken\.\.\.ref" output
 '
 
 test_expect_success 'branch -d can delete badly named ref' '
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 1deb7cb..c819f3e 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -144,21 +144,21 @@ EOF
 '
 
 test_expect_success 'git branch `--sort` option' '
-	cat >expect <<EOF &&
-* (HEAD detached from fromtag)
-  branch-two
-  branch-one
-  master
-EOF
+	cat >expect <<-\EOF &&
+	* (HEAD detached from fromtag)
+	  branch-two
+	  branch-one
+	  master
+	EOF
 	git branch --sort=objectsize >actual &&
 	test_i18ncmp expect actual
 '
 
 test_expect_success 'git branch --points-at option' '
-	cat >expect <<EOF &&
-  master
-  branch-one
-EOF
+	cat >expect <<-\EOF &&
+	  master
+	  branch-one
+	EOF
 	git branch --points-at=branch-one >actual &&
 	test_cmp expect actual
 '


-- 
2.5.0
