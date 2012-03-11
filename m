From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] commit: pass author/committer info to hooks
Date: Sun, 11 Mar 2012 04:16:09 -0700
Message-ID: <7vhaxvxu9y.fsf_-_@alter.siamese.dyndns.org>
References: <CAGc=MuCQoQ711uXnB8J80RqsY+pqbaeCOXHjy0-mjq7a_ESdyA@mail.gmail.com>
 <4F5BAE5E.5030407@gmail.com> <7vboo415rn.fsf@alter.siamese.dyndns.org>
 <4F5BDDAC.4050700@gmail.com> <7v62ebz9c0.fsf@alter.siamese.dyndns.org>
 <7vwr6rxul6.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>,
	Adrian Cornish <git@bluedreamer.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 11 12:16:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6gl7-000781-Ge
	for gcvg-git-2@plane.gmane.org; Sun, 11 Mar 2012 12:16:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209Ab2CKLQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Mar 2012 07:16:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50347 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751622Ab2CKLQM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2012 07:16:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4C6F6F7F;
	Sun, 11 Mar 2012 07:16:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=daP1/bCk+dA9F9ANoPwwOZHaxlE=; b=iQ8zSU
	/n0Ezp6nCHu+GKWImxRHFY/cSeeFzKGn7E6ju0yM/cfBT3Ia1zsxqH2OP7kp2sbM
	aHmMv9UGwngjGAeoXzWUrTMaYdc5RFU+Cde6MoqjB7LZlZv89ng4FWWKylPRx9JP
	nnWPHgWb5QwQzCRG2WUE9RV2vqAyNSTgEXGlo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qpx453MG0t7Nkj7K5Do+PuPfCF094Srz
	YVuHLBfW70ga2WQW5Fc3cBW4aupIjctislozSCIutnyzKR5yhGhIDyCrRuZ8TuIH
	/4xUh+wcRwomeLWAI7pAAr8nVyqHXd9lEd8Ia2DdTKsTXC+yOdtqCbAHKFqQViWj
	GG7GBoYtRC8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC7016F7E;
	Sun, 11 Mar 2012 07:16:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E371E6F7C; Sun, 11 Mar 2012
 07:16:10 -0400 (EDT)
In-Reply-To: <7vwr6rxul6.fsf_-_@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 11 Mar 2012 04:09:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9B533040-6B6B-11E1-8ED1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192807>

When lying the author name via GIT_AUTHOR_NAME environment variable
to "git commit", the hooks run by the command saw it and could act
on the name that will be recorded in the final commit. When the user
uses the "--author" option from the command line, the command should
give the same information to the hook, and back when "git command"
was a scripted Porcelain, it did set the environment variable and
hooks can learn the author name from it.

However, when the command was reimplemented in C, the rewritten code
was not very faithful to the original, and hooks stopped getting the
authorship information given with "--author".  Fix this by exporting
the necessary environment variables.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * And this is the final patch in the more complex of the two
   approaches.

 builtin/commit.c           |  132 ++++++++++++++++++++++++++++++--------------
 t/t7503-pre-commit-hook.sh |    2 +-
 2 files changed, 93 insertions(+), 41 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index eae5a29..4a47e39 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -27,6 +27,7 @@
 #include "quote.h"
 #include "submodule.h"
 #include "gpg-interface.h"
+#include "argv-array.h"
 
 static const char * const builtin_commit_usage[] = {
 	"git commit [options] [--] <filepattern>...",
@@ -637,13 +638,63 @@ static char *cut_ident_timestamp_part(char *string)
 	return ket;
 }
 
-static int prepare_to_commit(const char *index_file, const char *prefix,
+struct commit_context {
+	const char *index_file;
+	struct strbuf *author_ident;
+	struct strbuf *committer_ident;
+	struct argv_array env;
+};
+
+static void setup_commit_context(struct commit_context *ctx,
+				 const char *index_file,
+				 struct strbuf *author_ident,
+				 struct strbuf *committer_ident)
+{
+	struct ident_split s;
+	struct argv_array *env = &ctx->env;
+
+	ctx->index_file = index_file;
+	ctx->author_ident = author_ident;
+	ctx->committer_ident = committer_ident;
+	argv_array_init(env);
+	if (index_file)
+		argv_array_pushf(env, "GIT_INDEX_FILE=%s", index_file);
+
+	if (!split_ident_line(&s, author_ident->buf, author_ident->len)) {
+		argv_array_pushf(env, "GIT_AUTHOR_NAME=%.*s",
+				 (int)(s.name_end - s.name_begin),
+				 s.name_begin);
+		argv_array_pushf(env, "GIT_AUTHOR_EMAIL=%.*s",
+				 (int)(s.mail_end - s.mail_begin),
+				 s.mail_begin);
+		argv_array_pushf(env, "GIT_AUTHOR_DATE=@%.*s %.*s",
+				 (int)(s.date_end - s.date_begin),
+				 s.date_begin,
+				 (int)(s.tz_end - s.tz_begin),
+				 s.tz_begin);
+	}
+
+	if (!split_ident_line(&s, committer_ident->buf, committer_ident->len)) {
+		argv_array_pushf(env, "GIT_COMMITTER_NAME=%.*s",
+				 (int)(s.name_end - s.name_begin),
+				 s.name_begin);
+		argv_array_pushf(env, "GIT_COMMITTER_EMAIL=%.*s",
+				 (int)(s.mail_end - s.mail_begin),
+				 s.mail_begin);
+		argv_array_pushf(env, "GIT_COMMITTER_DATE=@%.*s %.*s",
+				 (int)(s.date_end - s.date_begin),
+				 s.date_begin,
+				 (int)(s.tz_end - s.tz_begin),
+				 s.tz_begin);
+	}
+}
+
+static int prepare_to_commit(struct commit_context *ctx,
+			     const char *prefix,
 			     struct commit *current_head,
-			     struct wt_status *s,
-			     struct strbuf *author_ident)
+			     struct wt_status *s)
 {
 	struct stat statbuf;
-	struct strbuf committer_ident = STRBUF_INIT;
 	int commitable, saved_color_setting;
 	struct strbuf sb = STRBUF_INIT;
 	char *buffer;
@@ -652,7 +703,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	int ident_shown = 0;
 	int clean_message_contents = (cleanup_mode != CLEANUP_NONE);
 
-	if (!no_verify && run_hook(index_file, "pre-commit", NULL))
+	if (!no_verify && run_hook_e(ctx->env.argv, "pre-commit", NULL))
 		return 0;
 
 	if (squash_message) {
@@ -771,11 +822,6 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 
 	strbuf_release(&sb);
 
-	/* This checks and barfs if author is badly specified */
-	determine_author_info(author_ident);
-
-	/* This checks if committer ident is explicitly given */
-	strbuf_addstr(&committer_ident, git_committer_info(0));
 	if (use_editor && include_status) {
 		char *ai_tmp, *ci_tmp;
 		if (whence != FROM_COMMIT)
@@ -809,28 +855,28 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			status_printf_ln(s, GIT_COLOR_NORMAL,
 					"%s", only_include_assumed);
 
-		ai_tmp = cut_ident_timestamp_part(author_ident->buf);
-		ci_tmp = cut_ident_timestamp_part(committer_ident.buf);
-		if (strcmp(author_ident->buf, committer_ident.buf))
+		ai_tmp = cut_ident_timestamp_part(ctx->author_ident->buf);
+		ci_tmp = cut_ident_timestamp_part(ctx->committer_ident->buf);
+		if (strcmp(ctx->author_ident->buf, ctx->committer_ident->buf))
 			status_printf_ln(s, GIT_COLOR_NORMAL,
-				_("%s"
-				"Author:    %s"),
-				ident_shown++ ? "" : "\n",
-				author_ident->buf);
+					 _("%s"
+					   "Author:    %s"),
+					 ident_shown++ ? "" : "\n",
+					 ctx->author_ident->buf);
 
 		if (!user_ident_sufficiently_given())
 			status_printf_ln(s, GIT_COLOR_NORMAL,
-				_("%s"
-				"Committer: %s"),
-				ident_shown++ ? "" : "\n",
-				committer_ident.buf);
+					 _("%s"
+					   "Committer: %s"),
+					 ident_shown++ ? "" : "\n",
+					 ctx->committer_ident->buf);
 
 		if (ident_shown)
 			status_printf_ln(s, GIT_COLOR_NORMAL, "");
 
 		saved_color_setting = s->use_color;
 		s->use_color = 0;
-		commitable = run_status(s->fp, index_file, prefix, 1, s);
+		commitable = run_status(s->fp, ctx->index_file, prefix, 1, s);
 		s->use_color = saved_color_setting;
 
 		*ai_tmp = ' ';
@@ -850,8 +896,6 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		else
 			commitable = index_differs_from(parent, 0);
 	}
-	strbuf_release(&committer_ident);
-
 	fclose(s->fp);
 
 	/*
@@ -861,7 +905,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	 */
 	if (!commitable && whence != FROM_MERGE && !allow_empty &&
 	    !(amend && is_a_merge(current_head))) {
-		run_status(stdout, index_file, prefix, 0, s);
+		run_status(stdout, ctx->index_file, prefix, 0, s);
 		if (amend)
 			fputs(_(empty_amend_advice), stderr);
 		else if (whence == FROM_CHERRY_PICK)
@@ -875,22 +919,18 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	 * the editor and after we invoke run_status above.
 	 */
 	discard_cache();
-	read_cache_from(index_file);
+	read_cache_from(ctx->index_file);
 	if (update_main_cache_tree(0)) {
 		error(_("Error building trees"));
 		return 0;
 	}
 
-	if (run_hook(index_file, "prepare-commit-msg",
-		     git_path(commit_editmsg), hook_arg1, hook_arg2, NULL))
+	if (run_hook_e(ctx->env.argv, "prepare-commit-msg",
+		       git_path(commit_editmsg), hook_arg1, hook_arg2, NULL))
 		return 0;
 
 	if (use_editor) {
-		char index[PATH_MAX];
-		const char *env[2] = { NULL };
-		env[0] =  index;
-		snprintf(index, sizeof(index), "GIT_INDEX_FILE=%s", index_file);
-		if (launch_editor(git_path(commit_editmsg), NULL, env)) {
+		if (launch_editor(git_path(commit_editmsg), NULL, ctx->env.argv)) {
 			fprintf(stderr,
 			_("Please supply the message using either -m or -F option.\n"));
 			exit(1);
@@ -898,7 +938,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	}
 
 	if (!no_verify &&
-	    run_hook(index_file, "commit-msg", git_path(commit_editmsg), NULL)) {
+	    run_hook_e(ctx->env.argv, "commit-msg", git_path(commit_editmsg), NULL)) {
 		return 0;
 	}
 
@@ -1389,6 +1429,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf author_ident = STRBUF_INIT;
+	struct strbuf committer_ident = STRBUF_INIT;
 	const char *index_file, *reflog_msg;
 	char *nl, *p;
 	unsigned char sha1[20];
@@ -1399,6 +1440,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	struct wt_status s;
 	struct commit *current_head = NULL;
 	struct commit_extra_header *extra = NULL;
+	struct commit_context commit_ctx;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_commit_usage, builtin_commit_options);
@@ -1420,10 +1462,16 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		return dry_run_commit(argc, argv, prefix, current_head, &s);
 	index_file = prepare_index(argc, argv, prefix, current_head, 0);
 
-	/* Set up everything for writing the commit object.  This includes
-	   running hooks, writing the trees, and interacting with the user.  */
-	if (!prepare_to_commit(index_file, prefix,
-			       current_head, &s, &author_ident)) {
+	/*
+	 * Set up everything for writing the commit object.  This includes
+	 * running hooks, writing the trees, and interacting with the user.
+	 */
+	determine_author_info(&author_ident);
+	strbuf_addstr(&committer_ident, git_committer_info(0));
+	setup_commit_context(&commit_ctx,
+			     index_file, &author_ident, &committer_ident);
+
+	if (!prepare_to_commit(&commit_ctx, prefix, current_head, &s)) {
 		rollback_index_files();
 		return 1;
 	}
@@ -1513,7 +1561,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		rollback_index_files();
 		die(_("failed to write commit object"));
 	}
-	strbuf_release(&author_ident);
 	free_commit_extra_headers(extra);
 
 	ref_lock = lock_any_ref_for_update("HEAD",
@@ -1552,7 +1599,12 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		     "not exceeded, and then \"git reset HEAD\" to recover."));
 
 	rerere(0);
-	run_hook(get_index_file(), "post-commit", NULL);
+
+	argv_array_clear(&commit_ctx.env);
+	setup_commit_context(&commit_ctx,
+			     get_index_file(),
+			     &author_ident, &committer_ident);
+	run_hook_e(commit_ctx.env.argv, "post-commit", NULL);
 	if (amend && !no_post_rewrite) {
 		struct notes_rewrite_cfg *cfg;
 		cfg = init_copy_notes_for_rewrite("amend");
diff --git a/t/t7503-pre-commit-hook.sh b/t/t7503-pre-commit-hook.sh
index fc6de5b..9301a0c 100755
--- a/t/t7503-pre-commit-hook.sh
+++ b/t/t7503-pre-commit-hook.sh
@@ -118,7 +118,7 @@ test_expect_success 'with failing hook requiring GIT_PREFIX' '
 	git checkout -- file
 '
 
-test_expect_failure 'check the author in hook' '
+test_expect_success 'check the author in hook' '
 	cat >"$HOOK" <<-\EOF &&
 	test "$GIT_AUTHOR_NAME" = "New Author" &&
 	test "$GIT_AUTHOR_EMAIL" = "newauthor@example.com"
-- 
1.7.10.rc0.33.g8866af
