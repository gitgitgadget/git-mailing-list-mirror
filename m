From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 03/10] bisect.c: convert leaf functions to use struct object_id
Date: Sat,  7 Mar 2015 23:23:58 +0000
Message-ID: <1425770645-628957-4-git-send-email-sandals@crustytoothpaste.net>
References: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Andreas Schwab <schwab@linux-m68k.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 00:24:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUO5J-0001mM-9d
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 00:24:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753302AbbCGXYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2015 18:24:38 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49827 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753117AbbCGXYR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Mar 2015 18:24:17 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id AAA2228094;
	Sat,  7 Mar 2015 23:24:15 +0000 (UTC)
X-Mailer: git-send-email 2.2.1.209.g41e5f3a
In-Reply-To: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265018>

Convert some constants to GIT_SHA1_HEXSZ.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 bisect.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/bisect.c b/bisect.c
index 8c6d843..2692d54 100644
--- a/bisect.c
+++ b/bisect.c
@@ -15,7 +15,7 @@
 static struct sha1_array good_revs;
 static struct sha1_array skipped_revs;
 
-static unsigned char *current_bad_sha1;
+static struct object_id *current_bad_oid;
 
 static const char *argv_checkout[] = {"checkout", "-q", NULL, "--", NULL};
 static const char *argv_show_branch[] = {"show-branch", NULL, NULL};
@@ -404,8 +404,8 @@ static int register_ref(const char *refname, const unsigned char *sha1,
 			int flags, void *cb_data)
 {
 	if (!strcmp(refname, "bad")) {
-		current_bad_sha1 = xmalloc(20);
-		hashcpy(current_bad_sha1, sha1);
+		current_bad_oid = xmalloc(sizeof(*current_bad_oid));
+		hashcpy(current_bad_oid->sha1, sha1);
 	} else if (starts_with(refname, "good-")) {
 		sha1_array_append(&good_revs, sha1);
 	} else if (starts_with(refname, "skip-")) {
@@ -564,7 +564,7 @@ static struct commit_list *skip_away(struct commit_list *list, int count)
 
 	for (i = 0; cur; cur = cur->next, i++) {
 		if (i == index) {
-			if (hashcmp(cur->item->object.sha1, current_bad_sha1))
+			if (hashcmp(cur->item->object.sha1, current_bad_oid->sha1))
 				return cur;
 			if (previous)
 				return previous;
@@ -607,7 +607,7 @@ static void bisect_rev_setup(struct rev_info *revs, const char *prefix,
 
 	/* rev_argv.argv[0] will be ignored by setup_revisions */
 	argv_array_push(&rev_argv, "bisect_rev_setup");
-	argv_array_pushf(&rev_argv, bad_format, sha1_to_hex(current_bad_sha1));
+	argv_array_pushf(&rev_argv, bad_format, sha1_to_hex(current_bad_oid->sha1));
 	for (i = 0; i < good_revs.nr; i++)
 		argv_array_pushf(&rev_argv, good_format,
 				 sha1_to_hex(good_revs.sha1[i]));
@@ -628,7 +628,7 @@ static void bisect_common(struct rev_info *revs)
 }
 
 static void exit_if_skipped_commits(struct commit_list *tried,
-				    const unsigned char *bad)
+				    const struct object_id *bad)
 {
 	if (!tried)
 		return;
@@ -637,12 +637,12 @@ static void exit_if_skipped_commits(struct commit_list *tried,
 	       "The first bad commit could be any of:\n");
 	print_commit_list(tried, "%s\n", "%s\n");
 	if (bad)
-		printf("%s\n", sha1_to_hex(bad));
+		printf("%s\n", oid_to_hex(bad));
 	printf("We cannot bisect more!\n");
 	exit(2);
 }
 
-static int is_expected_rev(const unsigned char *sha1)
+static int is_expected_rev(const struct object_id *oid)
 {
 	const char *filename = git_path("BISECT_EXPECTED_REV");
 	struct stat st;
@@ -658,7 +658,7 @@ static int is_expected_rev(const unsigned char *sha1)
 		return 0;
 
 	if (strbuf_getline(&str, fp, '\n') != EOF)
-		res = !strcmp(str.buf, sha1_to_hex(sha1));
+		res = !strcmp(str.buf, oid_to_hex(oid));
 
 	strbuf_release(&str);
 	fclose(fp);
@@ -719,7 +719,7 @@ static struct commit **get_bad_and_good_commits(int *rev_nr)
 	struct commit **rev = xmalloc(len * sizeof(*rev));
 	int i, n = 0;
 
-	rev[n++] = get_commit_reference(current_bad_sha1);
+	rev[n++] = get_commit_reference(current_bad_oid->sha1);
 	for (i = 0; i < good_revs.nr; i++)
 		rev[n++] = get_commit_reference(good_revs.sha1[i]);
 	*rev_nr = n;
@@ -729,8 +729,8 @@ static struct commit **get_bad_and_good_commits(int *rev_nr)
 
 static void handle_bad_merge_base(void)
 {
-	if (is_expected_rev(current_bad_sha1)) {
-		char *bad_hex = sha1_to_hex(current_bad_sha1);
+	if (is_expected_rev(current_bad_oid)) {
+		char *bad_hex = oid_to_hex(current_bad_oid);
 		char *good_hex = join_sha1_array_hex(&good_revs, ' ');
 
 		fprintf(stderr, "The merge base %s is bad.\n"
@@ -750,7 +750,7 @@ static void handle_bad_merge_base(void)
 static void handle_skipped_merge_base(const unsigned char *mb)
 {
 	char *mb_hex = sha1_to_hex(mb);
-	char *bad_hex = sha1_to_hex(current_bad_sha1);
+	char *bad_hex = sha1_to_hex(current_bad_oid->sha1);
 	char *good_hex = join_sha1_array_hex(&good_revs, ' ');
 
 	warning("the merge base between %s and [%s] "
@@ -781,7 +781,7 @@ static void check_merge_bases(int no_checkout)
 
 	for (; result; result = result->next) {
 		const unsigned char *mb = result->item->object.sha1;
-		if (!hashcmp(mb, current_bad_sha1)) {
+		if (!hashcmp(mb, current_bad_oid->sha1)) {
 			handle_bad_merge_base();
 		} else if (0 <= sha1_array_lookup(&good_revs, mb)) {
 			continue;
@@ -838,7 +838,7 @@ static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
 	struct stat st;
 	int fd;
 
-	if (!current_bad_sha1)
+	if (!current_bad_oid)
 		die("a bad revision is needed");
 
 	/* Check if file BISECT_ANCESTORS_OK exists. */
@@ -903,7 +903,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	struct commit_list *tried;
 	int reaches = 0, all = 0, nr, steps;
 	const unsigned char *bisect_rev;
-	char bisect_rev_hex[41];
+	char bisect_rev_hex[GIT_SHA1_HEXSZ + 1];
 
 	if (read_bisect_refs())
 		die("reading bisect refs failed");
@@ -927,7 +927,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 		exit_if_skipped_commits(tried, NULL);
 
 		printf("%s was both good and bad\n",
-		       sha1_to_hex(current_bad_sha1));
+		       oid_to_hex(current_bad_oid));
 		exit(1);
 	}
 
@@ -938,10 +938,10 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	}
 
 	bisect_rev = revs.commits->item->object.sha1;
-	memcpy(bisect_rev_hex, sha1_to_hex(bisect_rev), 41);
+	memcpy(bisect_rev_hex, sha1_to_hex(bisect_rev), GIT_SHA1_HEXSZ + 1);
 
-	if (!hashcmp(bisect_rev, current_bad_sha1)) {
-		exit_if_skipped_commits(tried, current_bad_sha1);
+	if (!hashcmp(bisect_rev, current_bad_oid->sha1)) {
+		exit_if_skipped_commits(tried, current_bad_oid);
 		printf("%s is the first bad commit\n", bisect_rev_hex);
 		show_diff_tree(prefix, revs.commits->item);
 		/* This means the bisection process succeeded. */
-- 
2.2.1.209.g41e5f3a
