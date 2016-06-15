From: Hitoshi Mitake <h.mitake@gmail.com>
Subject: [PATCH v0 1/2] git-less: a specialized pager for git-log
Date: Fri, 23 Mar 2012 03:42:23 +0900
Message-ID: <1332441744-5142-2-git-send-email-h.mitake@gmail.com>
References: <1332441744-5142-1-git-send-email-h.mitake@gmail.com>
Cc: git@vger.kernel.org, Hitoshi Mitake <h.mitake@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 22 19:43:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAmyT-0008Je-HO
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 19:43:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756324Ab2CVSm4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 14:42:56 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47559 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667Ab2CVSmz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 14:42:55 -0400
Received: by mail-pb0-f46.google.com with SMTP id un15so1796657pbc.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 11:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=dntkrma+lCWGH8KWlx41ERxmIfi4hQHwLb93s2OQyiY=;
        b=KDmFXg8U4ukefOYMtNaBMgNqhV7Y+abzjyqEPZ8VvTiLpxW1hNXulyz7k40wMyjAu5
         6NBnRSi92oPCcKEvZsdtcEsUGwhsha9sUfyHuCxlAox1aItnJ7UICnT8KJb1Bmq8yXum
         fVnrtVRDw/nRSxFDCOqs+JsAySNQ8tz/DVCjQ6D7F+WmZT8dLFq3QuZ+Fqt9Yq7TBhbQ
         lYJN6PJd2RQfgFPUHGM0z5aJDL9B/4ciRjQd2KARxCJeyQVjOin447WYxWahCMzkK1rC
         eb6WxzUKfbRC8TgCFKZK055petvJufpsbhOgy6EaO3t5Smlxg0DOoEtBjSwJa/Er2h1I
         p/+A==
Received: by 10.68.125.134 with SMTP id mq6mr22865354pbb.74.1332441775105;
        Thu, 22 Mar 2012 11:42:55 -0700 (PDT)
Received: from localhost.localdomain (FL1-122-135-76-206.tky.mesh.ad.jp. [122.135.76.206])
        by mx.google.com with ESMTPS id b4sm4255081pbc.7.2012.03.22.11.42.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Mar 2012 11:42:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc1.29.g2a42
In-Reply-To: <1332441744-5142-1-git-send-email-h.mitake@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193677>

This patch adds a specialized pager for git-log: "git-less". Basically git-less
works like ordinal less, but it uses some new keys. The important feature of
this pager is git's commit oriented log viewing.

This is the key mapping of commit oriented operations:

h ... show previous commit
l ... show next commit
g ... goto top of viewing commit
G ... goto bottom of viewing commit
H ... show root of the commit tree
L ... show HEAD of the commit tree
\ ... regex forward search only in viewing commit
! ... regex backward search only in viewing commit

As this mapping shows, commit oriented move and search are implemented.
Especially I like commit local regex searches.

This patch adds the new source file less.c, the implementation of git-less. And
modifies .gitignore and Makefile for ignoring the binary and buliding.

Signed-off-by: Hitoshi Mitake <h.mitake@gmail.com>
---
 .gitignore |    1 +
 Makefile   |    5 +
 less.c     |  899 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 905 insertions(+)
 create mode 100644 less.c

diff --git a/.gitignore b/.gitignore
index 87fcc5f..81dba3a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -163,6 +163,7 @@
 /git-web--browse
 /git-whatchanged
 /git-write-tree
+/git-less
 /git-core-*/?*
 /gitk-git/gitk-wish
 /gitweb/GITWEB-BUILD-OPTIONS
diff --git a/Makefile b/Makefile
index be1957a..48600d5 100644
--- a/Makefile
+++ b/Makefile
@@ -463,6 +463,7 @@ PROGRAM_OBJS += upload-pack.o
 PROGRAM_OBJS += http-backend.o
 PROGRAM_OBJS += sh-i18n--envsubst.o
 PROGRAM_OBJS += credential-store.o
+PROGRAM_OBJS += less.o
 
 # Binary suffix, set to .exe for Windows builds
 X =
@@ -2239,6 +2240,10 @@ git-http-push$X: revision.o http.o http-push.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
+gitless$X: gitless.o
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
+
 $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
 	$(QUIET_LNCP)$(RM) $@ && \
 	ln $< $@ 2>/dev/null || \
diff --git a/less.c b/less.c
new file mode 100644
index 0000000..9848eca
--- /dev/null
+++ b/less.c
@@ -0,0 +1,899 @@
+/*
+ * git-less - a specialized pager for git-log
+ *
+ * Copyright (C) 2012 Hitoshi Mitake <h.mitake@gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <unistd.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <sys/stat.h>
+#include <termios.h>
+#include <sys/ioctl.h>
+#include <signal.h>
+#include <errno.h>
+
+#include <assert.h>
+
+#include <regex.h>
+
+extern int errno;
+
+#define die(fmt, arg...)						\
+	do {                                                            \
+		fprintf(stderr, "line %d: fatal error, " fmt "\n",	\
+			__LINE__, ##arg);				\
+		fprintf(stderr, "errno: %s\n", strerror(errno));	\
+		exit(1);						\
+	} while (0)
+
+#define ETX 0x03
+
+static void *xalloc(size_t size)
+{
+	void *ret;
+
+	ret = calloc(sizeof(char), size);
+	if (!ret)
+		die("memory allocation failed");
+
+	return ret;
+}
+
+static void *xrealloc(void *ptr, size_t size)
+{
+	void *ret;
+
+	assert(size);
+	ret = realloc(ptr, size);
+	if (!ret)
+		die("memory allocation failed");
+
+	return ret;
+}
+
+static int ret_nl_index(char *s)
+{
+	int i;
+
+	for (i = 0; s[i] != '\n'; i++);
+	return i;
+}
+
+static int stdin_fd = 0, tty_fd, debug_fd;
+static unsigned int row, col;
+static int running = 1;
+static int searching;
+
+#define LINES_INIT_SIZE 128
+
+enum {
+	STATE_DEFAULT,
+	STATE_INPUT_SEARCH_QUERY,
+	STATE_SEARCHING_QUERY
+};
+static int state = STATE_DEFAULT;
+
+#define BOTTOM_MESSAGE_INIT_SIZE 32
+static char *bottom_message;
+static int bottom_message_size = BOTTOM_MESSAGE_INIT_SIZE;
+
+#define MATCH_ARRAY_INIT_SIZE 32
+static regmatch_t *match_array;
+static int match_array_size = MATCH_ARRAY_INIT_SIZE;
+
+#define bmprintf(fmt, arg...)						\
+	do {                                                            \
+		snprintf(bottom_message, bottom_message_size,		\
+			fmt, ##arg);					\
+	} while (0)
+
+#ifdef GIT_LESS_DEBUG
+
+#define debug_printf(fmt, arg...)					\
+	do {                                                            \
+		char dbg_msg[1024];					\
+		int w, wbyte, len;					\
+									\
+		bzero(dbg_msg, 1024);					\
+		len = snprintf(dbg_msg, 1024,				\
+			fmt, ##arg);					\
+									\
+		wbyte = 0;						\
+		while ((w = write(debug_fd, dbg_msg + wbyte,		\
+						len - wbyte))) {	\
+			if (wbyte < 0)					\
+				die("failed write() on debug_fd");	\
+									\
+			wbyte += w;					\
+			if (wbyte == len)				\
+				break;					\
+		}							\
+	} while (0)
+
+#else
+
+#define debug_printf(fmt, arg...) do { } while (0)
+
+#endif	/* GIT_LESS_DEBUG */
+
+static void update_row_col(void)
+{
+	struct winsize size;
+
+	bzero(&size, sizeof(struct winsize));
+	ioctl(tty_fd, TIOCGWINSZ, (void *)&size);
+
+	row = size.ws_row - 1;
+	col = size.ws_col;
+
+	if (bottom_message_size - 1 < col) {
+		bottom_message_size = col + 1;
+		bottom_message = xrealloc(bottom_message, bottom_message_size);
+	}
+
+	if (match_array_size < col) {
+		match_array_size = col;
+		match_array = xrealloc(match_array,
+				match_array_size * sizeof(regmatch_t));
+	}
+}
+
+static struct termios attr;
+
+static void init_tty(void)
+{
+	tty_fd = open("/dev/tty", O_RDONLY);
+	if (tty_fd < 0)
+		die("open()ing /dev/tty");
+
+	bzero(&attr, sizeof(struct termios));
+	tcgetattr(tty_fd, &attr);
+	attr.c_lflag &= ~ICANON;
+	attr.c_lflag &= ~ECHO;
+	tcsetattr(tty_fd, TCSANOW, &attr);
+
+	update_row_col();
+}
+
+static char *logbuf;
+static int logbuf_size, logbuf_used;
+#define LOGBUF_INIT_SIZE 1024
+
+static int last_etx;
+
+struct commit {
+	unsigned int *lines;	/* array of index of logbuf */
+	int lines_size;
+
+	int nr_lines, head_line;
+
+	/*
+	 * caution:
+	 * prev means previous commit of the commit object,
+	 * next means next commit of the commit object.
+	 */
+	struct commit *prev, *next;
+};
+
+/* head: HEAD, root: root of the commit tree */
+static struct commit *head, *root;
+/* current: current displaying commit, tail: tail of the read commits */
+static struct commit *current, *tail;
+
+static regex_t *re_compiled;
+
+static void update_terminal(void)
+{
+	int i, j, print;
+	char *line;
+
+	printf("\033[2J\033[0;0J");
+
+	/* FIXME: first new line should be eliminated in git-log */
+	if (current != head && !current->head_line)
+		current->head_line = 1;
+
+	for (i = current->head_line, print = 0;
+	     i < current->head_line + row
+		     && i < current->nr_lines; i++, print++) {
+		line = &logbuf[current->lines[i]];
+
+		if (state == STATE_SEARCHING_QUERY) {
+			int ret, mi, nli = ret_nl_index(line);
+			int rev = 0;
+
+			line[nli] = '\0';
+			ret = regexec(re_compiled, line,
+				match_array_size, match_array, 0);
+			line[nli] = '\n';
+
+			if (ret)
+				goto normal_print;
+
+			for (mi = j = 0; j < col && line[j] != '\n'; j++) {
+				if (j == match_array[mi].rm_so) {
+					printf("\033[7m");
+					rev = 1;
+				} else if (j == match_array[mi].rm_eo) {
+					printf("\033[0m");
+					rev = 0;
+
+					mi++;
+				}
+
+				if (match_array[mi].rm_so
+					== match_array[mi].rm_eo) {
+					printf("\033[0m");
+					rev = 0;
+
+					mi++;
+				}
+
+				putchar(line[j]);
+			}
+
+			if (rev)
+				printf("\033[0m");
+		} else {
+		normal_print:
+			for (j = 0; j < col && line[j] != '\n'; j++)
+				putchar(line[j]);
+		}
+		putchar('\n');
+	}
+
+	while (i++ < current->head_line + row)
+		putchar('\n');
+
+	if (current->nr_lines <= current->head_line + row)
+		printf("\033[7m100%%\033[0m");
+	else
+		printf("\033[7m% .0f%%\033[0m",
+			(float)(current->head_line + row)
+			/ current->nr_lines * 100.0);
+
+	printf("\033[7m %s\033[0m", bottom_message);
+	fflush(stdout);
+}
+
+static void signal_handler(int signum)
+{
+	switch (signum) {
+	case SIGWINCH:
+		update_row_col();
+		update_terminal();
+		break;
+
+	case SIGINT:
+		if (searching)
+			searching = 0;
+		else
+			running = 0;
+		break;
+
+	default:
+		die("unknown signal: %d", signum);
+		break;
+	}
+}
+
+static int init_sighandler(void)
+{
+	struct sigaction act;
+
+	bzero(&act, sizeof(struct sigaction));
+	act.sa_handler = signal_handler;
+	sigaction(SIGWINCH, &act, NULL);
+	sigaction(SIGINT, &act, NULL);
+
+	return 0;
+}
+
+static void init_commit(struct commit *c, int first_index)
+{
+	int i, line_head;
+
+	c->lines_size = LINES_INIT_SIZE;
+	c->lines = xalloc(c->lines_size * sizeof(int));
+
+	line_head = first_index;
+
+	for (i = first_index; logbuf[i] != ETX; i++) {
+		if (logbuf[i] != '\n')
+			continue;
+
+		c->lines[c->nr_lines++] = line_head;
+		line_head = i + 1;
+
+		if (c->lines_size == c->nr_lines) {
+			c->lines_size <<= 1;
+			c->lines = xrealloc(c->lines,
+					c->lines_size * sizeof(int));
+		}
+	}
+}
+
+static int contain_etx(int begin, int end)
+{
+	int i;
+
+	for (i = begin; i < end; i++)
+		if (logbuf[i] == (char)ETX) return i;
+
+	return -1;
+}
+
+static void read_head(void)
+{
+	int prev_logbuf_used = 0;
+
+	do {
+		int rbyte;
+
+		if (logbuf_used == logbuf_size) {
+			logbuf_size <<= 1;
+			logbuf = xrealloc(logbuf, logbuf_size);
+		}
+
+		rbyte = read(stdin_fd, &logbuf[logbuf_used],
+			logbuf_size - logbuf_used);
+
+		if (rbyte < 0) {
+			if (errno == EINTR)
+				continue;
+			else
+				die("read() failed");
+		}
+
+		if (!rbyte)
+			exit(0); /* no input */
+
+		prev_logbuf_used = logbuf_used;
+		logbuf_used += rbyte;
+	} while ((last_etx =
+			contain_etx(prev_logbuf_used, logbuf_used)) == -1);
+
+	head = xalloc(sizeof(struct commit));
+	init_commit(head, 0);
+
+	tail = current = head;
+}
+
+static void read_commit(void)
+{
+	int prev_last_etx = last_etx;
+	int prev_logbuf_used, first_logbuf_used;
+	struct commit *new_commit;
+
+	static int read_end;
+
+	if (read_end)
+		return;
+
+	if (last_etx + 1 < logbuf_used) {
+		unsigned int tmp_etx;
+
+		tmp_etx = contain_etx(last_etx + 1, logbuf_used);
+		if (tmp_etx != -1) {
+			last_etx = tmp_etx;
+			goto skip_read;
+		}
+	}
+
+	prev_logbuf_used = 0;
+	first_logbuf_used = logbuf_used;
+
+	do {
+		int rbyte;
+
+		if (logbuf_used == logbuf_size) {
+			logbuf_size <<= 1;
+			logbuf = xrealloc(logbuf, logbuf_size);
+		}
+
+		rbyte = read(stdin_fd, &logbuf[logbuf_used],
+			logbuf_size - logbuf_used);
+
+		if (rbyte < 0) {
+			if (errno == EINTR)
+				continue;
+			else
+				die("read() failed");
+		}
+
+		if (!rbyte) {
+			read_end = 1;
+			if (first_logbuf_used == logbuf_used)
+				return;
+		}
+
+		prev_logbuf_used = logbuf_used;
+		logbuf_used += rbyte;
+	} while ((last_etx =
+			contain_etx(prev_logbuf_used, logbuf_used)) == -1);
+
+skip_read:
+
+	new_commit = xalloc(sizeof(struct commit));
+
+	assert(!tail->prev);
+	tail->prev = new_commit;
+	new_commit->next = tail;
+
+	tail = new_commit;
+
+	init_commit(new_commit, prev_last_etx + 1);
+}
+
+static int show_prev_commit(char cmd)
+{
+	if (!current->prev) {
+		read_commit();
+
+		if (!current->prev)
+			return 0;
+	}
+
+	current = current->prev;
+	return 1;
+}
+
+static int show_next_commit(char cmd)
+{
+	if (!current->next) {
+		assert(current == head);
+		return 0;
+	}
+
+	current = current->next;
+	return 1;
+}
+
+static int forward_line(char cmd)
+{
+	if (current->head_line + row < current->nr_lines) {
+		current->head_line++;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int backward_line(char cmd)
+{
+	if (0 < current->head_line) {
+		current->head_line--;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int goto_top(char cmd)
+{
+	if (!current->head_line)
+		return 0;
+
+	current->head_line = 0;
+	return 1;
+}
+
+static int goto_bottom(char cmd)
+{
+	if (current->nr_lines < row)
+		return 0;
+
+	current->head_line = current->nr_lines - row;
+	return 1;
+}
+
+static int forward_page(char cmd)
+{
+	if (current->nr_lines < current->head_line + row)
+		return 0;
+
+	current->head_line += row;
+	return 1;
+}
+
+static int backward_page(char cmd)
+{
+	if (!current->head_line)
+		return 0;
+
+	current->head_line -= row;
+	if (current->head_line < 0)
+		current->head_line = 0;
+
+	return 1;
+}
+
+static int show_root(char cmd)
+{
+	if (root) {
+		current = root;
+		return 1;
+	}
+
+	do {
+		if (!current->prev)
+			read_commit();
+		if (!current->prev)
+			break;
+		current = current->prev;
+	} while (1);
+
+	assert(!root);
+	root = current;
+
+	return 1;
+}
+
+static int show_head(char cmd)
+{
+	if (current == head)
+		return 0;
+
+	current = head;
+	return 1;
+}
+
+#define QUERY_SIZE 128
+static char query[QUERY_SIZE + 1];
+static int query_used;
+
+static int match_line(char *line)
+{
+	if (!regexec(re_compiled, line, 0, NULL, REG_NOTEOL))
+		return 1;
+
+	return 0;
+}
+
+static int match_commit(struct commit *c, int direction, int prog)
+{
+	int i = c->head_line;
+	int nli, result;
+	char *line;
+
+	if (prog) {
+		if (direction) {
+			if (c->nr_lines <= i - 1)
+				return 0;
+		} else {
+			if (!i)
+				return 0;
+		}
+
+		i += direction ? 1 : -1;
+	}
+
+	do {
+		line = &logbuf[c->lines[i]];
+		nli = ret_nl_index(line);
+
+		line[nli] = '\0';
+		result = match_line(line);
+		line[nli] = '\n';
+
+		if (result) {
+			c->head_line = i;
+			return 1;
+		}
+
+		i += direction ? 1 : -1;
+	} while (direction ? i < c->nr_lines : 0 <= i);
+
+	return 0;
+}
+
+static int do_search(int direction, int global, int prog)
+{
+	int result;
+	struct commit *p;
+
+	assert(!searching);
+	searching = 1;
+
+	result = match_commit(current, direction, prog);
+	if (result || !global)
+		goto no_match;
+
+	if (direction) {
+		if (!current->prev)
+			read_commit();
+
+		if (current->prev)
+			p = current->prev;
+		else
+			goto no_match;
+	} else {
+		if (current->next)
+			p = current->next;
+		else
+			goto no_match;
+	}
+
+	do {
+		if (direction)
+			p->head_line = 0;
+		else
+			p->head_line = p->nr_lines - 1;
+
+		result = match_commit(p, direction, prog);
+		if (result)
+			goto matched;
+
+		if (direction && !p->prev)
+			read_commit();
+	} while (searching && (direction ? (p = p->prev) : (p = p->next)));
+
+	goto no_match;
+
+matched:
+	current = p;
+no_match:
+	searching = 0;
+
+	return result;
+}
+
+static int current_direction, current_global;
+
+#define update_query_bm()	do {					\
+		bmprintf("\033[7m%s %s search:\033[0m %s",		\
+			current_direction ? "forward" : "backward",	\
+			current_global ? "global" : "local",		\
+			query);						\
+									\
+	} while (0)
+
+static int _search(int key, int direction, int global)
+{
+	current_direction = direction;
+	current_global = global;
+
+	switch (state) {
+	case STATE_DEFAULT:
+	case STATE_SEARCHING_QUERY:
+		query_used = 0;
+		bzero(query, QUERY_SIZE);
+
+		update_query_bm();
+		state = STATE_INPUT_SEARCH_QUERY;
+		break;
+
+	case STATE_INPUT_SEARCH_QUERY:
+		if (query_used + 1 == QUERY_SIZE) {
+			bmprintf("search query is too long!");
+			state = STATE_DEFAULT;
+
+			goto end;
+		}
+
+		if (key == '\n')
+			state = STATE_SEARCHING_QUERY;
+		else {
+			query[query_used++] = (char)key;
+			update_query_bm();
+		}
+	end:
+		break;
+
+	default:
+		die("invalid or unknown state: %d", state);
+		break;
+	}
+
+	if (state == STATE_SEARCHING_QUERY) {
+		if (re_compiled)
+			regfree(re_compiled);
+		else
+			re_compiled = xalloc(sizeof(regex_t));
+		regcomp(re_compiled, query, REG_ICASE);
+
+		if (!do_search(direction, global, 0))
+			bmprintf("not found: %s", query);
+		else
+			update_query_bm();
+	}
+
+	return 1;
+}
+
+static int search(int direction, int global)
+{
+	return _search(-1, direction, global);
+}
+
+static int search_global_forward(char cmd)
+{
+	return search(1, 1);
+}
+
+static int search_global_backward(char cmd)
+{
+	return search(0, 1);
+}
+
+static int search_local_forward(char cmd)
+{
+	return search(1, 0);
+}
+
+static int search_local_backward(char cmd)
+{
+	return search(0, 0);
+}
+
+static int search_progress(char cmd)
+{
+	if (state != STATE_SEARCHING_QUERY)
+		return 0;
+
+	if (!do_search(cmd == 'n' ?
+			current_direction : !current_direction,
+			current_global, 1))
+		bmprintf("not found: %s", query);
+	else
+		update_query_bm();
+
+	return 1;
+}
+
+static int input_query(char key)
+{
+	if (key == (char)0x7f) {
+		/* backspace */
+		if (!query_used)
+			return 0;
+
+		query[--query_used] = '\0';
+		update_query_bm();
+
+		return 1;
+	} else if (key == (char)0x1b) {
+		/* escape */
+		regfree(re_compiled);
+		free(re_compiled);
+		re_compiled = NULL;
+
+		query_used = 0;
+		bzero(query, QUERY_SIZE);
+
+		bzero(bottom_message, bottom_message_size);
+		state = STATE_DEFAULT;
+		return 1;
+	}
+
+	return _search(key, current_direction, current_global);
+}
+
+static int nop(char cmd)
+{
+	return 0;
+}
+
+static int quit(char cmd)
+{
+	running = 0;
+	return 0;
+}
+
+struct key_cmd {
+	char key;
+	int (*op)(char);
+};
+
+static struct key_cmd valid_ops[] = {
+	{ 'h', show_prev_commit },
+	{ 'j', forward_line },
+	{ 'k', backward_line },
+	{ 'l', show_next_commit },
+	{ 'q', quit },
+	{ 'g', goto_top },
+	{ 'G', goto_bottom },
+	{ ' ', forward_page },
+	{ 'J', forward_page },
+	{ 'K', backward_page },
+	{ 'H', show_root },
+	{ 'L', show_head },
+	{ '/', search_global_forward },
+	{ '?', search_global_backward },
+	{ '\\', search_local_forward },
+	{ '!', search_local_backward },
+	{ 'n', search_progress },
+	{ 'p', search_progress },
+
+	{ '\0', NULL },
+};
+
+static int (*ops_array[256])(char);
+
+int main(void)
+{
+	int i;
+	char cmd;
+
+#ifdef GIT_LESS_DEBUG
+
+#define DEBUG_FIFO_NAME "/tmp/git-less-debug"
+	if (mkfifo(DEBUG_FIFO_NAME, S_IRWXU))
+		die("failed to create named fifo for debugging");
+
+	debug_fd = open(DEBUG_FIFO_NAME, O_RDWR);
+	if (debug_fd < 0)
+		die("failed to open() named fifo for debugging");
+
+#endif
+
+	bottom_message = xalloc(bottom_message_size);
+	match_array = xalloc(match_array_size * sizeof(regmatch_t));
+
+	init_tty();
+	init_sighandler();
+
+	logbuf_size = LOGBUF_INIT_SIZE;
+	logbuf = xalloc(logbuf_size);
+	logbuf_used = 0;
+	read_head();
+
+	update_terminal();
+
+	for (i = 0; i < 256; i++)
+		ops_array[i] = nop;
+
+	for (i = 0; valid_ops[i].key != '\0'; i++)
+		ops_array[(int)valid_ops[i].key] = valid_ops[i].op;
+
+	while (running) {
+		int ret;
+
+		ret = read(tty_fd, &cmd, 1);
+		if (ret == -1 && errno == EINTR) {
+			if (!running)
+				break;
+
+			errno = 0;
+			continue;
+		}
+
+		if (ret != 1)
+			die("reading key input failed");
+
+		if (state == STATE_INPUT_SEARCH_QUERY)
+			ret = input_query(cmd);
+		else
+			ret = ops_array[(int)cmd](cmd);
+
+		if (ret)
+			update_terminal();
+	}
+
+	printf("\n");
+
+#ifdef GIT_LESS_DEBUG
+	unlink(DEBUG_FIFO_NAME);
+#endif
+
+	return 0;
+}
-- 
1.7.10.rc1.33.g64ff3.dirty
