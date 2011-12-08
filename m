From: Jeff King <peff@peff.net>
Subject: [PATCH 5/7] add generic terminal prompt function
Date: Thu, 8 Dec 2011 03:33:23 -0500
Message-ID: <20111208083323.GE26409@sigill.intra.peff.net>
References: <20111208082118.GA1507@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 08 09:33:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYZQ2-0001iQ-LG
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 09:33:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752452Ab1LHId0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 03:33:26 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43110
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750753Ab1LHIdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 03:33:25 -0500
Received: (qmail 25824 invoked by uid 107); 8 Dec 2011 08:40:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Dec 2011 03:40:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Dec 2011 03:33:23 -0500
Content-Disposition: inline
In-Reply-To: <20111208082118.GA1507@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186541>

When we need to prompt the user for input interactively, we
want to access their terminal directly. We can't rely on
stdio because it may be connected to pipes or files, rather
than the terminal. Instead, we use "getpass()", because it
abstracts the idea of prompting and reading from the
terminal.  However, it has some problems:

  1. It never echoes the typed characters, which makes it OK
     for passwords but annoying for other input (like usernames).

  2. Some implementations of getpass() have an extremely
     small input buffer (e.g., Solaris 8 is reported to
     support only 8 characters).

  3. Some implementations of getpass() will fall back to
     reading from stdin (e.g., glibc). We explicitly don't
     want this, because our stdin may be connected to a pipe
     speaking a particular protocol, and reading will
     disrupt the protocol flow (e.g., the remote-curl
     helper).

  4. Some implementations of getpass() turn off signals, so
     that hitting "^C" on the terminal does not break out of
     the password prompt. This can be a mild annoyance.

Instead, let's provide an abstract "git_terminal_prompt"
function that addresses these concerns. This patch includes
an implementation based on /dev/tty, enabled by setting
HAVE_DEV_TTY. The fallback is to use getpass() as before.

For now, only Linux enables this by default. People on other
/dev/tty-enabled systems can submit patches to turn it on
once they have tested it.

Signed-off-by: Jeff King <peff@peff.net>
---
This is the interesting one. I suspect most Unixes will want to use
this, but I was conservative about enabling it. msysgit can just drop
its own function into compat/terminal.c, and the existing custom
getpass() implementation can just go away.

 Makefile          |   10 ++++++
 compat/terminal.c |   81 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 compat/terminal.h |    6 ++++
 3 files changed, 97 insertions(+), 0 deletions(-)
 create mode 100644 compat/terminal.c
 create mode 100644 compat/terminal.h

diff --git a/Makefile b/Makefile
index b024e2f..2a9bb3d 100644
--- a/Makefile
+++ b/Makefile
@@ -227,6 +227,9 @@ all::
 #
 # Define NO_REGEX if you have no or inferior regex support in your C library.
 #
+# Define HAVE_DEV_TTY if your system can open /dev/tty to interact with the
+# user.
+#
 # Define GETTEXT_POISON if you are debugging the choice of strings marked
 # for translation.  In a GETTEXT_POISON build, you can turn all strings marked
 # for translation into gibberish by setting the GIT_GETTEXT_POISON variable
@@ -523,6 +526,7 @@ LIB_H += compat/bswap.h
 LIB_H += compat/cygwin.h
 LIB_H += compat/mingw.h
 LIB_H += compat/obstack.h
+LIB_H += compat/terminal.h
 LIB_H += compat/win32/pthread.h
 LIB_H += compat/win32/syslog.h
 LIB_H += compat/win32/poll.h
@@ -610,6 +614,7 @@ LIB_OBJS += color.o
 LIB_OBJS += combine-diff.o
 LIB_OBJS += commit.o
 LIB_OBJS += compat/obstack.o
+LIB_OBJS += compat/terminal.o
 LIB_OBJS += config.o
 LIB_OBJS += connect.o
 LIB_OBJS += connected.o
@@ -833,6 +838,7 @@ ifeq ($(uname_S),Linux)
 	NO_STRLCPY = YesPlease
 	NO_MKSTEMPS = YesPlease
 	HAVE_PATHS_H = YesPlease
+	HAVE_DEV_TTY = YesPlease
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	NO_STRLCPY = YesPlease
@@ -1639,6 +1645,10 @@ ifdef HAVE_PATHS_H
 	BASIC_CFLAGS += -DHAVE_PATHS_H
 endif
 
+ifdef HAVE_DEV_TTY
+	BASIC_CFLAGS += -DHAVE_DEV_TTY
+endif
+
 ifdef DIR_HAS_BSD_GROUP_SEMANTICS
 	COMPAT_CFLAGS += -DDIR_HAS_BSD_GROUP_SEMANTICS
 endif
diff --git a/compat/terminal.c b/compat/terminal.c
new file mode 100644
index 0000000..49f16ca
--- /dev/null
+++ b/compat/terminal.c
@@ -0,0 +1,81 @@
+#include "git-compat-util.h"
+#include "compat/terminal.h"
+#include "sigchain.h"
+#include "strbuf.h"
+
+#ifndef NO_DEV_TTY
+
+static int term_fd = -1;
+static struct termios old_term;
+
+static void restore_term(void)
+{
+	if (term_fd < 0)
+		return;
+
+	tcsetattr(term_fd, TCSAFLUSH, &old_term);
+	term_fd = -1;
+}
+
+static void restore_term_on_signal(int sig)
+{
+	restore_term();
+	sigchain_pop(sig);
+	raise(sig);
+}
+
+char *git_terminal_prompt(const char *prompt, int echo)
+{
+	static struct strbuf buf = STRBUF_INIT;
+	int r;
+	FILE *fh;
+
+	fh = fopen("/dev/tty", "w+");
+	if (!fh)
+		return NULL;
+
+	if (!echo) {
+		struct termios t;
+
+		if (tcgetattr(fileno(fh), &t) < 0) {
+			fclose(fh);
+			return NULL;
+		}
+
+		old_term = t;
+		term_fd = fileno(fh);
+		sigchain_push_common(restore_term_on_signal);
+
+		t.c_lflag &= ~ECHO;
+		if (tcsetattr(fileno(fh), TCSAFLUSH, &t) < 0) {
+			term_fd = -1;
+			fclose(fh);
+			return NULL;
+		}
+	}
+
+	fputs(prompt, fh);
+	fflush(fh);
+
+	r = strbuf_getline(&buf, fh, '\n');
+	if (!echo) {
+		putc('\n', fh);
+		fflush(fh);
+	}
+
+	restore_term();
+	fclose(fh);
+
+	if (r == EOF)
+		return NULL;
+	return buf.buf;
+}
+
+#else
+
+char *git_terminal_prompt(const char *prompt, int echo)
+{
+	return getpass(prompt);
+}
+
+#endif
diff --git a/compat/terminal.h b/compat/terminal.h
new file mode 100644
index 0000000..97db7cd
--- /dev/null
+++ b/compat/terminal.h
@@ -0,0 +1,6 @@
+#ifndef COMPAT_TERMINAL_H
+#define COMPAT_TERMINAL_H
+
+char *git_terminal_prompt(const char *prompt, int echo);
+
+#endif /* COMPAT_TERMINAL_H */
-- 
1.7.8.rc2.8.gf0f4f
