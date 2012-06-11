From: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
Subject: [PATCHv3 2/2] Warnings before amending published history
Date: Mon, 11 Jun 2012 23:56:21 +0200
Message-ID: <1339451781-29324-2-git-send-email-Lucien.Kong@ensimag.imag.fr>
References: <1339409091-28150-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1339451781-29324-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Cc: Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 11 23:56:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeCbA-0005PM-OA
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 23:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392Ab2FKV42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 17:56:28 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59770 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751856Ab2FKV40 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 17:56:26 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5BLlQP9004769
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 11 Jun 2012 23:47:26 +0200
Received: from ensibm.imag.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q5BLuLS3022922;
	Mon, 11 Jun 2012 23:56:21 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id q5BLuLsX029676;
	Mon, 11 Jun 2012 23:56:21 +0200
Received: (from konglu@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id q5BLuLYl029675;
	Mon, 11 Jun 2012 23:56:21 +0200
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1339451781-29324-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 11 Jun 2012 23:47:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5BLlQP9004769
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: lucien.kong@phelma.grenoble-inp.fr
MailScanner-NULL-Check: 1340056050.25058@g9RjeCXzj2JlV2nAH0vvaQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199739>

This code detects that one is rewriting a commit that is an ancestor
of a remote-tracking branch with "git commit --amend", and warns the
user through the editor.

Signed-off-by: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
Signed-off-by: Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>
Signed-off-by: Franck Jonas <Franck.Jonas@ensimag.imag.fr>
Signed-off-by: Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
Signed-off-by: Huynh Khoi Nguyen Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---
At this point, this feature is not controlled by the config key
rebase.checkremoterefs. Also, the code can only detects the commits
that were published on the same current branch.

 builtin/commit.c              |   82 ++++++++++++++++++++++++++
 sha1_name.c                   |   95 +++++++-----------------------
 sha1_name.h                   |  130 +++++++++++++++++++++++++++++++++++++++++
 t/t3404-rebase-interactive.sh |   65 ++++++++++++++++++++
 4 files changed, 298 insertions(+), 74 deletions(-)
 create mode 100644 sha1_name.h

diff --git a/builtin/commit.c b/builtin/commit.c
index f43eaaf..53fe120 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -28,6 +28,7 @@
 #include "submodule.h"
 #include "gpg-interface.h"
 #include "column.h"
+#include "sha1_name.h"
 
 static const char * const builtin_commit_usage[] = {
 	"git commit [options] [--] <filepattern>...",
@@ -584,6 +585,83 @@ static char *cut_ident_timestamp_part(char *string)
 	return ket;
 }
 
+static char *read_line_from_git_path(const char *filename)
+{
+	struct strbuf buf = STRBUF_INIT;
+	FILE *fp = fopen(git_path("%s", filename), "r");
+	if (!fp) {
+		strbuf_release(&buf);
+		return NULL;
+	}
+	strbuf_getline(&buf, fp, '\n');
+	if (!fclose(fp))
+		return strbuf_detach(&buf, NULL);
+	else
+		return NULL;
+}
+
+static int insert_first_line_file(char *to_write, char *file_to_modify)
+{
+	int c;
+	FILE *tmp = tmpfile();
+	FILE *file = fopen(file_to_modify, "r+");
+	if (!file || !tmp)
+		return 0;
+
+	while ((c = fgetc(file)) != EOF)
+		fputc(c, tmp);
+
+	rewind(file);
+	rewind(tmp);
+	fputs(to_write, file);
+	while ((c = fgetc(tmp)) != EOF)
+		fputc(c, file);
+
+	fclose(tmp);
+	fclose(file);
+	return 1;
+}
+
+static int amend_warn_published(void)
+{
+	char *head_path = read_line_from_git_path("HEAD");
+	char *last_commit_sha1;
+	char remote_path[PATH_MAX] = "refs/remotes/origin/";
+	char *remote_branch;
+	unsigned char nth_ancestor_remote_sha1[20];
+	int i = 0;
+
+	if (!head_path)
+		return 0;
+
+	strtok(head_path, " ");
+	last_commit_sha1 = read_line_from_git_path(strtok(NULL, ""));
+	if (!last_commit_sha1)
+		return 0;
+
+	remote_branch = read_line_from_git_path("HEAD");
+	if (!remote_branch)
+		return 0;
+
+	strtok(remote_branch, "/");
+	strtok(NULL, "/");
+	strcat(remote_path, strtok(NULL, ""));
+
+	while (!get_nth_ancestor(remote_path, 40, nth_ancestor_remote_sha1, i)) {
+		if (!strcmp(sha1_to_hex(nth_ancestor_remote_sha1), last_commit_sha1)) {
+			insert_first_line_file("# The commit to reword is already published.\n\n",
+					git_path(commit_editmsg));
+			break;
+		}
+		i++;
+	}
+
+	free(head_path);
+	free(last_commit_sha1);
+	free(remote_branch);
+	return 1;
+}
+
 static int prepare_to_commit(const char *index_file, const char *prefix,
 			     struct commit *current_head,
 			     struct wt_status *s,
@@ -840,6 +918,10 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		const char *env[2] = { NULL };
 		env[0] =  index;
 		snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
+
+		if (amend)
+			amend_warn_published();
+
 		if (launch_editor(git_path(commit_editmsg), NULL, env)) {
 			fprintf(stderr,
 			_("Please supply the message using either -m or -F option.\n"));
diff --git a/sha1_name.c b/sha1_name.c
index c633113..14a0e96 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "sha1_name.h"
 #include "tag.h"
 #include "commit.h"
 #include "tree.h"
@@ -7,9 +8,7 @@
 #include "refs.h"
 #include "remote.h"
 
-static int get_sha1_oneline(const char *, unsigned char *, struct commit_list *);
-
-static int find_short_object_filename(int len, const char *name, unsigned char *sha1)
+int find_short_object_filename(int len, const char *name, unsigned char *sha1)
 {
 	struct alternate_object_database *alt;
 	char hex[40];
@@ -56,7 +55,7 @@ static int find_short_object_filename(int len, const char *name, unsigned char *
 	return found;
 }
 
-static int match_sha(unsigned len, const unsigned char *a, const unsigned char *b)
+int match_sha(unsigned len, const unsigned char *a, const unsigned char *b)
 {
 	do {
 		if (*a != *b)
@@ -71,7 +70,7 @@ static int match_sha(unsigned len, const unsigned char *a, const unsigned char *
 	return 1;
 }
 
-static int find_short_packed_object(int len, const unsigned char *match, unsigned char *sha1)
+int find_short_packed_object(int len, const unsigned char *match, unsigned char *sha1)
 {
 	struct packed_git *p;
 	const unsigned char *found_sha1 = NULL;
@@ -130,10 +129,7 @@ static int find_short_packed_object(int len, const unsigned char *match, unsigne
 	return found;
 }
 
-#define SHORT_NAME_NOT_FOUND (-1)
-#define SHORT_NAME_AMBIGUOUS (-2)
-
-static int find_unique_short_object(int len, char *canonical,
+int find_unique_short_object(int len, char *canonical,
 				    unsigned char *res, unsigned char *sha1)
 {
 	int has_unpacked, has_packed;
@@ -157,7 +153,7 @@ static int find_unique_short_object(int len, char *canonical,
 	return 0;
 }
 
-static int get_short_sha1(const char *name, int len, unsigned char *sha1,
+int get_short_sha1(const char *name, int len, unsigned char *sha1,
 			  int quietly)
 {
 	int i, status;
@@ -216,7 +212,7 @@ const char *find_unique_abbrev(const unsigned char *sha1, int len)
 	return hex;
 }
 
-static int ambiguous_path(const char *path, int len)
+int ambiguous_path(const char *path, int len)
 {
 	int slash = 1;
 	int cnt;
@@ -241,7 +237,7 @@ static int ambiguous_path(const char *path, int len)
 	return slash;
 }
 
-static inline int upstream_mark(const char *string, int len)
+inline int upstream_mark(const char *string, int len)
 {
 	const char *suffix[] = { "@{upstream}", "@{u}" };
 	int i;
@@ -255,9 +251,7 @@ static inline int upstream_mark(const char *string, int len)
 	return 0;
 }
 
-static int get_sha1_1(const char *name, int len, unsigned char *sha1);
-
-static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
+int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 {
 	static const char *warn_msg = "refname '%.*s' is ambiguous.";
 	char *real_ref = NULL;
@@ -358,7 +352,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 	return 0;
 }
 
-static int get_parent(const char *name, int len,
+int get_parent(const char *name, int len,
 		      unsigned char *result, int idx)
 {
 	unsigned char sha1[20];
@@ -388,7 +382,7 @@ static int get_parent(const char *name, int len,
 	return -1;
 }
 
-static int get_nth_ancestor(const char *name, int len,
+int get_nth_ancestor(const char *name, int len,
 			    unsigned char *result, int generation)
 {
 	unsigned char sha1[20];
@@ -436,7 +430,7 @@ struct object *peel_to_type(const char *name, int namelen,
 	}
 }
 
-static int peel_onion(const char *name, int len, unsigned char *sha1)
+int peel_onion(const char *name, int len, unsigned char *sha1)
 {
 	unsigned char outer[20];
 	const char *sp;
@@ -522,7 +516,7 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
 	return 0;
 }
 
-static int get_describe_name(const char *name, int len, unsigned char *sha1)
+int get_describe_name(const char *name, int len, unsigned char *sha1)
 {
 	const char *cp;
 
@@ -542,7 +536,7 @@ static int get_describe_name(const char *name, int len, unsigned char *sha1)
 	return -1;
 }
 
-static int get_sha1_1(const char *name, int len, unsigned char *sha1)
+int get_sha1_1(const char *name, int len, unsigned char *sha1)
 {
 	int ret, has_suffix;
 	const char *cp;
@@ -590,17 +584,7 @@ static int get_sha1_1(const char *name, int len, unsigned char *sha1)
 	return get_short_sha1(name, len, sha1, 0);
 }
 
-/*
- * This interprets names like ':/Initial revision of "git"' by searching
- * through history and returning the first commit whose message starts
- * the given regular expression.
- *
- * For future extension, ':/!' is reserved. If you want to match a message
- * beginning with a '!', you have to repeat the exclamation mark.
- */
-#define ONELINE_SEEN (1u<<20)
-
-static int handle_one_ref(const char *path,
+int handle_one_ref(const char *path,
 		const unsigned char *sha1, int flag, void *cb_data)
 {
 	struct commit_list **list = cb_data;
@@ -618,7 +602,7 @@ static int handle_one_ref(const char *path,
 	return 0;
 }
 
-static int get_sha1_oneline(const char *prefix, unsigned char *sha1,
+int get_sha1_oneline(const char *prefix, unsigned char *sha1,
 			    struct commit_list *list)
 {
 	struct commit_list *backup = NULL, *l;
@@ -675,12 +659,7 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1,
 	return found ? 0 : -1;
 }
 
-struct grab_nth_branch_switch_cbdata {
-	long cnt, alloc;
-	struct strbuf *buf;
-};
-
-static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
+int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
 				  const char *email, unsigned long timestamp, int tz,
 				  const char *message, void *cb_data)
 {
@@ -704,11 +683,7 @@ static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
 	return 0;
 }
 
-/*
- * Parse @{-N} syntax, return the number of characters parsed
- * if successful; otherwise signal an error with negative value.
- */
-static int interpret_nth_prior_checkout(const char *name, struct strbuf *buf)
+int interpret_nth_prior_checkout(const char *name, struct strbuf *buf)
 {
 	long nth;
 	int i, retval;
@@ -794,27 +769,6 @@ int get_sha1_mb(const char *name, unsigned char *sha1)
 	return st;
 }
 
-/*
- * This reads short-hand syntax that not only evaluates to a commit
- * object name, but also can act as if the end user spelled the name
- * of the branch from the command line.
- *
- * - "@{-N}" finds the name of the Nth previous branch we were on, and
- *   places the name of the branch in the given buf and returns the
- *   number of characters parsed if successful.
- *
- * - "<branch>@{upstream}" finds the name of the other ref that
- *   <branch> is configured to merge with (missing <branch> defaults
- *   to the current branch), and places the name of the branch in the
- *   given buf and returns the number of characters parsed if
- *   successful.
- *
- * If the input is not of the accepted format, it returns a negative
- * number to signal an error.
- *
- * If the input was ok but there are not N branch switches in the
- * reflog, it returns 0.
- */
 int interpret_branch_name(const char *name, struct strbuf *buf)
 {
 	char *cp;
@@ -898,18 +852,13 @@ int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
 	return check_refname_format(sb->buf, 0);
 }
 
-/*
- * This is like "get_sha1_basic()", except it allows "sha1 expressions",
- * notably "xyz^" for "parent of xyz"
- */
 int get_sha1(const char *name, unsigned char *sha1)
 {
 	struct object_context unused;
 	return get_sha1_with_context(name, sha1, &unused);
 }
 
-/* Must be called only when object_name:filename doesn't exist. */
-static void diagnose_invalid_sha1_path(const char *prefix,
+void diagnose_invalid_sha1_path(const char *prefix,
 				       const char *filename,
 				       const unsigned char *tree_sha1,
 				       const char *object_name)
@@ -946,8 +895,7 @@ static void diagnose_invalid_sha1_path(const char *prefix,
 	}
 }
 
-/* Must be called only when :stage:filename doesn't exist. */
-static void diagnose_invalid_index_path(int stage,
+void diagnose_invalid_index_path(int stage,
 					const char *prefix,
 					const char *filename)
 {
@@ -1003,7 +951,6 @@ static void diagnose_invalid_index_path(int stage,
 	free(fullname);
 }
 
-
 int get_sha1_with_mode_1(const char *name, unsigned char *sha1, unsigned *mode,
 			 int only_to_die, const char *prefix)
 {
@@ -1014,7 +961,7 @@ int get_sha1_with_mode_1(const char *name, unsigned char *sha1, unsigned *mode,
 	return ret;
 }
 
-static char *resolve_relative_path(const char *rel)
+char *resolve_relative_path(const char *rel)
 {
 	if (prefixcmp(rel, "./") && prefixcmp(rel, "../"))
 		return NULL;
diff --git a/sha1_name.h b/sha1_name.h
new file mode 100644
index 0000000..bdbcecd
--- /dev/null
+++ b/sha1_name.h
@@ -0,0 +1,130 @@
+#ifndef SHA1_NAME_H
+#define SHA1_NAME_H
+
+#include "commit.h"
+
+int find_short_object_filename(int len, const char *name, unsigned char *sha1);
+
+int match_sha(unsigned len, const unsigned char *a, const unsigned char *b);
+
+int find_short_packed_object(int len, const unsigned char *match, unsigned char *sha1);
+
+#define SHORT_NAME_NOT_FOUND (-1)
+#define SHORT_NAME_AMBIGUOUS (-2)
+
+int find_unique_short_object(int len, char *canonical,
+				    unsigned char *res, unsigned char *sha1);
+
+int get_short_sha1(const char *name, int len, unsigned char *sha1,
+			  int quietly);
+
+const char *find_unique_abbrev(const unsigned char *sha1, int len);
+
+int ambiguous_path(const char *path, int len);
+
+inline int upstream_mark(const char *string, int len);
+
+int get_sha1_basic(const char *str, int len, unsigned char *sha1);
+
+int get_parent(const char *name, int len,
+		      unsigned char *result, int idx);
+
+int get_nth_ancestor(const char *name, int len,
+			    unsigned char *result, int generation);
+
+struct object *peel_to_type(const char *name, int namelen,
+			    struct object *o, enum object_type expected_type);
+
+int peel_onion(const char *name, int len, unsigned char *sha1);
+
+int get_describe_name(const char *name, int len, unsigned char *sha1);
+
+int get_sha1_1(const char *name, int len, unsigned char *sha1);
+
+/*
+ * This interprets names like ':/Initial revision of "git"' by searching
+ * through history and returning the first commit whose message starts
+ * the given regular expression.
+ *
+ * For future extension, ':/!' is reserved. If you want to match a message
+ * beginning with a '!', you have to repeat the exclamation mark.
+ */
+#define ONELINE_SEEN (1u<<20)
+
+int handle_one_ref(const char *path,
+		const unsigned char *sha1, int flag, void *cb_data);
+
+int get_sha1_oneline(const char *prefix, unsigned char *sha1,
+			    struct commit_list *list);
+
+struct grab_nth_branch_switch_cbdata {
+	long cnt, alloc;
+	struct strbuf *buf;
+};
+
+int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
+				  const char *email, unsigned long timestamp, int tz,
+				  const char *message, void *cb_data);
+
+/*
+ * Parse @{-N} syntax, return the number of characters parsed
+ * if successful; otherwise signal an error with negative value.
+ */
+int interpret_nth_prior_checkout(const char *name, struct strbuf *buf);
+
+int get_sha1_mb(const char *name, unsigned char *sha1);
+
+/*
+ * This reads short-hand syntax that not only evaluates to a commit
+ * object name, but also can act as if the end user spelled the name
+ * of the branch from the command line.
+ *
+ * - "@{-N}" finds the name of the Nth previous branch we were on, and
+ *   places the name of the branch in the given buf and returns the
+ *   number of characters parsed if successful.
+ *
+ * - "<branch>@{upstream}" finds the name of the other ref that
+ *   <branch> is configured to merge with (missing <branch> defaults
+ *   to the current branch), and places the name of the branch in the
+ *   given buf and returns the number of characters parsed if
+ *   successful.
+ *
+ * If the input is not of the accepted format, it returns a negative
+ * number to signal an error.
+ *
+ * If the input was ok but there are not N branch switches in the
+ * reflog, it returns 0.
+ */
+int interpret_branch_name(const char *name, struct strbuf *buf);
+
+int strbuf_branchname(struct strbuf *sb, const char *name);
+
+int strbuf_check_branch_ref(struct strbuf *sb, const char *name);
+
+/*
+ * This is like "get_sha1_basic()", except it allows "sha1 expressions",
+ * notably "xyz^" for "parent of xyz"
+ */
+int get_sha1(const char *name, unsigned char *sha1);
+
+/* Must be called only when object_name:filename doesn't exist. */
+void diagnose_invalid_sha1_path(const char *prefix,
+				       const char *filename,
+				       const unsigned char *tree_sha1,
+				       const char *object_name);
+
+/* Must be called only when :stage:filename doesn't exist. */
+void diagnose_invalid_index_path(int stage,
+					const char *prefix,
+					const char *filename);
+
+int get_sha1_with_mode_1(const char *name, unsigned char *sha1, unsigned *mode,
+			 int only_to_die, const char *prefix);
+
+char *resolve_relative_path(const char *rel);
+
+int get_sha1_with_context_1(const char *name, unsigned char *sha1,
+			    struct object_context *oc,
+			    int only_to_die, const char *prefix);
+
+#endif
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 72934a5..fec448b 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -782,4 +782,69 @@ test_expect_success 'warn before rewriting published history' '
 	)
 '
 
+test_expect_success 'warn before rewriting published history: one user' '
+	test_when_finished "rm -rf git.git git" &&
+	git init git.git &&
+	git clone git &&
+	(
+		cd git &&
+		git config rebase.checkremoterefs true &&
+		test_commit one_commit main.txt one_commit &&
+		git push --all
+		set_copy_editor &&
+		TODO_DUMP=actual EDITOR=./editor.sh git commit --amend &&
+		tmp=$(cat actual | sed -n 1p) &&
+		echo "$tmp" >actual &&
+		echo "# The commit to reword is already published." >expected &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'warn before rewriting published history: several users' '
+	test_when_finished "rm -rf git.git git1 git2" &&
+	git init --bare --share git.git &&
+	git clone git.git git1 &&
+	git clone git.git git2 &&
+	(
+		cd git1 &&
+		test_commit one_commit main.txt one_commit &&
+		git push --all
+	) &&
+	(
+		cd git2 &&
+		git pull &&
+		test_commit two_commit main.txt two_commit &&
+		git push --all
+	) &&
+	(
+		cd git1 &&
+		git config rebase.checkremoterefs true &&
+		set_copy_editor &&
+		TODO_DUMP=actual EDITOR=./editor.sh git commit --amend &&
+		tmp=$(cat actual | sed -n 1p) &&
+		echo "$tmp" >actual &&
+		echo "# The commit to reword is already published." >expected &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'warn before rewriting published history: shared branch' '
+	test_when_finished "rm -rf git.git git" &&
+	git init git.git &&
+	git clone git &&
+	(
+		cd git &&
+		git config rebase.checkremoterefs true &&
+		git checkout -b sharedbranch &&
+		test_commit one_commit main.txt one_commit &&
+		git push --set-upstream origin sharedbranch &&
+		set_copy_editor &&
+		TODO_DUMP=actual EDITOR=./editor.sh git commit --amend &&
+		tmp=$(cat actual | sed -n 1p) &&
+		echo "$tmp" >actual &&
+		echo "# The commit to reword is already published." >expected &&
+		test_cmp expected actual
+	)
+'
+
 test_done
-- 
1.7.8
