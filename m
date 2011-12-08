From: Jeff King <peff@peff.net>
Subject: [PATCH 3/7] move git_getpass to its own source file
Date: Thu, 8 Dec 2011 03:24:43 -0500
Message-ID: <20111208082443.GC26409@sigill.intra.peff.net>
References: <20111208082118.GA1507@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 08 09:24:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYZHe-0007DK-H6
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 09:24:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752304Ab1LHIYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 03:24:46 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43100
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751336Ab1LHIYp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 03:24:45 -0500
Received: (qmail 25663 invoked by uid 107); 8 Dec 2011 08:31:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Dec 2011 03:31:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Dec 2011 03:24:43 -0500
Content-Disposition: inline
In-Reply-To: <20111208082118.GA1507@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186539>

This is currently in connect.c, but really has nothing to
do with the git protocol itself. Let's make a new source
file all about prompting the user, which will make it
cleaner to refactor.

Signed-off-by: Jeff King <peff@peff.net>
---
Same as patch 1 from the previous series.

 Makefile     |    2 ++
 cache.h      |    1 -
 connect.c    |   44 --------------------------------------------
 credential.c |    1 +
 imap-send.c  |    1 +
 prompt.c     |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 prompt.h     |    6 ++++++
 7 files changed, 58 insertions(+), 45 deletions(-)
 create mode 100644 prompt.c
 create mode 100644 prompt.h

diff --git a/Makefile b/Makefile
index a26f58a..b024e2f 100644
--- a/Makefile
+++ b/Makefile
@@ -563,6 +563,7 @@ LIB_H += parse-options.h
 LIB_H += patch-ids.h
 LIB_H += pkt-line.h
 LIB_H += progress.h
+LIB_H += prompt.h
 LIB_H += quote.h
 LIB_H += reflog-walk.h
 LIB_H += refs.h
@@ -669,6 +670,7 @@ LIB_OBJS += pkt-line.o
 LIB_OBJS += preload-index.o
 LIB_OBJS += pretty.o
 LIB_OBJS += progress.o
+LIB_OBJS += prompt.o
 LIB_OBJS += quote.o
 LIB_OBJS += reachable.o
 LIB_OBJS += read-cache.o
diff --git a/cache.h b/cache.h
index 2e6ad36..f320c98 100644
--- a/cache.h
+++ b/cache.h
@@ -1024,7 +1024,6 @@ struct ref {
 extern struct ref *find_ref_by_name(const struct ref *list, const char *name);
 
 #define CONNECT_VERBOSE       (1u << 0)
-extern char *git_getpass(const char *prompt);
 extern struct child_process *git_connect(int fd[2], const char *url, const char *prog, int flags);
 extern int finish_connect(struct child_process *conn);
 extern int git_connection_is_socket(struct child_process *conn);
diff --git a/connect.c b/connect.c
index 51990fa..519e527 100644
--- a/connect.c
+++ b/connect.c
@@ -619,47 +619,3 @@ int finish_connect(struct child_process *conn)
 	free(conn);
 	return code;
 }
-
-char *git_getpass(const char *prompt)
-{
-	const char *askpass;
-	struct child_process pass;
-	const char *args[3];
-	static struct strbuf buffer = STRBUF_INIT;
-
-	askpass = getenv("GIT_ASKPASS");
-	if (!askpass)
-		askpass = askpass_program;
-	if (!askpass)
-		askpass = getenv("SSH_ASKPASS");
-	if (!askpass || !(*askpass)) {
-		char *result = getpass(prompt);
-		if (!result)
-			die_errno("Could not read password");
-		return result;
-	}
-
-	args[0] = askpass;
-	args[1]	= prompt;
-	args[2] = NULL;
-
-	memset(&pass, 0, sizeof(pass));
-	pass.argv = args;
-	pass.out = -1;
-
-	if (start_command(&pass))
-		exit(1);
-
-	strbuf_reset(&buffer);
-	if (strbuf_read(&buffer, pass.out, 20) < 0)
-		die("failed to read password from %s\n", askpass);
-
-	close(pass.out);
-
-	if (finish_command(&pass))
-		exit(1);
-
-	strbuf_setlen(&buffer, strcspn(buffer.buf, "\r\n"));
-
-	return buffer.buf;
-}
diff --git a/credential.c b/credential.c
index a17eafe..fbb7231 100644
--- a/credential.c
+++ b/credential.c
@@ -3,6 +3,7 @@
 #include "string-list.h"
 #include "run-command.h"
 #include "url.h"
+#include "prompt.h"
 
 void credential_init(struct credential *c)
 {
diff --git a/imap-send.c b/imap-send.c
index 227253e..43588e8 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -25,6 +25,7 @@
 #include "cache.h"
 #include "exec_cmd.h"
 #include "run-command.h"
+#include "prompt.h"
 #ifdef NO_OPENSSL
 typedef void *SSL;
 #else
diff --git a/prompt.c b/prompt.c
new file mode 100644
index 0000000..42a1c9f
--- /dev/null
+++ b/prompt.c
@@ -0,0 +1,48 @@
+#include "cache.h"
+#include "run-command.h"
+#include "strbuf.h"
+#include "prompt.h"
+
+char *git_getpass(const char *prompt)
+{
+	const char *askpass;
+	struct child_process pass;
+	const char *args[3];
+	static struct strbuf buffer = STRBUF_INIT;
+
+	askpass = getenv("GIT_ASKPASS");
+	if (!askpass)
+		askpass = askpass_program;
+	if (!askpass)
+		askpass = getenv("SSH_ASKPASS");
+	if (!askpass || !(*askpass)) {
+		char *result = getpass(prompt);
+		if (!result)
+			die_errno("Could not read password");
+		return result;
+	}
+
+	args[0] = askpass;
+	args[1]	= prompt;
+	args[2] = NULL;
+
+	memset(&pass, 0, sizeof(pass));
+	pass.argv = args;
+	pass.out = -1;
+
+	if (start_command(&pass))
+		exit(1);
+
+	strbuf_reset(&buffer);
+	if (strbuf_read(&buffer, pass.out, 20) < 0)
+		die("failed to read password from %s\n", askpass);
+
+	close(pass.out);
+
+	if (finish_command(&pass))
+		exit(1);
+
+	strbuf_setlen(&buffer, strcspn(buffer.buf, "\r\n"));
+
+	return buffer.buf;
+}
diff --git a/prompt.h b/prompt.h
new file mode 100644
index 0000000..0fd7bd9
--- /dev/null
+++ b/prompt.h
@@ -0,0 +1,6 @@
+#ifndef PROMPT_H
+#define PROMPT_H
+
+char *git_getpass(const char *prompt);
+
+#endif /* PROMPT_H */
-- 
1.7.8.rc2.8.gf0f4f
