From: Jeff King <peff@peff.net>
Subject: [PATCH 6/6] compat/getpass: add a /dev/tty implementation
Date: Sun, 27 Nov 2011 03:31:51 -0500
Message-ID: <20111127083151.GF1702@sigill.intra.peff.net>
References: <20111127082744.GA32068@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 09:31:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUa9W-0003Rf-3g
	for gcvg-git-2@lo.gmane.org; Sun, 27 Nov 2011 09:31:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755289Ab1K0Iby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Nov 2011 03:31:54 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53671
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754462Ab1K0Ibx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2011 03:31:53 -0500
Received: (qmail 13206 invoked by uid 107); 27 Nov 2011 08:38:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 27 Nov 2011 03:38:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 27 Nov 2011 03:31:51 -0500
Content-Disposition: inline
In-Reply-To: <20111127082744.GA32068@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185976>

This is more or less what regular getpass() does, but
without turning off character echoing. You have to set
HAVE_DEV_TTY to enable it.

For now, only Linux enables this by default. People on other
/dev/tty-enabled systems can submit patches to turn it on
once they have tested it.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile         |    8 ++++++++
 compat/getpass.c |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index d133e2b..a2afe31 100644
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
@@ -835,6 +838,7 @@ ifeq ($(uname_S),Linux)
 	NO_STRLCPY = YesPlease
 	NO_MKSTEMPS = YesPlease
 	HAVE_PATHS_H = YesPlease
+	HAVE_DEV_TTY = YesPlease
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	NO_STRLCPY = YesPlease
@@ -1641,6 +1645,10 @@ ifdef HAVE_PATHS_H
 	BASIC_CFLAGS += -DHAVE_PATHS_H
 endif
 
+ifdef HAVE_DEV_TTY
+	BASIC_CFLAGS += -DHAVE_DEV_TTY
+endif
+
 ifdef DIR_HAS_BSD_GROUP_SEMANTICS
 	COMPAT_CFLAGS += -DDIR_HAS_BSD_GROUP_SEMANTICS
 endif
diff --git a/compat/getpass.c b/compat/getpass.c
index 8ae82f0..b5bd1dd 100644
--- a/compat/getpass.c
+++ b/compat/getpass.c
@@ -1,6 +1,41 @@
 #include "../git-compat-util.h"
 
+#ifdef HAVE_DEV_TTY
+
+char *getpass_echo(const char *prompt)
+{
+	static char buf[1024];
+	FILE *fh;
+	int i;
+
+	fh = fopen("/dev/tty", "w+");
+	if (!fh)
+		return NULL;
+
+	fputs(prompt, fh);
+	fflush(fh);
+	for (i = 0; i < sizeof(buf) - 1; i++) {
+		int ch = getc(fh);
+		if (ch == EOF || ch == '\n')
+			break;
+		buf[i] = ch;
+	}
+	buf[i] = '\0';
+
+	if (ferror(fh)) {
+		fclose(fh);
+		return NULL;
+	}
+
+	fclose(fh);
+	return buf;
+}
+
+#else
+
 char *getpass_echo(const char *prompt)
 {
 	return getpass(prompt);
 }
+
+#endif
-- 
1.7.7.4.7.g24824
