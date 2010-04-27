From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [patch 16/16] no-inline.patch
Date: Tue, 27 Apr 2010 13:57:24 +0000
Message-ID: <20100427135925.122499000@mlists.thewrittenword.com>
References: <20100427135708.258636000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 27 16:00:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6lKa-0003LI-DG
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 16:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756060Ab0D0N70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 09:59:26 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:60862 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755801Ab0D0N7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 09:59:25 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 06D145CDC
	for <git@vger.kernel.org>; Tue, 27 Apr 2010 14:20:33 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 06D145CDC
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 4B90AADA;
	Tue, 27 Apr 2010 13:59:25 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id 436A811D4D1; Tue, 27 Apr 2010 13:59:25 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=no-inline.patch
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145917>

Without this patch, git does not compile correctly on HPUX 11.11 and
earlier.

Compiler support for inline is sometimes buggy, and occasionally
missing entirely.  This patch adds a test for inline support, and
redefines the keyword with the preprocessor if necessary at compile
time.
---
 Makefile      |   10 ++++++++++
 config.mak.in |    1 +
 configure.ac  |    6 ++++++
 3 files changed, 17 insertions(+)

Index: b/Makefile
===================================================================
--- a/Makefile
+++ b/Makefile
@@ -11,6 +11,9 @@ all::
 # Define SOCKLEN_T to a suitable type (such as 'size_t') if your
 # system headers do not define a socklen_t type.
 #
+# Define INLINE to a suitable substitute (such as '__inline' or '') if git
+# fails to compile with errors about undefined inline functions or similar.
+#
 # Define SNPRINTF_RETURNS_BOGUS if your are on a system which snprintf()
 # or vsnprintf() return -1 instead of number of characters which would
 # have been written to the final string if enough space had been available.
@@ -972,6 +975,7 @@ ifeq ($(uname_S),IRIX64)
 	NEEDS_LIBGEN = YesPlease
 endif
 ifeq ($(uname_S),HP-UX)
+	INLINE = __inline
 	NO_IPV6=YesPlease
 	NO_SETENV=YesPlease
 	NO_STRCASESTR=YesPlease
@@ -985,6 +989,8 @@ ifeq ($(uname_S),HP-UX)
 	NO_NSEC = YesPlease
 	SNPRINTF_RETURNS_BOGUS = YesPlease
 	ifeq ($(uname_R),B.10.20)
+		# Override HP-UX 11.x setting:
+		INLINE =
 		SOCKLEN_T = size_t
 		NO_PREAD = YesPlease
 		NO_INET_NTOP = YesPlease
@@ -1120,6 +1126,10 @@ else
 BROKEN_PATH_FIX = '/^\# @@BROKEN_PATH_FIX@@$$/d'
 endif
 
+ifneq (,$(INLINE))
+	BASIC_CFLAGS += -Dinline=$(INLINE)
+endif
+
 ifneq (,$(SOCKLEN_T))
 	BASIC_CFLAGS += -Dsocklen_t=$(SOCKLEN_T)
 endif
Index: b/configure.ac
===================================================================
--- a/configure.ac
+++ b/configure.ac
@@ -327,6 +327,12 @@ GIT_PARSE_WITH(tcltk))
 AC_MSG_NOTICE([CHECKS for programs])
 #
 AC_PROG_CC([cc gcc])
+AC_C_INLINE
+case $ac_cv_c_inline in
+  inline | yes | no)	;;
+  *)			AC_SUBST([INLINE], [$ac_cv_c_inline]) ;;
+esac
+
 # which switch to pass runtime path to dynamic libraries to the linker
 AC_CACHE_CHECK([if linker supports -R], git_cv_ld_dashr, [
    SAVE_LDFLAGS="${LDFLAGS}"
Index: b/config.mak.in
===================================================================
--- a/config.mak.in
+++ b/config.mak.in
@@ -58,6 +58,7 @@ NO_INET_PTON=@NO_INET_PTON@
 NO_ICONV=@NO_ICONV@
 OLD_ICONV=@OLD_ICONV@
 NO_DEFLATE_BOUND=@NO_DEFLATE_BOUND@
+INLINE=@INLINE@
 SOCKLEN_T=@SOCKLEN_T@
 FREAD_READS_DIRECTORIES=@FREAD_READS_DIRECTORIES@
 SNPRINTF_RETURNS_BOGUS=@SNPRINTF_RETURNS_BOGUS@

-- 
Gary V. Vaughan (gary@thewrittenword.com)
