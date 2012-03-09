From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: [PATCH] configure: allow user to prevent $PATH "sanitization" on Solaris
Date: Fri,  9 Mar 2012 13:43:55 +0100
Message-ID: <a706eaa1e1cd5e13a8cd98362fe09bba628789d1.1331296220.git.stefano.lattarini@gmail.com>
References: <7vhay6etqc.fsf@alter.siamese.dyndns.org>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 09 13:44:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5zB9-0004UN-I0
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 13:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212Ab2CIMoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 07:44:10 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:44421 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753789Ab2CIMoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 07:44:09 -0500
Received: by eekc41 with SMTP id c41so450522eek.19
        for <git@vger.kernel.org>; Fri, 09 Mar 2012 04:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jPlqDGJ5V+Y7crTsUT2hQU9bVytqDYjCP/xhcnYVCVc=;
        b=agWKDJK7ifm6Wlus0FWizd9SYN6QbBa7tmDKp4Nq8jfeaQJJszyuWICcQqv0hYDqXz
         PMp3mjOHkE+Lod/OY+rnVLQeNuoEozloZGk+KpWlYOdUtQ1IExew8JvgiTItNlBnD5DB
         OucQiHUUmzwVZOhAtQ1biRgfP4dwUSNt4n8Za0BQ7S4I3wN7t+DNLtdWP5OaLtnGOo/Z
         4rYlzukZlufBx+v87FC1Bs5QayPMgwlcJUfmTAlYj4NbPg46nqYOMNjtHiSvV3ji5xtE
         C5WU5QNRUysfNzF1KFRqjPQd9mg8yKAvIvZKODaA3Uuq+o4/sNSYs7X2QQKIB4149Y1h
         bvrA==
Received: by 10.213.110.17 with SMTP id l17mr272278ebp.112.1331297047643;
        Fri, 09 Mar 2012 04:44:07 -0800 (PST)
Received: from localhost.localdomain (host28-94-dynamic.4-87-r.retail.telecomitalia.it. [87.4.94.28])
        by mx.google.com with ESMTPS id u9sm17641874eem.11.2012.03.09.04.44.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Mar 2012 04:44:06 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <7vhay6etqc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192716>

On a Solaris 10 system with Solaris make installed as '/usr/xpg4/bin/make',
GNU make installed as '/usr/local/bin/make', and with '/usr/local/bin'
appearing in $PATH *before* '/usr/xpg4/bin', I was seeing errors like this
upon invoking "make all":

        SUBDIR perl
    make: Warning: Ignoring DistributedMake -o option
    Usage : make [ -f makefile ][ -K statefile ]...
    make: Fatal error: Unknown option `-C'

This happened because the Git's Makefile, when running on Solaris,
automatically "sanitizes" $PATH by prepending '/usr/xpg6/bin' and
'/usr/xpg4/bin' to it, and in the setup described above such a behaviour
has the unintended consequence of forcing the use of Solaris make
in recursive make invocations -- even if the $(MAKE) macro is being
correctly used in them!

For developers that don't use the autoconf machinery, the best and easier
fix in such a situation is to properly override $(SANE_TOOL_PATH) in
config.mak.  But a developer using the autoconf-generated configure script
to set up its Git source tree's configuration wouldn't expect to also have
to provide such an override *by hand* after having run configure; he would
either expect:

  1) that the issue is automatically detected and transparently worked
     around by configure; or at least

  2) that a configure-time override telling how (and if) PATH is to be
     sanitized is provided.

This change implements the second approach, which is less-ambitious but
also much less fragile.  Note that, even if we should decide to implement
the first approach in the future, the code added by the present change
still be useful, allowing  the user the possibility to override the
configure's choices in case they turn out wrong (in true autotools
spirit).
---

 Hi Junio, sorry for the delay.  Here is a simpler approach that worked
 out well enough for me; the commit message should explain the rationales
 and motivations for it in detail.

 Regards,
   Stefano

 configure.ac |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index 8bb0f44..72f7958 100644
--- a/configure.ac
+++ b/configure.ac
@@ -137,6 +137,23 @@ if test -n "$1"; then
 fi
 ])
 
+# Directories holding "saner" versions of common or POSIX binaries.
+AC_ARG_WITH([sane-tool-path],
+  [AS_HELP_STRING(
+    [--with-sane-tool-path=DIR-1[[:DIR-2...:DIR-n]]],
+    [Directories to prepend to PATH in build system and generated scripts])],
+  [if test "$withval" = "no"; then
+    withval=''
+  else
+    AC_MSG_NOTICE([Setting SANE_TOOL_PATH to '$withval'])
+  fi
+  GIT_CONF_APPEND_LINE([SANE_TOOL_PATH=$withval])],
+  [# If the "--with-sane-tool-path" option was not given, don't touch
+   # SANE_TOOL_PATH here, but let defaults in Makefile take care of it.
+   # This should minimize spurious differences in the behaviour of the
+   # Git build system when configure is used w.r.t. when it is not.
+   :])
+
 ## Site configuration related to programs (before tests)
 ## --with-PACKAGE[=ARG] and --without-PACKAGE
 #
-- 
1.7.9
