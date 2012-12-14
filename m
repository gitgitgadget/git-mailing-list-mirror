From: David Michael <fedora.dm0@gmail.com>
Subject: [PATCH 2/4] Detect when the passwd struct is missing pw_gecos
Date: Fri, 14 Dec 2012 14:56:59 -0500
Message-ID: <CAEvUa7=1Es8LzyHt3XhWJGm+nFum=ggunRCi8hJB9A9nuL5KUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 14 20:57:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjbNm-0006W3-Hr
	for gcvg-git-2@plane.gmane.org; Fri, 14 Dec 2012 20:57:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246Ab2LNT5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2012 14:57:01 -0500
Received: from mail-vb0-f46.google.com ([209.85.212.46]:47037 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932146Ab2LNT5A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2012 14:57:00 -0500
Received: by mail-vb0-f46.google.com with SMTP id b13so4499142vby.19
        for <git@vger.kernel.org>; Fri, 14 Dec 2012 11:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=IO21PtayVPwhBuTrTaPkSmgKWTgHC13rGUqOmwjXlfI=;
        b=YXGyOKwdibG4P2fJOJ3+1TDceX+SogcMLj+o2/pv4KRmiUCE+C2en8nZrp6rjZrK/4
         7NFWnCyv1eUdbMEvCHWI9SLg5UQi7m0uc0GG2/MVEg+U/saWmRIF4JQba/P74YMFO6dA
         G4YF0wT2sTVu18UYDfjUuY+wYhX9JfzcaRGx6uQaBK9o7otfnNmi1SMHwv2wrP39WzBH
         lhaqjCNkPAF/ww6O0XEmeFUSb5OS5hwmEcwYb2/prhxv0GxyjMet0tJw7b6S/w94+KAo
         sH+IX+SNEh3rehH1xV/TJFbR8qb4mz6sBbXSzMIBPHaevxBMMB4gsfYOH041f0lM/gkw
         ajUg==
Received: by 10.58.2.71 with SMTP id 7mr11377679ves.42.1355515019789; Fri, 14
 Dec 2012 11:56:59 -0800 (PST)
Received: by 10.58.85.138 with HTTP; Fri, 14 Dec 2012 11:56:59 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211500>

NO_GECOS_IN_PWENT was documented with other Makefile variables but was only
enforced by manually defining it to the C preprocessor.  This adds support
for detecting the condition with configure and defining the make variable.

Signed-off-by: David Michael <fedora.dm0@gmail.com>
---
 Makefile     | 3 +++
 configure.ac | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/Makefile b/Makefile
index 8c3a0dd..735a834 100644
--- a/Makefile
+++ b/Makefile
@@ -1657,6 +1657,9 @@ endif
 ifdef NO_D_INO_IN_DIRENT
     BASIC_CFLAGS += -DNO_D_INO_IN_DIRENT
 endif
+ifdef NO_GECOS_IN_PWENT
+    BASIC_CFLAGS += -DNO_GECOS_IN_PWENT
+endif
 ifdef NO_ST_BLOCKS_IN_STRUCT_STAT
     BASIC_CFLAGS += -DNO_ST_BLOCKS_IN_STRUCT_STAT
 endif
diff --git a/configure.ac b/configure.ac
index 317bfc6..3347c17 100644
--- a/configure.ac
+++ b/configure.ac
@@ -759,6 +759,14 @@ AC_CHECK_MEMBER(struct dirent.d_type,
 [#include <dirent.h>])
 GIT_CONF_SUBST([NO_D_TYPE_IN_DIRENT])
 #
+# Define NO_GECOS_IN_PWENT if you don't have pw_gecos in struct passwd
+# in the C library.
+AC_CHECK_MEMBER(struct passwd.pw_gecos,
+[NO_GECOS_IN_PWENT=],
+[NO_GECOS_IN_PWENT=YesPlease],
+[#include <pwd.h>])
+GIT_CONF_SUBST([NO_GECOS_IN_PWENT])
+#
 # Define NO_SOCKADDR_STORAGE if your platform does not have struct
 # sockaddr_storage.
 AC_CHECK_TYPE(struct sockaddr_storage,
--
1.7.11.7
