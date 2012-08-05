From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH] Avoid crippled getpass function on Solaris
Date: Sun,  5 Aug 2012 19:17:52 -0400
Message-ID: <1344208672-20028-1-git-send-email-bwalton@artsci.utoronto.ca>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: gitster@pobox.com, peff@peff.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 06 01:18:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyA5Q-0006f9-KP
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 01:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755256Ab2HEXSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 19:18:10 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:51493 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755207Ab2HEXSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 19:18:09 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:54112 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SyA5A-00072D-FJ; Sun, 05 Aug 2012 19:18:00 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SyA5A-0005DX-Dr; Sun, 05 Aug 2012 19:18:00 -0400
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202940>

On Solaris getpass() returns at most 8 characters which cripples the
credential reading for accounts using longer passwords.  The alternate
function getpassphrase() was introduced in SunOS 5.6 and will return
up to 256 characters.

Ensure that git_terminal_prompt uses the more able function when
building on Solaris.

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---

Hi Jeff and Junio,

I considered making this minor change a few different ways but settled
on this as it seemed (to my eye) to most closely adhere to the way
other such things were done in the compatibility code. I'm entirely
open to modifying this if it's felt that there is a clearer/cleaner
way to do it.

I'd even considered making the function swap generic enough to be
driven by the build system.  That seemed over the top though, given
that most systems either have a decent getpass() or don't use this
code path at all.

I've also briefly dabbled with getting Solaris to simply use the
HAVE_DEV_TTY code path but the terminal echo stuff hasn't worked
nicely for me just yet.  (It reads the password with nothing echoed
but then displays the string after reading the newline.)  This might
still be a better approach in the future, but for now, having long
password reading capability will still be a benefit to users on this
platform.

Thanks
-Ben

 compat/terminal.c |    2 +-
 compat/terminal.h |    9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index 6d16c8f..e1ab536 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -75,7 +75,7 @@ char *git_terminal_prompt(const char *prompt, int echo)
 
 char *git_terminal_prompt(const char *prompt, int echo)
 {
-	return getpass(prompt);
+	return GETPASS(prompt);
 }
 
 #endif
diff --git a/compat/terminal.h b/compat/terminal.h
index 97db7cd..8d7b3f9 100644
--- a/compat/terminal.h
+++ b/compat/terminal.h
@@ -3,4 +3,13 @@
 
 char *git_terminal_prompt(const char *prompt, int echo);
 
+/* getpass() returns at most 8 characters on solaris so use
+   getpassphrase() which returns up to 256. */
+# if defined (__SVR4) && defined (__sun) /* solaris */
+#define GETPASS getpassphrase
+#else
+#define GETPASS getpass
+#endif
+
+
 #endif /* COMPAT_TERMINAL_H */
-- 
1.7.10.3
