From: Jeff King <peff@peff.net>
Subject: [PATCHv2 12/13] credentials: add "store" helper
Date: Tue, 6 Dec 2011 01:23:05 -0500
Message-ID: <20111206062305.GL29233@sigill.intra.peff.net>
References: <20111206062127.GA29046@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 07:23:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXoQv-0004m6-7R
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 07:23:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933000Ab1LFGXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 01:23:10 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40060
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932992Ab1LFGXI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 01:23:08 -0500
Received: (qmail 1359 invoked by uid 107); 6 Dec 2011 06:29:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 Dec 2011 01:29:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Dec 2011 01:23:05 -0500
Content-Disposition: inline
In-Reply-To: <20111206062127.GA29046@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186331>

This is like "cache", except that we actually put the
credentials on disk. This can be terribly insecure, of
course, but we do what we can to protect them by filesystem
permissions, and we warn the user in the documentation.

This is not unlike using .netrc to store entries, but it's a
little more user-friendly. Instead of putting credentials in
place ahead of time, we transparently store them after
prompting the user for them once.

Signed-off-by: Jeff King <peff@peff.net>
---
 .gitignore                             |    1 +
 Documentation/git-credential-store.txt |   75 ++++++++++++++++
 Documentation/gitcredentials.txt       |    5 +
 Makefile                               |    1 +
 credential-store.c                     |  148 ++++++++++++++++++++++++++++++++
 t/t0302-credential-store.sh            |    9 ++
 6 files changed, 239 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-credential-store.txt
 create mode 100644 credential-store.c
 create mode 100755 t/t0302-credential-store.sh

diff --git a/.gitignore b/.gitignore
index a6b0bd4..2b7a3f9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -32,6 +32,7 @@
 /git-count-objects
 /git-credential-cache
 /git-credential-cache--daemon
+/git-credential-store
 /git-cvsexportcommit
 /git-cvsimport
 /git-cvsserver
diff --git a/Documentation/git-credential-store.txt b/Documentation/git-credential-store.txt
new file mode 100644
index 0000000..3109346
--- /dev/null
+++ b/Documentation/git-credential-store.txt
@@ -0,0 +1,75 @@
+git-credential-store(1)
+=======================
+
+NAME
+----
+git-credential-store - helper to store credentials on disk
+
+SYNOPSIS
+--------
+-------------------
+git config credential.helper 'store [options]'
+-------------------
+
+DESCRIPTION
+-----------
+
+NOTE: Using this helper will store your passwords unencrypted on disk,
+protected only by filesystem permissions. If this is not an acceptable
+security tradeoff, try linkgit:git-credential-cache[1], or find a helper
+that integrates with secure storage provided by your operating system.
+
+This command stores credentials indefinitely on disk for use by future
+git programs.
+
+You probably don't want to invoke this command directly; it is meant to
+be used as a credential helper by other parts of git. See
+linkgit:gitcredentials[7] or `EXAMPLES` below.
+
+OPTIONS
+-------
+
+--store=<path>::
+
+	Use `<path>` to store credentials. The file will have its
+	filesystem permissions set to prevent other users on the system
+	from reading it, but will not be encrypted or otherwise
+	protected. Defaults to `~/.git-credentials`.
+
+EXAMPLES
+--------
+
+The point of this helper is to reduce the number of times you must type
+your username or password. For example:
+
+------------------------------------------
+$ git config credential.helper store
+$ git push http://example.com/repo.git
+Username: <type your username>
+Password: <type your password>
+
+[several days later]
+$ git push http://example.com/repo.git
+[your credentials are used automatically]
+------------------------------------------
+
+STORAGE FORMAT
+--------------
+
+The `.git-credentials` file is stored in plaintext. Each credential is
+stored on its own line as a URL like:
+
+------------------------------
+https://user:pass@example.com
+------------------------------
+
+When git needs authentication for a particular URL context,
+credential-store will consider that context a pattern to match against
+each entry in the credentials file.  If the protocol, hostname, and
+username (if we already have one) match, then the password is returned
+to git. See the discussion of configuration in linkgit:gitcredentials[7]
+for more information.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
index 4e3f860..066f825 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -71,6 +71,11 @@ cache::
 	Cache credentials in memory for a short period of time. See
 	linkgit:git-credential-cache[1] for details.
 
+store::
+
+	Store credentials indefinitely on disk. See
+	linkgit:git-credential-store[1] for details.
+
 You may also have third-party helpers installed; search for
 `credential-*` in the output of `git help -a`, and consult the
 documentation of individual helpers.  Once you have selected a helper,
diff --git a/Makefile b/Makefile
index 5d41c29..2537128 100644
--- a/Makefile
+++ b/Makefile
@@ -429,6 +429,7 @@ PROGRAM_OBJS += http-backend.o
 PROGRAM_OBJS += sh-i18n--envsubst.o
 PROGRAM_OBJS += credential-cache.o
 PROGRAM_OBJS += credential-cache--daemon.o
+PROGRAM_OBJS += credential-store.o
 
 PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 
diff --git a/credential-store.c b/credential-store.c
new file mode 100644
index 0000000..ed58768
--- /dev/null
+++ b/credential-store.c
@@ -0,0 +1,148 @@
+#include "cache.h"
+#include "credential.h"
+#include "string-list.h"
+#include "parse-options.h"
+
+static struct lock_file credential_lock;
+
+static void parse_credential_file(const char *fn,
+				  struct credential *c,
+				  void (*match_cb)(struct credential *),
+				  void (*other_cb)(struct strbuf *))
+{
+	FILE *fh;
+	struct strbuf line = STRBUF_INIT;
+	struct credential entry = CREDENTIAL_INIT;
+
+	fh = fopen(fn, "r");
+	if (!fh) {
+		if (errno != ENOENT)
+			die_errno("unable to open %s", fn);
+		return;
+	}
+
+	while (strbuf_getline(&line, fh, '\n') != EOF) {
+		credential_from_url(&entry, line.buf);
+		if (entry.username && entry.password &&
+		    credential_match(c, &entry)) {
+			if (match_cb) {
+				match_cb(&entry);
+				break;
+			}
+		}
+		else if (other_cb)
+			other_cb(&line);
+	}
+
+	credential_clear(&entry);
+	strbuf_release(&line);
+	fclose(fh);
+}
+
+static void print_entry(struct credential *c)
+{
+	printf("username=%s\n", c->username);
+	printf("password=%s\n", c->password);
+}
+
+static void print_line(struct strbuf *buf)
+{
+	strbuf_addch(buf, '\n');
+	write_or_die(credential_lock.fd, buf->buf, buf->len);
+}
+
+static void rewrite_credential_file(const char *fn, struct credential *c,
+				    struct strbuf *extra)
+{
+	if (hold_lock_file_for_update(&credential_lock, fn, 0) < 0)
+		die_errno("unable to get credential storage lock");
+	if (extra)
+		print_line(extra);
+	parse_credential_file(fn, c, NULL, print_line);
+	if (commit_lock_file(&credential_lock) < 0)
+		die_errno("unable to commit credential store");
+}
+
+static void store_credential(const char *fn, struct credential *c)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	/*
+	 * Sanity check that what we are storing is actually sensible.
+	 * In particular, we can't make a URL without a protocol field.
+	 * Without either a host or pathname (depending on the scheme),
+	 * we have no primary key. And without a username and password,
+	 * we are not actually storing a credential.
+	 */
+	if (!c->protocol || !(c->host || c->path) ||
+	    !c->username || !c->password)
+		return;
+
+	strbuf_addf(&buf, "%s://", c->protocol);
+	strbuf_addstr_urlencode(&buf, c->username, 1);
+	strbuf_addch(&buf, ':');
+	strbuf_addstr_urlencode(&buf, c->password, 1);
+	strbuf_addch(&buf, '@');
+	if (c->host)
+		strbuf_addstr_urlencode(&buf, c->host, 1);
+	if (c->path) {
+		strbuf_addch(&buf, '/');
+		strbuf_addstr_urlencode(&buf, c->path, 0);
+	}
+
+	rewrite_credential_file(fn, c, &buf);
+	strbuf_release(&buf);
+}
+
+static void remove_credential(const char *fn, struct credential *c)
+{
+	rewrite_credential_file(fn, c, NULL);
+}
+
+static int lookup_credential(const char *fn, struct credential *c)
+{
+	parse_credential_file(fn, c, print_entry, NULL);
+	return c->username && c->password;
+}
+
+int main(int argc, const char **argv)
+{
+	const char * const usage[] = {
+		"git credential-store [options] <action>",
+		NULL
+	};
+	const char *op;
+	struct credential c = CREDENTIAL_INIT;
+	char *file = NULL;
+	struct option options[] = {
+		OPT_STRING_LIST(0, "file", &file, "path",
+				"fetch and store credentials in <path>"),
+		OPT_END()
+	};
+
+	umask(077);
+
+	argc = parse_options(argc, argv, NULL, options, usage, 0);
+	if (argc != 1)
+		usage_with_options(usage, options);
+	op = argv[0];
+
+	if (!file)
+		file = expand_user_path("~/.git-credentials");
+	if (!file)
+		die("unable to set up default path; use --file");
+
+	if (credential_read(&c, stdin) < 0)
+		die("unable to read credential");
+
+	if (!strcmp(op, "get"))
+		lookup_credential(file, &c);
+	else if (!strcmp(op, "erase"))
+		remove_credential(file, &c);
+	else if (!strcmp(op, "store"))
+		store_credential(file, &c);
+	else
+		; /* Ignore unknown operation. */
+
+	return 0;
+}
diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
new file mode 100755
index 0000000..f61b40c
--- /dev/null
+++ b/t/t0302-credential-store.sh
@@ -0,0 +1,9 @@
+#!/bin/sh
+
+test_description='credential-store tests'
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-credential.sh
+
+helper_test store
+
+test_done
-- 
1.7.8.rc4.4.g884ec
