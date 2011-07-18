From: Jeff King <peff@peff.net>
Subject: [PATCH 14/14] credentials: add "getpass" helper
Date: Mon, 18 Jul 2011 03:58:59 -0400
Message-ID: <20110718075859.GN12341@sigill.intra.peff.net>
References: <20110718074642.GA11678@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 09:59:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiijL-0006tf-D4
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 09:59:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310Ab1GRH7C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 03:59:02 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56248
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750745Ab1GRH7B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 03:59:01 -0400
Received: (qmail 20090 invoked by uid 107); 18 Jul 2011 07:59:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Jul 2011 03:59:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jul 2011 03:58:59 -0400
Content-Disposition: inline
In-Reply-To: <20110718074642.GA11678@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177358>

This just does the normal "ask on the terminal, or use
GIT_ASKPASS" logic that we already do. But it's useful for
writers of third-party helpers. See the documentation for an
example.

Signed-off-by: Jeff King <peff@peff.net>
---
 .gitignore                               |    1 +
 Documentation/git-credential-getpass.txt |   58 ++++++++++++++++++++++++++++++
 Makefile                                 |    1 +
 credential-getpass.c                     |   37 +++++++++++++++++++
 4 files changed, 97 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-credential-getpass.txt
 create mode 100644 credential-getpass.c

diff --git a/.gitignore b/.gitignore
index 2b7a3f9..a26ad00 100644
--- a/.gitignore
+++ b/.gitignore
@@ -33,6 +33,7 @@
 /git-credential-cache
 /git-credential-cache--daemon
 /git-credential-store
+/git-credential-getpass
 /git-cvsexportcommit
 /git-cvsimport
 /git-cvsserver
diff --git a/Documentation/git-credential-getpass.txt b/Documentation/git-credential-getpass.txt
new file mode 100644
index 0000000..a37c7a2
--- /dev/null
+++ b/Documentation/git-credential-getpass.txt
@@ -0,0 +1,58 @@
+git-credential-getpass(1)
+=========================
+
+NAME
+----
+git-credential-getpass - helper to request credentials from a user
+
+SYNOPSIS
+--------
+[verse]
+git credential-getpass
+
+DESCRIPTION
+-----------
+
+This command requests credentials from the user using git's "default"
+scheme, including asking via the terminal and respecting the
+`GIT_ASKPASS` environment variable; see linkgit:gitcredentials[7] for a
+complete description. The helpers are provided on stdout using git's
+credential helper protocol.
+
+There is no point in using this program as a credential helper by
+itself; it is exactly equivalent to git's behavior when no helper is
+configured.
+
+However, writers of third-party helpers may want to invoke this program
+to simulate git's behavior.
+
+EXAMPLES
+--------
+
+Here's a simple, silly example of a helper that stores credentials on
+disk (similar to linkgit:git-credential-store[1]), and how it could use
+the `getpass` helper.
+
+-------------------------------------------
+#!/bin/sh
+
+STORAGE=$HOME/.credentials
+
+for i in "$@"; do
+	case "$i" in
+	--unique=*)
+		unique=${i#--unique=} ;;
+	esac
+done
+
+if ! test -e "$STORAGE/$unique"; then
+	mkdir -m 0700 "$STORAGE"
+	git credential-getpass "$@" >"$STORAGE/$unique"
+fi
+
+cat "$STORAGE/$unique"
+-------------------------------------------
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index e818257..86abd91 100644
--- a/Makefile
+++ b/Makefile
@@ -420,6 +420,7 @@ PROGRAM_OBJS += sh-i18n--envsubst.o
 PROGRAM_OBJS += credential-cache.o
 PROGRAM_OBJS += credential-cache--daemon.o
 PROGRAM_OBJS += credential-store.o
+PROGRAM_OBJS += credential-getpass.o
 
 PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
 
diff --git a/credential-getpass.c b/credential-getpass.c
new file mode 100644
index 0000000..6bfb8f8
--- /dev/null
+++ b/credential-getpass.c
@@ -0,0 +1,37 @@
+#include "cache.h"
+#include "credential.h"
+#include "parse-options.h"
+#include "string-list.h"
+
+int main(int argc, const char **argv)
+{
+	const char * const usage[] = {
+		"git credential-getpass [options]",
+		NULL
+	};
+	struct credential c = { NULL };
+	int reject = 0;
+	struct option options[] = {
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
+	if (reject)
+		return 0;
+
+	credential_getpass(&c);
+	printf("username=%s\n", c.username);
+	printf("password=%s\n", c.password);
+	return 0;
+}
-- 
1.7.6.rc1.12.g65e2
