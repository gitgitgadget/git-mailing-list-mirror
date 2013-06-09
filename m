From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 05/45] log-tree: remove dependency from sequencer
Date: Sun,  9 Jun 2013 11:40:17 -0500
Message-ID: <1370796057-25312-6-git-send-email-felipe.contreras@gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:43:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulii7-0006RE-0i
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228Ab3FIQnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:43:09 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:47141 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887Ab3FIQnG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:43:06 -0400
Received: by mail-oa0-f51.google.com with SMTP id i4so854397oah.24
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=fjNhiccfHIVxDP3GKx9mWtcPP6Q7pIJ63AqWY0bPzAY=;
        b=j+dG9UUgIWkLHQhy8g8NQA87nH9OuKy35iv5pHjMt45myjPvW4JbA07yEyROCmM7br
         o314IEuKLtmho3CalzaChz8/3YPNHTthmYk3EjnzKFVkVgfMgMZuL5DAykTn/TwV1ffS
         5UI5JtCVj0p9/iuTk2cw+xpkMMqx5rlohNePC9r++bphTBr9cJqzaolNrZxxEHM4lQ3/
         pDS3UOpMbt8rfaDIhaMKc5oINjNi2H6sye0x0DC5WucWlunpK9kpM3+pgBcElKD5mI27
         LtLez2AJ4L0akPOwTl4yCqeE4QN+dLu1mp9ka/zlR1cCB02EwlCVRfh8k7e8z6L8QpOg
         Te/A==
X-Received: by 10.182.101.131 with SMTP id fg3mr4843778obb.11.1370796185492;
        Sun, 09 Jun 2013 09:43:05 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id i2sm14868146obz.11.2013.06.09.09.43.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:43:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226976>

Move the relevant code from sequencer to log-tree. This code is not
specific to sequencer, and this allows the sequencer to move out of
libgit.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 log-tree.c  | 161 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 log-tree.h  |   3 ++
 sequencer.c | 160 ++---------------------------------------------------------
 sequencer.h |   4 --
 4 files changed, 166 insertions(+), 162 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 2eb69bc..654f5db 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -9,10 +9,13 @@
 #include "string-list.h"
 #include "color.h"
 #include "gpg-interface.h"
-#include "sequencer.h"
 #include "line-log.h"
 
+#define APPEND_SIGNOFF_DEDUP (1u << 0)
+
 struct decoration name_decoration = { "object names" };
+const char sign_off_header[] = "Signed-off-by: ";
+static const char cherry_picked_prefix[] = "(cherry picked from commit ";
 
 enum decoration_type {
 	DECORATION_NONE = 0,
@@ -472,6 +475,162 @@ static void show_mergetag(struct rev_info *opt, struct commit *commit)
 	free_commit_extra_headers(to_free);
 }
 
+static int is_rfc2822_line(const char *buf, int len)
+{
+	int i;
+
+	for (i = 0; i < len; i++) {
+		int ch = buf[i];
+		if (ch == ':')
+			return 1;
+		if (!isalnum(ch) && ch != '-')
+			break;
+	}
+
+	return 0;
+}
+
+static int is_cherry_picked_from_line(const char *buf, int len)
+{
+	/*
+	 * We only care that it looks roughly like (cherry picked from ...)
+	 */
+	return len > strlen(cherry_picked_prefix) + 1 &&
+		!prefixcmp(buf, cherry_picked_prefix) && buf[len - 1] == ')';
+}
+
+/*
+ * Returns 0 for non-conforming footer
+ * Returns 1 for conforming footer
+ * Returns 2 when sob exists within conforming footer
+ * Returns 3 when sob exists within conforming footer as last entry
+ */
+int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
+	int ignore_footer)
+{
+	char prev;
+	int i, k;
+	int len = sb->len - ignore_footer;
+	const char *buf = sb->buf;
+	int found_sob = 0;
+
+	/* footer must end with newline */
+	if (!len || buf[len - 1] != '\n')
+		return 0;
+
+	prev = '\0';
+	for (i = len - 1; i > 0; i--) {
+		char ch = buf[i];
+		if (prev == '\n' && ch == '\n') /* paragraph break */
+			break;
+		prev = ch;
+	}
+
+	/* require at least one blank line */
+	if (prev != '\n' || buf[i] != '\n')
+		return 0;
+
+	/* advance to start of last paragraph */
+	while (i < len - 1 && buf[i] == '\n')
+		i++;
+
+	for (; i < len; i = k) {
+		int found_rfc2822;
+
+		for (k = i; k < len && buf[k] != '\n'; k++)
+			; /* do nothing */
+		k++;
+
+		found_rfc2822 = is_rfc2822_line(buf + i, k - i - 1);
+		if (found_rfc2822 && sob &&
+		    !strncmp(buf + i, sob->buf, sob->len))
+			found_sob = k;
+
+		if (!(found_rfc2822 ||
+		      is_cherry_picked_from_line(buf + i, k - i - 1)))
+			return 0;
+	}
+	if (found_sob == i)
+		return 3;
+	if (found_sob)
+		return 2;
+	return 1;
+}
+
+void append_cherrypick(struct strbuf *msgbuf, struct object *obj)
+{
+	if (!has_conforming_footer(msgbuf, NULL, 0))
+		strbuf_addch(msgbuf, '\n');
+	strbuf_addstr(msgbuf, cherry_picked_prefix);
+	strbuf_addstr(msgbuf, sha1_to_hex(obj->sha1));
+	strbuf_addstr(msgbuf, ")\n");
+}
+
+void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
+{
+	unsigned no_dup_sob = flag & APPEND_SIGNOFF_DEDUP;
+	struct strbuf sob = STRBUF_INIT;
+	int has_footer;
+
+	strbuf_addstr(&sob, sign_off_header);
+	strbuf_addstr(&sob, fmt_name(getenv("GIT_COMMITTER_NAME"),
+				getenv("GIT_COMMITTER_EMAIL")));
+	strbuf_addch(&sob, '\n');
+
+	/*
+	 * If the whole message buffer is equal to the sob, pretend that we
+	 * found a conforming footer with a matching sob
+	 */
+	if (msgbuf->len - ignore_footer == sob.len &&
+	    !strncmp(msgbuf->buf, sob.buf, sob.len))
+		has_footer = 3;
+	else
+		has_footer = has_conforming_footer(msgbuf, &sob, ignore_footer);
+
+	if (!has_footer) {
+		const char *append_newlines = NULL;
+		size_t len = msgbuf->len - ignore_footer;
+
+		if (!len) {
+			/*
+			 * The buffer is completely empty.  Leave foom for
+			 * the title and body to be filled in by the user.
+			 */
+			append_newlines = "\n\n";
+		} else if (msgbuf->buf[len - 1] != '\n') {
+			/*
+			 * Incomplete line.  Complete the line and add a
+			 * blank one so that there is an empty line between
+			 * the message body and the sob.
+			 */
+			append_newlines = "\n\n";
+		} else if (len == 1) {
+			/*
+			 * Buffer contains a single newline.  Add another
+			 * so that we leave room for the title and body.
+			 */
+			append_newlines = "\n";
+		} else if (msgbuf->buf[len - 2] != '\n') {
+			/*
+			 * Buffer ends with a single newline.  Add another
+			 * so that there is an empty line between the message
+			 * body and the sob.
+			 */
+			append_newlines = "\n";
+		} /* else, the buffer already ends with two newlines. */
+
+		if (append_newlines)
+			strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
+				append_newlines, strlen(append_newlines));
+	}
+
+	if (has_footer != 3 && (!no_dup_sob || has_footer != 2))
+		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
+				sob.buf, sob.len);
+
+	strbuf_release(&sob);
+}
+
 void show_log(struct rev_info *opt)
 {
 	struct strbuf msgbuf = STRBUF_INIT;
diff --git a/log-tree.h b/log-tree.h
index d6ecd4d..1039e49 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -25,4 +25,7 @@ void load_ref_decorations(int flags);
 void fmt_output_commit(struct strbuf *, struct commit *, struct rev_info *);
 void fmt_output_subject(struct strbuf *, const char *subject, struct rev_info *);
 
+void append_cherrypick(struct strbuf *msgbuf, struct object *obj);
+void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
+
 #endif
diff --git a/sequencer.c b/sequencer.c
index ab6f8a7..e92e039 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -14,94 +14,10 @@
 #include "merge-recursive.h"
 #include "refs.h"
 #include "argv-array.h"
+#include "log-tree.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
-const char sign_off_header[] = "Signed-off-by: ";
-static const char cherry_picked_prefix[] = "(cherry picked from commit ";
-
-static int is_rfc2822_line(const char *buf, int len)
-{
-	int i;
-
-	for (i = 0; i < len; i++) {
-		int ch = buf[i];
-		if (ch == ':')
-			return 1;
-		if (!isalnum(ch) && ch != '-')
-			break;
-	}
-
-	return 0;
-}
-
-static int is_cherry_picked_from_line(const char *buf, int len)
-{
-	/*
-	 * We only care that it looks roughly like (cherry picked from ...)
-	 */
-	return len > strlen(cherry_picked_prefix) + 1 &&
-		!prefixcmp(buf, cherry_picked_prefix) && buf[len - 1] == ')';
-}
-
-/*
- * Returns 0 for non-conforming footer
- * Returns 1 for conforming footer
- * Returns 2 when sob exists within conforming footer
- * Returns 3 when sob exists within conforming footer as last entry
- */
-static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
-	int ignore_footer)
-{
-	char prev;
-	int i, k;
-	int len = sb->len - ignore_footer;
-	const char *buf = sb->buf;
-	int found_sob = 0;
-
-	/* footer must end with newline */
-	if (!len || buf[len - 1] != '\n')
-		return 0;
-
-	prev = '\0';
-	for (i = len - 1; i > 0; i--) {
-		char ch = buf[i];
-		if (prev == '\n' && ch == '\n') /* paragraph break */
-			break;
-		prev = ch;
-	}
-
-	/* require at least one blank line */
-	if (prev != '\n' || buf[i] != '\n')
-		return 0;
-
-	/* advance to start of last paragraph */
-	while (i < len - 1 && buf[i] == '\n')
-		i++;
-
-	for (; i < len; i = k) {
-		int found_rfc2822;
-
-		for (k = i; k < len && buf[k] != '\n'; k++)
-			; /* do nothing */
-		k++;
-
-		found_rfc2822 = is_rfc2822_line(buf + i, k - i - 1);
-		if (found_rfc2822 && sob &&
-		    !strncmp(buf + i, sob->buf, sob->len))
-			found_sob = k;
-
-		if (!(found_rfc2822 ||
-		      is_cherry_picked_from_line(buf + i, k - i - 1)))
-			return 0;
-	}
-	if (found_sob == i)
-		return 3;
-	if (found_sob)
-		return 2;
-	return 1;
-}
-
 static void remove_sequencer_state(void)
 {
 	struct strbuf seq_dir = STRBUF_INIT;
@@ -578,13 +494,8 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 			strbuf_addstr(&msgbuf, p);
 		}
 
-		if (opts->record_origin) {
-			if (!has_conforming_footer(&msgbuf, NULL, 0))
-				strbuf_addch(&msgbuf, '\n');
-			strbuf_addstr(&msgbuf, cherry_picked_prefix);
-			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
-			strbuf_addstr(&msgbuf, ")\n");
-		}
+		if (opts->record_origin)
+			append_cherrypick(&msgbuf, &commit->object);
 	}
 
 	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || opts->action == REPLAY_REVERT) {
@@ -1123,68 +1034,3 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 	save_opts(opts);
 	return pick_commits(todo_list, opts);
 }
-
-void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
-{
-	unsigned no_dup_sob = flag & APPEND_SIGNOFF_DEDUP;
-	struct strbuf sob = STRBUF_INIT;
-	int has_footer;
-
-	strbuf_addstr(&sob, sign_off_header);
-	strbuf_addstr(&sob, fmt_name(getenv("GIT_COMMITTER_NAME"),
-				getenv("GIT_COMMITTER_EMAIL")));
-	strbuf_addch(&sob, '\n');
-
-	/*
-	 * If the whole message buffer is equal to the sob, pretend that we
-	 * found a conforming footer with a matching sob
-	 */
-	if (msgbuf->len - ignore_footer == sob.len &&
-	    !strncmp(msgbuf->buf, sob.buf, sob.len))
-		has_footer = 3;
-	else
-		has_footer = has_conforming_footer(msgbuf, &sob, ignore_footer);
-
-	if (!has_footer) {
-		const char *append_newlines = NULL;
-		size_t len = msgbuf->len - ignore_footer;
-
-		if (!len) {
-			/*
-			 * The buffer is completely empty.  Leave foom for
-			 * the title and body to be filled in by the user.
-			 */
-			append_newlines = "\n\n";
-		} else if (msgbuf->buf[len - 1] != '\n') {
-			/*
-			 * Incomplete line.  Complete the line and add a
-			 * blank one so that there is an empty line between
-			 * the message body and the sob.
-			 */
-			append_newlines = "\n\n";
-		} else if (len == 1) {
-			/*
-			 * Buffer contains a single newline.  Add another
-			 * so that we leave room for the title and body.
-			 */
-			append_newlines = "\n";
-		} else if (msgbuf->buf[len - 2] != '\n') {
-			/*
-			 * Buffer ends with a single newline.  Add another
-			 * so that there is an empty line between the message
-			 * body and the sob.
-			 */
-			append_newlines = "\n";
-		} /* else, the buffer already ends with two newlines. */
-
-		if (append_newlines)
-			strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
-				append_newlines, strlen(append_newlines));
-	}
-
-	if (has_footer != 3 && (!no_dup_sob || has_footer != 2))
-		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
-				sob.buf, sob.len);
-
-	strbuf_release(&sob);
-}
diff --git a/sequencer.h b/sequencer.h
index 1fc22dc..c341918 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -6,8 +6,6 @@
 #define SEQ_TODO_FILE	"sequencer/todo"
 #define SEQ_OPTS_FILE	"sequencer/opts"
 
-#define APPEND_SIGNOFF_DEDUP (1u << 0)
-
 enum replay_action {
 	REPLAY_REVERT,
 	REPLAY_PICK
@@ -50,6 +48,4 @@ int sequencer_pick_revisions(struct replay_opts *opts);
 
 extern const char sign_off_header[];
 
-void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
-
 #endif
-- 
1.8.3.698.g079b096
