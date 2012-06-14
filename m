From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] remove the impression of unexpectedness when access is
	denied
Date: Thu, 14 Jun 2012 09:13:06 +0200
Message-ID: <20120614071259.GA51076@book.hvoigt.net>
References: <20120610182310.GB2427@book.hvoigt.net> <20120611190207.GA20889@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 14 09:13:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sf4F3-00070T-9i
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 09:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936Ab2FNHNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 03:13:13 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.103]:57339 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208Ab2FNHNL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 03:13:11 -0400
Received: from [77.20.33.80] (helo=localhost)
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Sf4Es-0007P6-Vm; Thu, 14 Jun 2012 09:13:07 +0200
Content-Disposition: inline
In-Reply-To: <20120611190207.GA20889@sigill.intra.peff.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199972>

If a server accessed through ssh is denying access git will currently
issue the message

	"fatal: The remote end hung up unexpectedly"

as the last line. This sounds as if something really ugly just happened.
Since this is a quite typical situation in which users regularly get
lets say:

	"fatal: Could not read remote heads"

If it happens at the beginning when reading the remote heads. Since
this is the first the client does it is very likely an authentication
error or a missing repository.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
On Mon, Jun 11, 2012 at 03:02:07PM -0400, Jeff King wrote:
> On Sun, Jun 10, 2012 at 08:23:10PM +0200, Heiko Voigt wrote:
> > We just got this bug report in msysgit
> > 
> > https://github.com/msysgit/msysgit/issues/28
> > 
> > and IIRC there have been more people questioning that line.
> 
> This does not seem like it would lessen the surprise all that much. I
> wonder if we could use some context about where we are in the protocol
> to tell more. For example, if the remote end hangs up before advertising
> its refs, it is probably an authentication error or a missing
> repository. And we should say that. If it happens during ref negotiation
> or during the pack file, then it really is unexpected; the other end has
> broken protocol, and it probably makes sense to say so.

This is the shortest I was currently able to come up with. Should we
add an explanation to the die like:

	This error very likely occurred because the remote repository
	path is wrong or access was denied.

This time I ran the testsuite and it passes with this patch.

Cheers Heiko


 builtin/archive.c        |  4 ++--
 builtin/fetch-pack.c     |  8 ++++----
 builtin/receive-pack.c   |  2 +-
 builtin/send-pack.c      |  4 ++--
 builtin/upload-archive.c |  2 +-
 connect.c                | 12 +++++++++++-
 daemon.c                 |  2 +-
 pkt-line.c               | 21 +++++++++++++++------
 pkt-line.h               |  2 +-
 remote-curl.c            |  6 +++---
 sideband.c               |  2 +-
 t/t5512-ls-remote.sh     |  2 +-
 upload-pack.c            |  4 ++--
 13 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/builtin/archive.c b/builtin/archive.c
index 931956d..2e4a784 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -53,7 +53,7 @@ static int run_remote_archiver(int argc, const char **argv,
 		packet_write(fd[1], "argument %s\n", argv[i]);
 	packet_flush(fd[1]);
 
-	len = packet_read_line(fd[0], buf, sizeof(buf));
+	len = packet_read_line(fd[0], buf, sizeof(buf), 0);
 	if (!len)
 		die(_("git archive: expected ACK/NAK, got EOF"));
 	if (buf[len-1] == '\n')
@@ -66,7 +66,7 @@ static int run_remote_archiver(int argc, const char **argv,
 		die(_("git archive: protocol error"));
 	}
 
-	len = packet_read_line(fd[0], buf, sizeof(buf));
+	len = packet_read_line(fd[0], buf, sizeof(buf), 0);
 	if (len)
 		die(_("git archive: expected a flush"));
 
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 149db88..4f0778d 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -179,7 +179,7 @@ static void consume_shallow_list(int fd)
 		 * is a block of have lines exchanged.
 		 */
 		char line[1000];
-		while (packet_read_line(fd, line, sizeof(line))) {
+		while (packet_read_line(fd, line, sizeof(line), 0)) {
 			if (!prefixcmp(line, "shallow "))
 				continue;
 			if (!prefixcmp(line, "unshallow "))
@@ -222,7 +222,7 @@ static int write_shallow_commits(struct strbuf *out, int use_pack_protocol)
 static enum ack_type get_ack(int fd, unsigned char *result_sha1)
 {
 	static char line[1000];
-	int len = packet_read_line(fd, line, sizeof(line));
+	int len = packet_read_line(fd, line, sizeof(line), 0);
 
 	if (!len)
 		die("git fetch-pack: expected ACK/NAK, got EOF");
@@ -352,7 +352,7 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 		unsigned char sha1[20];
 
 		send_request(fd[1], &req_buf);
-		while (packet_read_line(fd[0], line, sizeof(line))) {
+		while (packet_read_line(fd[0], line, sizeof(line), 0)) {
 			if (!prefixcmp(line, "shallow ")) {
 				if (get_sha1_hex(line + 8, sha1))
 					die("invalid shallow line: %s", line);
@@ -990,7 +990,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			 */
 			static char line[1000];
 			for (;;) {
-				int n = packet_read_line(0, line, sizeof(line));
+				int n = packet_read_line(0, line, sizeof(line), 0);
 				if (!n)
 					break;
 				if (line[n-1] == '\n')
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 0afb8b2..2267dac 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -743,7 +743,7 @@ static struct command *read_head_info(void)
 		char *refname;
 		int len, reflen;
 
-		len = packet_read_line(0, line, sizeof(line));
+		len = packet_read_line(0, line, sizeof(line), 0);
 		if (!len)
 			break;
 		if (line[len-1] == '\n')
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index d5d7105..7a8c21e 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -113,7 +113,7 @@ static int receive_status(int in, struct ref *refs)
 	struct ref *hint;
 	char line[1000];
 	int ret = 0;
-	int len = packet_read_line(in, line, sizeof(line));
+	int len = packet_read_line(in, line, sizeof(line), 0);
 	if (len < 10 || memcmp(line, "unpack ", 7))
 		return error("did not receive remote status");
 	if (memcmp(line, "unpack ok\n", 10)) {
@@ -127,7 +127,7 @@ static int receive_status(int in, struct ref *refs)
 	while (1) {
 		char *refname;
 		char *msg;
-		len = packet_read_line(in, line, sizeof(line));
+		len = packet_read_line(in, line, sizeof(line), 0);
 		if (!len)
 			break;
 		if (len < 3 ||
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index b928beb..e0e4d0c 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -40,7 +40,7 @@ int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix)
 	sent_argv[0] = "git-upload-archive";
 	for (p = buf;;) {
 		/* This will die if not enough free space in buf */
-		len = packet_read_line(0, p, (buf + sizeof buf) - p);
+		len = packet_read_line(0, p, (buf + sizeof buf) - p, 0);
 		if (len == 0)
 			break;	/* got a flush */
 		if (sent_argc > MAX_ARGS - 2)
diff --git a/connect.c b/connect.c
index 912cdde..19e73d5 100644
--- a/connect.c
+++ b/connect.c
@@ -56,6 +56,8 @@ struct ref **get_remote_heads(int in, struct ref **list,
 			      unsigned int flags,
 			      struct extra_have_objects *extra_have)
 {
+	int got_at_least_one_head = 0;
+
 	*list = NULL;
 	for (;;) {
 		struct ref *ref;
@@ -64,7 +66,14 @@ struct ref **get_remote_heads(int in, struct ref **list,
 		char *name;
 		int len, name_len;
 
-		len = packet_read_line(in, buffer, sizeof(buffer));
+		len = packet_read_line(in, buffer, sizeof(buffer), 1);
+		if (len < 0) {
+			if (got_at_least_one_head)
+				die("The remote end hung up unexpectedly");
+			else
+				die("Could not read remote heads");
+		}
+
 		if (!len)
 			break;
 		if (buffer[len-1] == '\n')
@@ -95,6 +104,7 @@ struct ref **get_remote_heads(int in, struct ref **list,
 		hashcpy(ref->old_sha1, old_sha1);
 		*list = ref;
 		list = &ref->next;
+		got_at_least_one_head = 1;
 	}
 	return list;
 }
diff --git a/daemon.c b/daemon.c
index ab21e66..a6bbfa4 100644
--- a/daemon.c
+++ b/daemon.c
@@ -539,7 +539,7 @@ static int execute(void)
 		loginfo("Connection from %s:%s", addr, port);
 
 	alarm(init_timeout ? init_timeout : timeout);
-	pktlen = packet_read_line(0, line, sizeof(line));
+	pktlen = packet_read_line(0, line, sizeof(line), 0);
 	alarm(0);
 
 	len = strlen(line);
diff --git a/pkt-line.c b/pkt-line.c
index 5a04984..533f1f6 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -135,13 +135,18 @@ void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
 	strbuf_add(buf, buffer, n);
 }
 
-static void safe_read(int fd, void *buffer, unsigned size)
+static int safe_read(int fd, void *buffer, unsigned size, int return_read_fail)
 {
 	ssize_t ret = read_in_full(fd, buffer, size);
 	if (ret < 0)
 		die_errno("read error");
 	else if (ret < size)
-		die("The remote end hung up unexpectedly");
+		if (return_read_fail)
+			return -1;
+		else
+			die("The remote end hung up unexpectedly");
+
+	return ret;
 }
 
 static int packet_length(const char *linelen)
@@ -169,12 +174,14 @@ static int packet_length(const char *linelen)
 	return len;
 }
 
-int packet_read_line(int fd, char *buffer, unsigned size)
+int packet_read_line(int fd, char *buffer, unsigned size, int return_read_fail)
 {
-	int len;
+	int len, ret;
 	char linelen[4];
 
-	safe_read(fd, linelen, 4);
+	ret = safe_read(fd, linelen, 4, return_read_fail);
+	if (return_read_fail && ret < 0)
+		return ret;
 	len = packet_length(linelen);
 	if (len < 0)
 		die("protocol error: bad line length character: %.4s", linelen);
@@ -185,7 +192,9 @@ int packet_read_line(int fd, char *buffer, unsigned size)
 	len -= 4;
 	if (len >= size)
 		die("protocol error: bad line length %d", len);
-	safe_read(fd, buffer, len);
+	ret = safe_read(fd, buffer, len, return_read_fail);
+	if (return_read_fail && ret < 0)
+		return ret;
 	buffer[len] = 0;
 	packet_trace(buffer, len, 0);
 	return len;
diff --git a/pkt-line.h b/pkt-line.h
index 1e5dcfe..277dc9d 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -12,7 +12,7 @@ void packet_write(int fd, const char *fmt, ...) __attribute__((format (printf, 2
 void packet_buf_flush(struct strbuf *buf);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 
-int packet_read_line(int fd, char *buffer, unsigned size);
+int packet_read_line(int fd, char *buffer, unsigned size, int return_read_fail);
 int packet_get_line(struct strbuf *out, char **src_buf, size_t *src_len);
 ssize_t safe_write(int, const void *, ssize_t);
 
diff --git a/remote-curl.c b/remote-curl.c
index 04a9d62..40f6b2d 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -314,7 +314,7 @@ static size_t rpc_out(void *ptr, size_t eltsize,
 
 	if (!avail) {
 		rpc->initial_buffer = 0;
-		avail = packet_read_line(rpc->out, rpc->buf, rpc->alloc);
+		avail = packet_read_line(rpc->out, rpc->buf, rpc->alloc, 0);
 		if (!avail)
 			return 0;
 		rpc->pos = 0;
@@ -429,7 +429,7 @@ static int post_rpc(struct rpc_state *rpc)
 			break;
 		}
 
-		n = packet_read_line(rpc->out, buf, left);
+		n = packet_read_line(rpc->out, buf, left, 0);
 		if (!n)
 			break;
 		rpc->len += n;
@@ -568,7 +568,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
 	rpc->hdr_accept = strbuf_detach(&buf, NULL);
 
 	while (!err) {
-		int n = packet_read_line(rpc->out, rpc->buf, rpc->alloc);
+		int n = packet_read_line(rpc->out, rpc->buf, rpc->alloc, 0);
 		if (!n)
 			break;
 		rpc->pos = 0;
diff --git a/sideband.c b/sideband.c
index d5ffa1c..1e86a6b 100644
--- a/sideband.c
+++ b/sideband.c
@@ -37,7 +37,7 @@ int recv_sideband(const char *me, int in_stream, int out)
 
 	while (1) {
 		int band, len;
-		len = packet_read_line(in_stream, buf + pf, LARGE_PACKET_MAX);
+		len = packet_read_line(in_stream, buf + pf, LARGE_PACKET_MAX, 0);
 		if (len == 0)
 			break;
 		if (len < 1) {
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 6764d51..7f165ec 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -87,7 +87,7 @@ test_expect_success 'use branch.<name>.remote if possible' '
 test_expect_success 'confuses pattern as remote when no remote specified' '
 	cat >exp <<-\EOF &&
 	fatal: '\''refs*master'\'' does not appear to be a git repository
-	fatal: The remote end hung up unexpectedly
+	fatal: Could not read remote heads
 	EOF
 	#
 	# Do not expect "git ls-remote <pattern>" to work; ls-remote, correctly,
diff --git a/upload-pack.c b/upload-pack.c
index bb08e2e..a690f63 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -426,7 +426,7 @@ static int get_common_commits(void)
 	save_commit_buffer = 0;
 
 	for (;;) {
-		int len = packet_read_line(0, line, sizeof(line));
+		int len = packet_read_line(0, line, sizeof(line), 0);
 		reset_timeout();
 
 		if (!len) {
@@ -587,7 +587,7 @@ static void receive_needs(void)
 		struct object *o;
 		const char *features;
 		unsigned char sha1_buf[20];
-		len = packet_read_line(0, line, sizeof(line));
+		len = packet_read_line(0, line, sizeof(line), 0);
 		reset_timeout();
 		if (!len)
 			break;
-- 
1.7.11.rc2.4.g4f85a3f
