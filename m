From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 07/10] Change incorrect "remote branch" to "remote tracking branch" in C code
Date: Tue,  2 Nov 2010 16:31:25 +0100
Message-ID: <1288711888-21528-8-git-send-email-Matthieu.Moy@imag.fr>
References: <1288711888-21528-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Nov 02 16:32:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDIqe-0003FI-05
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 16:32:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753845Ab0KBPc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 11:32:26 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35345 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753808Ab0KBPcY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 11:32:24 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id oA2FGnOC006385
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 2 Nov 2010 16:16:49 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PDIpw-00026c-OK; Tue, 02 Nov 2010 16:31:48 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PDIpw-0005cK-MO; Tue, 02 Nov 2010 16:31:48 +0100
X-Mailer: git-send-email 1.7.3.2.183.g2e7b0
In-Reply-To: <1288711888-21528-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 02 Nov 2010 16:16:49 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: oA2FGnOC006385
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1289315814.16784@fteF5iW1modf7XGU2+u3Lg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160528>

(Just like we did for documentation already)

In the process, we change "non-remote branch" to "branch outside the
refs/remotes/ hierarchy" to avoid the ugly "non-remote-tracking branch".
The new formulation actually corresponds to how the code detects this
case (i.e. prefixcmp(refname, "refs/remotes")).

Also, we use 'remote-tracking branch' in generated merge messages (by
merge an fmt-merge-msg).

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 branch.h                               |    4 ++--
 builtin/fetch.c                        |    2 +-
 builtin/fmt-merge-msg.c                |    6 +++---
 builtin/merge.c                        |    2 +-
 builtin/remote.c                       |    6 +++---
 contrib/examples/builtin-fetch--tool.c |    2 +-
 t/t1507-rev-parse-upstream.sh          |    2 +-
 t/t3409-rebase-preserve-merges.sh      |    2 +-
 t/t5505-remote.sh                      |    8 +++++---
 t/t7608-merge-messages.sh              |    4 ++--
 10 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/branch.h b/branch.h
index eed817a..4026e38 100644
--- a/branch.h
+++ b/branch.h
@@ -22,8 +22,8 @@ void create_branch(const char *head, const char *name, const char *start_name,
 void remove_branch_state(void);
 
 /*
- * Configure local branch "local" to merge remote branch "remote"
- * taken from origin "origin".
+ * Configure local branch "local" as downstream to branch "remote"
+ * from remote "origin".  Used by git branch --set-upstream.
  */
 #define BRANCH_CONFIG_VERBOSE 01
 extern void install_branch_config(int flag, const char *local, const char *origin, const char *remote);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 3b0b614..4243ef0 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -359,7 +359,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 			what = rm->name + 10;
 		}
 		else if (!prefixcmp(rm->name, "refs/remotes/")) {
-			kind = "remote branch";
+			kind = "remote-tracking branch";
 			what = rm->name + 13;
 		}
 		else {
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 78c7774..5189b16 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -100,8 +100,8 @@ static int handle_line(char *line)
 		origin = line;
 		string_list_append(&src_data->tag, origin + 4);
 		src_data->head_status |= 2;
-	} else if (!prefixcmp(line, "remote branch ")) {
-		origin = line + 14;
+	} else if (!prefixcmp(line, "remote-tracking branch ")) {
+		origin = line + strlen("remote-tracking branch ");
 		string_list_append(&src_data->r_branch, origin);
 		src_data->head_status |= 2;
 	} else {
@@ -233,7 +233,7 @@ static void do_fmt_merge_msg_title(struct strbuf *out,
 		if (src_data->r_branch.nr) {
 			strbuf_addstr(out, subsep);
 			subsep = ", ";
-			print_joined("remote branch ", "remote branches ",
+			print_joined("remote-tracking branch ", "remote-tracking branches ",
 					&src_data->r_branch, out);
 		}
 		if (src_data->tag.nr) {
diff --git a/builtin/merge.c b/builtin/merge.c
index 10f091b..9ec13f1 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -403,7 +403,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 			goto cleanup;
 		}
 		if (!prefixcmp(found_ref, "refs/remotes/")) {
-			strbuf_addf(msg, "%s\t\tremote branch '%s' of .\n",
+			strbuf_addf(msg, "%s\t\tremote-tracking branch '%s' of .\n",
 				    sha1_to_hex(branch_head), remote);
 			goto cleanup;
 		}
diff --git a/builtin/remote.c b/builtin/remote.c
index e9a6e09..6a06282 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -507,7 +507,7 @@ static int add_branch_for_removal(const char *refname,
 			return 0;
 	}
 
-	/* don't delete non-remote refs */
+	/* don't delete non-remote-tracking refs */
 	if (prefixcmp(refname, "refs/remotes")) {
 		/* advise user how to delete local branches */
 		if (!prefixcmp(refname, "refs/heads/"))
@@ -791,9 +791,9 @@ static int rm(int argc, const char **argv)
 
 	if (skipped.nr) {
 		fprintf(stderr, skipped.nr == 1 ?
-			"Note: A non-remote branch was not removed; "
+			"Note: A branch outside the refs/remotes/ hierarchy was not removed;\n"
 			"to delete it, use:\n" :
-			"Note: Non-remote branches were not removed; "
+			"Note: Some branches outside the refs/remotes/ hierarchy were not removed;\n"
 			"to delete them, use:\n");
 		for (i = 0; i < skipped.nr; i++)
 			fprintf(stderr, "  git branch -d %s\n",
diff --git a/contrib/examples/builtin-fetch--tool.c b/contrib/examples/builtin-fetch--tool.c
index cd10dbc..3140e40 100644
--- a/contrib/examples/builtin-fetch--tool.c
+++ b/contrib/examples/builtin-fetch--tool.c
@@ -148,7 +148,7 @@ static int append_fetch_head(FILE *fp,
 		what = remote_name + 10;
 	}
 	else if (!strncmp(remote_name, "refs/remotes/", 13)) {
-		kind = "remote branch";
+		kind = "remote-tracking branch";
 		what = remote_name + 13;
 	}
 	else {
diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index 8c8dfda..a455551 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -85,7 +85,7 @@ test_expect_success 'merge my-side@{u} records the correct name' '
 	git branch -t new my-side@{u} &&
 	git merge -s ours new@{u} &&
 	git show -s --pretty=format:%s >actual &&
-	echo "Merge remote branch ${sq}origin/side${sq}" >expect &&
+	echo "Merge remote-tracking branch ${sq}origin/side${sq}" >expect &&
 	test_cmp expect actual
 )
 '
diff --git a/t/t3409-rebase-preserve-merges.sh b/t/t3409-rebase-preserve-merges.sh
index 74161a4..19341e5 100755
--- a/t/t3409-rebase-preserve-merges.sh
+++ b/t/t3409-rebase-preserve-merges.sh
@@ -72,7 +72,7 @@ test_expect_success 'rebase -p fakes interactive rebase' '
 	git fetch &&
 	git rebase -p origin/topic &&
 	test 1 = $(git rev-list --all --pretty=oneline | grep "Modify A" | wc -l) &&
-	test 1 = $(git rev-list --all --pretty=oneline | grep "Merge remote branch " | wc -l)
+	test 1 = $(git rev-list --all --pretty=oneline | grep "Merge remote-tracking branch " | wc -l)
 	)
 '
 
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 5d1c66e..d189add 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -107,16 +107,18 @@ test_expect_success 'remove remote' '
 )
 '
 
-test_expect_success 'remove remote protects non-remote branches' '
+test_expect_success 'remove remote protects local branches' '
 (
 	cd test &&
 	{ cat >expect1 <<EOF
-Note: A non-remote branch was not removed; to delete it, use:
+Note: A branch outside the refs/remotes/ hierarchy was not removed;
+to delete it, use:
   git branch -d master
 EOF
 	} &&
 	{ cat >expect2 <<EOF
-Note: Non-remote branches were not removed; to delete them, use:
+Note: Some branches outside the refs/remotes/ hierarchy were not removed;
+to delete them, use:
   git branch -d foobranch
   git branch -d master
 EOF
diff --git a/t/t7608-merge-messages.sh b/t/t7608-merge-messages.sh
index 28d5679..9225fa6 100755
--- a/t/t7608-merge-messages.sh
+++ b/t/t7608-merge-messages.sh
@@ -47,14 +47,14 @@ test_expect_success 'ambiguous tag' '
 	check_oneline "Merge commit QambiguousQ"
 '
 
-test_expect_success 'remote branch' '
+test_expect_success 'remote-tracking branch' '
 	git checkout -b remote master &&
 	test_commit remote-1 &&
 	git update-ref refs/remotes/origin/master remote &&
 	git checkout master &&
 	test_commit master-5 &&
 	git merge origin/master &&
-	check_oneline "Merge remote branch Qorigin/masterQ"
+	check_oneline "Merge remote-tracking branch Qorigin/masterQ"
 '
 
 test_done
-- 
1.7.3.2.183.g2e7b0
