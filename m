From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 08/10] bisect: implement the "check_merge_bases" function
Date: Sat, 09 May 2009 17:55:45 +0200
Message-ID: <20090509155548.5387.22043.chriscool@tuxfamily.org>
References: <20090509154419.5324.96204.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 09 18:05:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2p2g-0006Vt-Bu
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 18:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754814AbZEIQEB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 12:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754425AbZEIQD7
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 12:03:59 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:36603 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752966AbZEIQDl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 12:03:41 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 7477D94013F;
	Sat,  9 May 2009 18:03:35 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 68FEC940148;
	Sat,  9 May 2009 18:03:33 +0200 (CEST)
X-git-sha1: 8a4d17988612656ebc97ff62d7957585ef99273d 
X-Mailer: git-mail-commits v0.4.0
In-Reply-To: <20090509154419.5324.96204.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118667>

And all functions needed to make it work.

This is a port from the shell function with the same name
"git-bisect.sh". This function is not used yet but it will be used
later.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.c |  130 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 130 insertions(+), 0 deletions(-)

diff --git a/bisect.c b/bisect.c
index d2a34d1..b24ee78 100644
--- a/bisect.c
+++ b/bisect.c
@@ -507,6 +507,20 @@ static int lookup_sha1_array(struct sha1_array *array,
 	return sha1_pos(sha1, array->sha1, array->sha1_nr, sha1_access);
 }
 
+static char *join_sha1_array_hex(struct sha1_array *array, char delim)
+{
+	struct strbuf joined_hexs = STRBUF_INIT;
+	int i;
+
+	for (i = 0; i < array->sha1_nr; i++) {
+		strbuf_addstr(&joined_hexs, sha1_to_hex(array->sha1[i]));
+		if (i + 1 < array->sha1_nr)
+			strbuf_addch(&joined_hexs, delim);
+	}
+
+	return strbuf_detach(&joined_hexs, NULL);
+}
+
 struct commit_list *filter_skipped(struct commit_list *list,
 				   struct commit_list **tried,
 				   int show_all)
@@ -587,6 +601,30 @@ static void exit_if_skipped_commits(struct commit_list *tried,
 	exit(2);
 }
 
+static int is_expected_rev(const unsigned char *sha1)
+{
+	const char *filename = git_path("BISECT_EXPECTED_REV");
+	struct stat st;
+	struct strbuf str = STRBUF_INIT;
+	FILE *fp;
+	int res = 0;
+
+	if (stat(filename, &st) || !S_ISREG(st.st_mode))
+		return 0;
+
+	fp = fopen(filename, "r");
+	if (!fp)
+		return 0;
+
+	if (strbuf_getline(&str, fp, '\n') != EOF)
+		res = !strcmp(str.buf, sha1_to_hex(sha1));
+
+	strbuf_release(&str);
+	fclose(fp);
+
+	return res;
+}
+
 static void mark_expected_rev(char *bisect_rev_hex)
 {
 	int len = strlen(bisect_rev_hex);
@@ -620,6 +658,98 @@ static int bisect_checkout(char *bisect_rev_hex)
 	return run_command_v_opt(argv_show_branch, RUN_GIT_CMD);
 }
 
+static struct commit *get_commit_reference(const unsigned char *sha1)
+{
+	struct commit *r = lookup_commit_reference(sha1);
+	if (!r)
+		die("Not a valid commit name %s", sha1_to_hex(sha1));
+	return r;
+}
+
+static struct commit **get_bad_and_good_commits(int *rev_nr)
+{
+	int len = 1 + good_revs.sha1_nr;
+	struct commit **rev = xmalloc(len * sizeof(*rev));
+	int i, n = 0;
+
+	rev[n++] = get_commit_reference(current_bad_sha1);
+	for (i = 0; i < good_revs.sha1_nr; i++)
+		rev[n++] = get_commit_reference(good_revs.sha1[i]);
+	*rev_nr = n;
+
+	return rev;
+}
+
+static void handle_bad_merge_base(void)
+{
+	if (is_expected_rev(current_bad_sha1)) {
+		char *bad_hex = sha1_to_hex(current_bad_sha1);
+		char *good_hex = join_sha1_array_hex(&good_revs, ' ');
+
+		fprintf(stderr, "The merge base %s is bad.\n"
+			"This means the bug has been fixed "
+			"between %s and [%s].\n",
+			bad_hex, bad_hex, good_hex);
+
+		exit(3);
+	}
+
+	fprintf(stderr, "Some good revs are not ancestor of the bad rev.\n"
+		"git bisect cannot work properly in this case.\n"
+		"Maybe you mistake good and bad revs?\n");
+	exit(1);
+}
+
+void handle_skipped_merge_base(const unsigned char *mb)
+{
+	char *mb_hex = sha1_to_hex(mb);
+	char *bad_hex = sha1_to_hex(current_bad_sha1);
+	char *good_hex = join_sha1_array_hex(&good_revs, ' ');
+
+	fprintf(stderr, "Warning: the merge base between %s and [%s] "
+		"must be skipped.\n"
+		"So we cannot be sure the first bad commit is "
+		"between %s and %s.\n"
+		"We continue anyway.\n",
+		bad_hex, good_hex, mb_hex, bad_hex);
+	free(good_hex);
+}
+
+/*
+ * "check_merge_bases" checks that merge bases are not "bad".
+ *
+ * - If one is "bad", it means the user assumed something wrong
+ * and we must exit with a non 0 error code.
+ * - If one is "good", that's good, we have nothing to do.
+ * - If one is "skipped", we can't know but we should warn.
+ * - If we don't know, we should check it out and ask the user to test.
+ */
+static void check_merge_bases(void)
+{
+	struct commit_list *result;
+	int rev_nr;
+	struct commit **rev = get_bad_and_good_commits(&rev_nr);
+
+	result = get_merge_bases_many(rev[0], rev_nr - 1, rev + 1, 0);
+
+	for (; result; result = result->next) {
+		const unsigned char *mb = result->item->object.sha1;
+		if (!hashcmp(mb, current_bad_sha1)) {
+			handle_bad_merge_base();
+		} else if (0 <= lookup_sha1_array(&good_revs, mb)) {
+			continue;
+		} else if (0 <= lookup_sha1_array(&skipped_revs, mb)) {
+			handle_skipped_merge_base(mb);
+		} else {
+			printf("Bisecting: a merge base must be tested\n");
+			exit(bisect_checkout(sha1_to_hex(mb)));
+		}
+	}
+
+	free(rev);
+	free_commit_list(result);
+}
+
 /*
  * We use the convention that exiting with an exit code 10 means that
  * the bisection process finished successfully.
-- 
1.6.3.rc1.112.g17e25
