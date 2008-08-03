From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC 2/2] Add Git-aware CGI for Git-aware smart HTTP transport
Date: Sun,  3 Aug 2008 00:25:17 -0700
Message-ID: <1217748317-70096-2-git-send-email-spearce@spearce.org>
References: <20080803025602.GB27465@spearce.org>
 <1217748317-70096-1-git-send-email-spearce@spearce.org>
To: git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sun Aug 03 09:26:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPXz3-00077l-1K
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 09:26:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601AbYHCHZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 03:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752592AbYHCHZY
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 03:25:24 -0400
Received: from george.spearce.org ([209.20.77.23]:41409 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552AbYHCHZU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 03:25:20 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id EF32B38438; Sun,  3 Aug 2008 07:25:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id E1C4E38419;
	Sun,  3 Aug 2008 07:25:18 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc1.221.g9ae23
In-Reply-To: <1217748317-70096-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91211>

This CGI can be loaded into an Apache server using ScriptAlias,
such as with the following configuration:

  LoadModule cgi_module /usr/libexec/apache2/mod_cgi.so
  LoadModule alias_module /usr/libexec/apache2/mod_alias.so
  ScriptAlias /git/ /usr/libexec/git-core/git-http-backend/

Repositories are accessed via the translated PATH_INFO.

The CGI is backwards compatible with the dumb client, allowing the
client to detect the server's smarts by looking at the content-type
returned from "GET /repo.git/info/refs".  If the returned content
type is the magic application/x-git-refs type then the client can
assume the server is Git-aware.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .gitignore                                |    1 +
 Documentation/technical/http-protocol.txt |   88 +++++++++
 Makefile                                  |    1 +
 http-backend.c                            |  302 +++++++++++++++++++++++++++++
 4 files changed, 392 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/technical/http-protocol.txt
 create mode 100644 http-backend.c

diff --git a/.gitignore b/.gitignore
index a213e8e..02eaf3a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -51,6 +51,7 @@ git-gc
 git-get-tar-commit-id
 git-grep
 git-hash-object
+git-http-backend
 git-http-fetch
 git-http-push
 git-imap-send
diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
new file mode 100644
index 0000000..6cb96f3
--- /dev/null
+++ b/Documentation/technical/http-protocol.txt
@@ -0,0 +1,88 @@
+Smart HTTP transfer protocols
+=============================
+
+Git supports two HTTP based transfer protocols.  A "dumb" protocol
+which requires only a standard HTTP server on the server end of the
+connection, and a "smart" protocol which requires a Git aware CGI
+(or server module).  This document describes the "smart" protocol.
+
+As a design feature smart servers automatically degrade to the
+dumb protocol when speaking with a dumb client.  This may cause
+more load to be placed on the server as the file GET requests are
+handled by a CGI rather than the server itself.
+
+
+Authentication
+--------------
+
+Standard HTTP authentication is used, and must be configured and
+enforced by the HTTP server software.
+
+Chunked Transfer Encoding
+-------------------------
+
+For performance reasons the HTTP/1.1 chunked transfer encoding is
+used frequently to transfer variable length objects.  This avoids
+needing to produce large results in memory to compute the proper
+content-length.
+
+Detecting Smart Servers
+-----------------------
+
+HTTP clients can detect a smart Git-aware server by sending the
+/info/refs request (below) to the server.  If the response has a
+status of 200 and the magic application/x-git-refs content type
+then the server can be assumed to be a smart Git-aware server.
+
+
+Show Refs
+---------
+
+Obtains the available refs from the remote repository.  The response
+is a sequence of refs, one per line.  The actual format matches that
+of the $GIT_DIR/info/refs file normally used by a "dumb" protocol.
+
+	C: GET /path/to/repository.git/info/refs HTTP/1.0
+
+	S: HTTP/1.1 200 OK
+	S: Content-Type: application/x-git-refs
+	S: Transfer-Encoding: chunked
+	S:
+	S: 62
+	S: 95dcfa3633004da0049d3d0fa03f80589cbcaf31 refs/heads/maint
+	S:
+	S: 63
+	S: d049f6c27a2244e12041955e262a404c7faba355 refs/heads/master
+	S:
+	S: 59
+	S: 2cb58b79488a98d2721cea644875a8dd0026b115 refs/heads/pu
+	S:
+
+Push Pack
+---------
+
+Uploads a pack and updates refs.  The start of the stream is the
+commands to update the refs and the remainder of the stream is the
+pack file itself.  See git-receive-pack and its network protocol
+in pack-protocol.txt, as this is essentially the same.
+
+	C: POST /path/to/repository.git/receive-pack HTTP/1.0
+	C: Content-Type: application/x-git-receive-pack
+	C: Transfer-Encoding: chunked
+	C:
+	C: 103
+	C: 006395dcfa3633004da0049d3d0fa03f80589cbcaf31 d049f6c27a2244e12041955e262a404c7faba355 refs/heads/maint
+	C: 4
+	C: 0000
+	C: 12
+	C: PACK
+	...
+	C: 0
+
+	S: HTTP/1.0 200 OK
+	S: Content-type: application/x-git-receive-pack-status
+	S: Transfer-Encoding: chunked
+	S:
+	S: ...<output of receive-pack>...
+
+
diff --git a/Makefile b/Makefile
index 52c67c1..3a93bf6 100644
--- a/Makefile
+++ b/Makefile
@@ -298,6 +298,7 @@ PROGRAMS += git-unpack-file$X
 PROGRAMS += git-update-server-info$X
 PROGRAMS += git-upload-pack$X
 PROGRAMS += git-var$X
+PROGRAMS += git-http-backend$X
 
 # List built-in command $C whose implementation cmd_$C() is not in
 # builtin-$C.o but is linked in as part of some other command.
diff --git a/http-backend.c b/http-backend.c
new file mode 100644
index 0000000..a498f89
--- /dev/null
+++ b/http-backend.c
@@ -0,0 +1,302 @@
+#include "cache.h"
+#include "refs.h"
+#include "pkt-line.h"
+#include "object.h"
+#include "tag.h"
+#include "exec_cmd.h"
+#include "run-command.h"
+
+static const char content_type[] = "Content-Type";
+static const char content_length[] = "Content-Length";
+
+static int can_chunk;
+static char buffer[1000];
+
+static void send_status(unsigned code, const char *msg)
+{
+	size_t n;
+
+	n = snprintf(buffer, sizeof(buffer), "Status: %u %s\r\n", code, msg);
+	if (n >= sizeof(buffer))
+		die("protocol error: impossibly long header");
+	safe_write(1, buffer, n);
+}
+
+static void send_header(const char *name, const char *value)
+{
+	size_t n;
+
+	n = snprintf(buffer, sizeof(buffer), "%s: %s\r\n", name, value);
+	if (n >= sizeof(buffer))
+		die("protocol error: impossibly long header");
+	safe_write(1, buffer, n);
+}
+
+static void end_headers(void)
+{
+	safe_write(1, "\r\n", 2);
+}
+
+static void send_nocaching(void)
+{
+	const char *proto = getenv("SERVER_PROTOCOL");
+	if (!proto || !strcmp(proto, "HTTP/1.0"))
+		send_header("Expires", "Mon, 17 Sep 2001 00:00:00 GMT");
+	else
+		send_header("Cache-Control", "no-cache");
+}
+
+static void send_connection_close(void)
+{
+	send_header("Connection", "close");
+}
+
+static void enable_chunking(void)
+{
+	const char *proto = getenv("SERVER_PROTOCOL");
+
+	can_chunk = proto && strcmp(proto, "HTTP/1.0");
+	if (can_chunk)
+		send_header("Transfer-Encoding", "chunked");
+	else
+		send_connection_close();
+}
+
+#define hex(a) (hexchar[(a) & 15])
+static void chunked_write(const char *fmt, ...)
+{
+	static const char hexchar[] = "0123456789abcdef";
+	va_list args;
+	unsigned n;
+
+	va_start(args, fmt);
+	n = vsnprintf(buffer + 6, sizeof(buffer) - 8, fmt, args);
+	va_end(args);
+	if (n >= sizeof(buffer) - 8)
+		die("protocol error: impossibly long line");
+
+	if (can_chunk) {
+		unsigned len = n + 4, b = 4;
+
+		buffer[4] = '\r';
+		buffer[5] = '\n';
+		buffer[n + 6] = '\r';
+		buffer[n + 7] = '\n';
+
+		while (n > 0) {
+			buffer[--b] = hex(n);
+			n >>= 4;
+			len++;
+		}
+
+		safe_write(1, buffer + b, len);
+	} else
+		safe_write(1, buffer + 6, n);
+}
+
+static void end_chunking(void)
+{
+	static const char flush_chunk[] = "0\r\n\r\n";
+	if (can_chunk)
+		safe_write(1, flush_chunk, strlen(flush_chunk));
+}
+
+static void NORETURN invalid_request(const char *msg)
+{
+	static const char header[] = "error: ";
+
+	send_status(400, "Bad Request");
+	send_header(content_type, "text/plain");
+	end_headers();
+
+	safe_write(1, header, strlen(header));
+	safe_write(1, msg, strlen(msg));
+	safe_write(1, "\n", 1);
+
+	exit(0);
+}
+
+static void not_found(void)
+{
+	send_status(404, "Not Found");
+	end_headers();
+}
+
+static void server_error(void)
+{
+	send_status(500, "Internal Error");
+	end_headers();
+}
+
+static void require_content_type(const char *need_type)
+{
+	const char *input_type = getenv("CONTENT_TYPE");
+	if (!input_type || strcmp(input_type, need_type))
+		invalid_request("Unsupported content-type");
+}
+
+static void do_GET_any_file(char *name)
+{
+	const char *p = git_path("%s", name);
+	struct stat sb;
+	uintmax_t remaining;
+	size_t n;
+	int fd = open(p, O_RDONLY);
+
+	if (fd < 0) {
+		not_found();
+		return;
+	}
+	if (fstat(fd, &sb) < 0) {
+		close(fd);
+		server_error();
+		die("fstat on plain file failed");
+	}
+	remaining = (uintmax_t)sb.st_size;
+
+	n = snprintf(buffer, sizeof(buffer),
+		"Content-Length: %" PRIuMAX "\r\n", remaining);
+	if (n >= sizeof(buffer))
+		die("protocol error: impossibly long header");
+	safe_write(1, buffer, n);
+	send_header(content_type, "application/octet-stream");
+	end_headers();
+
+	while (remaining) {
+		n = xread(fd, buffer, sizeof(buffer));
+		if (n < 0)
+			die("error reading from %s", p);
+		n = safe_write(1, buffer, n);
+		if (n <= 0)
+			break;
+	}
+	close(fd);
+}
+
+static int show_one_ref(const char *name, const unsigned char *sha1,
+	int flag, void *cb_data)
+{
+	struct object *o = parse_object(sha1);
+	if (!o)
+		return 0;
+
+	chunked_write("%s\t%s\n", sha1_to_hex(sha1), name);
+	if (o->type == OBJ_TAG) {
+		o = deref_tag(o, name, 0);
+		if (!o)
+			return 0;
+		chunked_write("%s\t%s^{}\n", sha1_to_hex(o->sha1), name);
+	}
+
+	return 0;
+}
+
+static void do_GET_info_refs(char *arg)
+{
+	send_header(content_type, "application/x-git-refs");
+	send_nocaching();
+	enable_chunking();
+	end_headers();
+
+	for_each_ref(show_one_ref, NULL);
+	end_chunking();
+}
+
+static void do_GET_info_packs(char *arg)
+{
+	size_t objdirlen = strlen(get_object_directory());
+	struct packed_git *p;
+
+	send_nocaching();
+	enable_chunking();
+	end_headers();
+
+	prepare_packed_git();
+	for (p = packed_git; p; p = p->next) {
+		if (!p->pack_local)
+			continue;
+		chunked_write("P %s\n", p->pack_name + objdirlen + 6);
+	}
+	chunked_write("\n");
+	end_chunking();
+}
+
+static void do_POST_receive_pack(char *arg)
+{
+	require_content_type("application/x-git-receive-pack");
+	send_header(content_type, "application/x-git-receive-pack-status");
+	send_nocaching();
+	send_connection_close();
+	end_headers();
+
+	execl_git_cmd("receive-pack",
+		"--report-status",
+		"--no-advertise-heads",
+		".",
+		NULL);
+	die("Failed to start receive-pack");
+}
+
+static struct service_cmd {
+	const char *method;
+	const char *pattern;
+	void (*imp)(char *);
+} services[] = {
+	{"GET", "/info/refs$", do_GET_info_refs},
+	{"GET", "/objects/info/packs", do_GET_info_packs},
+
+	{"GET", "/HEAD$", do_GET_any_file},
+	{"GET", "/objects/../.{38}$", do_GET_any_file},
+	{"GET", "/objects/pack/pack-[^/]*$", do_GET_any_file},
+	{"GET", "/objects/info/[^/]*$", do_GET_any_file},
+
+	{"POST", "/receive-pack", do_POST_receive_pack}
+};
+
+int main(int argc, char **argv)
+{
+	char *input_method = getenv("REQUEST_METHOD");
+	char *dir = getenv("PATH_TRANSLATED");
+	struct service_cmd *cmd = NULL;
+	char *cmd_arg = NULL;
+	int i;
+
+	if (!input_method)
+		die("No REQUEST_METHOD from server");
+	if (!strcmp(input_method, "HEAD"))
+		input_method = "GET";
+
+	if (!dir)
+		die("No PATH_TRANSLATED from server");
+
+	for (i = 0; i < ARRAY_SIZE(services); i++) {
+		struct service_cmd *c = &services[i];
+		regex_t re;
+		regmatch_t out[1];
+
+		if (strcmp(input_method, c->method))
+			continue;
+		if (regcomp(&re, c->pattern, REG_EXTENDED))
+			die("Bogus re in service table: %s", c->pattern);
+		if (!regexec(&re, dir, 2, out, 0)) {
+			size_t n = out[0].rm_eo - out[0].rm_so;
+			cmd = c;
+			cmd_arg = xmalloc(n);
+			strncpy(cmd_arg, dir + out[0].rm_so + 1, n);
+			cmd_arg[n] = 0;
+			dir[out[0].rm_so] = 0;
+			break;
+		}
+		regfree(&re);
+	}
+
+	if (!cmd)
+		invalid_request("Unsupported query request");
+
+	setup_path();
+	if (!enter_repo(dir, 0))
+		invalid_request("Not a Git repository");
+
+	cmd->imp(cmd_arg);
+	return 0;
+}
-- 
1.6.0.rc1.221.g9ae23
