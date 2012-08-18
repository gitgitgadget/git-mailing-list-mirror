From: "James R. McKaskill" <james@foobar.co.nz>
Subject: [RFC 1/2] add svn-fetch/push
Date: Sat, 18 Aug 2012 13:39:15 -0400
Message-ID: <1345311556-70767-2-git-send-email-james@foobar.co.nz>
References: <1345311556-70767-1-git-send-email-james@foobar.co.nz>
Cc: "James R. McKaskill" <james@foobar.co.nz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 18 19:39:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2n06-0003tR-EA
	for gcvg-git-2@plane.gmane.org; Sat, 18 Aug 2012 19:39:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191Ab2HRRjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Aug 2012 13:39:46 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37744 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667Ab2HRRjj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2012 13:39:39 -0400
Received: by ialo24 with SMTP id o24so1340032ial.19
        for <git@vger.kernel.org>; Sat, 18 Aug 2012 10:39:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=6U0B9AqfG5NT2foBLDYaLSOJZBYtno2lzE6/aNoSc18=;
        b=ef6KUD1xcY1ZbO/Z/uap5bl0c3ZtW6KGTEUJ5OHYAYg2mKxUVKVX+nNGhZS9y14WL8
         ND9PWXrgBkCxtwblG6T28HCAgGdEu7uThqc+TC6vZzN3oFLkxKjIiBBIxXFk/JonpzEn
         LeiwQCVMrULSL/sC3oT7XNsRPTHFuy/gLUclWREsf+z9x9GUGX0qc1MfWvcNVZl2lJyV
         4UD77i3jr+uliGaFlPCrLEnR5iybRUE39JSxNPif1nb5Znk/MZ6cOnTItJzTkQQrLqR4
         pmZgC9QWv/dEHG5di0T+/vB0T4en48nQchfCMgULA+xTcIWsaL7djOkzoZmTwraGW6pJ
         g/rw==
Received: by 10.42.92.17 with SMTP id r17mr7158232icm.39.1345311578263;
        Sat, 18 Aug 2012 10:39:38 -0700 (PDT)
Received: from aeir.local.net ([155.63.0.254])
        by mx.google.com with ESMTPS id gy9sm8037271igc.1.2012.08.18.10.39.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 18 Aug 2012 10:39:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345311556-70767-1-git-send-email-james@foobar.co.nz>
X-Gm-Message-State: ALoCoQke5vcnQL6GeB2rBvyXfZxXnQsO43/YK3T3NxF/JQdu1iGhbueFPkO8Ha1Pl16POLr0nNLm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203684>

From: "James R. McKaskill" <james@foobar.co.nz>


Signed-off-by: James R. McKaskill <james@foobar.co.nz>
---
 .gitignore          |    3 +
 Makefile            |    2 +
 builtin.h           |    2 +
 builtin/svn-fetch.c | 3257 +++++++++++++++++++++++++++++++++++++++++++++++++++
 command-list.txt    |    2 +
 git.c               |    2 +
 svn-sync.sh         |  150 +++
 7 files changed, 3418 insertions(+)
 create mode 100644 builtin/svn-fetch.c
 create mode 100755 svn-sync.sh

diff --git a/.gitignore b/.gitignore
index bb5c91e..8e9cd4b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -153,6 +153,8 @@
 /git-stripspace
 /git-submodule
 /git-svn
+/git-svn-fetch
+/git-svn-push
 /git-symbolic-ref
 /git-tag
 /git-tar-tree
@@ -233,3 +235,4 @@
 *.pdb
 /Debug/
 /Release/
+*.swp
diff --git a/Makefile b/Makefile
index 6b0c961..e28e224 100644
--- a/Makefile
+++ b/Makefile
@@ -523,6 +523,7 @@ BUILT_INS += git-show$X
 BUILT_INS += git-stage$X
 BUILT_INS += git-status$X
 BUILT_INS += git-whatchanged$X
+BUILT_INS += git-svn-push$X
 
 # what 'all' will build and 'install' will install in gitexecdir,
 # excluding programs for built-in commands
@@ -894,6 +895,7 @@ BUILTIN_OBJS += builtin/shortlog.o
 BUILTIN_OBJS += builtin/show-branch.o
 BUILTIN_OBJS += builtin/show-ref.o
 BUILTIN_OBJS += builtin/stripspace.o
+BUILTIN_OBJS += builtin/svn-fetch.o
 BUILTIN_OBJS += builtin/symbolic-ref.o
 BUILTIN_OBJS += builtin/tag.o
 BUILTIN_OBJS += builtin/tar-tree.o
diff --git a/builtin.h b/builtin.h
index ba6626b..71fe517 100644
--- a/builtin.h
+++ b/builtin.h
@@ -131,6 +131,8 @@ extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
 extern int cmd_status(int argc, const char **argv, const char *prefix);
 extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
+extern int cmd_svn_fetch(int argc, const char **argv, const char* prefix);
+extern int cmd_svn_push(int argc, const char **argv, const char* prefix);
 extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_tag(int argc, const char **argv, const char *prefix);
 extern int cmd_tar_tree(int argc, const char **argv, const char *prefix);
diff --git a/builtin/svn-fetch.c b/builtin/svn-fetch.c
new file mode 100644
index 0000000..05ef85f
--- /dev/null
+++ b/builtin/svn-fetch.c
@@ -0,0 +1,3257 @@
+#include "git-compat-util.h"
+#include "parse-options.h"
+#include "gettext.h"
+#include "cache.h"
+#include "cache-tree.h"
+#include "refs.h"
+#include "unpack-trees.h"
+#include "commit.h"
+#include "tag.h"
+#include "diff.h"
+#include "revision.h"
+#include "diffcore.h"
+#include "run-command.h"
+
+#include <openssl/hmac.h>
+#include <openssl/evp.h>
+#include <openssl/md5.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdarg.h>
+
+static const char *svnuser;
+static const char *trunk;
+static const char *branches;
+static const char *tags;
+static const char *remotedir;
+static const char *remoteheads;
+static const char *remotetags;
+static const char *trunkref = "master";
+static int last_revision = INT_MAX;
+static int verbose;
+static int push_from_stdin;
+static int svnfdc = 1;
+static int leave_remote;
+static int svnfd;
+static int inner;
+static int pause_between_commits;
+static const char* url;
+static enum eol svn_eol = EOL_UNSET;
+
+#define FETCH_AT_ONCE 1000
+
+static const char* const builtin_svn_fetch_usage[] = {
+	"git svn-fetch [options]",
+	NULL,
+};
+
+static struct option builtin_svn_fetch_options[] = {
+	OPT_STRING(0, "user", &svnuser, "user", "svn username"),
+	OPT_BOOLEAN('v', "verbose", &verbose, "verbose logging of all svn traffic"),
+	OPT_INTEGER('r', "revision", &last_revision, "revisions to fetch up to"),
+	OPT_INTEGER('c', "connections", &svnfdc, "number of concurrent connections"),
+	OPT_BOOLEAN(0, "inner", &inner, "internal"),
+	OPT_END()
+};
+
+static const char* const builtin_svn_push_usage[] = {
+	"git svn-push [options] <ref> <from commit> <to commit>",
+	"git svn-push [options] --stdin",
+	NULL,
+};
+
+static struct option builtin_svn_push_options[] = {
+	OPT_STRING(0, "user", &svnuser, "user", "default svn username"),
+	OPT_BOOLEAN('v', "verbose", &verbose, "verbose logging of all svn traffic"),
+	OPT_BOOLEAN(0, "stdin", &push_from_stdin, "read refs to update from stdin"),
+	OPT_END()
+};
+
+static int config(const char *var, const char *value, void *dummy) {
+	if (!strcmp(var, "svn.trunk")) {
+		return git_config_string(&trunk, var, value);
+	}
+	if (!strcmp(var, "svn.branches")) {
+		return git_config_string(&branches, var, value);
+	}
+	if (!strcmp(var, "svn.tags")) {
+		return git_config_string(&tags, var, value);
+	}
+	if (!strcmp(var, "svn.user")) {
+		return git_config_string(&svnuser, var, value);
+	}
+	if (!strcmp(var, "svn.url")) {
+		return git_config_string(&url, var, value);
+	}
+	if (!strcmp(var, "svn.remote")) {
+		return git_config_string(&remotedir, var, value);
+	}
+	if (!strcmp(var, "svn.trunkref")) {
+		return git_config_string(&trunkref, var, value);
+	}
+	if (!strcmp(var, "svn.eol")) {
+		if (value && !strcasecmp(value, "lf"))
+			svn_eol = EOL_LF;
+		else if (value && !strcasecmp(value, "crlf"))
+			svn_eol = EOL_CRLF;
+		else if (value && !strcasecmp(value, "native"))
+			svn_eol = EOL_NATIVE;
+		else
+			svn_eol = EOL_UNSET;
+		return 0;
+	}
+	return git_default_config(var, value, dummy);
+}
+
+#ifndef min
+#define min(a,b) ((a) < (b) ? (a) : (b))
+#endif
+
+#ifndef max
+#define max(a,b) ((a) < (b) ? (b) : (a))
+#endif
+
+struct inbuffer {
+	char buf[4096];
+	int b, e;
+};
+static struct inbuffer* inbuf;
+
+static int readc() {
+	if (inbuf->b == inbuf->e) {
+		inbuf->b = 0;
+		inbuf->e = xread(svnfd, inbuf->buf, sizeof(inbuf->buf));
+		if (inbuf->e <= 0) return EOF;
+	}
+
+	return inbuf->buf[inbuf->b++];
+}
+
+static void unreadc() {
+	inbuf->b--;
+}
+
+static ssize_t read_svn(void* p, size_t n) {
+	/* big reads we may as well read directly into the target */
+	if (inbuf->e == inbuf->b && n >= sizeof(inbuf->buf) / 2) {
+		return xread(svnfd, p, n);
+
+	} else if (inbuf->e == inbuf->b) {
+		inbuf->b = 0;
+		inbuf->e = xread(svnfd, inbuf->buf, sizeof(inbuf->buf));
+		if (inbuf->e <= 0) return inbuf->e;
+	}
+
+	n = min(n, inbuf->e - inbuf->b);
+	memcpy(p, inbuf->buf + inbuf->b, n);
+	inbuf->b += n;
+	return n;
+}
+
+static const char hex[] = "0123456789abcdef";
+#define MAX_PRINT_LEN 64
+
+static int print_ascii(const void* p, int n, int maxoutput) {
+	int i;
+	int printed = 0;
+	const unsigned char* v = p;
+
+	for (i = 0; i < n && printed < maxoutput; i++) {
+		int ch = v[i];
+
+		if (' ' <= ch && ch < 0x7F && ch != '\\') {
+			putc(v[i], stderr);
+			printed++;
+
+		} else if (ch == '\n') {
+			putc('\\', stderr);
+			putc('n', stderr);
+			printed += 2;
+
+		} else if (ch == '\r') {
+			putc('\\', stderr);
+			putc('r', stderr);
+			printed += 2;
+
+		} else if (ch == '\t') {
+			putc('\\', stderr);
+			putc('t', stderr);
+			printed += 2;
+
+		} else if (ch == '\\') {
+			putc('\\', stderr);
+			putc('\\', stderr);
+			printed += 2;
+
+		} else {
+			putc('\\', stderr);
+			putc('x', stderr);
+			putc(hex[ch >> 4], stderr);
+			putc(hex[ch & 0x0F], stderr);
+			printed += 4;
+		}
+	}
+
+	if (printed >= maxoutput) {
+		fprintf(stderr, "...");
+	}
+
+	return printed;
+}
+
+static int get_md5_hex(const char *hex, unsigned char *sha1)
+{
+	int i;
+	for (i = 0; i < 16; i++) {
+		unsigned int val;
+		/*
+		 * hex[1]=='\0' is caught when val is checked below,
+		 * but if hex[0] is NUL we have to avoid reading
+		 * past the end of the string:
+		 */
+		if (!hex[0])
+			return -1;
+		val = (hexval(hex[0]) << 4) | hexval(hex[1]);
+		if (val & ~0xff)
+			return -1;
+		*sha1++ = val;
+		hex += 2;
+	}
+	return 0;
+}
+
+static const char* md5_to_hex(const unsigned char* md5) {
+	static int bufno;
+	static char hexbuffer[4][50];
+	char *buffer = hexbuffer[3 & ++bufno], *buf = buffer;
+	int i;
+
+	for (i = 0; i < 16; i++) {
+		unsigned int val = *md5++;
+		*buf++ = hex[val >> 4];
+		*buf++ = hex[val & 0xf];
+	}
+	*buf = '\0';
+
+	return buffer;
+}
+
+__attribute__((format (printf,1,2)))
+static void sendf(const char* fmt, ...);
+
+static int verbosetxnl = 1;
+
+static void sendf(const char* fmt, ...) {
+	static struct strbuf out = STRBUF_INIT;
+	va_list ap;
+	va_start(ap, fmt);
+	strbuf_reset(&out);
+	strbuf_vaddf(&out, fmt, ap);
+
+	if (verbose) {
+		if (verbosetxnl) {
+			fputc('+', stderr);
+		}
+		verbosetxnl = out.len && out.buf[out.len-1] == '\n';
+		print_ascii(out.buf, out.len - verbosetxnl, INT_MAX);
+		if (verbosetxnl) {
+			fputc('\n', stderr);
+		}
+	}
+
+	if (write_in_full(svnfd, out.buf, out.len) != out.len) {
+		die_errno("write");
+	}
+}
+
+/* returns -1 if it can't find a number */
+static ssize_t read_number() {
+	ssize_t v;
+
+	for (;;) {
+		int ch = readc();
+		if ('0' <= ch && ch <= '9') {
+			v = ch - '0';
+			break;
+		} else if (ch != ' ' && ch != '\n') {
+			unreadc();
+			return -1;
+		}
+	}
+
+	for (;;) {
+		int ch = readc();
+		if (ch < '0' || ch > '9') {
+			unreadc();
+			if (verbose) fprintf(stderr, " %d", (int) v);
+			return v;
+		}
+
+		if (v > INT64_MAX/10) {
+			die(_("number too big"));
+		} else {
+			v = 10*v + (ch - '0');
+		}
+	}
+}
+
+/* returns -1 if it can't find a list */
+static int read_list() {
+	for (;;) {
+		int ch = readc();
+		if (ch == '(') {
+			if (verbose) fprintf(stderr, " (");
+			return 0;
+		} else if (ch != ' ' && ch != '\n') {
+			unreadc();
+			return -1;
+		}
+	}
+}
+
+/* returns 0 if the list is missing or empty (and skips over it), 1 if
+ * its present and has values */
+static int have_optional() {
+	if (read_list()) return 0;
+	for (;;) {
+		int ch = readc();
+		if (ch == ')') {
+			if (verbose) fprintf(stderr, " )");
+			return 0;
+		} else if (ch != ' ' && ch != '\n') {
+			unreadc();
+			return 1;
+		}
+	}
+}
+
+/* returns NULL if it can't find an atom, string only valid until next
+ * call to read_word, not thread-safe */
+static const char *read_word() {
+	static char buf[256];
+	int bufsz = 0;
+	int ch;
+
+	for (;;) {
+		ch = readc();
+		if (('a' <= ch && ch <= 'z') || ('A' <= ch && ch <= 'Z')) {
+			break;
+		} else if (ch != ' ' && ch != '\n') {
+			unreadc();
+			return NULL;
+		}
+	}
+
+	while (('a' <= ch && ch <= 'z') || ('A' <= ch && ch <= 'Z')
+			|| ('0' <= ch && ch <= '9')
+			|| ch == '-') {
+		if (bufsz >= sizeof(buf))
+			die(_("atom too long"));
+
+		buf[bufsz++] = ch;
+		ch = readc();
+	}
+
+	unreadc();
+	buf[bufsz] = '\0';
+	if (verbose) fprintf(stderr, " %s", buf);
+	return bufsz ? buf : NULL;
+}
+
+/* returns -1 if no string or an invalid string */
+static int read_string(struct strbuf* s) {
+	size_t i;
+	ssize_t n = read_number();
+	if (n < 0 || unsigned_add_overflows(s->len, (size_t) n))
+		return -1;
+	if (readc() != ':')
+		die(_("malformed string"));
+	if (verbose)
+		fprintf(stderr, ":");
+
+	strbuf_grow(s, s->len + n);
+
+	i = 0;
+	while (i < n) {
+		ssize_t r = read_svn(s->buf + s->len, n-i);
+		if (r < 0)
+			die_errno("read error");
+		if (r == 0)
+			die("short read");
+		strbuf_setlen(s, s->len + r);
+		i += r;
+	}
+
+	if (verbose) print_ascii(s->buf + s->len - n, n, MAX_PRINT_LEN);
+
+	return 0;
+}
+
+static int skip_string() {
+	struct strbuf buf = STRBUF_INIT;
+	int r = read_string(&buf);
+	strbuf_release(&buf);
+	return r;
+}
+
+static void read_end() {
+	int parens = 1;
+	while (parens > 0) {
+		int ch = readc();
+		if (ch == EOF)
+			die(_("socket close whilst looking for list close"));
+
+		if (ch == '(') {
+			if (verbose) fprintf(stderr, " (");
+			parens++;
+		} else if (ch == ')') {
+			if (verbose) fprintf(stderr, " )");
+			parens--;
+		} else if (ch == ' ' || ch == '\n') {
+			/* whitespace */
+		} else if ('0' <= ch && ch <= '9') {
+			/* number or string */
+			size_t n;
+			char buf[4096];
+			int toprint = verbose ? MAX_PRINT_LEN : 0;
+
+			unreadc();
+			n = read_number();
+
+			ch = readc();
+			if (ch != ':') {
+				/* number */
+				unreadc();
+				continue;
+			}
+
+			/* string */
+			if (verbose) fputc(':', stderr);
+			while (n) {
+				ssize_t r = read_svn(buf, min(n, sizeof(buf)));
+				if (r <= 0) die_errno("read");
+				if (toprint > 0) {
+					toprint -= print_ascii(buf, r, toprint);
+				}
+				n -= r;
+			}
+		} else {
+			unreadc();
+			if (!read_word())
+				die(_("unexpected character %c"), ch);
+		}
+	}
+}
+
+static const char* read_command() {
+	const char *cmd;
+
+	if (read_list()) goto err;
+
+	cmd = read_word();
+	if (!cmd) goto err;
+	if (read_list()) goto err;
+
+	return cmd;
+err:
+	die(_("malformed response"));
+}
+
+static void read_command_end() {
+	read_end();
+	read_end();
+	if (verbose) fprintf(stderr, "\n");
+}
+
+static void read_done() {
+	const char* s = read_word();
+	if (!s || strcmp(s, "done"))
+		die("unexpected failure");
+	if (verbose) fputc('\n', stderr);
+}
+
+static void read_success() {
+	const char* s = read_command();
+	if (strcmp(s, "success")) {
+		verbose = 1;
+		read_end();
+		die("unexpected failure");
+	}
+	read_command_end();
+}
+
+static void cram_md5(const char* user, const char* pass) {
+	const char *s;
+	unsigned char hash[16];
+	struct strbuf chlg = STRBUF_INIT;
+	HMAC_CTX hmac;
+
+	s = read_command();
+	if (strcmp(s, "step")) goto error;
+	if (read_string(&chlg)) goto error;
+
+	read_command_end();
+
+	HMAC_Init(&hmac, (unsigned char*) pass, strlen(pass), EVP_md5());
+	HMAC_Update(&hmac, (unsigned char*) chlg.buf, chlg.len);
+	HMAC_Final(&hmac, hash, NULL);
+	HMAC_CTX_cleanup(&hmac);
+
+	sendf("%d:%s %s\n", (int) (strlen(user) + 1 + 32), user, md5_to_hex(hash));
+
+	strbuf_release(&chlg);
+	return;
+
+error:
+	die(_("auth failed"));
+}
+
+static void read_name(struct strbuf* name) {
+	strbuf_reset(name);
+	if (read_string(name)) goto err;
+	if (name->buf[0] == '/') strbuf_remove(name, 0, 1);
+	if (memchr(name->buf, '\0', name->len)) goto err;
+	if (strstr(name->buf, "//")) goto err;
+	if (!strcmp(name->buf, "..")) goto err;
+	if (!strcmp(name->buf, ".")) goto err;
+	if (!prefixcmp(name->buf, "../")) goto err;
+	if (!prefixcmp(name->buf, "./")) goto err;
+	if (strstr(name->buf, "/../")) goto err;
+	if (strstr(name->buf, "/./")) goto err;
+	if (!suffixcmp(name->buf, "/..")) goto err;
+	if (!suffixcmp(name->buf, "/.")) goto err;
+
+	return;
+err:
+	die("invalid path name %s", name->buf);
+}
+
+static const char* cmt_to_hex(struct commit* c) {
+	return sha1_to_hex(c ? c->object.sha1 : null_sha1);
+}
+
+static const unsigned char* cmt_sha1(struct commit* c) {
+	return c ? c->object.sha1 : null_sha1;
+}
+
+static int parse_svnrev(struct commit* c) {
+	char* p = strstr(c->buffer, "\nrevision ");
+	if (!p) die("invalid svn commit %s", cmt_to_hex(c));
+	p += strlen("\nrevision ");
+	return atoi(p);
+}
+
+static void parse_svnpath(struct commit* c, struct strbuf* buf) {
+	char* e;
+	char* p = strstr(c->buffer, "\npath ");
+	if (!p) die("invalid svn commit %s", cmt_to_hex(c));
+	p += strlen("\npath ");
+	e = strchr(p, '\n');
+	if (!e) die("invalid svn commit %s", cmt_to_hex(c));
+	strbuf_add(buf, p, e-p);
+}
+
+static struct commit* svn_commit(struct commit* c) {
+	if (parse_commit(c) || !c->parents || !c->parents->item)
+		die("invalid svn commit %s", cmt_to_hex(c));
+	/* In the case of no git commit, but we have a previous svn
+	 * commit, the svn parent is repeated twice. That way we can
+	 * distinguish that case from a git commit but no svn commit */
+	if (c->parents->next && c->parents->item == c->parents->next->item) {
+		return NULL;
+	}
+	return c->parents->item;
+}
+
+static struct commit* svn_parent(struct commit* c) {
+	if (parse_commit(c) || !c->parents)
+		die("invalid svn commit %s", cmt_to_hex(c));
+	return c->parents->next ? c->parents->next->item : NULL;
+}
+
+struct svnref {
+	struct strbuf svn; /* svn root */
+	struct strbuf ref; /* svn ref path */
+	struct strbuf remote; /* remote ref path */
+
+	struct index_state git_index, svn_index;
+	struct tree *git_tree, *svn_tree;
+
+	unsigned int delete : 1;
+	unsigned int istag : 1;
+
+	struct commit* svncmt; /* current value of svn ref */
+	struct object* gitobj; /* current value of remote ref, may be tag or commit */
+	struct commit* parent; /* parent git commit */
+};
+
+static struct svnref** refs;
+static size_t refn, refalloc;
+
+static int is_in_dir(char* file, const char* dir, char** rel) {
+	size_t sz = strlen(dir);
+	if (strncmp(file, dir, sz)) return 0;
+	if (file[sz] && file[sz] != '/') return 0;
+	if (rel) *rel = file[sz] ? &file[sz+1] : &file[sz];
+	return 1;
+}
+
+#define TRUNK_REF 0
+#define BRANCH_REF 1
+#define TAG_REF 2
+
+static void add_refname(struct strbuf* buf, const char* name) {
+	while (*name) {
+		int ch = *(name++);
+		if (ch <= ' '
+			|| ch == 0x7F
+			|| ch == '~'
+			|| ch == '^'
+			|| ch == ':'
+			|| ch == '\\'
+			|| ch == '*'
+			|| ch == '?'
+			|| ch == '[') {
+			strbuf_addch(buf, '_');
+		} else {
+			strbuf_addch(buf, ch);
+		}
+	}
+}
+
+static void checkout_tree(struct index_state* idx, struct tree* t) {
+	struct tree_desc desc;
+	struct unpack_trees_options op;
+
+	if (!t) return;
+
+	if (parse_tree(t))
+		die("failed to checkout %s", sha1_to_hex(t->object.sha1));
+
+	init_tree_desc(&desc, t->buffer, t->size);
+
+	memset(&op, 0, sizeof(op));
+	op.src_index = idx;
+	op.dst_index = idx;
+	op.index_only = 1;
+
+	if (unpack_trees(1, &desc, &op))
+		die("failed to checkout %s", sha1_to_hex(t->object.sha1));
+}
+
+static struct index_state* git_index(struct svnref* r) {
+	checkout_tree(&r->git_index, r->git_tree);
+	r->git_tree = NULL;
+	return &r->git_index;
+}
+
+static struct index_state* svn_index(struct svnref* r) {
+	checkout_tree(&r->svn_index, r->svn_tree);
+	r->svn_tree = NULL;
+	return &r->svn_index;
+}
+
+static const unsigned char *idx_sha1(struct index_state* idx) {
+	if (!idx->cache_tree)
+		idx->cache_tree = cache_tree();
+	if (cache_tree_update(idx->cache_tree, idx->cache, idx->cache_nr, 0))
+		die("failed to update cache tree");
+
+	return idx->cache_tree->sha1;
+}
+
+static void checkout_svncmt(struct svnref* r, struct commit* svncmt) {
+	struct commit* gitcmt;
+
+	/* R (replace) log entries may already have content that
+	 * we need to clear first */
+
+	discard_index(&r->git_index);
+	discard_index(&r->svn_index);
+	r->git_tree = NULL;
+	r->svn_tree = NULL;
+
+	/* Note r->svncmt may not equal c if this creates a branch or
+	 * replaces an existing one. c will be the new source whereas
+	 * svncmt will continue to point to the old svn commit */
+
+	if (svncmt && parse_commit(svncmt))
+		die("invalid object %s", cmt_to_hex(svncmt));
+
+	r->svn_tree = svncmt ? svncmt->tree : NULL;
+	gitcmt = svncmt ? svn_commit(svncmt) : NULL;
+
+	if (gitcmt && parse_commit(gitcmt))
+		die("invalid object %s", cmt_to_hex(gitcmt));
+
+	r->git_tree = gitcmt ? gitcmt->tree : NULL;
+	r->parent = gitcmt;
+}
+
+static struct svnref* create_ref(int type, const char* name) {
+	struct svnref* r = NULL;
+	unsigned char sha1[20];
+
+	switch (type) {
+	case TRUNK_REF:
+		r = xcalloc(1, sizeof(*r));
+		strbuf_addstr(&r->svn, trunk ? trunk : "");
+		strbuf_addstr(&r->ref, "refs/svn/heads/trunk");
+		strbuf_addstr(&r->remote, remoteheads);
+		strbuf_addstr(&r->remote, trunkref);
+		break;
+
+	case BRANCH_REF:
+		r = xcalloc(1, sizeof(*r));
+
+		strbuf_addstr(&r->svn, branches);
+		strbuf_addch(&r->svn, '/');
+		strbuf_addstr(&r->svn, name);
+
+		strbuf_addstr(&r->ref, "refs/svn/heads/");
+		add_refname(&r->ref, name);
+
+		strbuf_addstr(&r->remote, remoteheads);
+		add_refname(&r->remote, name);
+		break;
+
+	case TAG_REF:
+		r = xcalloc(1, sizeof(*r));
+		r->istag = 1;
+
+		strbuf_addstr(&r->svn, tags);
+		strbuf_addch(&r->svn, '/');
+		strbuf_addstr(&r->svn, name);
+
+		strbuf_addstr(&r->ref, "refs/svn/tags/");
+		add_refname(&r->ref, name);
+
+		strbuf_addstr(&r->remote, remotetags);
+		add_refname(&r->remote, name);
+		break;
+	}
+
+	if (!read_ref(r->remote.buf, sha1) && !is_null_sha1(sha1)) {
+		r->gitobj = parse_object(sha1);
+		if (!r->gitobj)
+			die("invalid ref %s", name);
+	}
+
+	if (!read_ref(r->ref.buf, sha1) && !is_null_sha1(sha1)) {
+		r->svncmt = lookup_commit(sha1);
+		if (parse_commit(r->svncmt))
+			die("invalid ref %s", name);
+		checkout_svncmt(r, r->svncmt);
+	}
+
+	ALLOC_GROW(refs, refn + 1, refalloc);
+	refs[refn++] = r;
+	return r;
+}
+
+static struct svnref* find_svnref_by_path(struct strbuf* name) {
+	int i;
+	struct svnref* r;
+	char *a, *b, *c, *d;
+
+	if (!trunk && !branches && !tags && refn) {
+		return refs[0];
+	}
+
+	for (i = 0; i < refn; i++) {
+		r = refs[i];
+		if (prefixcmp(name->buf, r->svn.buf)) {
+			continue;
+		}
+
+		switch (name->buf[r->svn.len]) {
+		case '\0':
+			strbuf_setlen(name, 0);
+			return r;
+		case '/':
+			strbuf_remove(name, 0, r->svn.len + 1);
+			return r;
+		}
+	}
+
+	/* names are of the form
+	 * branches/foo/...
+	 * a        b  c   d
+	 */
+	a = name->buf;
+	d = name->buf + name->len;
+
+	if (!trunk && !branches && !tags) {
+		return create_ref(TRUNK_REF, NULL);
+
+	} else if (trunk && is_in_dir(a, trunk, &b)) {
+		strbuf_remove(name, 0, b - a);
+		return create_ref(TRUNK_REF, NULL);
+
+
+	} else if (branches && is_in_dir(a, branches, &b) && *b) {
+		c = memchr(b, '/', d - b);
+		if (c) {
+			*c = '\0';
+			r = create_ref(BRANCH_REF, b);
+			strbuf_remove(name, 0, c+1 - a);
+		} else {
+			r = create_ref(BRANCH_REF, b);
+			strbuf_reset(name);
+		}
+		return r;
+
+	} else if (tags && is_in_dir(a, tags, &b) && *b) {
+		c = memchr(b, '/', d - b);
+		if (c) {
+			*c = '\0';
+			r = create_ref(TAG_REF, b);
+			strbuf_remove(name, 0, c+1 - a);
+		} else {
+			r = create_ref(TAG_REF, b);
+			strbuf_reset(name);
+		}
+		return r;
+
+	} else {
+		return NULL;
+	}
+}
+
+static struct svnref* find_svnref_by_refname(const char* name) {
+	int i;
+	unsigned char sha1[20];
+
+	if (prefixcmp(name, "refs/")) {
+		char* real_ref;
+		int refcount = dwim_ref(name, strlen(name), sha1, &real_ref);
+
+		if (refcount > 1) {
+			die("ambiguous ref '%s'", name);
+		} else if (!refcount) {
+			die("can not find ref '%s'", name);
+		}
+
+		name = real_ref;
+	}
+
+	for (i = 0; i < refn; i++) {
+		struct svnref* r = refs[i];
+		if (!strcmp(r->remote.buf, name)) {
+			return r;
+		}
+	}
+
+	if (!prefixcmp(name, remoteheads)) {
+		name += strlen(remoteheads);
+
+		if (!strcmp(name, trunkref)) {
+			return create_ref(TRUNK_REF, NULL);
+		} else if (!branches) {
+			die("in order to push a branch, svn.branches must be set");
+		} else {
+			return create_ref(BRANCH_REF, name);
+		}
+
+	} else if (!prefixcmp(name, remotetags)) {
+		name += strlen(remotetags);
+		if (!tags)
+			die("in order to push a tag, svn.tags must be set");
+
+		return create_ref(TAG_REF, name);
+	}
+
+	die("can not find ref '%s'", name);
+}
+
+static struct commit* find_svncmt(struct svnref* r, int rev) {
+	struct commit* c = r->svncmt;
+
+	while (c && parse_svnrev(c) > rev) {
+		c = svn_parent(c);
+		if (c && parse_commit(c)) {
+			die("invalid commit %s", cmt_to_hex(c));
+		}
+	}
+
+	return c;
+}
+
+/* reads a path, revision pair */
+static struct svnref* read_copy_source(struct strbuf* name, int* rev) {
+	int64_t srev;
+	struct svnref* sref;
+
+	/* copy-path */
+	read_name(name);
+	sref = find_svnref_by_path(name);
+	if (!sref) return NULL;
+
+	/* copy-rev */
+	srev = read_number();
+	if (srev < 0 || srev > INT_MAX) goto err;
+	*rev = srev;
+
+	return sref;
+err:
+	die("invalid copy source");
+}
+
+static int create_ref_cb(const char* refname, const unsigned char* sha1, int flags, void* cb_data) {
+	int i;
+	for (i = 0; i < refn; i++) {
+		const char *s = refs[i]->ref.buf;
+		if (!prefixcmp(s, "refs/svn/heads/") && !strcmp(s + strlen("refs/svn/heads/"), refname)) {
+			return 0;
+		}
+	}
+
+	if (!strcmp(refname, "trunk")) {
+		create_ref(TRUNK_REF, "");
+	} else if (branches) {
+		create_ref(BRANCH_REF, refname);
+	}
+
+	return 0;
+}
+
+#define SEEN_FROM_OBJ 1
+#define SEEN_FROM_SVN 2
+#define SEEN_FROM_BOTH (SEEN_FROM_OBJ | SEEN_FROM_SVN)
+#define SVNCMT 4
+
+static void insert_commit(struct commit *c, struct commit_list **cmts) {
+	if (parse_commit(c)) {
+		die("invalid commit %s", sha1_to_hex(c->object.sha1));
+	}
+	commit_list_insert_by_date(c, cmts);
+}
+
+static void insert_svncmt(struct commit *sc, struct commit_list **cmts) {
+	struct commit *gc;
+	struct commit *sc2;
+	if (!sc) return;
+
+	sc->object.flags = SVNCMT;
+	insert_commit(sc, cmts);
+
+	/* If two or more svn commits point to the same git commit, then
+	 * we use the newest one. This is in line with using the newest
+	 * svn revision we can find. */
+	gc = svn_commit(sc);
+	if (!gc) return;
+
+	sc2 = (struct commit*) ((gc->object.flags & SEEN_FROM_SVN) ? gc->util : NULL);
+	if (!sc2 || sc->date > sc2->date) {
+		gc->object.flags |= SEEN_FROM_SVN;
+		gc->util = sc;
+		insert_commit(gc, cmts);
+	}
+}
+
+static void add_roots(struct commit_list **cmts, struct object *obj) {
+	static int all_refs_added;
+
+	int i;
+	struct commit *c = (struct commit*) deref_tag(obj, NULL, 0);
+	if (!c || c->object.type != OBJ_COMMIT) {
+		die("invalid object %s", sha1_to_hex(obj->sha1));
+	}
+
+	c->object.flags = SEEN_FROM_OBJ;
+	insert_commit(c, cmts);
+
+	if (!all_refs_added) {
+		for_each_ref_in("refs/svn/heads/", &create_ref_cb, NULL);
+		all_refs_added = 1;
+	}
+
+	for (i = 0; i < refn; i++) {
+		insert_svncmt(refs[i]->svncmt, cmts);
+	}
+}
+
+/* Searches back from the new object. Looking for the previous svn
+ * commit or failing that the newest svn commit.
+ */
+static struct commit* find_copy_source(struct svnref* r, struct object* obj) {
+	struct commit_list *cmts = NULL;
+	struct commit *end = r->svncmt ? svn_commit(r->svncmt) : NULL;
+	struct commit *ret = NULL;
+
+	add_roots(&cmts, obj);
+	while (cmts) {
+		struct commit *c = pop_commit(&cmts);
+		int both = (c->object.flags & SEEN_FROM_BOTH) == SEEN_FROM_BOTH;
+
+		if (both && c == end) {
+			ret = (struct commit*) c->util;
+			break;
+
+		} else if (c == end) {
+			end = NULL;
+			if (ret) break;
+
+		} else if (both && !ret) {
+			/* commits are processed newest first hence !ret */
+			ret = (struct commit*) c->util;
+			if (end == NULL) break;
+
+		} else if (c->object.flags & SVNCMT) {
+			insert_svncmt(svn_parent(c), &cmts);
+
+		} else if (c->object.flags & SEEN_FROM_OBJ) {
+			struct commit_list *p = c->parents;
+
+			while (p) {
+				c = p->item;
+				c->object.flags |= SEEN_FROM_OBJ;
+				insert_commit(c, &cmts);
+				p = p->next;
+			}
+		}
+	}
+
+	free_commit_list(cmts);
+	clear_object_flags(SEEN_FROM_BOTH | SVNCMT);
+
+	return ret;
+}
+
+static void read_add_dir(struct svnref* r, int rev) {
+	/* path, parent-token, child-token, [copy-path, copy-rev] */
+
+	struct strbuf name = STRBUF_INIT;
+	struct strbuf srcname = STRBUF_INIT;
+	struct cache_entry* ce;
+	char* p;
+	size_t dlen;
+	int files = 0;
+
+	read_name(&name);
+	find_svnref_by_path(&name);
+	fprintf(stderr, "A %s\n", name.buf);
+
+	if (name.len) strbuf_addch(&name, '/');
+	dlen = name.len;
+
+	strbuf_setlen(&name, dlen);
+
+	/* empty folder - add ./.gitempty */
+	if (files == 0 && dlen) {
+		unsigned char sha1[20];
+		if (write_sha1_file(NULL, 0, "blob", sha1))
+			die("failed to write .gitempty object");
+		strbuf_addstr(&name, ".gitempty");
+		ce = make_cache_entry(create_ce_mode(0644), sha1, name.buf, 0, 0);
+		add_index_entry(git_index(r), ce, ADD_CACHE_OK_TO_ADD);
+	}
+
+	/* remove ../.gitempty */
+	if (dlen) {
+		strbuf_setlen(&name, dlen - 1);
+		p = strrchr(name.buf, '/');
+		if (p) {
+			strbuf_setlen(&name, p - name.buf);
+			strbuf_addstr(&name, "/.gitempty");
+			remove_file_from_index(git_index(r), name.buf);
+		}
+	}
+
+	strbuf_release(&srcname);
+	strbuf_release(&name);
+}
+
+static void read_add_file(struct svnref* r, int rev, struct strbuf* name, void** srcp, size_t* srcsz) {
+	/* name, dir-token, file-token, [copy-path, copy-rev] */
+	struct strbuf srcname = STRBUF_INIT;
+	char* p;
+
+	read_name(name);
+	find_svnref_by_path(name);
+	fprintf(stderr, "A %s\n", name->buf);
+
+	/* remove ./.gitempty */
+	p = strrchr(name->buf, '/');
+	if (p) {
+		struct strbuf empty = STRBUF_INIT;
+		strbuf_add(&empty, name->buf, p - name->buf);
+		strbuf_addstr(&empty, "/.gitempty");
+		remove_file_from_index(git_index(r), empty.buf);
+		strbuf_release(&empty);
+	}
+
+	strbuf_release(&srcname);
+}
+
+static void read_open_file(struct svnref* r, int rev, struct strbuf* name, void** srcp, size_t* srcsz) {
+	/* name, dir-token, file-token, rev */
+	enum object_type type;
+	struct cache_entry* ce;
+	unsigned long srcn;
+
+	read_name(name);
+	find_svnref_by_path(name);
+	fprintf(stderr, "M %s\n", name->buf);
+
+	ce = index_name_exists(svn_index(r), name->buf, name->len, 0);
+	if (!ce) goto err;
+
+	*srcp = read_sha1_file(ce->sha1, &type, &srcn);
+	if (!srcp || type != OBJ_BLOB) goto err;
+	*srcsz = srcn;
+
+	return;
+err:
+	die("malformed update");
+}
+
+static void read_close_file(struct svnref* r, const char* name, const void* data, size_t sz) {
+	/* file-token, [text-checksum] */
+	struct cache_entry* ce;
+	unsigned char sha1[20];
+	struct strbuf buf = STRBUF_INIT;
+
+	if (skip_string()) goto err; /* file-token */
+
+	if (write_sha1_file(data, sz, "blob", sha1))
+		die_errno("write blob");
+
+	if (have_optional()) {
+		unsigned char h1[16], h2[16];
+		MD5_CTX ctx;
+
+		strbuf_reset(&buf);
+		if (read_string(&buf)) goto err;
+		if (get_md5_hex(buf.buf, h1)) goto err;
+
+		MD5_Init(&ctx);
+		MD5_Update(&ctx, data, sz);
+		MD5_Final(h2, &ctx);
+
+		if (memcmp(h1, h2, sizeof(h1))) {
+			ce = index_name_exists(svn_index(r), name, strlen(name), 0);
+			die("hash mismatch for '%s', expected md5 %s, got md5 %s, old sha1 %s, new sha1 %s",
+					name,
+					md5_to_hex(h2),
+					md5_to_hex(h1),
+					sha1_to_hex(ce ? ce->sha1 : null_sha1),
+					sha1_to_hex(sha1));
+		}
+
+		read_end();
+	}
+
+	ce = make_cache_entry(0644, sha1, name, 0, 0);
+	if (!ce) die("make_cache_entry failed for path '%s'", name);
+	add_index_entry(svn_index(r), ce, ADD_CACHE_OK_TO_ADD);
+
+	strbuf_reset(&buf);
+	if (convert_to_git(name, data, sz, &buf, SAFE_CRLF_FALSE)) {
+		if (write_sha1_file(buf.buf, buf.len, "blob", sha1)) {
+			die_errno("write blob");
+		}
+	}
+	ce = make_cache_entry(0644, sha1, name, 0, 0);
+	if (!ce) die("make_cache_entry failed for path '%s'", name);
+	add_index_entry(git_index(r), ce, ADD_CACHE_OK_TO_ADD);
+
+	strbuf_release(&buf);
+	return;
+
+err:
+	die("malformed update");
+}
+
+/* returns number of entries removed */
+static int remove_index_path(struct index_state* idx, struct strbuf* name) {
+	int ret = 0;
+	int i = index_name_pos(idx, name->buf, name->len);
+
+	if (i >= 0) {
+		/* file */
+		cache_tree_invalidate_path(idx->cache_tree, name->buf);
+		remove_index_entry_at(idx, i);
+		return 1;
+	}
+
+	/* we've got to re-lookup the path as a < a.c < a/c */
+	strbuf_addch(name, '/');
+	i = -index_name_pos(idx, name->buf, name->len) - 1;
+
+	/* directory, index_name_pos returns -first-1
+	 * where first is the position the entry would
+	 * be added at, and the cache is sorted */
+	while (i < idx->cache_nr) {
+		struct cache_entry* ce = idx->cache[i];
+		if (ce_namelen(ce) < name->len) break;
+		if (memcmp(ce->name, name->buf, name->len)) break;
+
+		ce->ce_flags |= CE_REMOVE;
+		i++;
+		ret++;
+	}
+
+	strbuf_setlen(name, name->len - 1);
+
+	if (ret) {
+		cache_tree_invalidate_path(idx->cache_tree, name->buf);
+		remove_marked_cache_entries(idx);
+	}
+
+	return ret;
+}
+
+static void read_delete_entry(struct svnref* r, int rev) {
+	/* name, [revno], dir-token */
+	struct strbuf name = STRBUF_INIT;
+
+	read_name(&name);
+	find_svnref_by_path(&name);
+	fprintf(stderr, "D %s\n", name.buf);
+
+	remove_index_path(svn_index(r), &name);
+	remove_index_path(git_index(r), &name);
+	if (!name.len) {
+		r->delete = 1;
+	}
+	strbuf_release(&name);
+	return;
+}
+
+static void read_text_delta(struct strbuf *delta) {
+	for (;;) {
+		const char* s;
+
+		/* finish off the previous textdelta-chunk or
+		 * apply-textdelta */
+		read_command_end();
+
+		s = read_command();
+
+		if (!strcmp(s, "textdelta-end")) {
+			/* leave textdelta-end opened for read_update to
+			 * close */
+			return;
+		}
+
+		/* if we get some other command we just loop around
+		 * again */
+		if (strcmp(s, "textdelta-chunk")) {
+			continue;
+		}
+
+		/* file-token, chunk */
+		if (skip_string() || read_string(delta))
+			die("invalid textdelta command");
+	}
+}
+
+#define MAX_VARINT_LEN 9
+
+static unsigned char* parse_varint(unsigned char *p, unsigned char *e, size_t *v) {
+	*v = 0;
+	for (;;) {
+		if (p == e || *v > (INT64_MAX >> 7))
+			die("invalid svndiff");
+
+		*v = (*v << 7) | (*p & 0x7F);
+
+		if (!(*(p++) & 0x80))
+			return p;
+	}
+}
+
+static unsigned char* encode_varint(unsigned char* p, size_t n) {
+	if (n < 0) die("int too large");
+	if (n >= (INT64_C(1) << 56)) *(p++) = ((n >> 56) & 0x7F) | 0x80;
+	if (n >= (INT64_C(1) << 49)) *(p++) = ((n >> 49) & 0x7F) | 0x80;
+	if (n >= (INT64_C(1) << 42)) *(p++) = ((n >> 42) & 0x7F) | 0x80;
+	if (n >= (INT64_C(1) << 35)) *(p++) = ((n >> 35) & 0x7F) | 0x80;
+	if (n >= (INT64_C(1) << 28)) *(p++) = ((n >> 28) & 0x7F) | 0x80;
+	if (n >= (INT64_C(1) << 21)) *(p++) = ((n >> 21) & 0x7F) | 0x80;
+	if (n >= (INT64_C(1) << 14)) *(p++) = ((n >> 14) & 0x7F) | 0x80;
+	if (n >= (INT64_C(1) << 7)) *(p++) = ((n >> 7) & 0x7F) | 0x80;
+	*(p++) = n & 0x7F;
+	return p;
+}
+
+static size_t encoded_length(size_t n) {
+	unsigned char b[MAX_VARINT_LEN];
+	return encode_varint(b, n) - b;
+}
+
+#define FROM_SOURCE (0 << 6)
+#define FROM_TARGET (1 << 6)
+#define FROM_NEW    (2 << 6)
+
+static unsigned char* parse_instruction(unsigned char *p, unsigned char *e, int* ins, size_t* off, size_t* len) {
+	int hdr;
+
+	if (p >= e) die("invalid svndiff");
+	hdr = *p++;
+
+	*len = hdr & 0x3F;
+	if (*len == 0) {
+		p = parse_varint(p, e, len);
+	}
+
+	*ins = hdr & 0xC0;
+	*off = 0;
+	if (*ins == FROM_SOURCE || *ins == FROM_TARGET) {
+		p = parse_varint(p, e, off);
+	}
+
+	return p;
+}
+
+#define MAX_INS_LEN (1 + 2 * MAX_VARINT_LEN)
+
+static unsigned char* encode_instruction(unsigned char* p, int ins, size_t off, size_t len) {
+	if (len < 0x3F) {
+		*(p++) = ins | len;
+	} else {
+		*(p++) = ins;
+		p = encode_varint(p, len);
+	}
+
+	if (ins == FROM_SOURCE || ins == FROM_TARGET) {
+		p = encode_varint(p, off);
+	}
+
+	return p;
+}
+
+static unsigned char *parse_svndiff_chunk(unsigned char *p, size_t *sz, struct strbuf *buf, int ver) {
+	unsigned char *e = p + *sz;
+	size_t inflated = *sz;
+	z_stream z;
+
+	if (ver > 0) {
+		p = parse_varint(p, e, &inflated);
+	}
+
+	*sz = inflated;
+	if (p + inflated == e)
+		return p;
+
+	memset(&z, 0, sizeof(z));
+	inflateInit(&z);
+
+	strbuf_grow(buf, inflated);
+
+	z.next_in = p;
+	z.avail_in = e - p;
+	z.next_out = (unsigned char*) buf->buf;
+	z.avail_out = inflated;
+
+	if (inflate(&z, Z_FINISH) != Z_STREAM_END) {
+		die("zlib error");
+	}
+	strbuf_setlen(buf, inflated - z.avail_out);
+	inflateEnd(&z);
+
+	return (unsigned char*) buf->buf;
+}
+
+static unsigned char* apply_svndiff_win(struct strbuf *tgt, const void *src, size_t sz, unsigned char *d, unsigned char *e, int ver) {
+	struct strbuf insbuf = STRBUF_INIT;
+	struct strbuf databuf = STRBUF_INIT;
+	unsigned char *insp, *inse, *datap, *datae;
+	size_t srco, srcl, tgtl, insl, datal, w = 0;
+
+	d = parse_varint(d, e, &srco);
+	d = parse_varint(d, e, &srcl);
+	d = parse_varint(d, e, &tgtl);
+	d = parse_varint(d, e, &insl);
+	d = parse_varint(d, e, &datal);
+
+	if (unsigned_add_overflows(srco, srcl) || srco + srcl > sz)
+		goto err;
+
+	if (unsigned_add_overflows(insl, datal) || insl + datal > e - d)
+		goto err;
+
+	insp = d;
+	datap = insp + insl;
+	d = datap + datal;
+
+	insp = parse_svndiff_chunk(insp, &insl, &insbuf, ver);
+	datap = parse_svndiff_chunk(datap, &datal, &databuf, ver);
+
+	inse = insp + insl;
+	datae = datap + datal;
+
+	strbuf_grow(tgt, tgt->len + tgtl);
+
+	while (insp < inse) {
+		size_t off, len;
+		ssize_t tgtr;
+		int ins;
+
+		insp = parse_instruction(insp, inse, &ins, &off, &len);
+
+		switch (ins) {
+		case FROM_SOURCE:
+			if (off > srcl || len > srcl - off) goto err;
+			strbuf_add(tgt, (char*) src + srco + off, len);
+			break;
+
+		case FROM_TARGET:
+			tgtr = min(w - off, len);
+			if (tgtr <= 0) goto err;
+
+			off = tgt->len - w + off;
+
+			/* len may be greater than tgtr. In this case we
+			 * just repeat [tgto,tgto+tgtr]
+			 */
+			while (len) {
+				int n = min(len, tgtr);
+				strbuf_add(tgt, tgt->buf + off, n);
+				len -= n;
+			}
+			break;
+
+		case FROM_NEW:
+			if (datae - datap < len) goto err;
+			strbuf_add(tgt, datap, len);
+			datap += len;
+			break;
+
+		default:
+			goto err;
+		}
+
+		w += len;
+	}
+
+	if (w != tgtl || datap != datae) goto err;
+
+	strbuf_release(&insbuf);
+	strbuf_release(&databuf);
+	return d;
+err:
+	die("invalid svndiff");
+}
+
+static void apply_svndiff(struct strbuf *tgt, const void *src, size_t sz, const void *delta, size_t dsz) {
+	unsigned char *d = (unsigned char*) delta;
+	unsigned char *e = d + dsz;
+	int ver;
+
+	if (dsz < 4 || memcmp(d, "SVN", 3))
+		goto err;
+
+	ver = d[3];
+	if (ver > 1)
+		goto err;
+
+	d += 4;
+
+	while (d < e) {
+		d = apply_svndiff_win(tgt, src, sz, d, e, ver);
+	}
+
+	return;
+
+err:
+	die(_("invalid svndiff"));
+}
+
+static void read_update(struct svnref* r, int rev) {
+	struct strbuf name = STRBUF_INIT;
+	struct strbuf tgt = STRBUF_INIT;
+	void* src = NULL;
+	size_t srcsz = 0;
+	int filedirty = 0;
+
+	read_success(); /* update */
+	read_success(); /* report */
+
+	for (;;) {
+		const char *s = read_command();
+
+		if (!strcmp(s, "close-edit")) {
+			if (name.len) goto err;
+			read_command_end();
+			break;
+
+		} else if (!strcmp(s, "abort-edit")) {
+			die("update aborted");
+
+		} else if (!strcmp(s, "open-root")) {
+			if (name.len) goto err;
+
+		} else if (!strcmp(s, "add-dir")) {
+			if (name.len) goto err;
+			read_add_dir(r, rev);
+
+		} else if (!strcmp(s, "open-file")) {
+			if (name.len) goto err;
+			read_open_file(r, rev, &name, &src, &srcsz);
+
+		} else if (!strcmp(s, "add-file")) {
+			if (name.len) goto err;
+			read_add_file(r, rev, &name, &src, &srcsz);
+
+		} else if (!strcmp(s, "close-file")) {
+			if (!name.len) goto err;
+
+			if (filedirty) {
+				read_close_file(r, name.buf, tgt.buf, tgt.len);
+			}
+
+			strbuf_release(&tgt);
+			strbuf_reset(&name);
+			free(src);
+			src = NULL;
+			srcsz = 0;
+			filedirty = 0;
+
+		} else if (!strcmp(s, "delete-entry")) {
+			if (name.len) goto err;
+			read_delete_entry(r, rev);
+
+		} else if (!strcmp(s, "apply-textdelta")) {
+			struct strbuf delta = STRBUF_INIT;
+
+			/* file-token, [base-checksum] */
+			if (!name.len) goto err;
+
+			read_text_delta(&delta);
+			filedirty = 1;
+			if (delta.len) {
+				apply_svndiff(&tgt, src, srcsz, delta.buf, delta.len);
+			}
+			strbuf_release(&delta);
+		}
+
+		read_command_end();
+	}
+
+	read_success();
+
+	free(src);
+	strbuf_release(&name);
+	strbuf_release(&tgt);
+	return;
+
+err:
+	die("malformed update");
+}
+
+struct author {
+	char* user;
+	char* pass;
+	char* name;
+	char* mail;
+};
+
+struct author* authors;
+size_t authorn, authoralloc;
+struct author* defauthor;
+
+static char* strip_space(char* p) {
+	char* e = p + strlen(p);
+
+	while (*p == ' ' || *p == '\t') {
+		p++;
+	}
+
+	while (e > p && (e[-1] == ' ' || e[-1] == '\t')) {
+		*(--e) = '\0';
+	}
+
+	return p;
+}
+
+static void parse_authors() {
+	char* p;
+	struct stat st;
+	int fd = open(git_path("svn-authors"), O_RDONLY);
+	if (fd < 0 || fstat(fd, &st)) return;
+
+	p = xmalloc(st.st_size + 1);
+	if (xread(fd, p, st.st_size) != st.st_size)
+		die("read failed on authors");
+
+	p[st.st_size] = '\0';
+
+	while (p && *p) {
+		struct author a;
+		char* line = strchr(p, '\n');
+		if (line) *(line++) = '\0';
+
+		a.user = p;
+
+		p = strchr(p, '=');
+		if (!p) goto nextline; /* empty line */
+		*(p++) = '\0';
+		a.name = p;
+
+		p = strchr(p, '<');
+		if (!p) die("invalid author entry for %s", a.user);
+		*(p++) = '\0';
+		a.mail = p;
+
+		p = strchr(p, '>');
+		if (!p) die("invalid author entry for %s", a.user);
+		*(p++) = '\0';
+		a.pass = p;
+
+		a.user = strip_space(a.user);
+		a.name = strip_space(a.name);
+		a.mail = strip_space(a.mail);
+
+		p = strchr(a.user, ':');
+		if (p) {
+			*p = '\0';
+			a.pass = p+1;
+		} else {
+			a.pass = NULL;
+		}
+
+		if (*a.user == '#') {
+			/* comment */
+		} else {
+			ALLOC_GROW(authors, authorn + 1, authoralloc);
+			authors[authorn++] = a;
+		}
+
+nextline:
+		p = line;
+	}
+
+	close(fd);
+}
+
+static void svn_author_to_git(struct strbuf* author) {
+	int i;
+
+	for (i = 0; i < authorn; i++) {
+		struct author* a = &authors[i];
+		if (!strcasecmp(author->buf, a->user)) {
+			strbuf_reset(author);
+			strbuf_addf(author, "%s <%s>", a->name, a->mail);
+			return;
+		}
+	}
+
+	die("could not find username '%s' in %s\n"
+			"Add a line of the form:\n"
+			"%s = Full Name <email@example.com>\n",
+			author->buf,
+			git_path("svn-authors"),
+			author->buf);
+}
+
+static struct author* get_object_author(struct object* obj) {
+	const char *lb, *le, *mb, *me;
+	struct strbuf buf = STRBUF_INIT;
+	struct author* ret = NULL;
+	char* data = NULL;
+	int i;
+
+	if (obj->type == OBJ_COMMIT) {
+		struct commit* cmt = (struct commit*) obj;
+		parse_commit(cmt);
+		lb = strstr(cmt->buffer, "\ncommitter ");
+		if (!lb) lb = strstr(cmt->buffer, "\nauthor ");
+	} else if (obj->type == OBJ_TAG) {
+		enum object_type type;
+		unsigned long size;
+		data = read_sha1_file(obj->sha1, &type, &size);
+		if (!data || type != OBJ_TAG) goto err;
+		lb = strstr(data, "\ntagger ");
+	} else {
+		die("invalid commit object");
+	}
+
+	if (!lb) goto err;
+	le = strchr(lb+1, '\n');
+	if (!le) goto err;
+	mb = memchr(lb, '<', le - lb);
+	if (!mb) goto err;
+	me = memchr(mb, '>', le - mb);
+	if (!me) goto err;
+
+	strbuf_add(&buf, mb+1, me - (mb+1));
+
+	for (i = 0; i < authorn; i++) {
+		struct author* a = &authors[i];
+		if (strcasecmp(buf.buf, a->mail)) continue;
+		if (!a->pass) {
+			die("need password for user '%s' in %s\n"
+				"Add a line of the form:\n"
+				"%s:password = Full Name <%s>\n",
+				a->user,
+				git_path("svn-authors"),
+				a->user,
+				a->mail);
+		}
+
+		ret = a;
+		break;
+	}
+
+	if (!ret) {
+		die("could not find username/password for %s in %s\n"
+				"Add a line of the form:\n"
+				"username:password = Full Name <%s>\n",
+				buf.buf,
+				git_path("svn-authors"),
+				buf.buf);
+	}
+
+	strbuf_release(&buf);
+	free(data);
+	return ret;
+
+err:
+	die("can not find author in %s", sha1_to_hex(obj->sha1));
+}
+
+static struct commit* latest_fetch_svncmt;
+
+static void init_latest_fetch(void) {
+	unsigned char sha1[20];
+	struct commit* cmt;
+
+	latest_fetch_svncmt = NULL;
+	if (read_ref("refs/svn/latest", sha1) || is_null_sha1(sha1))
+		return;
+
+	cmt = lookup_commit(sha1);
+	if (!cmt || parse_commit(cmt)) {
+		die("invalid latest ref %s", sha1_to_hex(sha1));
+	}
+
+	latest_fetch_svncmt = cmt;
+}
+
+static int latest_fetch_rev(void) {
+	return latest_fetch_svncmt ? parse_svnrev(latest_fetch_svncmt) : 0;
+}
+
+static int set_latest_fetch(struct commit* cmt) {
+	struct ref_lock* lk;
+
+	if (cmt == latest_fetch_svncmt) {
+		return 0;
+	}
+
+	lk = lock_ref_sha1("svn/latest", cmt_sha1(latest_fetch_svncmt));
+	if (!lk || write_ref_sha1(lk, cmt_sha1(cmt), "svn-fetch")) {
+		error("failed to update latest ref");
+		return 1;
+	}
+
+	latest_fetch_svncmt = cmt;
+	return 0;
+}
+
+static int svn_time_to_git(struct strbuf* time) {
+	struct tm tm;
+	memset(&tm, 0, sizeof(tm));
+	if (!strptime(time->buf, "%Y-%m-%dT%H:%M:%S", &tm)) return -1;
+	strbuf_reset(time);
+	strbuf_addf(time, "%"PRId64, (int64_t) mktime(&tm));
+	return 0;
+}
+
+static struct commit* create_fetched_commit(struct svnref* r, int rev, const char* author, const char* time, const char* log, int created) {
+	static struct strbuf buf = STRBUF_INIT;
+	unsigned char sha1[20];
+
+	struct object *gitobj;
+	struct commit *gitcmt, *svncmt;
+	struct ref_lock* lk = NULL;
+
+	/* Create the commit object.
+	 *
+	 * SVN can't create tags and branches without a commit,
+	 * but git can. In the cases where new refs are just
+	 * created without any changes to the tree, we don't add
+	 * a commit. This way git commits pushed to svn and
+	 * pulled back again look roughly the same.
+	 */
+	if (r->delete) {
+		gitcmt = NULL;
+
+	} else if ((r->istag || created)
+		&& r->parent
+		&& !hashcmp(idx_sha1(git_index(r)), r->parent->tree->object.sha1)
+		  ) {
+		/* branch/tag has been created/replaced, but the tree hasn't
+		 * been changed */
+		gitcmt = r->parent;
+
+	} else {
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "tree %s\n", sha1_to_hex(idx_sha1(git_index(r))));
+
+		if (r->parent) {
+			strbuf_addf(&buf, "parent %s\n", cmt_to_hex(r->parent));
+		}
+
+		strbuf_addf(&buf, "author %s %s +0000\n", author, time);
+		strbuf_addf(&buf, "committer %s %s +0000\n", author, time);
+
+		strbuf_addch(&buf, '\n');
+		strbuf_addstr(&buf, log);
+
+		if (write_sha1_file(buf.buf, buf.len, "commit", sha1))
+			die("failed to create commit");
+
+		gitcmt = lookup_commit(sha1);
+		if (!gitcmt || parse_commit(gitcmt))
+			die("failed to parse created commit");
+	}
+
+	/* Create the tag object.
+	 *
+	 * Now we create an annotated tag wrapped around either
+	 * the commit the tag was branched from or the wrapper.
+	 * Where a tag is later updated, we either recreate this
+	 * tag with a new time (no tree change) or create a new
+	 * dummy commit whose parent is the old dummy.
+	 */
+	if (r->delete) {
+		gitobj = NULL;
+
+	} else if (r->istag) {
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "object %s\n", cmt_to_hex(gitcmt));
+		strbuf_addf(&buf, "type commit\n");
+		strbuf_addf(&buf, "tag %s\n", r->remote.buf + strlen("refs/tags/"));
+		strbuf_addf(&buf, "tagger %s %s +0000\n", author, time);
+		strbuf_addch(&buf, '\n');
+		strbuf_addstr(&buf, log);
+
+		if (write_sha1_file(buf.buf, buf.len, tag_type, sha1))
+			die("failed to create tag");
+
+		gitobj = parse_object(sha1);
+		if (!gitobj)
+			die("failed to parse created tag");
+
+	} else {
+		gitobj = &gitcmt->object;
+	}
+
+	/* Create the svn commit */
+	strbuf_reset(&buf);
+	strbuf_addf(&buf, "tree %s\n", sha1_to_hex(idx_sha1(svn_index(r))));
+
+	if (gitcmt || r->svncmt) {
+		strbuf_addf(&buf, "parent %s\n", cmt_to_hex(gitcmt ? gitcmt : r->svncmt));
+	}
+
+	if (r->svncmt) {
+		strbuf_addf(&buf, "parent %s\n", cmt_to_hex(r->svncmt));
+	}
+
+	strbuf_addf(&buf, "author %s %s +0000\n", author, time);
+	strbuf_addf(&buf, "committer %s %s +0000\n", author, time);
+	strbuf_addf(&buf, "revision %d\n", rev);
+	strbuf_addf(&buf, "path %s\n", r->svn.buf);
+	strbuf_addch(&buf, '\n');
+
+	if (write_sha1_file(buf.buf, buf.len, "commit", sha1))
+		die("failed to create svn object");
+
+	svncmt = lookup_commit(sha1);
+	if (!svncmt || parse_commit(svncmt))
+		die("failed to parse created svn commit");
+
+	/* update the ref */
+
+	lk = lock_ref_sha1(r->ref.buf + strlen("refs/"), cmt_sha1(r->svncmt));
+	if (!lk || write_ref_sha1(lk, cmt_sha1(svncmt), "svn-fetch")) {
+		die("failed to update ref %s", r->ref.buf);
+	}
+
+	/* update the remote or tag ref */
+
+	if (r->gitobj && !gitobj) {
+		if (delete_ref(r->remote.buf, r->gitobj->sha1, 0)) {
+			error("failed to delete ref %s", r->remote.buf);
+			goto rollback;
+		}
+	} else if (gitobj) {
+		lk = lock_ref_sha1(r->remote.buf + strlen("refs/"),
+				r->gitobj ? r->gitobj->sha1 : null_sha1);
+
+		if (!lk || write_ref_sha1(lk, gitobj->sha1, "svn-fetch")) {
+			error("failed to update ref %s", r->remote.buf);
+			goto rollback;
+		}
+	}
+
+	r->delete = 0;
+	r->gitobj = gitobj;
+	r->svncmt = svncmt;
+	r->parent = gitcmt;
+
+	fprintf(stderr, "fetched %d %s %s\n", rev, r->ref.buf, sha1_to_hex(r->svncmt->object.sha1));
+	return svncmt;
+
+rollback:
+	if (r->svncmt) {
+		lk = lock_ref_sha1(r->ref.buf + strlen("refs/"), cmt_sha1(svncmt));
+		if (!lk || write_ref_sha1(lk, cmt_sha1(r->svncmt), "svn-fetch rollback"))
+			goto rollback_failed;
+	} else if (svncmt) {
+		if (delete_ref(r->ref.buf, cmt_sha1(svncmt), 0))
+			goto rollback_failed;
+	}
+
+	exit(128);
+
+rollback_failed:
+	die("failed to rollback %s", r->ref.buf);
+}
+
+static void request_commit(struct svnref* r, int rev, struct svnref* copysrc, int copyrev) {
+	fprintf(stderr, "request commit %d\n", rev);
+
+	if (!copysrc) {
+		copysrc = r;
+		copyrev = rev - 1;
+	}
+
+	/* [rev] target recurse target-url */
+	sendf("( switch ( ( %d ) %d:%s true %d:%s/%s ) )\n",
+			rev,
+			(int) copysrc->svn.len,
+			copysrc->svn.buf,
+			(int) (strlen(url) + 1 + r->svn.len),
+			url,
+			r->svn.buf);
+
+	/* path rev start-empty */
+	sendf("( set-path ( 0: %d false ) )\n", copyrev);
+	sendf("( finish-report ( ) )\n");
+	sendf("( success ( ) )\n");
+}
+
+static void request_log(int from, int to) {
+	struct strbuf paths = STRBUF_INIT;
+	if (!trunk && !branches && !tags) {
+		strbuf_addstr(&paths, "0: ");
+	}
+	if (trunk) {
+		strbuf_addf(&paths, "%d:%s ", (int) strlen(trunk), trunk);
+	}
+	if (branches) {
+		strbuf_addf(&paths, "%d:%s ", (int) strlen(branches), branches);
+	}
+	if (tags) {
+		strbuf_addf(&paths, "%d:%s ", (int) strlen(tags), tags);
+	}
+
+	sendf("( log ( ( %s) " /* (path...) */
+		"( %d ) ( %d ) " /* start/end revno */
+		"true false " /* changed-paths strict-node */
+		"0 " /* limit */
+		"false " /* include-merged-revisions */
+		"revprops ( 10:svn:author 8:svn:date 7:svn:log ) "
+		") )\n",
+		paths.buf,
+		from, /* log start */
+		to /* log end */
+	     );
+
+	strbuf_release(&paths);
+}
+
+struct pending {
+	char *buf, *msg, *author, *time;
+	struct svnref *ref, *copysrc;
+	int rev, copyrev;
+};
+
+static int have_next_commit(struct pending* retp) {
+	static struct pending *nextv;
+	static int nextc, nexta;
+	static int64_t rev;
+
+	struct strbuf msg = STRBUF_INIT;
+	struct strbuf author = STRBUF_INIT;
+	struct strbuf time = STRBUF_INIT;
+	struct strbuf name = STRBUF_INIT;
+
+	/* log reply is of the form
+	 * ( ( ( n:changed-path A|D|R|M ( n:copy-path copy-rev ) ) ... ) rev n:author n:date n:message )
+	 * ....
+	 * done
+	 * ( success ( ) )
+	 */
+
+	while (!nextc) {
+		struct pending* p;
+
+		/* start of log entry */
+		if (read_list()) {
+			read_done();
+			read_success();
+			return 0;
+		}
+
+		/* start changed path entries */
+		if (read_list()) goto err;
+
+		while (!read_list()) {
+			const char* s;
+			struct svnref *to;
+			int i;
+
+			/* path A|D|R|M [copy-path copy-rev] */
+			strbuf_reset(&name);
+			read_name(&name);
+			to = find_svnref_by_path(&name);
+			s = read_word();
+			if (!s) goto err;
+
+			p = NULL;
+			for (i = 0; i < nextc; i++) {
+				if (nextv[i].ref == to) {
+					p = &nextv[i];
+					break;
+				}
+			}
+
+			if (to && !name.len && (!strcmp(s, "A") || !strcmp(s, "R")) && have_optional()) {
+				int copyrev;
+				struct svnref* copysrc;
+
+				strbuf_reset(&name);
+				copysrc = read_copy_source(&name, &copyrev);
+				if (copysrc && name.len) {
+					warning("copy from non-root path");
+					copysrc = NULL;
+					copyrev = 0;
+				}
+
+				if (p == NULL) {
+					ALLOC_GROW(nextv, nextc+1, nexta);
+					p = &nextv[nextc++];
+				}
+
+				p->copysrc = copysrc;
+				p->copyrev = copyrev;
+				p->ref = to;
+
+				read_end();
+
+			} else if (to && p == NULL) {
+				ALLOC_GROW(nextv, nextc+1, nexta);
+				p = &nextv[nextc++];
+				p->copysrc = NULL;
+				p->ref = to;
+			}
+
+			read_end();
+		}
+
+		/* end of changed path entries */
+		read_end();
+
+		/* rev number */
+		rev = read_number();
+		if (rev < 0) goto err;
+
+		/* author */
+		if (read_list()) goto err;
+		strbuf_reset(&author);
+		if (read_string(&author)) goto err;
+		svn_author_to_git(&author);
+		read_end();
+
+		/* timestamp */
+		if (read_list()) goto err;
+		strbuf_reset(&time);
+		if (read_string(&time)) goto err;
+		if (svn_time_to_git(&time)) goto err;
+		read_end();
+
+		/* log message */
+		strbuf_reset(&msg);
+		if (have_optional()) {
+			if (read_string(&msg)) goto err;
+			strbuf_complete_line(&msg);
+			read_end();
+		}
+
+		/* end of log entry */
+		read_end();
+		if (verbose) fputc('\n', stderr);
+
+		/* remove entries where we've already downloaded the
+		 * commit */
+		p = nextv;
+		while (p < nextv+nextc) {
+			if (p->ref->svncmt && parse_svnrev(p->ref->svncmt) >= rev) {
+				memmove(p, p+1, sizeof(*p) * ((nextv+nextc) - (p+1)));
+				nextc--;
+			} else {
+				p->buf = xmalloc(msg.len + 1 + author.len + 1 + time.len + 1);
+
+				p->rev = rev;
+				p->msg = p->buf;
+				p->author = p->msg + msg.len + 1;
+				p->time = p->author + author.len + 1;
+
+				memcpy(p->msg, msg.buf, msg.len + 1);
+				memcpy(p->author, author.buf, author.len + 1);
+				memcpy(p->time, time.buf, time.len + 1);
+
+				p++;
+			}
+		}
+	}
+
+	*retp = nextv[0];
+
+	memmove(nextv, nextv+1, sizeof(nextv[0])*(nextc-1));
+	nextc--;
+
+	strbuf_release(&name);
+	strbuf_release(&msg);
+	strbuf_release(&author);
+	strbuf_release(&time);
+	return 1;
+
+err:
+	die("malformed log");
+}
+
+static char* clean_path(char* p) {
+	char* e;
+	if (*p == '/') p++;
+	e = p + strlen(p);
+	if (e > p && e[-1] == '/') e[-1] = '\0';
+	return p;
+}
+
+static struct author** connection_authors;
+static int *svnfdv;
+static struct inbuffer *inbufv;
+
+static void setup_globals() {
+	int i;
+
+	setenv("TZ", "", 1);
+
+	core_eol = svn_eol;
+
+	if (getenv("GIT_SVN_PUSH_PAUSE")) {
+		pause_between_commits = atoi(getenv("GIT_SVN_PUSH_PAUSE"));
+	}
+
+	if (remotedir) {
+		struct strbuf buf = STRBUF_INIT;
+		remotedir = clean_path((char*) remotedir);
+
+		strbuf_addstr(&buf, "refs/remotes/");
+		strbuf_addstr(&buf, remotedir);
+		strbuf_addch(&buf, '/');
+		remoteheads = strbuf_detach(&buf, NULL);
+
+		strbuf_addstr(&buf, "refs/tags/");
+		strbuf_addstr(&buf, remotedir);
+		strbuf_addch(&buf, '/');
+		remotetags = strbuf_detach(&buf, NULL);
+	} else {
+		remoteheads = "refs/heads/";
+		remotetags = "refs/tags/";
+		leave_remote = 1;
+	}
+
+	if (svnfdc < 1) die("invalid number of connections");
+
+	connection_authors = xcalloc(svnfdc+1, sizeof(connection_authors[0]));
+	svnfdv = xmalloc((svnfdc+1) * sizeof(svnfdv[0]));
+	inbufv = xmalloc((svnfdc+1) * sizeof(inbufv[0]));
+	for (i = 0; i <= svnfdc; i++) {
+		svnfdv[i] = -1;
+		inbufv[i].b = inbufv[i].e = 0;
+	}
+
+	parse_authors();
+
+	for (i = 0; svnuser && i < authorn; i++) {
+		struct author* a = &authors[i];
+		if (!strcasecmp(a->user, svnuser)) {
+			defauthor = a;
+			if (!a->pass) {
+				die("user specified with --user needs a password");
+			}
+			break;
+		}
+	}
+
+	if (!defauthor) die("need to specify default user with --user");
+	if (!url) die("need to specify a url with --url");
+
+	if (trunk) trunk = clean_path((char*) trunk);
+	if (branches) branches = clean_path((char*) branches);
+	if (tags) tags = clean_path((char*) tags);
+
+	init_latest_fetch();
+}
+
+static void close_connection(int cidx) {
+	if (svnfdv[cidx] >= 0) {
+		close(svnfdv[cidx]);
+	}
+	svnfdv[cidx] = -1;
+	connection_authors[cidx] = NULL;
+	inbufv[cidx].b = inbufv[cidx].e = 0;
+}
+
+static void change_connection(int cidx, struct author* a) {
+	char pathsep;
+	char *host, *port, *path;
+	const char *s;
+	struct addrinfo hints, *res, *ai;
+	int err;
+	int fd = -1;
+
+	svnfd = svnfdv[cidx];
+	inbuf = &inbufv[cidx];
+	if (svnfd >= 0 && connection_authors[cidx] == a) {
+		return;
+	}
+
+	close_connection(cidx);
+
+	if (prefixcmp(url, "svn://"))
+		die(_("only svn repositories are supported"));
+
+	if (!a->pass)
+		die("need a password for user %s", a->user);
+
+	host = (char*) url + strlen("svn://");
+
+	path = strchr(host, '/');
+	if (!path) path = host + strlen(host);
+	pathsep = *path;
+	*path = '\0';
+
+	port = strchr(host, ':');
+	if (port) *(port++) = '\0';
+
+	memset(&hints, 0, sizeof(hints));
+	hints.ai_socktype = SOCK_STREAM;
+
+	err = getaddrinfo(host, port ? port : "3690", &hints, &res);
+	*path = pathsep;
+	if (port) port[-1] = ':';
+
+	if (err)
+		die_errno("failed to connect to %s", url);
+
+	for (ai = res; ai != NULL; ai = ai->ai_next) {
+		fd = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
+		if (fd < 0) continue;
+
+		if (connect(fd, ai->ai_addr, ai->ai_addrlen)) {
+			int err = errno;
+			close(fd);
+			errno = err;
+			continue;
+		}
+
+		break;
+	}
+
+	if (fd < 0)
+		die_errno("failed to connect to %s", url);
+
+	svnfd = svnfdv[cidx] = fd;
+	inbuf = &inbufv[cidx];
+	verbosetxnl = 1;
+
+	/* TODO: client software version and client capabilities */
+	sendf("( 2 ( edit-pipeline svndiff1 ) %d:%s )\n", (int) strlen(url), url);
+	sendf("( CRAM-MD5 ( ) )\n");
+
+	/* TODO: we don't care about capabilities/versions right now */
+	s = read_command();
+	if (strcmp(s, "success"))
+		die("server error");
+
+	/* minver then maxver */
+	if (read_number() > 2 || read_number() < 2)
+		die(_("version mismatch"));
+
+	read_command_end();
+
+	/* TODO: read the mech lists et all */
+	read_success();
+
+	cram_md5(a->user, a->pass);
+
+	sendf("( reparent ( %d:%s ) )\n", (int) strlen(url), url);
+
+	read_success(); /* auth */
+	read_success(); /* repo info */
+	read_success(); /* reparent */
+	read_success(); /* reparent again */
+
+	connection_authors[cidx] = a;
+}
+
+static int run_gc_auto() {
+	const char *args[] = {"gc", "--auto", NULL};
+	return run_command_v_opt(args, RUN_GIT_CMD);
+}
+
+static const char* print_arg(struct strbuf* sb, const char* fmt, ...) {
+	va_list ap;
+	va_start(ap, fmt);
+	strbuf_reset(sb);
+	strbuf_vaddf(sb, fmt, ap);
+	return sb->buf;
+}
+
+int cmd_svn_fetch(int argc, const char **argv, const char *prefix) {
+	int64_t n;
+	int from, to, i, finished;
+	struct pending *pending;
+	struct commit* svncmt = NULL;
+
+	git_config(&config, NULL);
+
+	argc = parse_options(argc, argv, prefix, builtin_svn_fetch_options,
+			builtin_svn_fetch_usage, 0);
+
+	if (argc)
+		usage_msg_opt(_("Too many arguments."),
+			builtin_svn_fetch_usage, builtin_svn_fetch_options);
+
+	setup_globals();
+
+	if (getenv("GIT_SVN_FETCH_REPORT_LATEST")) {
+		printf("%d\n", latest_fetch_rev());
+		return 0;
+	}
+
+	from = latest_fetch_rev();
+	pending = xcalloc(svnfdc, sizeof(pending[0]));
+
+	change_connection(svnfdc, defauthor);
+	sendf("( get-latest-rev ( ) )\n");
+
+	read_success(); /* latest rev */
+	read_command(); /* latest rev again */
+	n = read_number();
+	if (n < 0 || n > INT_MAX) die("latest-rev failed");
+	read_command_end();
+
+	to = min(last_revision, (int) n);
+
+	fprintf(stderr, "request log for %d %d\n", from, to);
+
+	/* gc --auto invalidates the object cache. Thus we have to run
+	 * it last. For when we want to run the update in multiple
+	 * bunches then we spawn off a sub command for each chunk.
+	 */
+	if (!inner && to > from + FETCH_AT_ONCE) {
+		struct strbuf revs = STRBUF_INIT;
+		struct strbuf conns = STRBUF_INIT;
+
+		while (from < to) {
+			int ret;
+			int cmdto = min(from + FETCH_AT_ONCE, to);
+			const char* args[] = {
+				"svn-fetch",
+				"-c", print_arg(&conns, "%d", svnfdc),
+				"-r", print_arg(&revs, "%d", cmdto),
+				"--user", svnuser,
+				"--inner",
+				verbose ? "-v" : NULL,
+				NULL
+			};
+
+			ret = run_command_v_opt(args, RUN_GIT_CMD);
+			if (ret) return ret;
+
+			from = cmdto;
+		}
+
+		return 0;
+	}
+
+	if (from >= to) {
+		return 0;
+	}
+
+	change_connection(svnfdc, defauthor);
+	request_log(from+1, to);
+	read_success();
+
+	/* start requesting commits until we've filled out pending
+	 * commits or run out of commits */
+	i = 0;
+	finished = 0;
+	while (i < svnfdc) {
+		struct pending* p = &pending[i];
+
+		change_connection(svnfdc, defauthor);
+		if (!have_next_commit(p)) {
+			finished = 1;
+			break;
+		}
+		change_connection(i, defauthor);
+		request_commit(p->ref, p->rev, p->copysrc, p->copyrev);
+
+		i++;
+	}
+
+	i = 0;
+	for (;;) {
+		struct pending* p = &pending[i];
+
+		/* process a commit */
+		if (!p->ref) break;
+
+		/* Only update the latest when we've moved onto a new
+		 * revision. That way if we fail after the first of two
+		 * branch updates in a revision we replay the whole
+		 * revision next time. */
+		if (svncmt && p->rev > latest_fetch_rev()) {
+			set_latest_fetch(svncmt);
+		}
+
+		if (p->copysrc) {
+			struct commit* c = find_svncmt(p->copysrc, p->copyrev);
+			checkout_svncmt(p->ref, c);
+		}
+
+		change_connection(i, defauthor);
+		read_update(p->ref, p->rev);
+		svncmt = create_fetched_commit(p->ref, p->rev, p->author, p->time, p->msg, p->copysrc != NULL);
+		free(p->buf);
+
+		/* then request a new one on that connection */
+		change_connection(svnfdc, defauthor);
+		if (!finished && have_next_commit(p)) {
+			change_connection(i, defauthor);
+			request_commit(p->ref, p->rev, p->copysrc, p->copyrev);
+		} else {
+			finished = 1;
+			p->ref = NULL;
+		}
+
+		i = (i+1) % svnfdc;
+	}
+
+	if (svncmt) {
+		set_latest_fetch(svncmt);
+	}
+
+	return run_gc_auto();
+}
+
+static const char* dtoken(int dir) {
+	static int bufnum;
+	static char bufs[4][32];
+	char* buf1 = bufs[bufnum++ & 3];
+	char* buf2 = bufs[bufnum++ & 3];
+	sprintf(buf1, "d%d", dir);
+	sprintf(buf2, "%d:%s", (int) strlen(buf1), buf1);
+	return buf2;
+}
+
+static int fcount;
+static const char* ftoken() {
+	static char buf[32];
+	sprintf(buf, "f%d", ++fcount);
+	sprintf(buf, "%d:f%d", (int) strlen(buf), fcount);
+	return buf;
+}
+
+/* check that no commits have been inserted on our branch between from
+ * (the previous revision at which we saw a change) and to (the revision
+ * we just commited) */
+static void check_for_svn_commits(struct svnref* r, int from, int to) {
+	if (from + 1 >= to) {
+		return;
+	}
+
+	sendf("( log ( ( %d:%s ) " /* (path...) */
+			"( %d ) ( %d ) " /* start/end revno */
+			"false false " /* changed-paths strict-node */
+			"0 false " /* limit include-merged-revisions */
+			"revprops ( ) ) )\n",
+		(int) r->svn.len,
+		r->svn.buf,
+		from + 1,
+		to - 1);
+
+	read_success();
+	if (!read_list()) {
+		die("commits inserted during push");
+	}
+
+	read_done();
+	read_success();
+}
+
+static size_t common_directory(const char* a, const char* b, int* depth) {
+	int off;
+	const char* ab = a;
+
+	off = 0;
+	while (*a && *b && *a == *b) {
+		if (*a == '/') {
+			(*depth)++;
+			off = a + 1 - ab;
+		}
+		a++;
+		b++;
+	}
+
+	return off;
+}
+
+static struct strbuf cpath = STRBUF_INIT;
+static int cdepth;
+
+static int change_dir(const char* path) {
+	const char *p, *d;
+	int off, depth = 0;
+
+	off = common_directory(path, cpath.buf, &depth);
+
+	/* cd .. to the common root */
+	while (cdepth > depth) {
+		sendf("( close-dir ( %s ) )\n", dtoken(cdepth));
+		cdepth--;
+	}
+
+	strbuf_setlen(&cpath, off);
+
+	/* cd down to the new path */
+	d = p = path + off;
+	for (;;) {
+		char* d = strchr(p, '/');
+		if (!d) break;
+
+		sendf("( open-dir ( %d:%.*s %s %s ( ) ) )\n",
+			(int) (d - path), (int) (d - path), path,
+			dtoken(cdepth),
+			dtoken(cdepth+1));
+
+		/* include the / at the end */
+		d++;
+		strbuf_add(&cpath, p, d - p);
+		p = d;
+		cdepth++;
+	}
+
+	return cdepth;
+}
+
+static void dir_changed(int dir, const char* path) {
+	strbuf_reset(&cpath);
+	strbuf_addstr(&cpath, path);
+	if (*path) strbuf_addch(&cpath, '/');
+	cdepth = dir;
+}
+
+static void send_delta_chunk(const char* tok, const void* data, size_t sz) {
+	sendf("( textdelta-chunk ( %s %d:", tok, (int) sz);
+
+	print_ascii(data, sz, MAX_PRINT_LEN);
+
+	if (write_in_full(svnfd, data, sz) != sz) {
+		die_errno("write");
+	}
+
+	sendf(" ) )\n");
+}
+
+#define MAX_DELTA_SIZE (32*1024)
+
+static void send_file(const char* tok, char *data, size_t sz) {
+	struct strbuf dataz = STRBUF_INIT;
+	z_stream z;
+
+	memset(&z, 0, sizeof(z));
+
+	sendf("( apply-textdelta ( %s ( ) ) )\n", tok);
+
+	send_delta_chunk(tok, "SVN\1", 4);
+
+	while (sz > 0) {
+		unsigned char hdr[7*MAX_VARINT_LEN+MAX_INS_LEN], *hp = hdr;
+		unsigned char ins[MAX_INS_LEN], *inp;
+		size_t d = min(MAX_DELTA_SIZE, sz);
+		int ret = Z_OK;
+
+		z.next_in = (unsigned char*) data;
+		z.avail_in = d;
+		strbuf_reset(&dataz);
+
+		deflateInit(&z, Z_DEFAULT_COMPRESSION);
+
+		while (ret == Z_OK) {
+			strbuf_grow(&dataz, dataz.len + MAX_DELTA_SIZE);
+			z.next_out = (unsigned char*) dataz.buf + dataz.len;
+			z.avail_out = MAX_DELTA_SIZE;
+			ret = deflate(&z, Z_FINISH);
+			strbuf_setlen(&dataz, MAX_DELTA_SIZE - z.avail_out);
+		}
+
+		deflateEnd(&z);
+
+		inp = encode_instruction(ins, FROM_NEW, 0, d);
+
+		hp = encode_varint(hp, 0); /* source off */
+		hp = encode_varint(hp, 0); /* source len */
+		hp = encode_varint(hp, d); /* target len */
+		hp = encode_varint(hp, inp - ins + encoded_length(inp - ins)); /* ins compressed len */
+		hp = encode_varint(hp, dataz.len + encoded_length(d)); /* compressed data len */
+		hp = encode_varint(hp, inp - ins); /* ins decompressed len */
+		memcpy(hp, ins, inp - ins); /* instructions */
+		hp += inp - ins;
+		hp = encode_varint(hp, d); /* decompressed data len */
+
+		send_delta_chunk(tok, hdr, hp - hdr);
+		send_delta_chunk(tok, dataz.buf, dataz.len);
+
+		data += d;
+		sz -= d;
+
+	}
+
+	sendf("( textdelta-end ( %s ) )\n", tok);
+
+	strbuf_release(&dataz);
+}
+
+static void change(struct diff_options* op,
+		unsigned omode,
+		unsigned nmode,
+		const unsigned char* osha1,
+		const unsigned char* nsha1,
+		const char* svnpath,
+		unsigned odsubmodule,
+		unsigned ndsubmodule)
+{
+	struct svnref* r = op->format_callback_data;
+	int svnlen = (int) strlen(svnpath);
+	const char *gitpath = r->svn.len ? svnpath + r->svn.len : svnpath;
+	int gitlen = svnpath + svnlen - gitpath;
+	struct cache_entry* ce;
+	struct strbuf buf = STRBUF_INIT;
+	enum object_type type;
+	const char* tok;
+	char* data;
+	int dir;
+	size_t sz;
+
+	if (verbose) fprintf(stderr, "change mode %x/%x sha1 %s/%s path %s\n",
+			omode, nmode, sha1_to_hex(osha1), sha1_to_hex(nsha1), svnpath);
+
+	/* dont care about changed directories */
+	if (!S_ISREG(nmode)) return;
+
+	dir = change_dir(svnpath);
+
+	ce = index_name_exists(svn_index(r), gitpath, gitlen, 0);
+	if (!ce) {
+		/* file exists in git but not in svn */
+		return;
+	}
+
+	/* TODO make this actually use diffcore */
+
+	data = read_sha1_file(nsha1, &type, &sz);
+	if (type != OBJ_BLOB)
+		die("unexpected object type for %s", sha1_to_hex(nsha1));
+
+	if (convert_to_working_tree(gitpath, data, sz, &buf)) {
+		unsigned char sha1[20];
+		free(data);
+		data = strbuf_detach(&buf, &sz);
+
+		if (write_sha1_file(data, sz, "blob", sha1)) {
+			die_errno("blob write");
+		}
+
+		ce = make_cache_entry(0644, sha1, gitpath, 0, 0);
+		add_index_entry(svn_index(r), ce, ADD_CACHE_OK_TO_REPLACE);
+	}
+
+	tok = ftoken();
+	sendf("( open-file ( %d:%s %s %s ( ) ) )\n",
+		svnlen, svnpath, dtoken(dir), tok);
+
+	send_file(tok, data, sz);
+
+	sendf("( close-file ( %s ( ) ) )\n", tok);
+
+	diff_change(op, omode, nmode, osha1, nsha1, gitpath, odsubmodule, ndsubmodule);
+
+	free(data);
+}
+
+static void addremove(struct diff_options* op,
+		int addrm,
+		unsigned mode,
+		const unsigned char* sha1,
+		const char* svnpath,
+		unsigned dsubmodule)
+{
+	static struct strbuf buf = STRBUF_INIT;
+	struct svnref* r = op->format_callback_data;
+	int svnlen = strlen(svnpath);
+	const char *gitpath = r->svn.len ? svnpath + r->svn.len : svnpath;
+	int gitlen = svnpath + svnlen - gitpath;
+
+	if (verbose) fprintf(stderr, "addrm %c mode %x sha1 %s path %s\n",
+			addrm, mode, sha1_to_hex(sha1), svnpath);
+
+	if (addrm == '-' && S_ISDIR(mode)) {
+		strbuf_reset(&buf);
+		strbuf_add(&buf, gitpath, gitlen);
+		if (remove_index_path(svn_index(r), &buf) > 0) {
+			int dir = change_dir(svnpath);
+			sendf("( delete-entry ( %d:%s ( ) %s ) )\n",
+				svnlen, svnpath, dtoken(dir));
+		}
+
+	} else if (addrm == '+' && S_ISDIR(mode)) {
+		int dir = change_dir(svnpath);
+		sendf("( add-dir ( %d:%s %s %s ( ) ) )\n",
+			svnlen, svnpath, dtoken(dir), dtoken(dir+1));
+
+		dir_changed(++dir, svnpath);
+
+	} else if (addrm == '-' && S_ISREG(mode)) {
+		strbuf_reset(&buf);
+		strbuf_add(&buf, gitpath, gitlen);
+		if (remove_index_path(svn_index(r), &buf) > 0) {
+			int dir = change_dir(svnpath);
+			sendf("( delete-entry ( %d:%s ( ) %s ) )\n",
+				svnlen, svnpath, dtoken(dir));
+		}
+
+	} else if (addrm == '+' && S_ISREG(mode)) {
+		struct cache_entry* ce;
+		unsigned char nsha1[20];
+		struct strbuf buf = STRBUF_INIT;
+		enum object_type type;
+		const char* tok;
+		void* data;
+		size_t sz;
+		int dir;
+
+		/* files beginning with .git eg .gitempty,
+		 * .gitattributes, etc are filtered from svn
+		 */
+		const char* p = strrchr(gitpath, '/');
+		p = p ? p+1 : gitpath;
+		if (!prefixcmp(p, ".git")) {
+			return;
+		}
+
+		hashcpy(nsha1, sha1);
+		data = read_sha1_file(nsha1, &type, &sz);
+		if (!data || type != OBJ_BLOB)
+			die("unexpected object type for %s", sha1_to_hex(sha1));
+
+		if (convert_to_working_tree(gitpath, data, sz, &buf)) {
+			free(data);
+			data = strbuf_detach(&buf, &sz);
+
+			if (write_sha1_file(data, sz, "blob", nsha1)) {
+				die_errno("blob write");
+			}
+		}
+
+		ce = make_cache_entry(0644, nsha1, gitpath, 0, 0);
+		add_index_entry(svn_index(r), ce, ADD_CACHE_OK_TO_ADD);
+
+		/* TODO: use diffcore to find copies */
+
+		dir = change_dir(svnpath);
+		tok = ftoken();
+		sendf("( add-file ( %d:%s %s %s ( ) ) )\n",
+			svnlen, svnpath, dtoken(dir), tok);
+
+		send_file(tok, data, sz);
+
+		sendf("( close-file ( %s ( ) ) )\n", tok);
+
+		free(data);
+	}
+
+	diff_addremove(op, addrm, mode, sha1, svnpath, dsubmodule);
+}
+
+static int read_commit_revno(struct strbuf* time) {
+	int64_t n;
+
+	read_success();
+	read_success();
+
+	/* commit-info */
+	if (read_list()) goto err;
+	n = read_number();
+	if (n < 0 || n > INT_MAX) goto err;
+	if (have_optional() && time) {
+		read_string(time);
+		svn_time_to_git(time);
+		read_end();
+	}
+	read_end();
+	if (verbose) fputc('\n', stderr);
+
+	return (int) n;
+
+err:
+	die("commit failed");
+}
+
+/* returns the rev number */
+static int send_commit(struct svnref* r, struct commit* cmt, struct commit* copysrc, const char* log, struct strbuf* time) {
+	struct diff_options op;
+	int dir;
+
+	/* If we are creating a new ref that we have never seen before
+	 * in SVN, then the target is just above the last fetch, as that
+	 * is the last time we checked the branches/tags folder for new
+	 * refs. Otherwise its just above the last time we pushed/pulled
+	 * this ref.
+	 */
+	int tgtrev = (r->svncmt ? parse_svnrev(r->svncmt) : latest_fetch_rev()) + 1;
+
+	sendf("( commit ( %d:%s ) )\n", (int) strlen(log), log);
+	sendf("( target-rev ( %d ) )\n", tgtrev);
+	sendf("( open-root ( ( ) %s ) )\n", dtoken(0));
+
+	read_success();
+	read_success();
+
+	dir = change_dir(r->svn.buf);
+
+	if (!cmt) {
+		sendf("( delete-entry ( %d:%s ( ) %s ) )\n",
+				(int) r->svn.len,
+				r->svn.buf,
+				dtoken(dir));
+	} else {
+		if (copysrc) {
+			struct strbuf path = STRBUF_INIT;
+			parse_svnpath(copysrc, &path);
+
+			if (r->gitobj) {
+				sendf("( delete-entry ( %d:%s ( ) %s ) )\n",
+						(int) r->svn.len,
+						r->svn.buf,
+						dtoken(dir));
+			}
+
+			sendf("( add-dir ( %d:%s %s %s ( %d:%s/%s %d ) ) )\n",
+					(int) r->svn.len,
+					r->svn.buf,
+					dtoken(dir),
+					dtoken(dir+1),
+					(int) (strlen(url) + 1 + path.len),
+					url,
+					path.buf,
+					parse_svnrev(copysrc));
+
+			strbuf_release(&path);
+		} else {
+			/* We never have to create the root */
+			sendf("( %s ( %d:%s %s %s ( ) ) )\n",
+				(!r->gitobj && r->svn.len) ? "add-dir" : "open-dir",
+				(int) r->svn.len,
+				r->svn.buf,
+				dtoken(dir),
+				dtoken(dir+1));
+		}
+
+		dir_changed(++dir, r->svn.buf);
+
+		diff_setup(&op);
+		op.output_format = DIFF_FORMAT_NO_OUTPUT;
+		op.change = &change;
+		op.add_remove = &addremove;
+		op.format_callback_data = r;
+		DIFF_OPT_SET(&op, RECURSIVE);
+		DIFF_OPT_SET(&op, IGNORE_SUBMODULES);
+		DIFF_OPT_SET(&op, TREE_IN_RECURSIVE);
+
+		if (r->svn.len) {
+			strbuf_addch(&r->svn, '/');
+		}
+
+		if (r->parent) {
+			if (diff_tree_sha1(cmt_sha1(r->parent), cmt_sha1(cmt), r->svn.buf, &op))
+				die("diff tree failed");
+		} else {
+			if (diff_root_tree_sha1(cmt_sha1(cmt), r->svn.buf, &op))
+				die("diff tree failed");
+		}
+
+		if (r->svn.len) {
+			strbuf_setlen(&r->svn, r->svn.len - 1);
+		}
+
+		diffcore_std(&op);
+		diff_flush(&op);
+	}
+
+	change_dir("");
+	sendf("( close-dir ( %s ) )\n", dtoken(0));
+	sendf("( close-edit ( ) )\n");
+
+	return read_commit_revno(time);
+}
+
+struct push {
+	struct push* next;
+	struct object* old;
+	struct object* new;
+	struct svnref* ref;
+	struct commit* copysrc;
+};
+
+/* logobj is used for the log message and author, gitcmt is used for the
+ * tree. gitcmt is non NULL on branch mod and creation, NULL on
+ * deletion. logobj will be NULL for branch deletion and branch creation
+ * where gitcmt is for another branch in svn.
+ */
+static void push_commit(struct push* p, struct object* logobj, struct commit* gitcmt) {
+	static struct strbuf buf = STRBUF_INIT;
+	static struct strbuf time = STRBUF_INIT;
+	static struct strbuf logbuf = STRBUF_INIT;
+
+	int rev;
+	unsigned char sha1[20];
+	struct ref_lock* lk;
+	const char* log;
+	struct svnref *r = p->ref;
+	struct author *auth = logobj ? get_object_author(logobj) : defauthor;
+	struct commit *svncmt;
+
+	fprintf(stderr, "push commit %s\n", cmt_to_hex(gitcmt));
+
+	change_connection(0, auth);
+
+	if (!logobj) {
+		strbuf_reset(&logbuf);
+		strbuf_addf(&logbuf, "%s %s\n",
+			r->parent ? "Create" : "Remove",
+			r->svn.buf);
+		log = logbuf.buf;
+
+	} else if (logobj->type == OBJ_COMMIT) {
+		find_commit_subject(((struct commit*) logobj)->buffer, &log);
+
+	} else if (logobj->type == OBJ_TAG) {
+		unsigned long size;
+		enum object_type type;
+		char* data = read_sha1_file(logobj->sha1, &type, &size);
+		find_commit_subject(data, &log);
+		strbuf_reset(&logbuf);
+		strbuf_add(&logbuf, log, parse_signature(log, data + size - log));
+		free(data);
+		log = logbuf.buf;
+
+	} else {
+		die("unexpected type");
+	}
+
+	strbuf_reset(&time);
+	rev = send_commit(r, gitcmt, p->copysrc, log, &time);
+
+	/* If we find any intermediate commits, we die. They will be
+	 * picked up the next time the user does a pull.  If we have
+	 * just created a branch then the svn server will check this for
+	 * us by failing on the add-dir. If we have just replaced a
+	 * branch then we don't really care as the git history for this
+	 * branch wouldn't have referenced those commits anyways (they
+	 * will be picked up on the next fetch though in case they are
+	 * copied on the svn side later).
+	 */
+	if (!p->copysrc && r->svncmt) {
+		check_for_svn_commits(r, parse_svnrev(r->svncmt), rev);
+	}
+
+	/* create the svn object */
+
+	strbuf_reset(&buf);
+	strbuf_addf(&buf, "tree %s\n", sha1_to_hex(idx_sha1(svn_index(r))));
+
+	if (gitcmt || r->svncmt) {
+		strbuf_addf(&buf, "parent %s\n", cmt_to_hex(gitcmt ? gitcmt : r->svncmt));
+	}
+
+	if (r->svncmt) {
+		strbuf_addf(&buf, "parent %s\n", cmt_to_hex(r->svncmt));
+	}
+
+	strbuf_addf(&buf, "author %s <%s> %s +0000\n", auth->name, auth->mail, time.buf);
+	strbuf_addf(&buf, "committer %s <%s> %s +0000\n", auth->name, auth->mail, time.buf);
+	strbuf_addf(&buf, "revision %d\n", rev);
+	strbuf_addf(&buf, "path %s\n", r->svn.buf);
+	strbuf_addch(&buf, '\n');
+
+	if (write_sha1_file(buf.buf, buf.len, "commit", sha1))
+		die("failed to create svn commit");
+
+	svncmt = lookup_commit(sha1);
+	if (!svncmt || parse_commit(svncmt))
+		die("failed to parse created svn commit");
+
+	/* update the ref */
+
+	lk = lock_ref_sha1(r->ref.buf + strlen("refs/"), cmt_sha1(r->svncmt));
+	if (!lk || write_ref_sha1(lk, cmt_sha1(svncmt), "svn-push"))
+		die("failed to grab ref lock for %s", r->ref.buf);
+
+	/* update the remote */
+
+	if (leave_remote) {
+		/* we don't update 'remotes' that are not stored in a
+		 * remote directory (e.g. refs/tags/ or refs/heads/ when
+		 * svn.remote is not set)
+		 */
+
+	} else if (gitcmt) {
+		lk = lock_ref_sha1(r->remote.buf + strlen("refs/"), r->gitobj ? r->gitobj->sha1 : null_sha1);
+		if (!lk || write_ref_sha1(lk, cmt_sha1(gitcmt), "svn-push"))
+			die("failed to update ref %s", r->remote.buf);
+
+	} else if (r->gitobj) {
+		if (delete_ref(r->remote.buf, r->gitobj->sha1, 0))
+			die("failed to delete ref %s", r->remote.buf);
+
+	}
+
+	r->svncmt = svncmt;
+	r->parent = gitcmt;
+	p->copysrc = NULL;
+
+	if (logobj) {
+		r->gitobj = logobj;
+	} else if (gitcmt) {
+		r->gitobj = &gitcmt->object;
+	} else {
+		r->gitobj = NULL;
+	}
+
+	if (pause_between_commits) {
+		int fd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
+		struct sockaddr_in addr;
+		addr.sin_addr.s_addr = ntohl(INADDR_LOOPBACK);
+		addr.sin_port = htons(pause_between_commits);
+		bind(fd, (struct sockaddr*) &addr, sizeof(addr));
+		listen(fd, SOMAXCONN);
+		close(accept(fd, NULL, NULL));
+		close(accept(fd, NULL, NULL));
+		close(fd);
+		pause_between_commits = 0;
+	}
+}
+
+static int has_parent(struct commit *c, struct commit *parent) {
+	struct commit_list *p = c->parents;
+
+	/* null parents are only parents of root commits */
+	if (!parent) {
+		return p == NULL;
+	}
+
+	while (p) {
+		if (p->item == parent) {
+			return 1;
+		}
+		p = p->next;
+	}
+	return 0;
+}
+
+static void do_push(struct push* p) {
+	struct svnref* r = p->ref;
+	struct commit* cmt;
+	struct rev_info walk;
+
+	if (p->old != r->gitobj) {
+		die("non fast-forward for %s", r->ref.buf);
+	}
+
+	if (p->old && !p->new) {
+		/* deleting a ref */
+		push_commit(p, NULL, NULL);
+
+	} else if (p->new != p->old) {
+		/* add/modify/replace a ref */
+		int have_commits = 0;
+		struct commit *new = (struct commit*) deref_tag(p->new, NULL, 0);
+
+		if (!new || new->object.type != OBJ_COMMIT)
+			die("invalid tag %s", sha1_to_hex(p->new->sha1));
+
+		init_revisions(&walk, NULL);
+		add_pending_object(&walk, &new->object, "to");
+		walk.reverse = 1;
+
+		if (p->old) {
+			struct object *old = deref_tag(p->old, NULL, 0);
+			if (!old || old->type != OBJ_COMMIT)
+				die("invalid tag %s", sha1_to_hex(p->old->sha1));
+
+			old->flags |= UNINTERESTING;
+			add_pending_object(&walk, old, "from");
+		}
+
+		if (p->copysrc) {
+			struct object* obj = &svn_commit(p->copysrc)->object;
+			obj->flags |= UNINTERESTING;
+			add_pending_object(&walk, obj, "from");
+			/* sets r->parent for the has_parent check below */
+			checkout_svncmt(r, p->copysrc);
+		}
+
+		if (prepare_revision_walk(&walk))
+			die("prepare rev walk failed");
+
+		while ((cmt = get_revision(&walk)) != NULL) {
+			/* The revwalk gives us all paths that go from
+			 * copysrc or p->old to cmt. We can work with
+			 * any of these so pick one arbitrarily by using
+			 * r->parent. r->parent is set by
+			 * checkout_svncmt above for add/replace.
+			 */
+			if (!has_parent(cmt, r->parent)) continue;
+
+			if (cmt == new) {
+				/* use the tag object in p->new for the
+				 * log message */
+				push_commit(p, p->new, cmt);
+			} else {
+				push_commit(p, &cmt->object, cmt);
+			}
+
+			have_commits = 1;
+		}
+
+		/* if there were no commits we have to force through a
+		 * commit to create/replace the branch/tag in svn. */
+
+		if (r->gitobj != p->new) {
+			/* If we have an annotated tag, we can use that
+			 * for a log statement. Otherwise we have to
+			 * create a message.
+			 */
+			struct object *logobj = (p->new != &new->object) ? p->new : NULL;
+			push_commit(p, logobj, new);
+		}
+
+		reset_revision_walk();
+	}
+}
+
+static void new_push(struct push** list, const char* ref, const char* oldref, const char* newref) {
+	unsigned char old[20], new[20];
+	struct push *p = xcalloc(1, sizeof(*p));
+
+	if (get_sha1(oldref, old))
+		die("invalid ref %s", oldref);
+
+	if (get_sha1(newref, new))
+		die("invalid ref %s", newref);
+
+	if (!is_null_sha1(old)) {
+		p->old = parse_object(old);
+		if (!p->old)
+			die("invalid ref %s", oldref);
+	}
+
+	if (!is_null_sha1(new)) {
+		p->new = parse_object(new);
+		if (!p->new)
+			die("invalid ref %s", newref);
+	}
+
+	p->ref = find_svnref_by_refname(ref);
+	p->next = *list;
+	*list = p;
+}
+
+int cmd_svn_push(int argc, const char **argv, const char *prefix) {
+	struct push *updates = NULL, *p;
+	char buf[256];
+
+	git_config(&config, NULL);
+
+	argc = parse_options(argc, argv, prefix, builtin_svn_push_options,
+			builtin_svn_push_usage, 0);
+
+	setup_globals();
+
+	/* get the list of references to push */
+	if (push_from_stdin) {
+		if (argc)
+			usage_msg_opt( _("Too many arguments."),
+				builtin_svn_push_usage, builtin_svn_push_options);
+
+
+		while (fgets(buf, sizeof(buf), stdin)) {
+			size_t sz = strlen(buf);
+			if (sz <= 82) continue;
+
+			if (buf[sz-1] == '\n') {
+				buf[--sz] = '\0';
+			}
+			if (buf[sz-1] == '\r') {
+				buf[--sz] = '\0';
+			}
+
+			buf[40] = '\0';
+			buf[81] = '\0';
+			new_push(&updates, &buf[82], &buf[0], &buf[41]);
+		}
+	} else {
+		if (argc != 3)
+			usage_msg_opt(argc > 3 ? _("Too many arguments.") : _("Too few arguments"),
+				builtin_svn_push_usage, builtin_svn_push_options);
+
+		new_push(&updates, argv[0], argv[1], argv[2]);
+	}
+
+	/* modify/delete refs */
+	for (p = updates; p != NULL; p = p->next) {
+		if (p->new) {
+			p->copysrc = find_copy_source(p->ref, p->new);
+		}
+		if (p->old && (!p->copysrc || deref_tag(p->old, NULL, 0) == &svn_commit(p->copysrc)->object)) {
+			p->copysrc = NULL;
+			do_push(p);
+			p->ref = NULL;
+		}
+	}
+
+	/* add/replace refs - do this last so we can find copy bases in
+	 * the modified refs. Note if two added refs have a common
+	 * commit branching off of svn then those common commits will be
+	 * assigned to whichever ref comes first (i.e. unspecified). */
+	for (p = updates; p != NULL; p = p->next) {
+		if (p->ref) {
+			p->copysrc = find_copy_source(p->ref, p->new);
+			do_push(p);
+		}
+	}
+
+	return 0;
+}
diff --git a/command-list.txt b/command-list.txt
index ec64cac..64f6d6d 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -120,6 +120,8 @@ git-status                              mainporcelain common
 git-stripspace                          purehelpers
 git-submodule                           mainporcelain
 git-svn                                 foreignscminterface
+git-svn-fetch				foreignscminterface
+git-svn-push				foreignscminterface
 git-symbolic-ref                        plumbingmanipulators
 git-tag                                 mainporcelain common
 git-tar-tree                            plumbinginterrogators	deprecated
diff --git a/git.c b/git.c
index 8788b32..c861b5a 100644
--- a/git.c
+++ b/git.c
@@ -425,6 +425,8 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 		{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 		{ "stripspace", cmd_stripspace },
+		{ "svn-fetch", cmd_svn_fetch, RUN_SETUP },
+		{ "svn-push", cmd_svn_push, RUN_SETUP },
 		{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
 		{ "tag", cmd_tag, RUN_SETUP },
 		{ "tar-tree", cmd_tar_tree },
diff --git a/svn-sync.sh b/svn-sync.sh
new file mode 100755
index 0000000..af8a66e
--- /dev/null
+++ b/svn-sync.sh
@@ -0,0 +1,150 @@
+#!/bin/sh
+
+make
+
+rm -rf svn
+mkdir svn
+cd svn
+
+#Setup the test database
+svnadmin create db
+
+cat > db/conf/passwd <<!
+[users]
+user = pass
+!
+
+cat > db/conf/svnserve.conf <<!
+[general]
+anon-access = none
+auth-access = write
+password-db = passwd
+realm = Test Repository
+!
+
+# Setup the subversion repo
+killall svnserve
+killall lt-svnserve
+svnserve --daemon --log-file svnlog --root db
+
+svn co --username user --password pass svn://localhost co
+cd co
+svn mkdir trunk
+cd trunk
+cat > file.txt <<!
+Some file contents
+Some more
+
+!
+svn add file.txt
+svn ci -m 'add file.txt'
+
+svn mkdir --parents a/b/c/d/e/f
+cat > a/b/c/d/e/f/deep.txt <<!
+Some deep contents
+.....
+!
+svn add a/b/c/d/e/f/deep.txt
+svn ci -m 'add deep.txt'
+svn up
+
+svn rm file.txt
+svn ci -m 'remove file.txt'
+svn up
+
+svn mkdir svn://localhost/tags -m 'create tags folder'
+
+svn rm a/b
+svn ci -m 'remove folder a/b'
+svn up
+
+cat > a/foo.txt <<!
+Some other contents for foo.txt
+!
+svn add a/foo.txt
+svn ci -m 'add foo.txt'
+svn up
+
+svn mv a b
+svn ci -m 'move folder'
+svn up
+
+svn mv b/foo.txt b/foo2.txt
+svn ci -m 'move file'
+svn up
+
+cd ..
+#echo "some new text" >> trunk/b/foo2.txt
+#echo "some new file" > trunk/b/foo.txt
+#svn add trunk/b/foo.txt
+#svn mkdir fake
+#svn ci -m 'git commit add/mod'
+#exit
+
+svn mkdir branches
+svn ci -m 'create branches folder'
+svn up
+
+svn cp svn://localhost/trunk svn://localhost/branches/foobranch -m 'create branch'
+svn cp svn://localhost/trunk@4 svn://localhost/tags/footag -m 'create tag'
+
+cd ..
+git init
+
+cat > .git/svn-authors <<!
+# Some comment
+
+user:pass = James M <james@example.com>
+!
+
+../git-svn-fetch -v -r 3 -t trunk -b branches -T tags --user user --pass pass svn://localhost
+../git-svn-fetch -v -t trunk -b branches -T tags --user user --pass pass svn://localhost
+
+git config user.name 'James M'
+git config user.email 'james@example.com'
+
+
+git checkout -b master svn/master
+
+echo "some new text" >> b/foo2.txt
+echo "some new file" > b/foo.txt
+git add b/foo.txt b/foo2.txt
+git commit -m 'git commit add/mod'
+
+mkdir -p b/c
+echo "some more text" >> b/c/foo.txt
+git add b/c/foo.txt
+git commit -m 'git commit 2'
+
+git rm -rf b
+git commit -m 'some removals'
+
+
+git checkout -b foobranch svn/foobranch
+
+echo "some branch file" >> b/foo2.txt
+git add b/foo2.txt
+git commit -m 'git branch commit'
+
+../git svn-push -v -t trunk -b branches -T tags svn://localhost heads/master svn/master master
+../git svn-push -v -t trunk -b branches -T tags svn://localhost heads/foobranch svn/foobranch foobranch
+
+cat > .git/hooks/pre-receive <<!
+#!/bin/sh
+exec $PWD/../git-svn-push -v -t trunk -b branches -T tags --pre-receive svn://localhost
+!
+
+chmod +x .git/hooks/pre-receive
+git config receive.denyCurrentBranch ignore
+
+../git clone -- . gitco
+cd gitco
+
+git config user.name 'James M'
+git config user.email 'james@example.com'
+
+echo "some mod" >> b/foo2.txt
+../../git add b/foo2.txt
+../../git commit -m 'git clone commit'
+../../git push
+
-- 
1.7.11.3
