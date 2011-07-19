From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 12/18] revert: Save command-line options for continuing operation
Date: Tue, 19 Jul 2011 22:47:50 +0530
Message-ID: <1311095876-3098-13-git-send-email-artagnon@gmail.com>
References: <1311095876-3098-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 19 19:19:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjDxb-0003LZ-E4
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 19:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809Ab1GSRTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 13:19:43 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:36451 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793Ab1GSRTm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 13:19:42 -0400
Received: by mail-pv0-f174.google.com with SMTP id 12so4030753pvg.19
        for <git@vger.kernel.org>; Tue, 19 Jul 2011 10:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=9KTePHFfymKNevmJwAu5BcJ4Z+mpd4TwJp9V+hP0vAU=;
        b=piSBYOuypScjJTfel5w/i4LsJbKcOIlj/jRYA4xakS6RHZz0jiK2L08VpbMCO4lfPL
         yUClFFH4tVXTJ5HGauVuj0kW2FtGpr3AbUoOK8UV6pM8iIdM4rnacWDy/STgUZ4/fIlY
         qtTBb5bIf0rpdvVYjUnTwtcZW3AioOFa2t+jw=
Received: by 10.143.165.2 with SMTP id s2mr3456537wfo.417.1311095982245;
        Tue, 19 Jul 2011 10:19:42 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id r12sm4276415wfe.1.2011.07.19.10.19.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Jul 2011 10:19:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1311095876-3098-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177477>

In the same spirit as ".git/sequencer/head" and ".git/sequencer/todo",
introduce ".git/sequencer/opts" to persist the replay_opts structure
for continuing after a conflict resolution.  Use the gitconfig format
for this file so that it looks like:

[core]
	signoff = true
	record-origin = true
	mainline = 1
	strategy = recursive
	strategy-option = patience
	strategy-option = ours

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c                |   78 +++++++++++++++++++++++++++++++++++++++
 t/t3510-cherry-pick-sequence.sh |   28 +++++++++++++-
 2 files changed, 105 insertions(+), 1 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index cdfa906..a8ac5a1 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -65,6 +65,7 @@ struct replay_opts {
 #define SEQ_DIR         "sequencer"
 #define SEQ_HEAD_FILE   "sequencer/head"
 #define SEQ_TODO_FILE   "sequencer/todo"
+#define SEQ_OPTS_FILE   "sequencer/opts"
 
 static const char *action_name(const struct replay_opts *opts)
 {
@@ -716,6 +717,49 @@ error:
 	die(_("Unusable instruction sheet: %s"), todo_file);
 }
 
+static int populate_opts_cb(const char *key, const char *value, void *data)
+{
+	struct replay_opts *opts = data;
+	int error_flag = 1;
+
+	if (!value)
+		error_flag = 0;
+	else if (!strcmp(key, "core.no-commit"))
+		opts->no_commit = git_config_bool_or_int(key, value, &error_flag);
+	else if (!strcmp(key, "core.edit"))
+		opts->edit = git_config_bool_or_int(key, value, &error_flag);
+	else if (!strcmp(key, "core.signoff"))
+		opts->signoff = git_config_bool_or_int(key, value, &error_flag);
+	else if (!strcmp(key, "core.record-origin"))
+		opts->record_origin = git_config_bool_or_int(key, value, &error_flag);
+	else if (!strcmp(key, "core.allow-ff"))
+		opts->allow_ff = git_config_bool_or_int(key, value, &error_flag);
+	else if (!strcmp(key, "core.mainline"))
+		opts->mainline = git_config_int(key, value);
+	else if (!strcmp(key, "core.strategy"))
+		git_config_string(&opts->strategy, key, value);
+	else if (!strcmp(key, "core.strategy-option")) {
+		ALLOC_GROW(opts->xopts, opts->xopts_nr + 1, opts->xopts_alloc);
+		opts->xopts[opts->xopts_nr++] = xstrdup(value);
+	} else
+		return error(_("Invalid key: %s"), key);
+
+	if (!error_flag)
+		return error(_("Invalid value for %s: %s"), key, value);
+
+	return 0;
+}
+
+static void MAYBE_UNUSED read_populate_opts(struct replay_opts **opts_ptr)
+{
+	const char *opts_file = git_path(SEQ_OPTS_FILE);
+
+	if (!file_exists(opts_file))
+		return;
+	if (git_config_from_file(populate_opts_cb, opts_file, *opts_ptr) < 0)
+		die(_("Malformed options sheet: %s"), opts_file);
+}
+
 static void walk_revs_populate_todo(struct commit_list **todo_list,
 				struct replay_opts *opts)
 {
@@ -774,6 +818,39 @@ static void save_todo(struct commit_list *todo_list, struct replay_opts *opts)
 	strbuf_release(&buf);
 }
 
+static void save_opts(struct replay_opts *opts)
+{
+	const char *opts_file = git_path(SEQ_OPTS_FILE);
+	struct strbuf buf = STRBUF_INIT;
+	int i;
+
+	if (opts->no_commit)
+		git_config_set_in_file("core.no-commit", "true", opts_file);
+	if (opts->edit)
+		git_config_set_in_file("core.edit", "true", opts_file);
+	if (opts->signoff)
+		git_config_set_in_file("core.signoff", "true", opts_file);
+	if (opts->record_origin)
+		git_config_set_in_file("core.record-origin", "true", opts_file);
+	if (opts->allow_ff)
+		git_config_set_in_file("core.allow-ff", "true", opts_file);
+	if (opts->mainline) {
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "%d", opts->mainline);
+		git_config_set_in_file("core.mainline", buf.buf, opts_file);
+	}
+	if (opts->strategy)
+		git_config_set_in_file("core.strategy", opts->strategy, opts_file);
+	if (opts->xopts) {
+		for (i = 0; i < opts->xopts_nr; i ++)
+			git_config_set_multivar_in_file("core.strategy-option",
+							opts->xopts[i], "^$", 0,
+							opts_file);
+	}
+
+	strbuf_release(&buf);
+}
+
 static int pick_commits(struct replay_opts *opts)
 {
 	struct commit_list *todo_list = NULL;
@@ -796,6 +873,7 @@ static int pick_commits(struct replay_opts *opts)
 		return error(_("Can't cherry-pick into empty head"));
 	} else
 		save_head(sha1_to_hex(sha1));
+	save_opts(opts);
 	save_todo(todo_list, opts);
 
 	for (cur = todo_list; cur; cur = cur->next) {
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 64eaa20..79d868f 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -32,10 +32,36 @@ test_expect_success setup '
 
 test_expect_success 'cherry-pick persists data on failure' '
 	pristine_detach initial &&
-	test_must_fail git cherry-pick base..anotherpick &&
+	test_must_fail git cherry-pick -s base..anotherpick &&
 	test_path_is_dir .git/sequencer &&
 	test_path_is_file .git/sequencer/head &&
 	test_path_is_file .git/sequencer/todo &&
+	test_path_is_file .git/sequencer/opts &&
+	rm -rf .git/sequencer
+'
+
+test_expect_success 'cherry-pick persists opts correctly' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick -s -m 1 --strategy=recursive -X patience -X ours base..anotherpick &&
+	test_path_is_dir .git/sequencer &&
+	test_path_is_file .git/sequencer/head &&
+	test_path_is_file .git/sequencer/todo &&
+	test_path_is_file .git/sequencer/opts &&
+	echo "true" >expect
+	git config --file=.git/sequencer/opts --get-all core.signoff >actual &&
+	test_cmp expect actual &&
+	echo "1" >expect
+	git config --file=.git/sequencer/opts --get-all core.mainline >actual &&
+	test_cmp expect actual &&
+	echo "recursive" >expect
+	git config --file=.git/sequencer/opts --get-all core.strategy >actual &&
+	test_cmp expect actual &&
+	cat >expect <<-\EOF
+	patience
+	ours
+	EOF
+	git config --file=.git/sequencer/opts --get-all core.strategy-option >actual &&
+	test_cmp expect actual &&
 	rm -rf .git/sequencer
 '
 
-- 
1.7.4.rc1.7.g2cf08.dirty
