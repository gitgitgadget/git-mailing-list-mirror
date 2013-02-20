From: Jeff King <peff@peff.net>
Subject: [PATCH v3 12/19] pkt-line: teach packet_read_line to chomp newlines
Date: Wed, 20 Feb 2013 15:02:28 -0500
Message-ID: <20130220200228.GL25647@sigill.intra.peff.net>
References: <20130220195147.GA25332@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 20 21:02:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8FsW-0004x0-6w
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 21:02:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935146Ab3BTUCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 15:02:31 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54612 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935054Ab3BTUCb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 15:02:31 -0500
Received: (qmail 17792 invoked by uid 107); 20 Feb 2013 20:04:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Feb 2013 15:04:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Feb 2013 15:02:28 -0500
Content-Disposition: inline
In-Reply-To: <20130220195147.GA25332@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216726>

The packets sent during ref negotiation are all terminated
by newline; even though the code to chomp these newlines is
short, we end up doing it in a lot of places.

This patch teaches packet_read_line to auto-chomp the
trailing newline; this lets us get rid of a lot of inline
chomping code.

As a result, some call-sites which are not reading
line-oriented data (e.g., when reading chunks of packfiles
alongside sideband) transition away from packet_read_line to
the generic packet_read interface. This patch converts all
of the existing callsites.

Since the function signature of packet_read_line does not
change (but its behavior does), there is a possibility of
new callsites being introduced in later commits, silently
introducing an incompatibility.  However, since a later
patch in this series will change the signature, such a
commit would have to be merged directly into this commit,
not to the tip of the series; we can therefore ignore the
issue.

This is an internal cleanup and should produce no change of
behavior in the normal case. However, there is one corner
case to note. Callers of packet_read_line have never been
able to tell the difference between a flush packet ("0000")
and an empty packet ("0004"), as both cause packet_read_line
to return a length of 0. Readers treat them identically,
even though Documentation/technical/protocol-common.txt says
we must not; it also says that implementations should not
send an empty pkt-line.

By stripping out the newline before the result gets to the
caller, we will now treat the newline-only packet ("0005\n")
the same as an empty packet, which in turn gets treated like
a flush packet. In practice this doesn't matter, as neither
empty nor newline-only packets are part of git's protocols
(at least not for the line-oriented bits, and readers who
are not expecting line-oriented packets will be calling
packet_read directly, anyway). But even if we do decide to
care about the distinction later, it is orthogonal to this
patch.  The right place to tighten would be to stop treating
empty packets as flush packets, and this change does not
make doing so any harder.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/archive.c        | 2 --
 builtin/fetch-pack.c     | 2 --
 builtin/receive-pack.c   | 2 --
 builtin/upload-archive.c | 4 ----
 connect.c                | 5 ++---
 daemon.c                 | 2 +-
 fetch-pack.c             | 2 --
 pkt-line.c               | 7 ++++++-
 pkt-line.h               | 9 ++++++++-
 remote-curl.c            | 6 +++---
 send-pack.c              | 6 +-----
 sideband.c               | 2 +-
 upload-pack.c            | 8 --------
 13 files changed, 22 insertions(+), 35 deletions(-)

diff --git a/builtin/archive.c b/builtin/archive.c
index 9a1cfd3..d381ac4 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -56,8 +56,6 @@ static int run_remote_archiver(int argc, const char **argv,
 	len = packet_read_line(fd[0], buf, sizeof(buf));
 	if (!len)
 		die(_("git archive: expected ACK/NAK, got EOF"));
-	if (buf[len-1] == '\n')
-		buf[--len] = 0;
 	if (strcmp(buf, "ACK")) {
 		if (len > 5 && !prefixcmp(buf, "NACK "))
 			die(_("git archive: NACK %s"), buf + 5);
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 940ae35..f73664f 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -105,8 +105,6 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 				int n = packet_read_line(0, line, sizeof(line));
 				if (!n)
 					break;
-				if (line[n-1] == '\n')
-					n--;
 				string_list_append(&sought, xmemdupz(line, n));
 			}
 		}
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 9129563..6679e63 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -763,8 +763,6 @@ static struct command *read_head_info(void)
 		len = packet_read_line(0, line, sizeof(line));
 		if (!len)
 			break;
-		if (line[len-1] == '\n')
-			line[--len] = 0;
 		if (len < 83 ||
 		    line[40] != ' ' ||
 		    line[81] != ' ' ||
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 3393cef..7d367b5 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -40,10 +40,6 @@ int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix)
 		if (sent_argv.argc > MAX_ARGS)
 		    die("Too many options (>%d)", MAX_ARGS - 1);
 
-		if (buf[len-1] == '\n') {
-			buf[--len] = 0;
-		}
-
 		if (prefixcmp(buf, arg_cmd))
 			die("'argument' token or flush expected");
 		argv_array_push(&sent_argv, buf + strlen(arg_cmd));
diff --git a/connect.c b/connect.c
index 0aa202f..fe8eb01 100644
--- a/connect.c
+++ b/connect.c
@@ -77,14 +77,13 @@ struct ref **get_remote_heads(int in, struct ref **list,
 		int len, name_len;
 
 		len = packet_read(in, buffer, sizeof(buffer),
-				  PACKET_READ_GENTLE_ON_EOF);
+				  PACKET_READ_GENTLE_ON_EOF |
+				  PACKET_READ_CHOMP_NEWLINE);
 		if (len < 0)
 			die_initial_contact(got_at_least_one_head);
 
 		if (!len)
 			break;
-		if (buffer[len-1] == '\n')
-			buffer[--len] = 0;
 
 		if (len > 4 && !prefixcmp(buffer, "ERR "))
 			die("remote error: %s", buffer + 4);
diff --git a/daemon.c b/daemon.c
index 4602b46..4f5cd61 100644
--- a/daemon.c
+++ b/daemon.c
@@ -612,7 +612,7 @@ static int execute(void)
 		loginfo("Connection from %s:%s", addr, port);
 
 	alarm(init_timeout ? init_timeout : timeout);
-	pktlen = packet_read_line(0, line, sizeof(line));
+	pktlen = packet_read(0, line, sizeof(line), 0);
 	alarm(0);
 
 	len = strlen(line);
diff --git a/fetch-pack.c b/fetch-pack.c
index b53a18f..f830db2 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -220,8 +220,6 @@ static enum ack_type get_ack(int fd, unsigned char *result_sha1)
 
 	if (!len)
 		die("git fetch-pack: expected ACK/NAK, got EOF");
-	if (line[len-1] == '\n')
-		line[--len] = 0;
 	if (!strcmp(line, "NAK"))
 		return NAK;
 	if (!prefixcmp(line, "ACK ")) {
diff --git a/pkt-line.c b/pkt-line.c
index 8700cf8..dc11c40 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -164,6 +164,11 @@ int packet_read(int fd, char *buffer, unsigned size, int options)
 	ret = safe_read(fd, buffer, len, options);
 	if (ret < 0)
 		return ret;
+
+	if ((options & PACKET_READ_CHOMP_NEWLINE) &&
+	    len && buffer[len-1] == '\n')
+		len--;
+
 	buffer[len] = 0;
 	packet_trace(buffer, len, 0);
 	return len;
@@ -171,7 +176,7 @@ int packet_read_line(int fd, char *buffer, unsigned size)
 
 int packet_read_line(int fd, char *buffer, unsigned size)
 {
-	return packet_read(fd, buffer, size, 0);
+	return packet_read(fd, buffer, size, PACKET_READ_CHOMP_NEWLINE);
 }
 
 int packet_get_line(struct strbuf *out,
diff --git a/pkt-line.h b/pkt-line.h
index 8cd326c..5d2fb42 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -44,11 +44,18 @@ int packet_read(int fd, char *buffer, unsigned size, int options);
  * If options does contain PACKET_READ_GENTLE_ON_EOF, we will not die on
  * condition 4 (truncated input), but instead return -1. However, we will still
  * die for the other 3 conditions.
+ *
+ * If options contains PACKET_READ_CHOMP_NEWLINE, a trailing newline (if
+ * present) is removed from the buffer before returning.
  */
 #define PACKET_READ_GENTLE_ON_EOF (1u<<0)
+#define PACKET_READ_CHOMP_NEWLINE (1u<<1)
 int packet_read(int fd, char *buffer, unsigned size, int options);
 
-/* Historical convenience wrapper for packet_read that sets no options */
+/*
+ * Convenience wrapper for packet_read that is not gentle, and sets the
+ * CHOMP_NEWLINE option.
+ */
 int packet_read_line(int fd, char *buffer, unsigned size);
 
 int packet_get_line(struct strbuf *out, char **src_buf, size_t *src_len);
diff --git a/remote-curl.c b/remote-curl.c
index 7be4b53..b28f965 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -308,7 +308,7 @@ static size_t rpc_out(void *ptr, size_t eltsize,
 
 	if (!avail) {
 		rpc->initial_buffer = 0;
-		avail = packet_read_line(rpc->out, rpc->buf, rpc->alloc);
+		avail = packet_read(rpc->out, rpc->buf, rpc->alloc, 0);
 		if (!avail)
 			return 0;
 		rpc->pos = 0;
@@ -425,7 +425,7 @@ static int post_rpc(struct rpc_state *rpc)
 			break;
 		}
 
-		n = packet_read_line(rpc->out, buf, left);
+		n = packet_read(rpc->out, buf, left, 0);
 		if (!n)
 			break;
 		rpc->len += n;
@@ -579,7 +579,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
 	rpc->hdr_accept = strbuf_detach(&buf, NULL);
 
 	while (!err) {
-		int n = packet_read_line(rpc->out, rpc->buf, rpc->alloc);
+		int n = packet_read(rpc->out, rpc->buf, rpc->alloc, 0);
 		if (!n)
 			break;
 		rpc->pos = 0;
diff --git a/send-pack.c b/send-pack.c
index bde796b..8c230bf 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -111,10 +111,7 @@ static int receive_status(int in, struct ref *refs)
 	int len = packet_read_line(in, line, sizeof(line));
 	if (prefixcmp(line, "unpack "))
 		return error("did not receive remote status");
-	if (strcmp(line, "unpack ok\n")) {
-		char *p = line + strlen(line) - 1;
-		if (*p == '\n')
-			*p = '\0';
+	if (strcmp(line, "unpack ok")) {
 		error("unpack failed: %s", line + 7);
 		ret = -1;
 	}
@@ -131,7 +128,6 @@ static int receive_status(int in, struct ref *refs)
 			break;
 		}
 
-		line[strlen(line)-1] = '\0';
 		refname = line + 3;
 		msg = strchr(refname, ' ');
 		if (msg)
diff --git a/sideband.c b/sideband.c
index 8f7b25b..15cc1ae 100644
--- a/sideband.c
+++ b/sideband.c
@@ -38,7 +38,7 @@ int recv_sideband(const char *me, int in_stream, int out)
 
 	while (1) {
 		int band, len;
-		len = packet_read_line(in_stream, buf + pf, LARGE_PACKET_MAX);
+		len = packet_read(in_stream, buf + pf, LARGE_PACKET_MAX, 0);
 		if (len == 0)
 			break;
 		if (len < 1) {
diff --git a/upload-pack.c b/upload-pack.c
index c2b2c61..7446cb7 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -50,13 +50,6 @@ static void reset_timeout(void)
 	alarm(timeout);
 }
 
-static int strip(char *line, int len)
-{
-	if (len && line[len-1] == '\n')
-		line[--len] = 0;
-	return len;
-}
-
 static ssize_t send_client_data(int fd, const char *data, ssize_t sz)
 {
 	if (use_sideband)
@@ -447,7 +440,6 @@ static int get_common_commits(void)
 			got_other = 0;
 			continue;
 		}
-		strip(line, len);
 		if (!prefixcmp(line, "have ")) {
 			switch (got_sha1(line+5, sha1)) {
 			case -1: /* they have what we do not */
-- 
1.8.2.rc0.9.g352092c
