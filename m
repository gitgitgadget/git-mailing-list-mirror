From: Jeff King <peff@peff.net>
Subject: [PATCHv2 05/10] pkt-line: rename s/packet_read_line/packet_read/
Date: Mon, 18 Feb 2013 04:22:52 -0500
Message-ID: <20130218092252.GE5096@sigill.intra.peff.net>
References: <20130218091203.GB17003@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 10:23:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7MwR-0001dW-UL
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 10:23:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756717Ab3BRJWz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 04:22:55 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51674 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753609Ab3BRJWy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 04:22:54 -0500
Received: (qmail 17641 invoked by uid 107); 18 Feb 2013 09:24:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Feb 2013 04:24:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Feb 2013 04:22:52 -0500
Content-Disposition: inline
In-Reply-To: <20130218091203.GB17003@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216451>

Originally packets were used just for the line-oriented ref
advertisement and negotiation. These days, we also stuff
packfiles and sidebands into them, and they do not
necessarily represent a line. Drop the "_line" suffix, as it
is not informative and makes the function names quite long
(especially as we add "_gently" and other variants).

Signed-off-by: Jeff King <peff@peff.net>
---
Again, this is a taste issue. Can be optional.

 builtin/archive.c        | 4 ++--
 builtin/fetch-pack.c     | 2 +-
 builtin/receive-pack.c   | 2 +-
 builtin/upload-archive.c | 2 +-
 connect.c                | 2 +-
 daemon.c                 | 2 +-
 fetch-pack.c             | 6 +++---
 pkt-line.c               | 4 ++--
 pkt-line.h               | 6 +++---
 remote-curl.c            | 6 +++---
 send-pack.c              | 4 ++--
 sideband.c               | 2 +-
 upload-pack.c            | 4 ++--
 13 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/builtin/archive.c b/builtin/archive.c
index 9a1cfd3..bf600f5 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -53,7 +53,7 @@ static int run_remote_archiver(int argc, const char **argv,
 		packet_write(fd[1], "argument %s\n", argv[i]);
 	packet_flush(fd[1]);
 
-	len = packet_read_line(fd[0], buf, sizeof(buf));
+	len = packet_read(fd[0], buf, sizeof(buf));
 	if (!len)
 		die(_("git archive: expected ACK/NAK, got EOF"));
 	if (buf[len-1] == '\n')
@@ -66,7 +66,7 @@ static int run_remote_archiver(int argc, const char **argv,
 		die(_("git archive: protocol error"));
 	}
 
-	len = packet_read_line(fd[0], buf, sizeof(buf));
+	len = packet_read(fd[0], buf, sizeof(buf));
 	if (len)
 		die(_("git archive: expected a flush"));
 
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 940ae35..b59e60e 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -102,7 +102,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			 */
 			static char line[1000];
 			for (;;) {
-				int n = packet_read_line(0, line, sizeof(line));
+				int n = packet_read(0, line, sizeof(line));
 				if (!n)
 					break;
 				if (line[n-1] == '\n')
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 48cd5dc..3f58ce8 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -736,7 +736,7 @@ static struct command *read_head_info(void)
 		char *refname;
 		int len, reflen;
 
-		len = packet_read_line(0, line, sizeof(line));
+		len = packet_read(0, line, sizeof(line));
 		if (!len)
 			break;
 		if (line[len-1] == '\n')
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index b928beb..2ecf461 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -40,7 +40,7 @@ int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix)
 	sent_argv[0] = "git-upload-archive";
 	for (p = buf;;) {
 		/* This will die if not enough free space in buf */
-		len = packet_read_line(0, p, (buf + sizeof buf) - p);
+		len = packet_read(0, p, (buf + sizeof buf) - p);
 		if (len == 0)
 			break;	/* got a flush */
 		if (sent_argc > MAX_ARGS - 2)
diff --git a/connect.c b/connect.c
index 7e0920d..59266b1 100644
--- a/connect.c
+++ b/connect.c
@@ -76,7 +76,7 @@ struct ref **get_remote_heads(int in, struct ref **list,
 		char *name;
 		int len, name_len;
 
-		len = packet_read_line_gently(in, buffer, sizeof(buffer));
+		len = packet_read_gently(in, buffer, sizeof(buffer));
 		if (len < 0)
 			die_initial_contact(got_at_least_one_head);
 
diff --git a/daemon.c b/daemon.c
index 4602b46..ac26b93 100644
--- a/daemon.c
+++ b/daemon.c
@@ -612,7 +612,7 @@ static int execute(void)
 		loginfo("Connection from %s:%s", addr, port);
 
 	alarm(init_timeout ? init_timeout : timeout);
-	pktlen = packet_read_line(0, line, sizeof(line));
+	pktlen = packet_read(0, line, sizeof(line));
 	alarm(0);
 
 	len = strlen(line);
diff --git a/fetch-pack.c b/fetch-pack.c
index b90dadf..d89c9d0 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -173,7 +173,7 @@ static void consume_shallow_list(struct fetch_pack_args *args, int fd)
 		 * is a block of have lines exchanged.
 		 */
 		char line[1000];
-		while (packet_read_line(fd, line, sizeof(line))) {
+		while (packet_read(fd, line, sizeof(line))) {
 			if (!prefixcmp(line, "shallow "))
 				continue;
 			if (!prefixcmp(line, "unshallow "))
@@ -216,7 +216,7 @@ static enum ack_type get_ack(int fd, unsigned char *result_sha1)
 static enum ack_type get_ack(int fd, unsigned char *result_sha1)
 {
 	static char line[1000];
-	int len = packet_read_line(fd, line, sizeof(line));
+	int len = packet_read(fd, line, sizeof(line));
 
 	if (!len)
 		die("git fetch-pack: expected ACK/NAK, got EOF");
@@ -350,7 +350,7 @@ static int find_common(struct fetch_pack_args *args,
 		unsigned char sha1[20];
 
 		send_request(args, fd[1], &req_buf);
-		while (packet_read_line(fd[0], line, sizeof(line))) {
+		while (packet_read(fd[0], line, sizeof(line))) {
 			if (!prefixcmp(line, "shallow ")) {
 				if (get_sha1_hex(line + 8, sha1))
 					die("invalid shallow line: %s", line);
diff --git a/pkt-line.c b/pkt-line.c
index f2a7575..85faf73 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -170,12 +170,12 @@ int packet_read_line_gently(int fd, char *buffer, unsigned size)
 	return len;
 }
 
-int packet_read_line_gently(int fd, char *buffer, unsigned size)
+int packet_read_gently(int fd, char *buffer, unsigned size)
 {
 	return packet_read_internal(fd, buffer, size, 1);
 }
 
-int packet_read_line(int fd, char *buffer, unsigned size)
+int packet_read(int fd, char *buffer, unsigned size)
 {
 	return packet_read_internal(fd, buffer, size, 0);
 }
diff --git a/pkt-line.h b/pkt-line.h
index 31bd069..2dc4941 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -37,13 +37,13 @@ int packet_read_line(int fd, char *buffer, unsigned size);
  *   4. Truncated output from the remote (e.g., we expected a packet but got
  *      EOF, or we got a partial packet followed by EOF).
  */
-int packet_read_line(int fd, char *buffer, unsigned size);
+int packet_read(int fd, char *buffer, unsigned size);
 
 /*
- * Same as packet_read_line, but do not die on condition 4 (truncated input);
+ * Same as packet_read, but do not die on condition 4 (truncated input);
  * instead return -1.  We still die for the other conditions.
  */
-int packet_read_line_gently(int fd, char *buffer, unsigned size);
+int packet_read_gently(int fd, char *buffer, unsigned size);
 
 int packet_get_line(struct strbuf *out, char **src_buf, size_t *src_len);
 ssize_t safe_write(int, const void *, ssize_t);
diff --git a/remote-curl.c b/remote-curl.c
index 7be4b53..99cc016 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -308,7 +308,7 @@ static size_t rpc_out(void *ptr, size_t eltsize,
 
 	if (!avail) {
 		rpc->initial_buffer = 0;
-		avail = packet_read_line(rpc->out, rpc->buf, rpc->alloc);
+		avail = packet_read(rpc->out, rpc->buf, rpc->alloc);
 		if (!avail)
 			return 0;
 		rpc->pos = 0;
@@ -425,7 +425,7 @@ static int post_rpc(struct rpc_state *rpc)
 			break;
 		}
 
-		n = packet_read_line(rpc->out, buf, left);
+		n = packet_read(rpc->out, buf, left);
 		if (!n)
 			break;
 		rpc->len += n;
@@ -579,7 +579,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
 	rpc->hdr_accept = strbuf_detach(&buf, NULL);
 
 	while (!err) {
-		int n = packet_read_line(rpc->out, rpc->buf, rpc->alloc);
+		int n = packet_read(rpc->out, rpc->buf, rpc->alloc);
 		if (!n)
 			break;
 		rpc->pos = 0;
diff --git a/send-pack.c b/send-pack.c
index a99a1e4..7b22235 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -108,7 +108,7 @@ static int receive_status(int in, struct ref *refs)
 	struct ref *hint;
 	char line[1000];
 	int ret = 0;
-	int len = packet_read_line(in, line, sizeof(line));
+	int len = packet_read(in, line, sizeof(line));
 	if (len < 10 || memcmp(line, "unpack ", 7))
 		return error("did not receive remote status");
 	if (memcmp(line, "unpack ok\n", 10)) {
@@ -122,7 +122,7 @@ static int receive_status(int in, struct ref *refs)
 	while (1) {
 		char *refname;
 		char *msg;
-		len = packet_read_line(in, line, sizeof(line));
+		len = packet_read(in, line, sizeof(line));
 		if (!len)
 			break;
 		if (len < 3 ||
diff --git a/sideband.c b/sideband.c
index 8f7b25b..4a6446d 100644
--- a/sideband.c
+++ b/sideband.c
@@ -38,7 +38,7 @@ int recv_sideband(const char *me, int in_stream, int out)
 
 	while (1) {
 		int band, len;
-		len = packet_read_line(in_stream, buf + pf, LARGE_PACKET_MAX);
+		len = packet_read(in_stream, buf + pf, LARGE_PACKET_MAX);
 		if (len == 0)
 			break;
 		if (len < 1) {
diff --git a/upload-pack.c b/upload-pack.c
index 04d6bd7..04231d7 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -428,7 +428,7 @@ static int get_common_commits(void)
 	save_commit_buffer = 0;
 
 	for (;;) {
-		int len = packet_read_line(0, line, sizeof(line));
+		int len = packet_read(0, line, sizeof(line));
 		reset_timeout();
 
 		if (!len) {
@@ -589,7 +589,7 @@ static void receive_needs(void)
 		struct object *o;
 		const char *features;
 		unsigned char sha1_buf[20];
-		len = packet_read_line(0, line, sizeof(line));
+		len = packet_read(0, line, sizeof(line));
 		reset_timeout();
 		if (!len)
 			break;
-- 
1.8.1.20.g7078b03
