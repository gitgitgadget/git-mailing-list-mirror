From: Jeff King <peff@peff.net>
Subject: [PATCH v3 14/19] pkt-line: provide a LARGE_PACKET_MAX static buffer
Date: Wed, 20 Feb 2013 15:02:57 -0500
Message-ID: <20130220200257.GN25647@sigill.intra.peff.net>
References: <20130220195147.GA25332@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 20 21:03:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8Fsz-0005Iu-Tp
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 21:03:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935168Ab3BTUDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 15:03:00 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54665 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935054Ab3BTUDA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 15:03:00 -0500
Received: (qmail 17830 invoked by uid 107); 20 Feb 2013 20:04:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Feb 2013 15:04:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Feb 2013 15:02:57 -0500
Content-Disposition: inline
In-Reply-To: <20130220195147.GA25332@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216728>

Most of the callers of packet_read_line just read into a
static 1000-byte buffer (callers which handle arbitrary
binary data already use LARGE_PACKET_MAX). This works fine
in practice, because:

  1. The only variable-sized data in these lines is a ref
     name, and refs tend to be a lot shorter than 1000
     characters.

  2. When sending ref lines, git-core always limits itself
     to 1000 byte packets.

However, the only limit given in the protocol specification
in Documentation/technical/protocol-common.txt is
LARGE_PACKET_MAX; the 1000 byte limit is mentioned only in
pack-protocol.txt, and then only describing what we write,
not as a specific limit for readers.

This patch lets us bump the 1000-byte limit to
LARGE_PACKET_MAX. Even though git-core will never write a
packet where this makes a difference, there are two good
reasons to do this:

  1. Other git implementations may have followed
     protocol-common.txt and used a larger maximum size. We
     don't bump into it in practice because it would involve
     very long ref names.

  2. We may want to increase the 1000-byte limit one day.
     Since packets are transferred before any capabilities,
     it's difficult to do this in a backwards-compatible
     way. But if we bump the size of buffer the readers can
     handle, eventually older versions of git will be
     obsolete enough that we can justify bumping the
     writers, as well. We don't have plans to do this
     anytime soon, but there is no reason not to start the
     clock ticking now.

Just bumping all of the reading bufs to LARGE_PACKET_MAX
would waste memory. Instead, since most readers just read
into a temporary buffer anyway, let's provide a single
static buffer that all callers can use. We can further wrap
this detail away by having the packet_read_line wrapper just
use the buffer transparently and return a pointer to the
static storage.  That covers most of the cases, and the
remaining ones already read into their own LARGE_PACKET_MAX
buffers.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/archive.c        | 15 +++++++--------
 builtin/fetch-pack.c     |  7 +++----
 builtin/receive-pack.c   |  6 +++---
 builtin/upload-archive.c |  7 ++-----
 connect.c                |  4 ++--
 daemon.c                 |  4 ++--
 fetch-pack.c             | 12 ++++++------
 pkt-line.c               |  9 +++++++--
 pkt-line.h               |  9 +++++++--
 send-pack.c              |  7 +++----
 upload-pack.c            | 12 +++++-------
 11 files changed, 47 insertions(+), 45 deletions(-)

diff --git a/builtin/archive.c b/builtin/archive.c
index d381ac4..49178f1 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -27,8 +27,8 @@ static int run_remote_archiver(int argc, const char **argv,
 			       const char *remote, const char *exec,
 			       const char *name_hint)
 {
-	char buf[LARGE_PACKET_MAX];
-	int fd[2], i, len, rv;
+	char *buf;
+	int fd[2], i, rv;
 	struct transport *transport;
 	struct remote *_remote;
 
@@ -53,19 +53,18 @@ static int run_remote_archiver(int argc, const char **argv,
 		packet_write(fd[1], "argument %s\n", argv[i]);
 	packet_flush(fd[1]);
 
-	len = packet_read_line(fd[0], buf, sizeof(buf));
-	if (!len)
+	buf = packet_read_line(fd[0], NULL);
+	if (!buf)
 		die(_("git archive: expected ACK/NAK, got EOF"));
 	if (strcmp(buf, "ACK")) {
-		if (len > 5 && !prefixcmp(buf, "NACK "))
+		if (!prefixcmp(buf, "NACK "))
 			die(_("git archive: NACK %s"), buf + 5);
-		if (len > 4 && !prefixcmp(buf, "ERR "))
+		if (!prefixcmp(buf, "ERR "))
 			die(_("remote error: %s"), buf + 4);
 		die(_("git archive: protocol error"));
 	}
 
-	len = packet_read_line(fd[0], buf, sizeof(buf));
-	if (len)
+	if (packet_read_line(fd[0], NULL))
 		die(_("git archive: expected a flush"));
 
 	/* Now, start reading from fd[0] and spit it out to stdout */
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index f73664f..c21cc2c 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -100,12 +100,11 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			/* in stateless RPC mode we use pkt-line to read
 			 * from stdin, until we get a flush packet
 			 */
-			static char line[1000];
 			for (;;) {
-				int n = packet_read_line(0, line, sizeof(line));
-				if (!n)
+				char *line = packet_read_line(0, NULL);
+				if (!line)
 					break;
-				string_list_append(&sought, xmemdupz(line, n));
+				string_list_append(&sought, xstrdup(line));
 			}
 		}
 		else {
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 6679e63..ccebd74 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -754,14 +754,14 @@ static struct command *read_head_info(void)
 	struct command *commands = NULL;
 	struct command **p = &commands;
 	for (;;) {
-		static char line[1000];
+		char *line;
 		unsigned char old_sha1[20], new_sha1[20];
 		struct command *cmd;
 		char *refname;
 		int len, reflen;
 
-		len = packet_read_line(0, line, sizeof(line));
-		if (!len)
+		line = packet_read_line(0, &len);
+		if (!line)
 			break;
 		if (len < 83 ||
 		    line[40] != ' ' ||
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 7d367b5..2a94675 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -21,8 +21,6 @@ int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix)
 {
 	struct argv_array sent_argv = ARGV_ARRAY_INIT;
 	const char *arg_cmd = "argument ";
-	char buf[4096];
-	int len;
 
 	if (argc != 2)
 		usage(upload_archive_usage);
@@ -33,9 +31,8 @@ int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix)
 	/* put received options in sent_argv[] */
 	argv_array_push(&sent_argv, "git-upload-archive");
 	for (;;) {
-		/* This will die if not enough free space in buf */
-		len = packet_read_line(0, buf, sizeof(buf));
-		if (len == 0)
+		char *buf = packet_read_line(0, NULL);
+		if (!buf)
 			break;	/* got a flush */
 		if (sent_argv.argc > MAX_ARGS)
 		    die("Too many options (>%d)", MAX_ARGS - 1);
diff --git a/connect.c b/connect.c
index fe8eb01..611ffb4 100644
--- a/connect.c
+++ b/connect.c
@@ -72,11 +72,11 @@ struct ref **get_remote_heads(int in, struct ref **list,
 	for (;;) {
 		struct ref *ref;
 		unsigned char old_sha1[20];
-		static char buffer[1000];
 		char *name;
 		int len, name_len;
+		char *buffer = packet_buffer;
 
-		len = packet_read(in, buffer, sizeof(buffer),
+		len = packet_read(in, packet_buffer, sizeof(packet_buffer),
 				  PACKET_READ_GENTLE_ON_EOF |
 				  PACKET_READ_CHOMP_NEWLINE);
 		if (len < 0)
diff --git a/daemon.c b/daemon.c
index 4f5cd61..3f70e79 100644
--- a/daemon.c
+++ b/daemon.c
@@ -604,7 +604,7 @@ static int execute(void)
 
 static int execute(void)
 {
-	static char line[1000];
+	char *line = packet_buffer;
 	int pktlen, len, i;
 	char *addr = getenv("REMOTE_ADDR"), *port = getenv("REMOTE_PORT");
 
@@ -612,7 +612,7 @@ static int execute(void)
 		loginfo("Connection from %s:%s", addr, port);
 
 	alarm(init_timeout ? init_timeout : timeout);
-	pktlen = packet_read(0, line, sizeof(line), 0);
+	pktlen = packet_read(0, packet_buffer, sizeof(packet_buffer), 0);
 	alarm(0);
 
 	len = strlen(line);
diff --git a/fetch-pack.c b/fetch-pack.c
index f830db2..66ff9ad 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -172,8 +172,8 @@ static void consume_shallow_list(struct fetch_pack_args *args, int fd)
 		 * shallow and unshallow commands every time there
 		 * is a block of have lines exchanged.
 		 */
-		char line[1000];
-		while (packet_read_line(fd, line, sizeof(line))) {
+		char *line;
+		while ((line = packet_read_line(fd, NULL))) {
 			if (!prefixcmp(line, "shallow "))
 				continue;
 			if (!prefixcmp(line, "unshallow "))
@@ -215,8 +215,8 @@ static enum ack_type get_ack(int fd, unsigned char *result_sha1)
 
 static enum ack_type get_ack(int fd, unsigned char *result_sha1)
 {
-	static char line[1000];
-	int len = packet_read_line(fd, line, sizeof(line));
+	int len;
+	char *line = packet_read_line(fd, &len);
 
 	if (!len)
 		die("git fetch-pack: expected ACK/NAK, got EOF");
@@ -346,11 +346,11 @@ static int find_common(struct fetch_pack_args *args,
 	state_len = req_buf.len;
 
 	if (args->depth > 0) {
-		char line[1024];
+		char *line;
 		unsigned char sha1[20];
 
 		send_request(args, fd[1], &req_buf);
-		while (packet_read_line(fd[0], line, sizeof(line))) {
+		while ((line = packet_read_line(fd[0], NULL))) {
 			if (!prefixcmp(line, "shallow ")) {
 				if (get_sha1_hex(line + 8, sha1))
 					die("invalid shallow line: %s", line);
diff --git a/pkt-line.c b/pkt-line.c
index dc11c40..55fb688 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "pkt-line.h"
 
+char packet_buffer[LARGE_PACKET_MAX];
 static const char *packet_trace_prefix = "git";
 static const char trace_key[] = "GIT_TRACE_PACKET";
 
@@ -174,9 +175,13 @@ int packet_read_line(int fd, char *buffer, unsigned size)
 	return len;
 }
 
-int packet_read_line(int fd, char *buffer, unsigned size)
+char *packet_read_line(int fd, int *len_p)
 {
-	return packet_read(fd, buffer, size, PACKET_READ_CHOMP_NEWLINE);
+	int len = packet_read(fd, packet_buffer, sizeof(packet_buffer),
+			      PACKET_READ_CHOMP_NEWLINE);
+	if (len_p)
+		*len_p = len;
+	return len ? packet_buffer : NULL;
 }
 
 int packet_get_line(struct strbuf *out,
diff --git a/pkt-line.h b/pkt-line.h
index 6927ea5..fa93e32 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -54,12 +54,17 @@ int packet_read_line(int fd, char *buffer, unsigned size);
 
 /*
  * Convenience wrapper for packet_read that is not gentle, and sets the
- * CHOMP_NEWLINE option.
+ * CHOMP_NEWLINE option. The return value is NULL for a flush packet,
+ * and otherwise points to a static buffer (that may be overwritten by
+ * subsequent calls). If the size parameter is not NULL, the length of the
+ * packet is written to it.
  */
-int packet_read_line(int fd, char *buffer, unsigned size);
+char *packet_read_line(int fd, int *size);
+
 
 #define DEFAULT_PACKET_MAX 1000
 #define LARGE_PACKET_MAX 65520
+extern char packet_buffer[LARGE_PACKET_MAX];
 
 int packet_get_line(struct strbuf *out, char **src_buf, size_t *src_len);
 
diff --git a/send-pack.c b/send-pack.c
index 8c230bf..7d172ef 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -106,9 +106,8 @@ static int receive_status(int in, struct ref *refs)
 static int receive_status(int in, struct ref *refs)
 {
 	struct ref *hint;
-	char line[1000];
 	int ret = 0;
-	int len = packet_read_line(in, line, sizeof(line));
+	char *line = packet_read_line(in, NULL);
 	if (prefixcmp(line, "unpack "))
 		return error("did not receive remote status");
 	if (strcmp(line, "unpack ok")) {
@@ -119,8 +118,8 @@ static int receive_status(int in, struct ref *refs)
 	while (1) {
 		char *refname;
 		char *msg;
-		len = packet_read_line(in, line, sizeof(line));
-		if (!len)
+		line = packet_read_line(in, NULL);
+		if (!line)
 			break;
 		if (prefixcmp(line, "ok ") && prefixcmp(line, "ng ")) {
 			error("invalid ref status from remote: %s", line);
diff --git a/upload-pack.c b/upload-pack.c
index 7446cb7..bc241ba 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -408,7 +408,6 @@ static int get_common_commits(void)
 
 static int get_common_commits(void)
 {
-	static char line[1000];
 	unsigned char sha1[20];
 	char last_hex[41];
 	int got_common = 0;
@@ -418,10 +417,10 @@ static int get_common_commits(void)
 	save_commit_buffer = 0;
 
 	for (;;) {
-		int len = packet_read_line(0, line, sizeof(line));
+		char *line = packet_read_line(0, NULL);
 		reset_timeout();
 
-		if (!len) {
+		if (!line) {
 			if (multi_ack == 2 && got_common
 			    && !got_other && ok_to_give_up()) {
 				sent_ready = 1;
@@ -567,8 +566,7 @@ static void receive_needs(void)
 static void receive_needs(void)
 {
 	struct object_array shallows = OBJECT_ARRAY_INIT;
-	static char line[1000];
-	int len, depth = 0;
+	int depth = 0;
 	int has_non_tip = 0;
 
 	shallow_nr = 0;
@@ -576,9 +574,9 @@ static void receive_needs(void)
 		struct object *o;
 		const char *features;
 		unsigned char sha1_buf[20];
-		len = packet_read_line(0, line, sizeof(line));
+		char *line = packet_read_line(0, NULL);
 		reset_timeout();
-		if (!len)
+		if (!line)
 			break;
 
 		if (!prefixcmp(line, "shallow ")) {
-- 
1.8.2.rc0.9.g352092c
