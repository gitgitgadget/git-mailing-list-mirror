From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH v4 13/26] Git-aware CGI to provide dumb HTTP transport
Date: Wed, 28 Oct 2009 17:00:35 -0700
Message-ID: <1256774448-7625-14-git-send-email-spearce@spearce.org>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 01:02:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3ISt-0000kN-Hy
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 01:02:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756019AbZJ2ABq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 20:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755802AbZJ2AA4
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 20:00:56 -0400
Received: from george.spearce.org ([209.20.77.23]:36243 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755585AbZJ2AAw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 20:00:52 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 963673826E; Thu, 29 Oct 2009 00:00:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id E16C438215
	for <git@vger.kernel.org>; Thu, 29 Oct 2009 00:00:52 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.2.181.gd6f41
In-Reply-To: <1256774448-7625-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131534>

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
 .gitignore                         |    1 +
 Documentation/git-http-backend.txt |  105 +++++++++++++
 Makefile                           |    1 +
 http-backend.c                     |  290 ++++++++++++++++++++++++++++++++++++
 4 files changed, 397 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-http-backend.txt
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
diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
new file mode 100644
index 0000000..867675f
--- /dev/null
+++ b/Documentation/git-http-backend.txt
@@ -0,0 +1,105 @@
+git-http-backend(1)
+===================
+
+NAME
+----
+git-http-backend - Server side implementation of Git over HTTP
+
+SYNOPSIS
+--------
+[verse]
+'git-http-backend'
+
+DESCRIPTION
+-----------
+A simple CGI program to serve the contents of a Git repository to Git
+clients accessing the repository over http:// and https:// protocols.
+
+By default, only the `upload-pack` service is enabled, which serves
+'git-fetch-pack' and 'git-ls-remote' clients, which are invoked from
+'git-fetch', 'git-pull', and 'git-clone'.
+
+This is ideally suited for read-only updates, i.e., pulling from
+git repositories.
+
+URL TRANSLATION
+---------------
+'git-http-backend' relies on the invoking web server to perform
+URL to path translation, and store the repository path into the
+PATH_TRANSLATED environment variable.  Most web servers will do
+this translation automatically, resolving the suffix after the
+CGI name relative to the server's document root.
+
+EXAMPLES
+--------
+
+Apache 2.x::
+	To serve all Git repositories contained within the '/git/'
+	subdirectory of the DocumentRoot, ensure mod_cgi and
+	mod_alias are enabled, and create a ScriptAlias to the CGI:
++
+----------------------------------------------------------------
+ScriptAlias /git/ /usr/libexec/git-core/git-http-backend/git/
+
+<Directory /usr/libexec/git-core>
+	Options None
+</Directory>
+<Files /usr/libexec/git-core/git-http-backend>
+	Options ExecCGI
+</Files>
+----------------------------------------------------------------
++
+To require authentication for reads, use a Directory
+directive around the repository, or one of its parent directories:
++
+----------------------------------------------------------------
+<Directory /var/www/git/private>
+	AuthType Basic
+	AuthName "Private Git Access"
+	Require group committers
+	...
+</Directory>
+----------------------------------------------------------------
+
+Accelerated static Apache 2.x::
+	Similar to the above, but Apache can be used to return static
+	files that are stored on disk.	On many systems this may
+	be more efficient as Apache can ask the kernel to copy the
+	file contents from the file system directly to the network:
++
+----------------------------------------------------------------
+DocumentRoot /var/www
+
+ScriptAlias /git/        /usr/libexec/git-core/git-http-backend/git/
+Alias       /git_static/ /var/www/git/
+
+RewriteEngine on
+RewriteRule ^/git/(.*/objects/[0-9a-f]{2}/[0-9a-f]{38})$    /git_static/$1 [PT]
+RewriteRule ^/git/(.*/objects/pack/pack-[0-9a-f]{40}.pack)$ /git_static/$1 [PT]
+RewriteRule ^/git/(.*/objects/pack/pack-[0-9a-f]{40}.idx)$  /git_static/$1 [PT]
+----------------------------------------------------------------
+
+
+ENVIRONMENT
+-----------
+'git-http-backend' relies upon the CGI environment variables set
+by the invoking web server, including:
+
+* PATH_TRANSLATED
+* REMOTE_USER
+* REMOTE_ADDR
+* CONTENT_TYPE
+* QUERY_STRING
+* REQUEST_METHOD
+
+Author
+------
+Written by Shawn O. Pearce <spearce@spearce.org>.
+
+Documentation
+--------------
+Documentation by Shawn O. Pearce <spearce@spearce.org>.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index fea237b..271c290 100644
--- a/Makefile
+++ b/Makefile
@@ -365,6 +365,7 @@ PROGRAMS += git-show-index$X
 PROGRAMS += git-unpack-file$X
 PROGRAMS += git-upload-pack$X
 PROGRAMS += git-var$X
+PROGRAMS += git-http-backend$X
 
 # List built-in command $C whose implementation cmd_$C() is not in
 # builtin-$C.o but is linked in as part of some other command.
diff --git a/http-backend.c b/http-backend.c
new file mode 100644
index 0000000..374f60d
--- /dev/null
+++ b/http-backend.c
@@ -0,0 +1,290 @@
+#include "cache.h"
+#include "refs.h"
+#include "pkt-line.h"
+#include "object.h"
+#include "tag.h"
+#include "exec_cmd.h"
+
+static const char content_type[] = "Content-Type";
+static const char content_length[] = "Content-Length";
+static const char last_modified[] = "Last-Modified";
+
+static void format_write(int fd, const char *fmt, ...)
+{
+	static char buffer[1024];
+
+	va_list args;
+	unsigned n;
+
+	va_start(args, fmt);
+	n = vsnprintf(buffer, sizeof(buffer), fmt, args);
+	va_end(args);
+	if (n >= sizeof(buffer))
+		die("protocol error: impossibly long line");
+
+	safe_write(fd, buffer, n);
+}
+
+static void http_status(unsigned code, const char *msg)
+{
+	format_write(1, "Status: %u %s\r\n", code, msg);
+}
+
+static void hdr_str(const char *name, const char *value)
+{
+	format_write(1, "%s: %s\r\n", name, value);
+}
+
+static void hdr_int(const char *name, size_t value)
+{
+	format_write(1, "%s: %" PRIuMAX "\r\n", name, value);
+}
+
+static void hdr_date(const char *name, unsigned long when)
+{
+	const char *value = show_date(when, 0, DATE_RFC2822);
+	hdr_str(name, value);
+}
+
+static void hdr_nocache(void)
+{
+	hdr_str("Expires", "Fri, 01 Jan 1980 00:00:00 GMT");
+	hdr_str("Pragma", "no-cache");
+	hdr_str("Cache-Control", "no-cache, max-age=0, must-revalidate");
+}
+
+static void hdr_cache_forever(void)
+{
+	unsigned long now = time(NULL);
+	hdr_date("Date", now);
+	hdr_date("Expires", now + 31536000);
+	hdr_str("Cache-Control", "public, max-age=31536000");
+}
+
+static void end_headers(void)
+{
+	safe_write(1, "\r\n", 2);
+}
+
+static NORETURN void not_found(const char *err, ...)
+{
+	va_list params;
+
+	http_status(404, "Not Found");
+	hdr_nocache();
+	end_headers();
+
+	va_start(params, err);
+	if (err && *err)
+		vfprintf(stderr, err, params);
+	va_end(params);
+	exit(0);
+}
+
+static void send_strbuf(const char *type, struct strbuf *buf)
+{
+	hdr_int(content_length, buf->len);
+	hdr_str(content_type, type);
+	end_headers();
+	safe_write(1, buf->buf, buf->len);
+}
+
+static void send_file(const char *the_type, const char *name)
+{
+	const char *p = git_path("%s", name);
+	size_t buf_alloc = 8192;
+	char *buf = xmalloc(buf_alloc);
+	int fd;
+	struct stat sb;
+	size_t size;
+
+	fd = open(p, O_RDONLY);
+	if (fd < 0)
+		not_found("Cannot open '%s': %s", p, strerror(errno));
+	if (fstat(fd, &sb) < 0)
+		die_errno("Cannot stat '%s'", p);
+
+	size = xsize_t(sb.st_size);
+
+	hdr_int(content_length, size);
+	hdr_str(content_type, the_type);
+	hdr_date(last_modified, sb.st_mtime);
+	end_headers();
+
+	while (size) {
+		ssize_t n = xread(fd, buf, buf_alloc);
+		if (n < 0)
+			die_errno("Cannot read '%s'", p);
+		if (!n)
+			break;
+		safe_write(1, buf, n);
+	}
+	close(fd);
+	free(buf);
+}
+
+static void get_text_file(char *name)
+{
+	hdr_nocache();
+	send_file("text/plain", name);
+}
+
+static void get_loose_object(char *name)
+{
+	hdr_cache_forever();
+	send_file("application/x-git-loose-object", name);
+}
+
+static void get_pack_file(char *name)
+{
+	hdr_cache_forever();
+	send_file("application/x-git-packed-objects", name);
+}
+
+static void get_idx_file(char *name)
+{
+	hdr_cache_forever();
+	send_file("application/x-git-packed-objects-toc", name);
+}
+
+static int show_text_ref(const char *name, const unsigned char *sha1,
+	int flag, void *cb_data)
+{
+	struct strbuf *buf = cb_data;
+	struct object *o = parse_object(sha1);
+	if (!o)
+		return 0;
+
+	strbuf_addf(buf, "%s\t%s\n", sha1_to_hex(sha1), name);
+	if (o->type == OBJ_TAG) {
+		o = deref_tag(o, name, 0);
+		if (!o)
+			return 0;
+		strbuf_addf(buf, "%s\t%s^{}\n", sha1_to_hex(o->sha1), name);
+	}
+	return 0;
+}
+
+static void get_info_refs(char *arg)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	for_each_ref(show_text_ref, &buf);
+	hdr_nocache();
+	send_strbuf("text/plain", &buf);
+	strbuf_release(&buf);
+}
+
+static void get_info_packs(char *arg)
+{
+	size_t objdirlen = strlen(get_object_directory());
+	struct strbuf buf = STRBUF_INIT;
+	struct packed_git *p;
+	size_t cnt = 0;
+
+	prepare_packed_git();
+	for (p = packed_git; p; p = p->next) {
+		if (p->pack_local)
+			cnt++;
+	}
+
+	strbuf_grow(&buf, cnt * 53 + 2);
+	for (p = packed_git; p; p = p->next) {
+		if (p->pack_local)
+			strbuf_addf(&buf, "P %s\n", p->pack_name + objdirlen + 6);
+	}
+	strbuf_addch(&buf, '\n');
+
+	hdr_nocache();
+	send_strbuf("text/plain; charset=utf-8", &buf);
+	strbuf_release(&buf);
+}
+
+static NORETURN void die_webcgi(const char *err, va_list params)
+{
+	char buffer[1000];
+
+	http_status(500, "Internal Server Error");
+	hdr_nocache();
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
+	{"GET", "/objects/info/alternates$", get_text_file},
+	{"GET", "/objects/info/http-alternates$", get_text_file},
+	{"GET", "/objects/info/packs$", get_info_packs},
+	{"GET", "/objects/info/[^/]*$", get_text_file},
+	{"GET", "/objects/[0-9a-f]{2}/[0-9a-f]{38}$", get_loose_object},
+	{"GET", "/objects/pack/pack-[0-9a-f]{40}\\.pack$", get_pack_file},
+	{"GET", "/objects/pack/pack-[0-9a-f]{40}\\.idx$", get_idx_file}
+};
+
+int main(int argc, char **argv)
+{
+	char *method = getenv("REQUEST_METHOD");
+	char *dir = getenv("PATH_TRANSLATED");
+	struct service_cmd *cmd = NULL;
+	char *cmd_arg = NULL;
+	int i;
+
+	git_extract_argv0_path(argv[0]);
+	set_die_routine(die_webcgi);
+
+	if (!method)
+		die("No REQUEST_METHOD from server");
+	if (!strcmp(method, "HEAD"))
+		method = "GET";
+	if (!dir)
+		die("No PATH_TRANSLATED from server");
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
+			if (strcmp(method, c->method)) {
+				const char *proto = getenv("SERVER_PROTOCOL");
+				if (proto && !strcmp(proto, "HTTP/1.1"))
+					http_status(405, "Method Not Allowed");
+				else
+					http_status(400, "Bad Request");
+				hdr_nocache();
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
1.6.5.2.181.gd6f41
