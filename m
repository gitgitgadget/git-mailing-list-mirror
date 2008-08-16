From: Giovanni Funchal <gafunchal@gmail.com>
Subject: [PATCH 2/2] Add tests for runpath switches in configure
Date: Sat, 16 Aug 2008 15:01:23 +0200
Message-ID: <1218891683-6048-1-git-send-email-gafunchal@gmail.com>
Cc: Giovanni Funchal <gafunchal@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 16 15:02:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KULQR-0001fa-Ft
	for gcvg-git-2@gmane.org; Sat, 16 Aug 2008 15:02:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945AbYHPNBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2008 09:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751946AbYHPNBZ
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Aug 2008 09:01:25 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:25648 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbYHPNBY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2008 09:01:24 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1162787fgg.17
        for <git@vger.kernel.org>; Sat, 16 Aug 2008 06:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=a4k7PLPMmu3sG5I7fIXWPddO4yLl/wjQrMihBgQEVck=;
        b=DPfFjE8O0u9hw90SWksLXOV+gQ9Dp5ZGafNf352nTJqRf1HAJ4/ZyLsPuzbi6p7GlZ
         LXJsM7upLxHzjBswhh1bzXeAIDNHa2f/bgSyXTkMHYeuMbssqlSXNw7z21cPJii3ciW5
         nfiGTW57278RZNYvGdzP46m/pX+FbgIxkl10w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=OLNmN5SELnCg84WgEgPq0t6yaXJljohODqpotmvZUfxjYYJm8srdXfOmNIZFyrgC/w
         SXw6mwq56gUfjzcwhfIJ4f7mvQ944l+/oO+pJ9B9Z7wSLFdYv84Wbtlql+QtIB2iKOpo
         nZSacMaucN+XZHV1DBr+O9b4TqMpTNJfgioEI=
Received: by 10.86.26.1 with SMTP id 1mr2962493fgz.35.1218891683447;
        Sat, 16 Aug 2008 06:01:23 -0700 (PDT)
Received: from localhost.localdomain ( [85.69.129.210])
        by mx.google.com with ESMTPS id d4sm9462507fga.8.2008.08.16.06.01.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 16 Aug 2008 06:01:22 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc3.19.g4db473
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92544>

Most systems (e.g. Linux gcc) use "-Wl,-rpath," to pass to the linker the
runtime dynamic library paths. Some other systems (e.g. Sun, some BSD) use
"-R" etc. This patch adds tests in configure for the three most common
switches (to my best knowledge) which should cover all current platforms
where Git is used.

Signed-Off-By: Giovanni Funchal <gafunchal@gmail.com>
---

This second part of this patch follows the idea of Junio that Makefile changes
should be minimal, but I think this is better solution because it uses
CC_LD_DYNPATH directly instead of NO_R_TO_GCC_LINKER, and thus it is not
anymore a matter of "to -R or not to -R".

Note, however, that the current Makefile default is "-R" which is by far not
the most common thing. This is left unchanged for backward compatibility. You
should probably be defining NO_R_TO_GCC_LINKER or using configure!!

 config.mak.in |    1 +
 configure.ac  |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/config.mak.in b/config.mak.in
index b776149..467b4aa 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -3,6 +3,7 @@
 
 CC = @CC@
 CFLAGS = @CFLAGS@
+CC_LD_DYNPATH = @CC_LD_DYNPATH@
 AR = @AR@
 TAR = @TAR@
 #INSTALL = @INSTALL@		# needs install-sh or install.sh in sources
diff --git a/configure.ac b/configure.ac
index 7c2856e..27bab00 100644
--- a/configure.ac
+++ b/configure.ac
@@ -103,6 +103,38 @@ GIT_PARSE_WITH(tcltk))
 AC_MSG_NOTICE([CHECKS for programs])
 #
 AC_PROG_CC([cc gcc])
+# which switch to pass runtime path to dynamic libraries to the linker
+AC_CACHE_CHECK([if linker supports -R], ld_dashr, [
+   SAVE_LDFLAGS="${LDFLAGS}"
+   LDFLAGS="${SAVE_LDFLAGS} -R /"
+   AC_LINK_IFELSE(AC_LANG_PROGRAM([], []), [ld_dashr=yes], [ld_dashr=no])
+   LDFLAGS="${SAVE_LDFLAGS}"
+])
+if test "$ld_dashr" = "yes"; then
+   AC_SUBST(CC_LD_DYNPATH, [-R])
+else
+   AC_CACHE_CHECK([if linker supports -Wl,-rpath,], ld_wl_rpath, [
+      SAVE_LDFLAGS="${LDFLAGS}"
+      LDFLAGS="${SAVE_LDFLAGS} -Wl,-rpath,/"
+      AC_LINK_IFELSE(AC_LANG_PROGRAM([], []), [ld_wl_rpath=yes], [ld_wl_rpath=no])
+      LDFLAGS="${SAVE_LD_FLAGS}"
+   ])
+   if test "$ld_wl_rpath" = "yes"; then
+      AC_SUBST(CC_LD_DYNPATH, [-Wl,-rpath,])
+   else
+      AC_CACHE_CHECK([if linker supports -rpath], ld_rpath, [
+         SAVE_LDFLAGS="${LDFLAGS}"
+         LDFLAGS="${SAVE_LDFLAGS} -rpath /"
+         AC_LINK_IFELSE(AC_LANG_PROGRAM([], []), [ld_rpath=yes], [ld_rpath=no])
+         LDFLAGS="${SAVE_LD_FLAGS}"
+      ])
+      if test "$ld_rpath" = "yes"; then
+         AC_SUBST(CC_LD_DYNPATH, [-rpath])
+      else
+         AC_MSG_WARN([linker does not support runtime path to dynamic libraries])
+      fi
+   fi
+fi
 #AC_PROG_INSTALL		# needs install-sh or install.sh in sources
 AC_CHECK_TOOLS(AR, [gar ar], :)
 AC_CHECK_PROGS(TAR, [gtar tar])
-- 
1.5.4.3
