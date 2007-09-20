From: Pierre Habouzit <madcoder@debian.org>
Subject: [SUPERSEDES PATCH 2/7] nfv?asprintf are broken without va_copy, workaround them.
Date: Thu, 20 Sep 2007 10:43:11 +0200
Message-ID: <20070920084311.GB2053@artemis.corp>
References: <1190241736-30449-1-git-send-email-madcoder@debian.org> <1190241736-30449-2-git-send-email-madcoder@debian.org> <1190241736-30449-3-git-send-email-madcoder@debian.org> <7vwsumkll8.fsf@gitster.siamese.dyndns.org> <20070920082701.GA2053@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 20 10:43:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYHd4-0005LU-4z
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 10:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753178AbXITInP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 04:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752827AbXITInP
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 04:43:15 -0400
Received: from pan.madism.org ([88.191.52.104]:45337 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752636AbXITInN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 04:43:13 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id D67401EF4F;
	Thu, 20 Sep 2007 10:43:11 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 517C82F31; Thu, 20 Sep 2007 10:43:11 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070920082701.GA2053@artemis.corp>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58763>

* drop nfasprintf.
* move nfvasprintf into imap-send.c back, and let it work on a 8k buffer,
  and die() in case of overflow. It should be enough for imap commands, if
  someone cares about imap-send, he's welcomed to fix it properly.
* replace nfvasprintf use in merge-recursive with a copy of the strbuf_addf
  logic, it's one place, we'll live with it.
  To ease the change, output_buffer string list is replaced with a strbuf ;)
* rework trace.c to call vsnprintf itself.  It's used to format strerror()s
  and git command names, it should never be more than a few octets long, let
  it work on a 8k static buffer with vsnprintf or die loudly.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

  This reinstates the trace_argv_printf API. The implementation is
stupid, but is rewritten in a latter commit. I didn't wanted to bother
optimizing it.


 cache.h           |    2 -
 imap-send.c       |   13 ++++++++
 merge-recursive.c |   74 ++++++++++++++++++++-----------------------
 trace.c           |   90 ++++++++++++++++-------------------------------------
 4 files changed, 74 insertions(+), 105 deletions(-)

diff --git a/cache.h b/cache.h
index c57ccd6..b127c43 100644
--- a/cache.h
+++ b/cache.h
@@ -587,8 +587,6 @@ extern void *alloc_object_node(void);
 extern void alloc_report(void);
 
 /* trace.c */
-extern int nfasprintf(char **str, const char *fmt, ...);
-extern int nfvasprintf(char **str, const char *fmt, va_list va);
 extern void trace_printf(const char *format, ...);
 extern void trace_argv_printf(const char **argv, int count, const char *format, ...);
 
diff --git a/imap-send.c b/imap-send.c
index 905d097..e95cdde 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -105,6 +105,19 @@ static void free_generic_messages( message_t * );
 
 static int nfsnprintf( char *buf, int blen, const char *fmt, ... );
 
+static int nfvasprintf(char **strp, const char *fmt, va_list ap)
+{
+	int len;
+	char tmp[8192];
+
+	len = vsnprintf(tmp, sizeof(tmp), fmt, ap);
+	if (len < 0)
+		die("Fatal: Out of memory\n");
+	if (len >= sizeof(tmp))
+		die("imap command overflow !\n");
+	*strp = xmemdupz(tmp, len);
+	return len;
+}
 
 static void arc4_init( void );
 static unsigned char arc4_getbyte( void );
diff --git a/merge-recursive.c b/merge-recursive.c
index 14b56c2..4e27549 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -85,63 +85,57 @@ struct stage_data
 	unsigned processed:1;
 };
 
-struct output_buffer
-{
-	struct output_buffer *next;
-	char *str;
-};
-
 static struct path_list current_file_set = {NULL, 0, 0, 1};
 static struct path_list current_directory_set = {NULL, 0, 0, 1};
 
 static int call_depth = 0;
 static int verbosity = 2;
 static int buffer_output = 1;
-static struct output_buffer *output_list, *output_end;
+static struct strbuf obuf = STRBUF_INIT;
 
-static int show (int v)
+static int show(int v)
 {
 	return (!call_depth && verbosity >= v) || verbosity >= 5;
 }
 
-static void output(int v, const char *fmt, ...)
+static void flush_output(void)
 {
-	va_list args;
-	va_start(args, fmt);
-	if (buffer_output && show(v)) {
-		struct output_buffer *b = xmalloc(sizeof(*b));
-		nfvasprintf(&b->str, fmt, args);
-		b->next = NULL;
-		if (output_end)
-			output_end->next = b;
-		else
-			output_list = b;
-		output_end = b;
-	} else if (show(v)) {
-		int i;
-		for (i = call_depth; i--;)
-			fputs("  ", stdout);
-		vfprintf(stdout, fmt, args);
-		fputc('\n', stdout);
+	if (obuf.len) {
+		fputs(obuf.buf, stdout);
+		strbuf_reset(&obuf);
 	}
-	va_end(args);
 }
 
-static void flush_output(void)
+static void output(int v, const char *fmt, ...)
 {
-	struct output_buffer *b, *n;
-	for (b = output_list; b; b = n) {
-		int i;
-		for (i = call_depth; i--;)
-			fputs("  ", stdout);
-		fputs(b->str, stdout);
-		fputc('\n', stdout);
-		n = b->next;
-		free(b->str);
-		free(b);
+	if (show(v)) {
+		int len;
+		va_list ap;
+
+		strbuf_grow(&obuf, call_depth);
+		memset(obuf.buf + obuf.len, ' ', call_depth);
+		strbuf_setlen(&obuf, obuf.len + call_depth);
+
+		va_start(ap, fmt);
+		len = vsnprintf(obuf.buf, strbuf_avail(&obuf) + 1, fmt, ap);
+		va_end(ap);
+
+		if (len < 0)
+			len = 0;
+		if (len > strbuf_avail(&obuf)) {
+			strbuf_grow(&obuf, len);
+			va_start(ap, fmt);
+			len = vsnprintf(obuf.buf, strbuf_avail(&obuf) + 1, fmt, ap);
+			va_end(ap);
+			if (len > strbuf_avail(&obuf)) {
+				die("this should not happen, your snprintf is broken");
+			}
+		}
+
+		strbuf_setlen(&obuf, obuf.len + len);
+		if (!buffer_output)
+			flush_output();
 	}
-	output_list = NULL;
-	output_end = NULL;
 }
 
 static void output_commit_title(struct commit *commit)
diff --git a/trace.c b/trace.c
index 7961a27..91548a5 100644
--- a/trace.c
+++ b/trace.c
@@ -25,33 +25,6 @@
 #include "cache.h"
 #include "quote.h"
 
-/* Stolen from "imap-send.c". */
-int nfvasprintf(char **strp, const char *fmt, va_list ap)
-{
-	int len;
-	char tmp[1024];
-
-	if ((len = vsnprintf(tmp, sizeof(tmp), fmt, ap)) < 0 ||
-	    !(*strp = xmalloc(len + 1)))
-		die("Fatal: Out of memory\n");
-	if (len >= (int)sizeof(tmp))
-		vsprintf(*strp, fmt, ap);
-	else
-		memcpy(*strp, tmp, len + 1);
-	return len;
-}
-
-int nfasprintf(char **str, const char *fmt, ...)
-{
-	int rc;
-	va_list args;
-
-	va_start(args, fmt);
-	rc = nfvasprintf(str, fmt, args);
-	va_end(args);
-	return rc;
-}
-
 /* Get a trace file descriptor from GIT_TRACE env variable. */
 static int get_trace_fd(int *need_close)
 {
@@ -89,63 +62,54 @@ static int get_trace_fd(int *need_close)
 static const char err_msg[] = "Could not trace into fd given by "
 	"GIT_TRACE environment variable";
 
-void trace_printf(const char *format, ...)
+void trace_printf(const char *fmt, ...)
 {
-	char *trace_str;
-	va_list rest;
-	int need_close = 0;
-	int fd = get_trace_fd(&need_close);
+	char buf[8192];
+	va_list ap;
+	int fd, len, need_close = 0;
 
+	fd = get_trace_fd(&need_close);
 	if (!fd)
 		return;
 
-	va_start(rest, format);
-	nfvasprintf(&trace_str, format, rest);
-	va_end(rest);
-
-	write_or_whine_pipe(fd, trace_str, strlen(trace_str), err_msg);
-
-	free(trace_str);
+	va_start(ap, fmt);
+	len = vsnprintf(buf, sizeof(buf), fmt, ap);
+	va_end(ap);
+	if (len >= sizeof(buf))
+		die("unreasonnable trace length");
+	write_or_whine_pipe(fd, buf, len, err_msg);
 
 	if (need_close)
 		close(fd);
 }
 
-void trace_argv_printf(const char **argv, int count, const char *format, ...)
+void trace_argv_printf(const char **argv, int count, const char *fmt, ...)
 {
-	char *argv_str, *format_str, *trace_str;
-	size_t argv_len, format_len, trace_len;
-	va_list rest;
-	int need_close = 0;
-	int fd = get_trace_fd(&need_close);
+	char buf[8192];
+	va_list ap;
+	char *argv_str;
+	size_t argv_len;
+	int fd, len, need_close = 0;
 
+	fd = get_trace_fd(&need_close);
 	if (!fd)
 		return;
 
+	va_start(ap, fmt);
+	len = vsnprintf(buf, sizeof(buf), fmt, ap);
+	va_end(ap);
+	if (len >= sizeof(buf))
+		die("unreasonnable trace length");
+
 	/* Get the argv string. */
 	argv_str = sq_quote_argv(argv, count);
 	argv_len = strlen(argv_str);
 
-	/* Get the formated string. */
-	va_start(rest, format);
-	nfvasprintf(&format_str, format, rest);
-	va_end(rest);
-
-	/* Allocate buffer for trace string. */
-	format_len = strlen(format_str);
-	trace_len = argv_len + format_len + 1; /* + 1 for \n */
-	trace_str = xmalloc(trace_len + 1);
-
-	/* Copy everything into the trace string. */
-	strncpy(trace_str, format_str, format_len);
-	strncpy(trace_str + format_len, argv_str, argv_len);
-	strcpy(trace_str + trace_len - 1, "\n");
-
-	write_or_whine_pipe(fd, trace_str, trace_len, err_msg);
+	write_or_whine_pipe(fd, buf, len, err_msg);
+	write_or_whine_pipe(fd, argv_str, argv_len, err_msg);
+	write_or_whine_pipe(fd, "\n", 1, err_msg);
 
 	free(argv_str);
-	free(format_str);
-	free(trace_str);
 
 	if (need_close)
 		close(fd);
-- 
1.5.3.2.1036.gca8d2
