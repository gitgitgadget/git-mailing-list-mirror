From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 12/17] revert: Save command-line options for continuing operation
Date: Mon, 11 Jul 2011 14:54:03 +0000
Message-ID: <1310396048-24925-13-git-send-email-artagnon@gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 11 16:55:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgHtD-0005dD-AI
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 16:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757866Ab1GKOye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 10:54:34 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:60018 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757838Ab1GKOyc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 10:54:32 -0400
Received: by mail-vw0-f46.google.com with SMTP id 1so2748281vws.19
        for <git@vger.kernel.org>; Mon, 11 Jul 2011 07:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=1xrCH3pNe4+Vr5xQM7C5bHG0UjLjVsvmJEbiwfT8G10=;
        b=XbM/P5TtWkbFS2Vnuavvr7X1TPvXEnLk1qKUaiTAsneoCXRKOzysp+klmcxWLNDwds
         eMPvjgoYYqq8yBh4cIJCkdZV/fNVAUGqpWigAlvkrwn7+QAEDXVIfylFysYuPWkSuiyd
         ISTjDc/sg1hpR4VG1e5CFB9dww/4BtL1JdKAA=
Received: by 10.52.188.34 with SMTP id fx2mr2182534vdc.358.1310396071687;
        Mon, 11 Jul 2011 07:54:31 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id b9sm4510527vdk.25.2011.07.11.07.54.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jul 2011 07:54:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176854>

In the same spirit as ".git/sequencer/head" and ".git/sequencer/todo",
introduce ".git/sequencer/opts" to persist the replay_opts structure
for continuing after a conflict resolution.  Use a simple "key =
value" format for this file, using "|" to separate multiple values so
that the file looks like:

signoff = true
record-origin = true
mainline = 1
strategy = recursive
strategy-option = patience | ours

Write the file just after writing ".git/sequencer/head", and parse it
out just after parsing out ".git/sequencer/head".  There is now enough
data for "--continue" to work.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c                |  226 +++++++++++++++++++++++++++++++++++++++
 sequencer.h                     |    1 +
 t/t3510-cherry-pick-sequence.sh |   20 ++++-
 3 files changed, 246 insertions(+), 1 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 856ee97..edf74fb 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -596,6 +596,32 @@ struct commit_list **commit_list_append(struct commit *commit,
 	return &new->next;
 }
 
+static void format_opts(struct strbuf *buf, struct replay_opts *opts)
+{
+	int i;
+
+	if (opts->no_commit)
+		strbuf_addstr(buf, "no-commit = true\n");
+	if (opts->edit)
+		strbuf_addstr(buf, "edit = true\n");
+	if (opts->signoff)
+		strbuf_addstr(buf, "signoff = true\n");
+	if (opts->record_origin)
+		strbuf_addstr(buf, "record-origin = true\n");
+	if (opts->allow_ff)
+		strbuf_addstr(buf, "ff = true\n");
+	if (opts->mainline)
+		strbuf_addf(buf, "mainline = %d\n", opts->mainline);
+	if (opts->strategy)
+		strbuf_addf(buf, "strategy = %s\n", opts->strategy);
+	if (opts->xopts) {
+		strbuf_addf(buf, "strategy-option = ");
+		for (i = 0; i < opts->xopts_nr - 1; i ++)
+			strbuf_addf(buf, "%s | ", opts->xopts[i]);
+		strbuf_addf(buf, "%s\n", opts->xopts[i]);
+	}
+}
+
 static void format_todo(struct strbuf *buf, struct commit_list *todo_list,
 			struct replay_opts *opts)
 {
@@ -694,6 +720,184 @@ error:
 	die(_("Malformed instruction sheet: %s"), git_path(SEQ_TODO_FILE));
 }
 
+static struct strbuf *parse_value(const char *start, char **end_ptr)
+{
+	static struct strbuf value = STRBUF_INIT;
+	int quote = 0;
+	char *p = (char *)start;
+	char *end;
+
+	/* Find and strip '\n', '\r' */
+	if ((end = strchr(start, '\n'))) {
+		*end = '\0'; /* Remove trailing '\n' */
+		if (*(end - 1) == '\r')
+			*(end - 1) = '\0'; /* Remove trailing '\r' */
+	} else if (strchr(start, '\0'))
+		end = NULL;
+	else
+		goto error;
+
+	for (; *p != '\0'; p ++) {
+		if (!quote && (*p == ';' || *p == '#'))
+			/* Ignore comments */
+			goto ok;
+		if (*p == '\\') {
+			p += 1;
+			switch (*p) {
+			case '\n':
+				continue;
+			case 't':
+				strbuf_addch(&value, '\t');
+				break;
+			case 'b':
+				strbuf_addch(&value, '\b');
+				break;
+			case 'n':
+				strbuf_addch(&value, '\n');
+				break;
+			/* Some pharapters escape as themselves */
+			case '\\': case '"':
+				break;
+			/* Reject unknown escape sequences */
+			default:
+				goto error;
+			}
+			continue;
+		}
+		if (*p == '"') {
+			quote = 1 - quote;
+			continue;
+		}
+		strbuf_addch(&value, *p);
+	}
+	/* Quote not closed */
+	if (quote)
+		goto error;
+
+	if (end)
+		*end_ptr = end + 1;
+	else
+		*end_ptr = NULL;
+ok:
+	strbuf_trim(&value);
+	return &value;
+error:
+	strbuf_release(&value);
+	return NULL;
+}
+
+static char *parse_opt_value(const char *start, void *key,
+			enum parse_opt_type type, parse_opt_cb *cb_function)
+{
+	struct strbuf *value, *subvalue;
+	struct option opt;
+	char *p, *cur, *val, *end;
+
+	/* Remove spaces before '=' */
+	for (p = (char *)start; isspace(*p); p++);
+	if (*p != '=')
+		goto error;
+
+	if (!(value = parse_value(p + 1, &end)))
+		goto error;
+	val = value->buf;
+
+	switch (type) {
+	case OPTION_BOOLEAN:
+		if (!strcasecmp(val, "true")
+			|| !strcasecmp(val, "yes")
+			|| !strcasecmp(val, "on"))
+			*(int *)key = 1;
+		else if (!strcasecmp(val, "false")
+			|| !strcasecmp(val, "no")
+			|| !strcasecmp(val, "off"))
+			*(int *)key = 0;
+		else
+			goto error;
+		break;
+	case OPTION_INTEGER:
+		*(int *)key = strtol(val, NULL, 10);
+		break;
+	case OPTION_STRING:
+		*(char **)key = xstrdup(val);
+		break;
+	case OPTION_CALLBACK:
+		opt.value = (struct replay_opts **)key;
+		while (val) {
+			if ((cur = strchr(val, '|'))) {
+				*cur = '\0';
+				subvalue = parse_value(val, &end);
+				(*cb_function)(&opt, subvalue->buf, 0);
+				strbuf_release(subvalue);
+				val = cur + 1;
+			} else {
+				(*cb_function)(&opt, val, 0);
+				break;
+			}
+		}
+		break;
+	default:
+		die(_("program error"));
+	}
+	strbuf_release(value);
+	return end;
+error:
+	die(_("Malformed options sheet: %s"), git_path(SEQ_OPTS_FILE));
+}
+
+static void read_populate_opts(struct replay_opts **opts_ptr)
+{
+	struct replay_opts *opts = *opts_ptr;
+	struct strbuf buf = STRBUF_INIT;
+	char *p;
+	int fd;
+
+	fd = open(git_path(SEQ_OPTS_FILE), O_RDONLY);
+	if (fd < 0)
+		goto ok;
+	if (strbuf_read(&buf, fd, 0) < buf.len) {
+		close(fd);
+		strbuf_release(&buf);
+		die(_("Could not read %s."), git_path(SEQ_OPTS_FILE));
+	}
+	close(fd);
+
+	for (p = buf.buf; p && *p != '\0';) {
+		if (!prefixcmp(p, "no-commit"))
+			p = parse_opt_value(p + strlen("no-commit"),
+					&opts->no_commit, OPTION_BOOLEAN, NULL);
+		else if (!prefixcmp(p, "edit"))
+			p = parse_opt_value(p + strlen("edit"),
+					&opts->edit, OPTION_BOOLEAN, NULL);
+		else if (!prefixcmp(p, "signoff"))
+			p = parse_opt_value(p + strlen("signoff"),
+					&opts->signoff, OPTION_BOOLEAN, NULL);
+		else if (!prefixcmp(p, "mainline"))
+			p = parse_opt_value(p + strlen("mainline"),
+					&opts->mainline, OPTION_INTEGER, NULL);
+		else if (!prefixcmp(p, "record-origin"))
+			p = parse_opt_value(p + strlen("record-origin"),
+					&opts->record_origin, OPTION_BOOLEAN, NULL);
+		else if (!prefixcmp(p, "ff"))
+			p = parse_opt_value(p + strlen("ff"),
+					&opts->allow_ff, OPTION_BOOLEAN, NULL);
+		else if (!prefixcmp(p, "strategy-option"))
+			p = parse_opt_value(p + strlen("strategy-option"),
+					&opts, OPTION_CALLBACK, option_parse_x);
+		else if (!prefixcmp(p, "strategy"))
+			p = parse_opt_value(p + strlen("strategy"),
+					&opts->strategy, OPTION_STRING, NULL);
+		else
+			goto error;
+	}
+ok:
+	strbuf_release(&buf);
+	return;
+error:
+	strbuf_release(&buf);
+	die(_("Malformed options sheet: %s"), git_path(SEQ_OPTS_FILE));
+}
+
 static void walk_revs_populate_todo(struct commit_list **todo_list,
 				struct replay_opts *opts)
 {
@@ -751,6 +955,27 @@ static void save_todo(struct commit_list *todo_list, struct replay_opts *opts)
 	strbuf_release(&buf);
 }
 
+static void save_opts(struct replay_opts *opts)
+{
+	static struct lock_file opts_lock;
+	struct strbuf buf = STRBUF_INIT;
+	int fd;
+
+	fd = hold_lock_file_for_update(&opts_lock, git_path(SEQ_OPTS_FILE), LOCK_DIE_ON_ERROR);
+	format_opts(&buf, opts);
+	if (!buf.len)
+		return;
+	if (write_in_full(fd, buf.buf, buf.len) < 0) {
+		strbuf_release(&buf);
+		die_errno(_("Could not write to %s."), git_path(SEQ_OPTS_FILE));
+	}
+	if (commit_lock_file(&opts_lock) < 0) {
+		strbuf_release(&buf);
+		die(_("Error wrapping up %s"), git_path(SEQ_OPTS_FILE));
+	}
+	strbuf_release(&buf);
+}
+
 static int pick_commits(struct replay_opts *opts)
 {
 	struct commit_list *todo_list = NULL;
@@ -768,6 +993,7 @@ static int pick_commits(struct replay_opts *opts)
 	create_seq_dir();
 	if (!get_sha1("HEAD", sha1))
 		save_head(sha1_to_hex(sha1));
+	save_opts(opts);
 	save_todo(todo_list, opts);
 
 	for (cur = todo_list; cur; cur = cur->next) {
diff --git a/sequencer.h b/sequencer.h
index 673616b..dcb51b1 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -5,6 +5,7 @@
 #define SEQ_OLD_DIR	"sequencer-old"
 #define SEQ_HEAD_FILE	"sequencer/head"
 #define SEQ_TODO_FILE	"sequencer/todo"
+#define SEQ_OPTS_FILE	"sequencer/opts"
 
 /* Removes SEQ_OLD_DIR and renames SEQ_DIR to SEQ_OLD_DIR, ignoring
  * any errors.  Intended to be used by 'git reset --hard'.
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 64eaa20..100cbb1 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -32,10 +32,28 @@ test_expect_success setup '
 
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
+	cat >expect <<-\EOF &&
+	signoff = true
+	mainline = 1
+	strategy = recursive
+	strategy-option = patience | ours
+	EOF
+	test_cmp expect .git/sequencer/opts &&
 	rm -rf .git/sequencer
 '
 
-- 
1.7.5.GIT
