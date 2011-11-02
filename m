From: Nick Alcock <nix@esperi.org.uk>
Subject: [PATCH 1/2] Add strtoimax() compatibility function.
Date: Wed,  2 Nov 2011 15:46:22 +0000
Message-ID: <1320248783-29577-2-git-send-email-nix@esperi.org.uk>
References: <1320248783-29577-1-git-send-email-nix@esperi.org.uk>
Cc: Nick Alcock <nix@esperi.org.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 17:25:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLdck-0003kb-Rz
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 17:25:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933005Ab1KBQZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 12:25:07 -0400
Received: from icebox.esperi.org.uk ([81.187.191.129]:42917 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932495Ab1KBQZF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 12:25:05 -0400
X-Greylist: delayed 2294 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Nov 2011 12:25:03 EDT
Received: from esperi.org.uk (compiler@spindle.srvr.nix [192.168.14.15])
	by mail.esperi.org.uk (8.14.5/8.14.5) with ESMTP id pA2Fkqkj032579;
	Wed, 2 Nov 2011 15:46:52 GMT
Received: (from compiler@localhost)
	by esperi.org.uk (8.14.5/8.14.5/Submit) id pA2FkqGP029627;
	Wed, 2 Nov 2011 15:46:52 GMT
X-Mailer: git-send-email 1.7.6.1.138.g03ab.dirty
In-Reply-To: <1320248783-29577-1-git-send-email-nix@esperi.org.uk>
X-DCC-URT-Metrics: spindle 1060; Body=2 Fuz1=2 Fuz2=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184642>

Since systems that omit strtoumax() will likely omit strtomax() too,
and likewise for strtoull() and strtoll(), we arrange for the
compatibility #defines NO_STRTOUMAX and NO_STRTOULL to cover both
the signed and unsigned functions. (We cannot change their names
without breaking existing makefile configurations.)

Signed-off-by: Nick Alcock <nix@esperi.org.uk>
---
 Makefile           |    6 +++---
 compat/strtoimax.c |   10 ++++++++++
 2 files changed, 13 insertions(+), 3 deletions(-)
 create mode 100644 compat/strtoimax.c

diff --git a/Makefile b/Makefile
index 303a8df..a1f7e34 100644
--- a/Makefile
+++ b/Makefile
@@ -58,8 +58,8 @@ include /home/compiler/.configure/site.mk
 #
 # Define NO_STRLCPY if you don't have strlcpy.
 #
-# Define NO_STRTOUMAX if you don't have strtoumax in the C library.
-# If your compiler also does not support long long or does not have
+# Define NO_STRTOUMAX if you don't have both strtoimax and strtoumax in the
+# C library. If your compiler also does not support long long or does not have
 # strtoull, define NO_STRTOULL.
 #
 # Define NO_SETENV if you don't have setenv in the C library.
@@ -1459,7 +1459,7 @@ ifdef NO_STRLCPY
 endif
 ifdef NO_STRTOUMAX
 	COMPAT_CFLAGS += -DNO_STRTOUMAX
-	COMPAT_OBJS += compat/strtoumax.o
+	COMPAT_OBJS += compat/strtoumax.o compat/strtoimax.o
 endif
 ifdef NO_STRTOULL
 	COMPAT_CFLAGS += -DNO_STRTOULL
diff --git a/compat/strtoimax.c b/compat/strtoimax.c
new file mode 100644
index 0000000..ac09ed8
--- /dev/null
+++ b/compat/strtoimax.c
@@ -0,0 +1,10 @@
+#include "../git-compat-util.h"
+
+intmax_t gitstrtoimax (const char *nptr, char **endptr, int base)
+{
+#if defined(NO_STRTOULL)
+	return strtol(nptr, endptr, base);
+#else
+	return strtoll(nptr, endptr, base);
+#endif
+}
-- 
1.7.6.1.138.g03ab.dirty
