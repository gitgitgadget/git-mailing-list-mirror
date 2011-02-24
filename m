From: Jeff King <peff@peff.net>
Subject: [PATCH 7/8] add packet tracing debug code
Date: Thu, 24 Feb 2011 09:30:19 -0500
Message-ID: <20110224143019.GG15477@sigill.intra.peff.net>
References: <20110224142308.GA15356@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 15:30:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PscD4-0008Ra-QK
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 15:30:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756092Ab1BXOaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 09:30:21 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:55844 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755575Ab1BXOaU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 09:30:20 -0500
Received: (qmail 23401 invoked by uid 111); 24 Feb 2011 14:30:20 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 24 Feb 2011 14:30:20 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Feb 2011 09:30:19 -0500
Content-Disposition: inline
In-Reply-To: <20110224142308.GA15356@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167817>

This shows a trace of all packets coming in or out of a given
program. This can help with debugging object negotiation or
other protocol issues.

To keep the code changes simple, we operate at the lowest
level, meaning we don't necessarily understand what's in the
packets. The one exception is a packet starting with "PACK",
which causes us to skip that packet and turn off tracing
(since the gigantic pack data will not be interesting to
read, at least not in the trace format).

We show both written and read packets. In the local case,
this may mean you will see packets twice (written by the
sender and read by the receiver). However, for cases where
the other end is remote, this allows you to see the full
conversation.

Packet tracing can be enabled with GIT_TRACE_PACKET=<foo>,
where <foo> takes the same arguments as GIT_TRACE.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/clone.c        |    1 +
 builtin/fetch-pack.c   |    2 +
 builtin/fetch.c        |    2 +
 builtin/push.c         |    1 +
 builtin/receive-pack.c |    2 +
 cache.h                |    2 +
 pkt-line.c             |   55 +++++++++++++++++++++++++++++++++++++++++++++++-
 upload-pack.c          |    1 +
 8 files changed, 65 insertions(+), 1 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 60d9a64..38b4b71 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -383,6 +383,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	junk_pid = getpid();
 
+	packet_trace_identity("clone");
 	argc = parse_options(argc, argv, prefix, builtin_clone_options,
 			     builtin_clone_usage, 0);
 
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index b999413..272bc38 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -804,6 +804,8 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	char **pack_lockfile_ptr = NULL;
 	struct child_process *conn;
 
+	packet_trace_identity("fetch-pack");
+
 	nr_heads = 0;
 	heads = NULL;
 	for (i = 1; i < argc; i++) {
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 357f3cd..e94e001 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -906,6 +906,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	struct remote *remote;
 	int result = 0;
 
+	packet_trace_identity("fetch");
+
 	/* Record the command line for the reflog */
 	strbuf_addstr(&default_rla, "fetch");
 	for (i = 1; i < argc; i++)
diff --git a/builtin/push.c b/builtin/push.c
index e655eb7..26171ff 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -228,6 +228,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	packet_trace_identity("push");
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 760817d..5fa4be8 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -778,6 +778,8 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	char *dir = NULL;
 	struct command *commands;
 
+	packet_trace_identity("receive-pack");
+
 	argv++;
 	for (i = 1; i < argc; i++) {
 		const char *arg = *argv++;
diff --git a/cache.h b/cache.h
index 3978112..2e59aae 100644
--- a/cache.h
+++ b/cache.h
@@ -1074,6 +1074,8 @@ extern void trace_repo_setup(const char *prefix);
 extern int trace_want(const char *key);
 extern void trace_strbuf(const char *key, const struct strbuf *buf);
 
+void packet_trace_identity(const char *prog);
+
 /* convert.c */
 /* returns 1 if *dst was used */
 extern int convert_to_git(const char *path, const char *src, size_t len,
diff --git a/pkt-line.c b/pkt-line.c
index 295ba2b..cd1bd26 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -1,6 +1,51 @@
 #include "cache.h"
 #include "pkt-line.h"
 
+const char *packet_trace_prefix = "git";
+static const char trace_key[] = "GIT_TRACE_PACKET";
+
+void packet_trace_identity(const char *prog)
+{
+	packet_trace_prefix = xstrdup(prog);
+}
+
+static void packet_trace(const char *buf, unsigned int len, int write)
+{
+	int i;
+	struct strbuf out;
+
+	if (!trace_want(trace_key))
+		return;
+
+	/* +32 is just a guess for header + quoting */
+	strbuf_init(&out, len+32);
+
+	strbuf_addf(&out, "packet: %12s%c ",
+		    packet_trace_prefix, write ? '>' : '<');
+
+	if ((len >= 4 && !prefixcmp(buf, "PACK")) ||
+	    (len >= 5 && !prefixcmp(buf+1, "PACK"))) {
+		strbuf_addstr(&out, "PACK ...");
+		unsetenv(trace_key);
+	}
+	else {
+		/* XXX we should really handle printable utf8 */
+		for (i = 0; i < len; i++) {
+			/* suppress newlines */
+			if (buf[i] == '\n')
+				continue;
+			if (buf[i] >= 0x20 && buf[i] <= 0x7e)
+				strbuf_addch(&out, buf[i]);
+			else
+				strbuf_addf(&out, "\\%o", buf[i]);
+		}
+	}
+
+	strbuf_addch(&out, '\n');
+	trace_strbuf(trace_key, &out);
+	strbuf_release(&out);
+}
+
 /*
  * Write a packetized stream, where each line is preceded by
  * its length (including the header) as a 4-byte hex number.
@@ -39,11 +84,13 @@ ssize_t safe_write(int fd, const void *buf, ssize_t n)
  */
 void packet_flush(int fd)
 {
+	packet_trace("0000", 4, 1);
 	safe_write(fd, "0000", 4);
 }
 
 void packet_buf_flush(struct strbuf *buf)
 {
+	packet_trace("0000", 4, 1);
 	strbuf_add(buf, "0000", 4);
 }
 
@@ -62,6 +109,7 @@ static unsigned format_packet(const char *fmt, va_list args)
 	buffer[1] = hex(n >> 8);
 	buffer[2] = hex(n >> 4);
 	buffer[3] = hex(n);
+	packet_trace(buffer+4, n-4, 1);
 	return n;
 }
 
@@ -130,13 +178,16 @@ int packet_read_line(int fd, char *buffer, unsigned size)
 	len = packet_length(linelen);
 	if (len < 0)
 		die("protocol error: bad line length character: %.4s", linelen);
-	if (!len)
+	if (!len) {
+		packet_trace("0000", 4, 0);
 		return 0;
+	}
 	len -= 4;
 	if (len >= size)
 		die("protocol error: bad line length %d", len);
 	safe_read(fd, buffer, len);
 	buffer[len] = 0;
+	packet_trace(buffer, len, 0);
 	return len;
 }
 
@@ -153,6 +204,7 @@ int packet_get_line(struct strbuf *out,
 	if (!len) {
 		*src_buf += 4;
 		*src_len -= 4;
+		packet_trace("0000", 4, 0);
 		return 0;
 	}
 	if (*src_len < len)
@@ -165,5 +217,6 @@ int packet_get_line(struct strbuf *out,
 	strbuf_add(out, *src_buf, len);
 	*src_buf += len;
 	*src_len -= len;
+	packet_trace(out->buf, out->len, 0);
 	return len;
 }
diff --git a/upload-pack.c b/upload-pack.c
index b40a43f..0c87bc0 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -682,6 +682,7 @@ int main(int argc, char **argv)
 	int i;
 	int strict = 0;
 
+	packet_trace_identity("upload-pack");
 	git_extract_argv0_path(argv[0]);
 	read_replace_refs = 0;
 
-- 
1.7.2.5.25.g3bb93
