From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 2/9] bisect.c: convert to use struct object_id
Date: Sat,  3 May 2014 20:12:15 +0000
Message-ID: <1399147942-165308-3-git-send-email-sandals@crustytoothpaste.net>
References: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 22:13:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WggIq-0005FK-4Q
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 22:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753351AbaECUMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 16:12:48 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47528 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753066AbaECUM2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 May 2014 16:12:28 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 1A7D228089
	for <git@vger.kernel.org>; Sat,  3 May 2014 20:12:27 +0000 (UTC)
X-Mailer: git-send-email 2.0.0.rc0
In-Reply-To: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 () ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248056>

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 bisect.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/bisect.c b/bisect.c
index d6e851d..fe53214 100644
--- a/bisect.c
+++ b/bisect.c
@@ -15,7 +15,7 @@
 static struct sha1_array good_revs;
 static struct sha1_array skipped_revs;
 
-static unsigned char *current_bad_sha1;
+static struct object_id *current_bad_sha1;
 
 static const char *argv_checkout[] = {"checkout", "-q", NULL, "--", NULL};
 static const char *argv_show_branch[] = {"show-branch", NULL, NULL};
@@ -403,8 +403,8 @@ static int register_ref(const char *refname, const unsigned char *sha1,
 			int flags, void *cb_data)
 {
 	if (!strcmp(refname, "bad")) {
-		current_bad_sha1 = xmalloc(20);
-		hashcpy(current_bad_sha1, sha1);
+		current_bad_sha1 = xmalloc(sizeof(*current_bad_sha1));
+		hashcpy(current_bad_sha1->oid, sha1);
 	} else if (starts_with(refname, "good-")) {
 		sha1_array_append(&good_revs, sha1);
 	} else if (starts_with(refname, "skip-")) {
@@ -563,7 +563,7 @@ static struct commit_list *skip_away(struct commit_list *list, int count)
 
 	for (i = 0; cur; cur = cur->next, i++) {
 		if (i == index) {
-			if (hashcmp(cur->item->object.sha1, current_bad_sha1))
+			if (hashcmp(cur->item->object.sha1, current_bad_sha1->oid))
 				return cur;
 			if (previous)
 				return previous;
@@ -606,7 +606,7 @@ static void bisect_rev_setup(struct rev_info *revs, const char *prefix,
 
 	/* rev_argv.argv[0] will be ignored by setup_revisions */
 	argv_array_push(&rev_argv, "bisect_rev_setup");
-	argv_array_pushf(&rev_argv, bad_format, sha1_to_hex(current_bad_sha1));
+	argv_array_pushf(&rev_argv, bad_format, sha1_to_hex(current_bad_sha1->oid));
 	for (i = 0; i < good_revs.nr; i++)
 		argv_array_pushf(&rev_argv, good_format,
 				 sha1_to_hex(good_revs.sha1[i]));
@@ -627,7 +627,7 @@ static void bisect_common(struct rev_info *revs)
 }
 
 static void exit_if_skipped_commits(struct commit_list *tried,
-				    const unsigned char *bad)
+				    const struct object_id *bad)
 {
 	if (!tried)
 		return;
@@ -636,12 +636,12 @@ static void exit_if_skipped_commits(struct commit_list *tried,
 	       "The first bad commit could be any of:\n");
 	print_commit_list(tried, "%s\n", "%s\n");
 	if (bad)
-		printf("%s\n", sha1_to_hex(bad));
+		printf("%s\n", sha1_to_hex(bad->oid));
 	printf("We cannot bisect more!\n");
 	exit(2);
 }
 
-static int is_expected_rev(const unsigned char *sha1)
+static int is_expected_rev(const struct object_id *sha1)
 {
 	const char *filename = git_path("BISECT_EXPECTED_REV");
 	struct stat st;
@@ -657,7 +657,7 @@ static int is_expected_rev(const unsigned char *sha1)
 		return 0;
 
 	if (strbuf_getline(&str, fp, '\n') != EOF)
-		res = !strcmp(str.buf, sha1_to_hex(sha1));
+		res = !strcmp(str.buf, sha1_to_hex(sha1->oid));
 
 	strbuf_release(&str);
 	fclose(fp);
@@ -718,7 +718,7 @@ static struct commit **get_bad_and_good_commits(int *rev_nr)
 	struct commit **rev = xmalloc(len * sizeof(*rev));
 	int i, n = 0;
 
-	rev[n++] = get_commit_reference(current_bad_sha1);
+	rev[n++] = get_commit_reference(current_bad_sha1->oid);
 	for (i = 0; i < good_revs.nr; i++)
 		rev[n++] = get_commit_reference(good_revs.sha1[i]);
 	*rev_nr = n;
@@ -729,7 +729,7 @@ static struct commit **get_bad_and_good_commits(int *rev_nr)
 static void handle_bad_merge_base(void)
 {
 	if (is_expected_rev(current_bad_sha1)) {
-		char *bad_hex = sha1_to_hex(current_bad_sha1);
+		char *bad_hex = sha1_to_hex(current_bad_sha1->oid);
 		char *good_hex = join_sha1_array_hex(&good_revs, ' ');
 
 		fprintf(stderr, "The merge base %s is bad.\n"
@@ -749,7 +749,7 @@ static void handle_bad_merge_base(void)
 static void handle_skipped_merge_base(const unsigned char *mb)
 {
 	char *mb_hex = sha1_to_hex(mb);
-	char *bad_hex = sha1_to_hex(current_bad_sha1);
+	char *bad_hex = sha1_to_hex(current_bad_sha1->oid);
 	char *good_hex = join_sha1_array_hex(&good_revs, ' ');
 
 	warning("the merge base between %s and [%s] "
@@ -780,7 +780,7 @@ static void check_merge_bases(int no_checkout)
 
 	for (; result; result = result->next) {
 		const unsigned char *mb = result->item->object.sha1;
-		if (!hashcmp(mb, current_bad_sha1)) {
+		if (!hashcmp(mb, current_bad_sha1->oid)) {
 			handle_bad_merge_base();
 		} else if (0 <= sha1_array_lookup(&good_revs, mb)) {
 			continue;
@@ -926,7 +926,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 		exit_if_skipped_commits(tried, NULL);
 
 		printf("%s was both good and bad\n",
-		       sha1_to_hex(current_bad_sha1));
+		       sha1_to_hex(current_bad_sha1->oid));
 		exit(1);
 	}
 
@@ -939,7 +939,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	bisect_rev = revs.commits->item->object.sha1;
 	memcpy(bisect_rev_hex, sha1_to_hex(bisect_rev), 41);
 
-	if (!hashcmp(bisect_rev, current_bad_sha1)) {
+	if (!hashcmp(bisect_rev, current_bad_sha1->oid)) {
 		exit_if_skipped_commits(tried, current_bad_sha1);
 		printf("%s is the first bad commit\n", bisect_rev_hex);
 		show_diff_tree(prefix, revs.commits->item);
-- 
2.0.0.rc0
