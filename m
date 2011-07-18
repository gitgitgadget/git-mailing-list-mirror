From: Jeff King <peff@peff.net>
Subject: [PATCH 13/14] credentials: add "store" helper
Date: Mon, 18 Jul 2011 03:58:14 -0400
Message-ID: <20110718075814.GM12341@sigill.intra.peff.net>
References: <20110718074642.GA11678@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 09:58:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qiiib-0006iY-NB
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 09:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242Ab1GRH6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 03:58:17 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56246
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750745Ab1GRH6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 03:58:16 -0400
Received: (qmail 20062 invoked by uid 107); 18 Jul 2011 07:58:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Jul 2011 03:58:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jul 2011 03:58:14 -0400
Content-Disposition: inline
In-Reply-To: <20110718074642.GA11678@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177357>

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
This reuses the gitconfig format for storage. Which is really kind of
limiting, because I want an extra layer of hierarchy:

  credential.$context.$username.password

So as it is now, it just looks up the username and password for a
context. But in theory, it should be able to handle multiple usernames
for a given context, and correctly look up passwords for
user1@example.com versus user2@example.com. In practice, I doubt it
really matters, though.

 .gitignore                             |    1 +
 Documentation/git-credential-store.txt |   69 +++++++++++++++++++++++++
 Documentation/gitcredentials.txt       |    5 ++
 Makefile                               |    1 +
 credential-store.c                     |   87 ++++++++++++++++++++++++++++++++
 t/t0300-credentials.sh                 |   55 ++++++++++++++++++++
 6 files changed, 218 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-credential-store.txt
 create mode 100644 credential-store.c

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
index 0000000..9fc0f76
--- /dev/null
+++ b/Documentation/git-credential-store.txt
@@ -0,0 +1,69 @@
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
+This command requests credentials from the user and stores them
+indefinitely on disk for use by future git programs.
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
+	protected.
+
+--chain <helper>::
+
+	Specify an external helper to use for retrieving credentials
+	from the user, instead of the default method. The resulting
+	credentials are then stored as normal. This option can be
+	given multiple times; each chained helper will be tried until
+	credentials are received.
+
+Git may provide other options to the program when it is called as a
+credential helper; see linkgit:gitcredentials[7].
+
+EXAMPLES
+--------
+
+The point of this helper is to reduce the number of times you must type
+your username or password. For example:
+
+------------------------------------
+$ git config credential.helper store
+$ git push http://example.com/repo.git
+Username: <type your username>
+Password: <type your password>
+
+[several days later]
+$ git push http://example.com/repo.git
+[your credentials are used automatically]
+------------------------------------
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
index bd1a3b6..33ea56c 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -88,6 +88,11 @@ cache::
 	Cache credentials in memory for a short period of time. See
 	linkgit:git-credential-cache[1] for details.
 
+store::
+
+	Store credentials indefinitely on disk. See
+	linkgit:git-credential-store[1] for details.
+
 You may may also have third-party helpers installed; search for
 `credential-*` in the output of `git help -a`, and consult the
 documentation of individual helpers.  Once you have selected a helper,
diff --git a/Makefile b/Makefile
index 2ecfd90..e818257 100644
--- a/Makefile
+++ b/Makefile
@@ -419,6 +419,7 @@ PROGRAM_OBJS += http-backend.o
 PROGRAM_OBJS += sh-i18n--envsubst.o
 PROGRAM_OBJS += credential-cache.o
 PROGRAM_OBJS += credential-cache--daemon.o
+PROGRAM_OBJS += credential-store.o
 
 PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 
diff --git a/credential-store.c b/credential-store.c
new file mode 100644
index 0000000..8ab8582
--- /dev/null
+++ b/credential-store.c
@@ -0,0 +1,87 @@
+#include "cache.h"
+#include "credential.h"
+#include "string-list.h"
+#include "parse-options.h"
+
+static int lookup_credential(const char *fn, struct credential *c)
+{
+	config_exclusive_filename = fn;
+	credential_from_config(c);
+	return c->username && c->password;
+}
+
+static void store_item(const char *fn, const char *unique,
+		       const char *item, const char *value)
+{
+	struct strbuf key = STRBUF_INIT;
+
+	if (!unique)
+		return;
+
+	config_exclusive_filename = fn;
+	umask(077);
+
+	strbuf_addf(&key, "credential.%s.%s", unique, item);
+	git_config_set(key.buf, value);
+	strbuf_release(&key);
+}
+
+static void store_credential(const char *fn, struct credential *c)
+{
+	store_item(fn, c->unique, "username", c->username);
+	store_item(fn, c->unique, "password", c->password);
+}
+
+static void remove_credential(const char *fn, struct credential *c)
+{
+	store_item(fn, c->unique, "username", NULL);
+	store_item(fn, c->unique, "password", NULL);
+}
+
+int main(int argc, const char **argv)
+{
+	const char * const usage[] = {
+		"git credential-store [options]",
+		NULL
+	};
+	struct credential c = { NULL };
+	struct string_list chain = STRING_LIST_INIT_NODUP;
+	char *store = NULL;
+	int reject = 0;
+	struct option options[] = {
+		OPT_STRING_LIST(0, "store", &store, "file",
+				"fetch and store credentials in <file>"),
+		OPT_STRING_LIST(0, "chain", &chain, "helper",
+				"use <helper> to get non-cached credentials"),
+		OPT_BOOLEAN(0, "reject", &reject,
+			    "reject a stored credential"),
+		OPT_STRING(0, "username", &c.username, "name",
+			   "an existing username"),
+		OPT_STRING(0, "description", &c.description, "desc",
+			   "human-readable description of the credential"),
+		OPT_STRING(0, "unique", &c.unique, "token",
+			   "a unique context for the credential"),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, NULL, options, usage, 0);
+	if (argc)
+		usage_with_options(usage, options);
+
+	if (!store)
+		store = expand_user_path("~/.git-credentials");
+	if (!store)
+		die("unable to set up default store; use --store");
+
+	if (reject)
+		remove_credential(store, &c);
+	else {
+		if (!lookup_credential(store, &c)) {
+			credential_fill(&c, &chain);
+			store_credential(store, &c);
+		}
+		printf("username=%s\n", c.username);
+		printf("password=%s\n", c.password);
+	}
+	return 0;
+}
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 994a0aa..5d54976 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -273,4 +273,59 @@ test_expect_success 'credential-cache removes rejected credentials' '
 	EOF
 '
 
+test_expect_success 'credential-store stores password' '
+	test_when_finished "rm -f .git-credentials" &&
+	check --unique=host store <<-\EOF &&
+	username=askpass-result
+	password=askpass-result
+	--
+	askpass: Username:
+	askpass: Password:
+	EOF
+	check --unique=host store <<-\EOF
+	username=askpass-result
+	password=askpass-result
+	--
+	EOF
+'
+
+test_expect_success 'credential-store requires matching unique token' '
+	test_when_finished "rm -f .git-credentials" &&
+	check --unique=host store <<-\EOF &&
+	username=askpass-result
+	password=askpass-result
+	--
+	askpass: Username:
+	askpass: Password:
+	EOF
+	check --unique=host2 store <<-\EOF
+	username=askpass-result
+	password=askpass-result
+	--
+	askpass: Username:
+	askpass: Password:
+	EOF
+'
+
+test_expect_success 'credential-store removes rejected credentials' '
+	test_when_finished "rm -f .git-credentials" &&
+	check --unique=host store <<-\EOF &&
+	username=askpass-result
+	password=askpass-result
+	--
+	askpass: Username:
+	askpass: Password:
+	EOF
+	check --reject --unique=host --username=askpass-result store <<-\EOF &&
+	--
+	EOF
+	check --unique=host store <<-\EOF
+	username=askpass-result
+	password=askpass-result
+	--
+	askpass: Username:
+	askpass: Password:
+	EOF
+'
+
 test_done
-- 
1.7.6.rc1.12.g65e2
