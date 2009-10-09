From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH 2/4] Git-aware CGI to provide dumb HTTP transport
Date: Thu,  8 Oct 2009 22:22:46 -0700
Message-ID: <1255065768-10428-3-git-send-email-spearce@spearce.org>
References: <1255065768-10428-1-git-send-email-spearce@spearce.org>
 <1255065768-10428-2-git-send-email-spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 07:26:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mw80D-0001sK-Si
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 07:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189AbZJIFXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 01:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbZJIFXb
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 01:23:31 -0400
Received: from george.spearce.org ([209.20.77.23]:37232 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbZJIFX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 01:23:28 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 51BBB3821F; Fri,  9 Oct 2009 05:22:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 63C3D381FF
	for <git@vger.kernel.org>; Fri,  9 Oct 2009 05:22:49 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.rc3.193.gdf7a
In-Reply-To: <1255065768-10428-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129733>

The git-http-backend CGI can be configured into any Apache server
using ScriptAlias, such as with the following configuration:

  LoadModule cgi_module /usr/libexec/apache2/mod_cgi.so
  LoadModule alias_module /usr/libexec/apache2/mod_alias.so
  ScriptAlias /git/ /usr/libexec/git-core/git-http-backend/

Repositories are accessed via the translated PATH_INFO.

The CGI is backwards compatible with the dumb client, allowing all
older HTTP clients to continue to download repositories which are
managed by the CGI.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .gitignore     |    1 +
 Makefile       |    1 +
 http-backend.c |  261 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 263 insertions(+), 0 deletions(-)
 create mode 100644 http-backend.c

diff --git a/.gitignore b/.gitignore
index 51a37b1..353d22f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -55,6 +55,7 @@ git-get-tar-commit-id
 git-grep
 git-hash-object
 git-help
+git-http-backend
 git-http-fetch
 git-http-push
 git-imap-send
diff --git a/Makefile b/Makefile
index dd3d520..c80fb56 100644
--- a/Makefile
+++ b/Makefile
@@ -361,6 +361,7 @@ PROGRAMS += git-show-index$X
 PROGRAMS += git-unpack-file$X
 PROGRAMS += git-upload-pack$X
 PROGRAMS += git-var$X
+PROGRAMS += git-http-backend$X
 
 # List built-in command $C whose implementation cmd_$C() is not in
 # builtin-$C.o but is linked in as part of some other command.
diff --git a/http-backend.c b/http-backend.c
new file mode 100644
index 0000000..39cfd25
--- /dev/null
+++ b/http-backend.c
@@ -0,0 +1,261 @@
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
+static char buffer[1024];
+
+static const char *http_date(unsigned long time)
+{
+	return show_date(time, 0, DATE_RFC2822);
+}
+
+static void format_write(const char *fmt, ...)
+{
+	va_list args;
+	unsigned n;
+
+	va_start(args, fmt);
+	n = vsnprintf(buffer, sizeof(buffer), fmt, args);
+	va_end(args);
+	if (n >= sizeof(buffer))
+		die("protocol error: impossibly long line");
+
+	safe_write(1, buffer, n);
+}
+
+static void write_status(unsigned code, const char *msg)
+{
+	format_write("Status: %u %s\r\n", code, msg);
+}
+
+static void write_header(const char *name, const char *value)
+{
+	format_write("%s: %s\r\n", name, value);
+}
+
+static void end_headers(void)
+{
+	safe_write(1, "\r\n", 2);
+}
+
+static void write_nocache(void)
+{
+	write_header("Expires", "Fri, 01 Jan 1980 00:00:00 GMT");
+	write_header("Pragma", "no-cache");
+	write_header("Cache-Control", "no-cache, max-age=0, must-revalidate");
+}
+
+static void write_cache_forever(void)
+{
+	unsigned long now = time(NULL);
+	write_header("Date", http_date(now));
+	write_header("Expires", http_date(now + 31536000));
+	write_header("Cache-Control", "public, max-age=31536000");
+}
+
+static NORETURN void not_found(const char *err, ...)
+{
+	va_list params;
+
+	write_status(404, "Not Found");
+	write_nocache();
+	end_headers();
+
+	va_start(params, err);
+	if (err && *err) {
+		vsnprintf(buffer, sizeof(buffer), err, params);
+		fprintf(stderr, "%s\n", buffer);
+	}
+	va_end(params);
+	exit(0);
+}
+
+static void write_file(const char *the_type, const char *name)
+{
+	const char *p = git_path("%s", name);
+	int fd;
+	struct stat sb;
+	uintmax_t remaining;
+
+	fd = open(p, O_RDONLY);
+	if (fd < 0)
+		not_found("Cannot open '%s': %s", p, strerror(errno));
+	if (fstat(fd, &sb) < 0)
+		die_errno("Cannot stat '%s'", p);
+	remaining = (uintmax_t)sb.st_size;
+
+	write_header(content_type, the_type);
+	write_header("Last-Modified", http_date(sb.st_mtime));
+	format_write("Content-Length: %" PRIuMAX "\r\n", remaining);
+	end_headers();
+
+	while (remaining) {
+		ssize_t n = xread(fd, buffer, sizeof(buffer));
+		if (n < 0)
+			die_errno("Cannot read '%s'", p);
+		n = safe_write(1, buffer, n);
+		if (n <= 0)
+			break;
+	}
+	close(fd);
+}
+
+static void get_text_file(char *name)
+{
+	write_nocache();
+	write_file("text/plain; charset=utf-8", name);
+}
+
+static void get_loose_object(char *name)
+{
+	write_cache_forever();
+	write_file("application/x-git-loose-object", name);
+}
+
+static void get_pack_file(char *name)
+{
+	write_cache_forever();
+	write_file("application/x-git-packed-objects", name);
+}
+
+static void get_idx_file(char *name)
+{
+	write_cache_forever();
+	write_file("application/x-git-packed-objects-toc", name);
+}
+
+static int show_text_ref(const char *name, const unsigned char *sha1,
+	int flag, void *cb_data)
+{
+	struct object *o = parse_object(sha1);
+	if (!o)
+		return 0;
+
+	format_write("%s\t%s\n", sha1_to_hex(sha1), name);
+	if (o->type == OBJ_TAG) {
+		o = deref_tag(o, name, 0);
+		if (!o)
+			return 0;
+		format_write("%s\t%s^{}\n", sha1_to_hex(o->sha1), name);
+	}
+
+	return 0;
+}
+
+static void get_info_refs(char *arg)
+{
+	write_nocache();
+	write_header(content_type, "text/plain; charset=utf-8");
+	end_headers();
+
+	for_each_ref(show_text_ref, NULL);
+}
+
+static void get_info_packs(char *arg)
+{
+	size_t objdirlen = strlen(get_object_directory());
+	struct packed_git *p;
+
+	write_nocache();
+	write_header(content_type, "text/plain; charset=utf-8");
+	end_headers();
+
+	prepare_packed_git();
+	for (p = packed_git; p; p = p->next) {
+		if (!p->pack_local)
+			continue;
+		format_write("P %s\n", p->pack_name + objdirlen + 6);
+	}
+	safe_write(1, "\n", 1);
+}
+
+static NORETURN void die_webcgi(const char *err, va_list params)
+{
+	write_status(500, "Internal Server Error");
+	write_nocache();
+	end_headers();
+
+	vsnprintf(buffer, sizeof(buffer), err, params);
+	fprintf(stderr, "fatal: %s\n", buffer);
+	exit(0);
+}
+
+static struct service_cmd {
+	const char *method;
+	const char *pattern;
+	void (*imp)(char *);
+} services[] = {
+	{"GET", "/HEAD$", get_text_file},
+	{"GET", "/info/refs$", get_info_refs},
+	{"GET", "/objects/info/packs$", get_info_packs},
+	{"GET", "/objects/info/[^/]*$", get_text_file},
+	{"GET", "/objects/[0-9a-f]{2}/[0-9a-f]{38}$", get_loose_object},
+	{"GET", "/objects/pack/pack-[0-9a-f]{40}\\.pack$", get_pack_file},
+	{"GET", "/objects/pack/pack-[0-9a-f]{40}\\.idx$", get_idx_file}
+};
+
+int main(int argc, char **argv)
+{
+	char *dir = getenv("PATH_TRANSLATED");
+	char *input_method = getenv("REQUEST_METHOD");
+	struct service_cmd *cmd = NULL;
+	char *cmd_arg = NULL;
+	int i;
+
+	set_die_routine(die_webcgi);
+
+	if (!dir)
+		die("No PATH_TRANSLATED from server");
+	if (!input_method)
+		die("No REQUEST_METHOD from server");
+	if (!strcmp(input_method, "HEAD"))
+		input_method = "GET";
+
+	for (i = 0; i < ARRAY_SIZE(services); i++) {
+		struct service_cmd *c = &services[i];
+		regex_t re;
+		regmatch_t out[1];
+
+		if (regcomp(&re, c->pattern, REG_EXTENDED))
+			die("Bogus regex in service table: %s", c->pattern);
+		if (!regexec(&re, dir, 1, out, 0)) {
+			size_t n = out[0].rm_eo - out[0].rm_so;
+
+			if (strcmp(input_method, c->method)) {
+				const char *proto = getenv("SERVER_PROTOCOL");
+				if (proto && !strcmp(proto, "HTTP/1.1"))
+					write_status(405, "Method Not Allowed");
+				else
+					write_status(400, "Bad Request");
+				write_nocache();
+				end_headers();
+				return 0;
+			}
+
+			cmd = c;
+			cmd_arg = xmalloc(n);
+			strncpy(cmd_arg, dir + out[0].rm_so + 1, n);
+			cmd_arg[n] = '\0';
+			dir[out[0].rm_so] = 0;
+			break;
+		}
+		regfree(&re);
+	}
+
+	if (!cmd)
+		not_found("Request not supported: '%s'", dir);
+
+	setup_path();
+	if (!enter_repo(dir, 0))
+		not_found("Not a git repository: '%s'", dir);
+
+	cmd->imp(cmd_arg);
+	return 0;
+}
-- 
1.6.5.rc3.193.gdf7a
