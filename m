From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [RFC PATCH] revert: Persist per-session opts
Date: Sat,  9 Jul 2011 15:41:58 +0000
Message-ID: <1310226118-10201-2-git-send-email-artagnon@gmail.com>
References: <1310226118-10201-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 09 17:42:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QfZfj-00089Y-OX
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jul 2011 17:42:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754518Ab1GIPmE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jul 2011 11:42:04 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48202 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754384Ab1GIPmC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2011 11:42:02 -0400
Received: by mail-vw0-f46.google.com with SMTP id 1so1974456vws.19
        for <git@vger.kernel.org>; Sat, 09 Jul 2011 08:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=h8aZPqN1poc3uvccGR3AzAPRmHhCAU+09/PmBbyJ5Ok=;
        b=Hya4T97iLjltebBw4WsQZI0NDvU1scUh6g0Iw/623RvMwXqu3acGZj/saHI2byStpT
         xFiX0HHkYDYDyEkVTRSTX/FBD+tX7EeVlB9laJP4IpaL5nZg4OF3PjrtFCgZ471c1GKb
         MNqZEOsbIfQL/9S2pygs0KMqbXsiTgy756x1o=
Received: by 10.52.171.79 with SMTP id as15mr3856762vdc.198.1310226121823;
        Sat, 09 Jul 2011 08:42:01 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id fm10sm3000306vbb.6.2011.07.09.08.42.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 09 Jul 2011 08:42:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1310226118-10201-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176817>

Save the replay_opts struct in .git/sequencer/opts using a simple "key
= value" format.  Parse it and populate the options structure before
replaying.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |  143 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 sequencer.h      |    8 +++
 2 files changed, 151 insertions(+), 0 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 1feecd5..0693fd8 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -635,6 +635,32 @@ static void read_and_refresh_cache(const char *me, struct replay_opts *opts)
 	rollback_lock_file(&index_lock);
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
@@ -733,6 +759,102 @@ error:
 	die(_("Malformed instruction sheet: %s"), git_path(SEQ_TODO_FILE));
 }
 
+static char *parse_opt_value(char *p, void *key, enum seq_opt_type type,
+			parse_opt_cb *cb_function) {
+	struct option opt;
+	char *val, *cur, *end;
+
+	if (!(val = strchr(p, '=')))
+		goto error;
+	if (!*(val + 1))
+		goto error;
+	if (!(end = strchr(p, '\n')))
+		goto error;
+	val += 2;
+	*end = '\0'; /* Remove trailing '\n' */
+
+	switch (type) {
+	case SEQ_OPTION_BOOLEAN:
+		if (!strncmp(val, "true", strlen("true")))
+			*(int *)key = 1;
+		else if (!strncmp(val, "false", strlen("false")))
+			*(int *)key = 0;
+		else
+			goto error;
+		break;
+	case SEQ_OPTION_INTEGER:
+		*(int *)key = strtol(val, NULL, 10);
+		break;
+	case SEQ_OPTION_STRING:
+		*(char **)key = xstrdup(val);
+		break;
+	case SEQ_OPTION_CALLBACK:
+		opt.value = (struct replay_opts **)key;
+		while (val) {
+			if ((cur = strchr(val, '|'))) {
+				*(cur - 1) = '\0';
+				(*cb_function)(&opt, val, 0);
+				val = cur + 2;
+			} else {
+				(*cb_function)(&opt, val, 0);
+				break;
+			}
+		}
+		break;
+	default:
+		die(_("program error"));
+	}
+	return end + 1;
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
+	if (fd < 0) {
+		strbuf_release(&buf);
+		die_errno(_("Could not open %s."), git_path(SEQ_OPTS_FILE));
+	}
+	if (strbuf_read(&buf, fd, 0) < buf.len) {
+		close(fd);
+		strbuf_release(&buf);
+		die(_("Could not read %s."), git_path(SEQ_OPTS_FILE));
+	}
+	close(fd);
+
+	for (p = buf.buf; *p;) {
+		if (!strncmp(p, "no-commit ", strlen("no-commit ")))
+			p = parse_opt_value(p, &opts->no_commit, SEQ_OPTION_BOOLEAN, NULL);
+		else if (!strncmp(p, "edit ", strlen("edit ")))
+			p = parse_opt_value(p, &opts->edit, SEQ_OPTION_BOOLEAN, NULL);
+		else if (!strncmp(p, "signoff ", strlen("signoff ")))
+			p = parse_opt_value(p, &opts->signoff, SEQ_OPTION_BOOLEAN, NULL);
+		else if (!strncmp(p, "mainline ", strlen("mainline ")))
+			p = parse_opt_value(p, &opts->mainline, SEQ_OPTION_INTEGER, NULL);
+		else if (!strncmp(p, "record-origin ", strlen("record-origin ")))
+			p = parse_opt_value(p, &opts->record_origin, SEQ_OPTION_BOOLEAN, NULL);
+		else if (!strncmp(p, "ff ", strlen("ff ")))
+			p = parse_opt_value(p, &opts->allow_ff, SEQ_OPTION_BOOLEAN, NULL);
+		else if (!strncmp(p, "strategy ", strlen("strategy ")))
+			p = parse_opt_value(p, &opts->strategy, SEQ_OPTION_STRING, NULL);
+		else if (!strncmp(p, "strategy-option ", strlen("strategy-option ")))
+			p = parse_opt_value(p, &opts, SEQ_OPTION_CALLBACK, option_parse_x);
+		else
+			goto error;
+	}
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
@@ -800,6 +922,25 @@ static void save_todo(struct commit_list *todo_list, struct replay_opts *opts)
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
 static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 {
 	struct commit_list *cur;
@@ -849,6 +990,7 @@ static int process_continuation(struct replay_opts *opts)
 	} else if (opts->subcommand == REPLAY_CONTINUE) {
 		if (!file_exists(git_path(SEQ_TODO_FILE)))
 			goto error;
+		read_populate_opts(&opts);
 		read_populate_todo(&todo_list, opts);
 
 		/* Verify that the conflict has been resolved */
@@ -871,6 +1013,7 @@ static int process_continuation(struct replay_opts *opts)
 		create_seq_dir();
 		if (!get_sha1("HEAD", sha1))
 			save_head(sha1_to_hex(sha1));
+		save_opts(opts);
 		save_todo(todo_list, opts);
 	}
 	return pick_commits(todo_list, opts);
diff --git a/sequencer.h b/sequencer.h
index d6fe6e0..e7bef5d 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -5,6 +5,14 @@
 #define SEQ_OLD_DIR	"sequencer-old"
 #define SEQ_HEAD_FILE	"sequencer/head"
 #define SEQ_TODO_FILE	"sequencer/todo"
+#define SEQ_OPTS_FILE	"sequencer/opts"
+
+enum seq_opt_type {
+	SEQ_OPTION_BOOLEAN,
+	SEQ_OPTION_INTEGER,
+	SEQ_OPTION_STRING,
+	SEQ_OPTION_CALLBACK,
+};
 
 /* Removes SEQ_OLD_DIR and renames SEQ_DIR to SEQ_OLD_DIR, ignoring
  * any errors.  Intended to be used by 'git reset --hard'.
-- 
1.7.5.GIT
