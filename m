From: John Szakmeister <john@szakmeister.net>
Subject: [PATCH 1/1] Don't append -lintl when there is no gettext support
Date: Sat, 18 Feb 2012 14:38:04 -0500
Message-ID: <1329593884-9999-2-git-send-email-john@szakmeister.net>
References: <1329593884-9999-1-git-send-email-john@szakmeister.net>
Cc: John Szakmeister <john@szakmeister.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 18 20:40:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ryq9E-0001r4-Dx
	for gcvg-git-2@plane.gmane.org; Sat, 18 Feb 2012 20:40:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607Ab2BRTjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Feb 2012 14:39:55 -0500
Received: from mail-qw0-f53.google.com ([209.85.216.53]:54588 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565Ab2BRTj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2012 14:39:27 -0500
Received: by qafk1 with SMTP id k1so4688496qaf.19
        for <git@vger.kernel.org>; Sat, 18 Feb 2012 11:39:26 -0800 (PST)
Received-SPF: pass (google.com: domain of jszakmeister@gmail.com designates 10.229.75.138 as permitted sender) client-ip=10.229.75.138;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jszakmeister@gmail.com designates 10.229.75.138 as permitted sender) smtp.mail=jszakmeister@gmail.com; dkim=pass header.i=jszakmeister@gmail.com
Received: from mr.google.com ([10.229.75.138])
        by 10.229.75.138 with SMTP id y10mr10141578qcj.110.1329593966909 (num_hops = 1);
        Sat, 18 Feb 2012 11:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=uWQgE0QpAv1eh9S4mBHozVgzS8aYed2SiT0vV9VTNTM=;
        b=UMPerPa88ZHB9qGa9SptzyRCXkxF9qYf/CMJUVCn8Nu3PdeEuysP56tFqquqnzEOk/
         7/pa2srU+D4d3eHDfD/KwXc4JzUJCLh7cUpMTyiLJ5Qx4gG3nMNexMFjrDW+PZsO4Vag
         JpvJz/YKa7/lSAq+Z6JFvX9lgngqIZ3uAqsXA=
Received: by 10.229.75.138 with SMTP id y10mr8645143qcj.110.1329593966829;
        Sat, 18 Feb 2012 11:39:26 -0800 (PST)
Received: from localhost.localdomain (pool-71-179-190-236.bltmmd.fios.verizon.net. [71.179.190.236])
        by mx.google.com with ESMTPS id bf2sm8430903qab.20.2012.02.18.11.39.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 18 Feb 2012 11:39:26 -0800 (PST)
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1329593884-9999-1-git-send-email-john@szakmeister.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191010>

The check for libintl in a C library incorrectly assumes that if it's
not builtin then it must exist externally.  Instead, let's check for
the existence of libintl.h first.  If libintl.h exists, and libintl is
not in libc, then we append the library.

Signed-off-by: John Szakmeister <john@szakmeister.net>
---
 configure.ac |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/configure.ac b/configure.ac
index 630dbdd..8471f5c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -640,7 +640,18 @@ AC_CHECK_LIB([c], [gettext],
 [LIBC_CONTAINS_LIBINTL=YesPlease],
 [LIBC_CONTAINS_LIBINTL=])
 AC_SUBST(LIBC_CONTAINS_LIBINTL)
-test -n "$LIBC_CONTAINS_LIBINTL" || LIBS="$LIBS -lintl"
+
+#
+# Define NO_GETTEXT if you don't want Git output to be translated.
+# A translated Git requires GNU libintl or another gettext implementation
+AC_CHECK_HEADER([libintl.h],
+[NO_GETTEXT=],
+[NO_GETTEXT=YesPlease])
+AC_SUBST(NO_GETTEXT)
+
+if test -z "$NO_GETTEXT"; then
+    test -n "$LIBC_CONTAINS_LIBINTL" || LIBS="$LIBS -lintl"
+fi
 
 ## Checks for header files.
 AC_MSG_NOTICE([CHECKS for header files])
@@ -824,13 +835,6 @@ AC_CHECK_HEADER([paths.h],
 [HAVE_PATHS_H=])
 AC_SUBST(HAVE_PATHS_H)
 #
-# Define NO_GETTEXT if you don't want Git output to be translated.
-# A translated Git requires GNU libintl or another gettext implementation
-AC_CHECK_HEADER([libintl.h],
-[NO_GETTEXT=],
-[NO_GETTEXT=YesPlease])
-AC_SUBST(NO_GETTEXT)
-#
 # Define HAVE_LIBCHARSET_H if have libcharset.h
 AC_CHECK_HEADER([libcharset.h],
 [HAVE_LIBCHARSET_H=YesPlease],
-- 
1.7.9.1
