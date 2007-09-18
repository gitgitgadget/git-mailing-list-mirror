From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 2/5] sq_quote_argv and add_to_string rework with strbuf's.
Date: Tue, 18 Sep 2007 22:15:16 +0200
Message-ID: <20070918224120.1DC44344AB3@madism.org>
References: <20070918223947.GB4535@artemis.corp>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 00:41:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXll1-0007bW-Q5
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 00:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008AbXIRWlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 18:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753854AbXIRWlX
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 18:41:23 -0400
Received: from pan.madism.org ([88.191.52.104]:54829 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751643AbXIRWlV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 18:41:21 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 65BBE20A21;
	Wed, 19 Sep 2007 00:41:20 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 1DC44344AB3; Wed, 19 Sep 2007 00:41:20 +0200 (CEST)
In-Reply-To: <20070918223947.GB4535@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58647>

* sq_quote_buf is made public, and works on a strbuf.
* sq_quote_argv also works on a strbuf.
* make sq_quote_argv take a "maxlen" argument to check the buffer won't grow
  too big.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 connect.c |   21 ++++++--------
 git.c     |   16 +++-------
 quote.c   |   91 ++++++++++++++++---------------------------------------------
 quote.h   |    9 ++----
 rsh.c     |   33 ++++++----------------
 trace.c   |   35 +++++++-----------------
 6 files changed, 60 insertions(+), 145 deletions(-)

diff --git a/connect.c b/connect.c
index 1653a0e..06d279e 100644
--- a/connect.c
+++ b/connect.c
@@ -577,16 +577,13 @@ pid_t git_connect(int fd[2], char *url, const char *prog, int flags)
 	if (pid < 0)
 		die("unable to fork");
 	if (!pid) {
-		char command[MAX_CMD_LEN];
-		char *posn = command;
-		int size = MAX_CMD_LEN;
-		int of = 0;
+		struct strbuf cmd;
 
-		of |= add_to_string(&posn, &size, prog, 0);
-		of |= add_to_string(&posn, &size, " ", 0);
-		of |= add_to_string(&posn, &size, path, 1);
-
-		if (of)
+		strbuf_init(&cmd, MAX_CMD_LEN);
+		strbuf_addstr(&cmd, prog);
+		strbuf_addch(&cmd, ' ');
+		sq_quote_buf(&cmd, path);
+		if (cmd.len >= MAX_CMD_LEN)
 			die("command line too long");
 
 		dup2(pipefd[1][0], 0);
@@ -606,10 +603,10 @@ pid_t git_connect(int fd[2], char *url, const char *prog, int flags)
 				ssh_basename++;
 
 			if (!port)
-				execlp(ssh, ssh_basename, host, command, NULL);
+				execlp(ssh, ssh_basename, host, cmd.buf, NULL);
 			else
 				execlp(ssh, ssh_basename, "-p", port, host,
-				       command, NULL);
+				       cmd.buf, NULL);
 		}
 		else {
 			unsetenv(ALTERNATE_DB_ENVIRONMENT);
@@ -618,7 +615,7 @@ pid_t git_connect(int fd[2], char *url, const char *prog, int flags)
 			unsetenv(GIT_WORK_TREE_ENVIRONMENT);
 			unsetenv(GRAFT_ENVIRONMENT);
 			unsetenv(INDEX_ENVIRONMENT);
-			execlp("sh", "sh", "-c", command, NULL);
+			execlp("sh", "sh", "-c", cmd.buf, NULL);
 		}
 		die("exec failed");
 	}
diff --git a/git.c b/git.c
index 56ae8cc..9eaca1d 100644
--- a/git.c
+++ b/git.c
@@ -187,19 +187,13 @@ static int handle_alias(int *argcp, const char ***argv)
 	if (alias_string) {
 		if (alias_string[0] == '!') {
 			if (*argcp > 1) {
-				int i, sz = PATH_MAX;
-				char *s = xmalloc(sz), *new_alias = s;
+				struct strbuf buf;
 
-				add_to_string(&s, &sz, alias_string, 0);
+				strbuf_init(&buf, PATH_MAX);
+				strbuf_addstr(&buf, alias_string);
+				sq_quote_argv(&buf, (*argv) + 1, *argcp - 1, PATH_MAX);
 				free(alias_string);
-				alias_string = new_alias;
-				for (i = 1; i < *argcp &&
-					!add_to_string(&s, &sz, " ", 0) &&
-					!add_to_string(&s, &sz, (*argv)[i], 1)
-					; i++)
-					; /* do nothing */
-				if (!sz)
-					die("Too many or long arguments");
+				alias_string = buf.buf;
 			}
 			trace_printf("trace: alias to shell cmd: %s => %s\n",
 				     alias_command, alias_string + 1);
diff --git a/quote.c b/quote.c
index d88bf75..4df3262 100644
--- a/quote.c
+++ b/quote.c
@@ -20,29 +20,26 @@ static inline int need_bs_quote(char c)
 	return (c == '\'' || c == '!');
 }
 
-static size_t sq_quote_buf(char *dst, size_t n, const char *src)
+void sq_quote_buf(struct strbuf *dst, const char *src)
 {
-	char c;
-	char *bp = dst;
-	size_t len = 0;
-
-	EMIT('\'');
-	while ((c = *src++)) {
-		if (need_bs_quote(c)) {
-			EMIT('\'');
-			EMIT('\\');
-			EMIT(c);
-			EMIT('\'');
-		} else {
-			EMIT(c);
+	char *to_free = NULL;
+
+	if (dst->buf == src)
+		to_free = strbuf_detach(dst);
+
+	strbuf_addch(dst, '\'');
+	while (*src) {
+		size_t len = strcspn(src, "'\\");
+		strbuf_add(dst, src, len);
+		src += len;
+		while (need_bs_quote(*src)) {
+			strbuf_addstr(dst, "'\\");
+			strbuf_addch(dst, *src++);
+			strbuf_addch(dst, '\'');
 		}
 	}
-	EMIT('\'');
-
-	if ( n )
-		*bp = 0;
-
-	return len;
+	strbuf_addch(dst, '\'');
+	free(to_free);
 }
 
 void sq_quote_print(FILE *stream, const char *src)
@@ -62,11 +59,10 @@ void sq_quote_print(FILE *stream, const char *src)
 	fputc('\'', stream);
 }
 
-char *sq_quote_argv(const char** argv, int count)
+void sq_quote_argv(struct strbuf *dst, const char** argv, int count,
+                   size_t maxlen)
 {
-	char *buf, *to;
 	int i;
-	size_t len = 0;
 
 	/* Count argv if needed. */
 	if (count < 0) {
@@ -74,53 +70,14 @@ char *sq_quote_argv(const char** argv, int count)
 			; /* just counting */
 	}
 
-	/* Special case: no argv. */
-	if (!count)
-		return xcalloc(1,1);
-
-	/* Get destination buffer length. */
-	for (i = 0; i < count; i++)
-		len += sq_quote_buf(NULL, 0, argv[i]) + 1;
-
-	/* Alloc destination buffer. */
-	to = buf = xmalloc(len + 1);
-
 	/* Copy into destination buffer. */
+	strbuf_grow(dst, 32 * count);
 	for (i = 0; i < count; ++i) {
-		*to++ = ' ';
-		to += sq_quote_buf(to, len, argv[i]);
+		strbuf_addch(dst, ' ');
+		sq_quote_buf(dst, argv[i]);
+		if (maxlen && dst->len > maxlen)
+			die("Too many or long arguments");
 	}
-
-	return buf;
-}
-
-/*
- * Append a string to a string buffer, with or without shell quoting.
- * Return true if the buffer overflowed.
- */
-int add_to_string(char **ptrp, int *sizep, const char *str, int quote)
-{
-	char *p = *ptrp;
-	int size = *sizep;
-	int oc;
-	int err = 0;
-
-	if (quote)
-		oc = sq_quote_buf(p, size, str);
-	else {
-		oc = strlen(str);
-		memcpy(p, str, (size <= oc) ? size - 1 : oc);
-	}
-
-	if (size <= oc) {
-		err = 1;
-		oc = size - 1;
-	}
-
-	*ptrp += oc;
-	**ptrp = '\0';
-	*sizep -= oc;
-	return err;
 }
 
 char *sq_dequote(char *arg)
diff --git a/quote.h b/quote.h
index 8a59cc5..78e8d3e 100644
--- a/quote.h
+++ b/quote.h
@@ -29,13 +29,10 @@
  */
 
 extern void sq_quote_print(FILE *stream, const char *src);
-extern char *sq_quote_argv(const char** argv, int count);
 
-/*
- * Append a string to a string buffer, with or without shell quoting.
- * Return true if the buffer overflowed.
- */
-extern int add_to_string(char **ptrp, int *sizep, const char *str, int quote);
+extern void sq_quote_buf(struct strbuf *, const char *src);
+extern void sq_quote_argv(struct strbuf *, const char **argv, int count,
+                          size_t maxlen);
 
 /* This unwraps what sq_quote() produces in place, but returns
  * NULL if the input does not look like what sq_quote would have
diff --git a/rsh.c b/rsh.c
index 5754a23..e4ce255 100644
--- a/rsh.c
+++ b/rsh.c
@@ -7,14 +7,10 @@
 int setup_connection(int *fd_in, int *fd_out, const char *remote_prog,
 		     char *url, int rmt_argc, char **rmt_argv)
 {
+	struct strbuf cmd;
 	char *host;
 	char *path;
 	int sv[2];
-	char command[COMMAND_SIZE];
-	char *posn;
-	int sizen;
-	int of;
-	int i;
 	pid_t pid;
 
 	if (!strcmp(url, "-")) {
@@ -37,24 +33,13 @@ int setup_connection(int *fd_in, int *fd_out, const char *remote_prog,
 		return error("Bad URL: %s", url);
 	}
 	/* $GIT_RSH <host> "env GIT_DIR=<path> <remote_prog> <args...>" */
-	sizen = COMMAND_SIZE;
-	posn = command;
-	of = 0;
-	of |= add_to_string(&posn, &sizen, "env ", 0);
-	of |= add_to_string(&posn, &sizen, GIT_DIR_ENVIRONMENT "=", 0);
-	of |= add_to_string(&posn, &sizen, path, 1);
-	of |= add_to_string(&posn, &sizen, " ", 0);
-	of |= add_to_string(&posn, &sizen, remote_prog, 1);
-
-	for ( i = 0 ; i < rmt_argc ; i++ ) {
-		of |= add_to_string(&posn, &sizen, " ", 0);
-		of |= add_to_string(&posn, &sizen, rmt_argv[i], 1);
-	}
-
-	of |= add_to_string(&posn, &sizen, " -", 0);
-
-	if ( of )
-		return error("Command line too long");
+	strbuf_init(&cmd, COMMAND_SIZE);
+	strbuf_addstr(&cmd, "env " GIT_DIR_ENVIRONMENT "=");
+	sq_quote_buf(&cmd, path);
+	strbuf_addch(&cmd, ' ');
+	sq_quote_buf(&cmd, remote_prog);
+	sq_quote_argv(&cmd, (const char **)rmt_argv, rmt_argc, COMMAND_SIZE - 2);
+	strbuf_addstr(&cmd, " -");
 
 	if (socketpair(AF_UNIX, SOCK_STREAM, 0, sv))
 		return error("Couldn't create socket");
@@ -74,7 +59,7 @@ int setup_connection(int *fd_in, int *fd_out, const char *remote_prog,
 		close(sv[1]);
 		dup2(sv[0], 0);
 		dup2(sv[0], 1);
-		execlp(ssh, ssh_basename, host, command, NULL);
+		execlp(ssh, ssh_basename, host, cmd.buf, NULL);
 	}
 	close(sv[0]);
 	*fd_in = sv[1];
diff --git a/trace.c b/trace.c
index 7961a27..ed1cdf0 100644
--- a/trace.c
+++ b/trace.c
@@ -113,39 +113,24 @@ void trace_printf(const char *format, ...)
 
 void trace_argv_printf(const char **argv, int count, const char *format, ...)
 {
-	char *argv_str, *format_str, *trace_str;
-	size_t argv_len, format_len, trace_len;
-	va_list rest;
+	struct strbuf trace;
+	va_list ap;
 	int need_close = 0;
 	int fd = get_trace_fd(&need_close);
 
 	if (!fd)
 		return;
 
-	/* Get the argv string. */
-	argv_str = sq_quote_argv(argv, count);
-	argv_len = strlen(argv_str);
-
-	/* Get the formated string. */
-	va_start(rest, format);
-	nfvasprintf(&format_str, format, rest);
-	va_end(rest);
+	strbuf_init(&trace, 0);
 
-	/* Allocate buffer for trace string. */
-	format_len = strlen(format_str);
-	trace_len = argv_len + format_len + 1; /* + 1 for \n */
-	trace_str = xmalloc(trace_len + 1);
+	va_start(ap, format);
+	strbuf_addvf(&trace, format, ap);
+	va_end(ap);
+	sq_quote_argv(&trace, argv, count, 0);
+	strbuf_addch(&trace, '\n');
 
-	/* Copy everything into the trace string. */
-	strncpy(trace_str, format_str, format_len);
-	strncpy(trace_str + format_len, argv_str, argv_len);
-	strcpy(trace_str + trace_len - 1, "\n");
-
-	write_or_whine_pipe(fd, trace_str, trace_len, err_msg);
-
-	free(argv_str);
-	free(format_str);
-	free(trace_str);
+	write_or_whine_pipe(fd, trace.buf, trace.len, err_msg);
+	strbuf_release(&trace);
 
 	if (need_close)
 		close(fd);
-- 
1.5.3.1
