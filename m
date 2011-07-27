From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 12/18] revert: Save command-line options for continuing operation
Date: Wed, 27 Jul 2011 08:49:09 +0530
Message-ID: <1311736755-24205-13-git-send-email-artagnon@gmail.com>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 27 05:23:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QluiY-00068x-5l
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 05:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110Ab1G0DXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 23:23:16 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:35904 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524Ab1G0DXP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 23:23:15 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so1938359pzk.1
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 20:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=DBhrTiwin22tkI4eHMJJP5Kg5cP/PEQJHgZ3OAE7WSI=;
        b=wHR/lWdH9GEuK9AjUwWZqyKsiZId6NRde+geYMhBLxaJnFZ+R/gNHDi51Cpt7HNMYf
         GmkgoW59m8xm0Hl2IhnuIx+CBXnqFx2JJfUmMthwH4JHzb73jqMTq5W82iPElNQQWJgK
         UEmIvjBYWKEqYieq0/kx3KWToZGZyF0P6+iRk=
Received: by 10.68.8.137 with SMTP id r9mr10391514pba.426.1311736995633;
        Tue, 26 Jul 2011 20:23:15 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id p7sm1210706pbn.65.2011.07.26.20.23.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Jul 2011 20:23:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177915>

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
index b3b1bf8..b02d3d2 100644
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
+		git_config_set_in_file(opts_file, "core.no-commit", "true");
+	if (opts->edit)
+		git_config_set_in_file(opts_file, "core.edit", "true");
+	if (opts->signoff)
+		git_config_set_in_file(opts_file, "core.signoff", "true");
+	if (opts->record_origin)
+		git_config_set_in_file(opts_file, "core.record-origin", "true");
+	if (opts->allow_ff)
+		git_config_set_in_file(opts_file, "core.allow-ff", "true");
+	if (opts->mainline) {
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "%d", opts->mainline);
+		git_config_set_in_file(opts_file, "core.mainline", buf.buf);
+	}
+	if (opts->strategy)
+		git_config_set_in_file(opts_file, "core.strategy", opts->strategy);
+	if (opts->xopts) {
+		for (i = 0; i < opts->xopts_nr; i ++)
+			git_config_set_multivar_in_file(opts_file,
+							"core.strategy-option",
+							opts->xopts[i], "^$", 0);
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
