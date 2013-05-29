From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 4/8] cherry-pick: store rewritten commits
Date: Tue, 28 May 2013 22:56:24 -0500
Message-ID: <1369799788-24803-5-git-send-email-felipe.contreras@gmail.com>
References: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 29 05:58:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhXX2-00035O-QN
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 05:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934871Ab3E2D6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 23:58:24 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:39133 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933578Ab3E2D6U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 23:58:20 -0400
Received: by mail-oa0-f54.google.com with SMTP id o17so10954341oag.27
        for <git@vger.kernel.org>; Tue, 28 May 2013 20:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=3BCiSg5aOO5Nd1SS41Yr9VNaWR8dZnhzca2Br8nbLqU=;
        b=dHljkvSS2dGjFJLIhIORj5Q9NGSo1uR6sIwU8KYJaNZAw+b2hEF82Uju/9JEFNiAZG
         W9vQdN2C1YWLsb5EXUQInE28uZ5Tu2unQBWOfgP0UMaWQaAsTr3btHB5gDApSGmJr62z
         NdA0P/vj0V9ihf8Ba//gWyLZviAiviNW1oKyxDqSyRYAnZ7GmXuxWrJ2ZzQxbT1Lu9Av
         uxOzmLomsrDg7Ms8Z2jQIv/V9L2nVzAhtKvE6Rf5EAnuASQUx6I7cUl7I2eJYo7A0mRP
         BvaQfjVt8dY8tBzeuu789WaS6QY7SkJtbtk6+uqK7avlGwLg5ZNvVZkW1k5jYT9G6iz5
         RFjQ==
X-Received: by 10.60.94.113 with SMTP id db17mr502589oeb.62.1369799900210;
        Tue, 28 May 2013 20:58:20 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id q4sm38349141obl.1.2013.05.28.20.58.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 20:58:19 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225719>

Will be useful for the next commits.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sequencer.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 sequencer.h |  1 +
 2 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index d3c7d72..c217716 100644
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
 
+	if (!res) {
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
@@ -1003,8 +1093,10 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 	for (cur = todo_list; cur; cur = cur->next) {
 		save_todo(cur, opts);
 		res = do_pick_commit(cur->item, opts);
-		if (res)
+		if (res) {
+			save_rewritten();
 			return res;
+		}
 	}
 
 	/*
@@ -1033,6 +1125,7 @@ static int sequencer_continue(struct replay_opts *opts)
 		return continue_single_pick();
 	read_populate_opts(&opts);
 	read_populate_todo(&todo_list, opts);
+	read_populate_rewritten();
 
 	/* Verify that the conflict has been resolved */
 	if (file_exists(git_path("CHERRY_PICK_HEAD")) ||
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
1.8.3.rc3.312.g47657de
