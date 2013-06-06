From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 4/9] cherry-pick: store rewritten commits
Date: Thu,  6 Jun 2013 03:58:59 -0500
Message-ID: <1370509144-31974-5-git-send-email-felipe.contreras@gmail.com>
References: <1370509144-31974-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 06 11:01:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkW4Q-0006Dn-HG
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 11:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430Ab3FFJBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 05:01:13 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:49618 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932326Ab3FFJBH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 05:01:07 -0400
Received: by mail-ob0-f181.google.com with SMTP id 16so4279732obc.12
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 02:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=0NXfyyp+JEw0dBNlv4POKyA/lMi6XhpAdQqkVXp/maI=;
        b=ixG9dPUGSolfk6eH6ItPX9u0Sr0O9fo49jpzMNY7MvmeOrDN1ih8Sf9Ay7kluzX+eE
         etKEwHEQHZgsguwLTIMr1jFU8iAFqjMnGgilBheuzja6hL4B/+YlawqSOGhNvmLGl70r
         xMB7TU/CvcNUzgbGxMcXxAx9utlBIjfpgimvZn2ETBUyH3VMbwe9tzBZh5RIelaBLQPG
         NO28+/L4g+M1WpB6iZSANXw4edaBSgqL5RDORU1W1vKHm8CRXAxoz9gBdPztbm/ulKNA
         gcT3Bl7sXMwIgdNAQ9fqCjZfLZofsSRdnaWectI9P9oXhxHGebnhS62OyrSBmRFCLpwP
         9VYw==
X-Received: by 10.60.34.225 with SMTP id c1mr17639717oej.17.1370509266824;
        Thu, 06 Jun 2013 02:01:06 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id w7sm57266718obx.9.2013.06.06.02.01.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 06 Jun 2013 02:01:05 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370509144-31974-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226491>

Will be useful for the next commits.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sequencer.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 sequencer.h |   1 +
 2 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index d3c7d72..76ff2ff 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -20,6 +20,18 @@
 const char sign_off_header[] = "Signed-off-by: ";
 static const char cherry_picked_prefix[] = "(cherry picked from commit ";
 
+struct rewritten_list_item {
+	unsigned char from[20];
+	unsigned char to[20];
+};
+
+struct rewritten_list {
+	struct rewritten_list_item *items;
+	unsigned int nr, alloc;
+};
+
+static struct rewritten_list rewritten;
+
 static int is_rfc2822_line(const char *buf, int len)
 {
 	int i;
@@ -102,6 +114,19 @@ static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
 	return 1;
 }
 
+static void add_rewritten(unsigned char *from, unsigned char *to)
+{
+	struct rewritten_list_item *item;
+	if (rewritten.nr + 1 >= rewritten.alloc) {
+		rewritten.alloc += 32;
+		rewritten.items = xrealloc(rewritten.items, rewritten.alloc * sizeof(*rewritten.items));
+	}
+	item = &rewritten.items[rewritten.nr];
+	hashcpy(item->from, from);
+	hashcpy(item->to, to);
+	rewritten.nr++;
+}
+
 static void remove_sequencer_state(void)
 {
 	struct strbuf seq_dir = STRBUF_INIT;
@@ -641,6 +666,14 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	if (!opts->no_commit)
 		res = run_git_commit(defmsg, opts, allow);
 
+	if (!res && opts->action == REPLAY_PICK) {
+		unsigned char to[20];
+
+		if (read_ref("HEAD", to))
+			goto leave;
+
+		add_rewritten(commit->object.sha1, to);
+	}
 leave:
 	free_message(&msg);
 	free(defmsg);
@@ -786,6 +819,40 @@ static void read_populate_todo(struct commit_list **todo_list,
 		die(_("Unusable instruction sheet: %s"), todo_file);
 }
 
+static void read_populate_rewritten(void)
+{
+	const char *rewritten_file = git_path(SEQ_REWR_FILE);
+	struct strbuf buf = STRBUF_INIT;
+	char *p;
+	int fd;
+
+	fd = open(rewritten_file, O_RDONLY);
+	if (fd < 0)
+		return;
+	if (strbuf_read(&buf, fd, 0) < 0) {
+		close(fd);
+		strbuf_release(&buf);
+		return;
+	}
+	close(fd);
+
+	for (p = buf.buf; *p;) {
+		unsigned char from[20];
+		unsigned char to[20];
+		char *eol = strchrnul(p, '\n');
+		if (eol - p != 81)
+			/* wrong size */
+			break;
+		if (get_sha1_hex(p, from))
+			break;
+		if (get_sha1_hex(p + 41, to))
+			break;
+		add_rewritten(from, to);
+		p = *eol ? eol + 1 : eol;
+	}
+	strbuf_release(&buf);
+}
+
 static int populate_opts_cb(const char *key, const char *value, void *data)
 {
 	struct replay_opts *opts = data;
@@ -958,6 +1025,29 @@ static void save_todo(struct commit_list *todo_list, struct replay_opts *opts)
 	strbuf_release(&buf);
 }
 
+static void save_rewritten(void)
+{
+	const char *todo_file = git_path(SEQ_REWR_FILE);
+	static struct lock_file rewritten_lock;
+	struct strbuf buf = STRBUF_INIT;
+	int fd, i;
+
+	fd = hold_lock_file_for_update(&rewritten_lock, todo_file, LOCK_DIE_ON_ERROR);
+	for (i = 0; i < rewritten.nr; i++) {
+		struct rewritten_list_item *item = &rewritten.items[i];
+		strbuf_addf(&buf, "%s %s\n", sha1_to_hex(item->from), sha1_to_hex(item->to));
+	}
+	if (write_in_full(fd, buf.buf, buf.len) < 0) {
+		strbuf_release(&buf);
+		die_errno(_("Could not write to %s"), todo_file);
+	}
+	if (commit_lock_file(&rewritten_lock) < 0) {
+		strbuf_release(&buf);
+		die(_("Error wrapping up %s."), todo_file);
+	}
+	strbuf_release(&buf);
+}
+
 static void save_opts(struct replay_opts *opts)
 {
 	const char *opts_file = git_path(SEQ_OPTS_FILE);
@@ -1003,8 +1093,11 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 	for (cur = todo_list; cur; cur = cur->next) {
 		save_todo(cur, opts);
 		res = do_pick_commit(cur->item, opts);
-		if (res)
+		if (res) {
+			if (opts->action == REPLAY_PICK)
+				save_rewritten();
 			return res;
+		}
 	}
 
 	/*
@@ -1033,6 +1126,8 @@ static int sequencer_continue(struct replay_opts *opts)
 		return continue_single_pick();
 	read_populate_opts(&opts);
 	read_populate_todo(&todo_list, opts);
+	if (opts->action == REPLAY_PICK)
+		read_populate_rewritten();
 
 	/* Verify that the conflict has been resolved */
 	if (file_exists(git_path("CHERRY_PICK_HEAD")) ||
@@ -1043,6 +1138,11 @@ static int sequencer_continue(struct replay_opts *opts)
 	}
 	if (index_differs_from("HEAD", 0))
 		return error_dirty_index(opts);
+	if (opts->action == REPLAY_PICK) {
+		unsigned char to[20];
+		if (!read_ref("HEAD", to))
+			add_rewritten(todo_list->item->object.sha1, to);
+	}
 	todo_list = todo_list->next;
 	return pick_commits(todo_list, opts);
 }
diff --git a/sequencer.h b/sequencer.h
index 3b04844..84b9957 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -5,6 +5,7 @@
 #define SEQ_HEAD_FILE	"sequencer/head"
 #define SEQ_TODO_FILE	"sequencer/todo"
 #define SEQ_OPTS_FILE	"sequencer/opts"
+#define SEQ_REWR_FILE	"sequencer/rewritten"
 
 #define APPEND_SIGNOFF_DEDUP (1u << 0)
 
-- 
1.8.3.698.g079b096
