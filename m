From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [PATCH v5 12/18] Allow disabling "inline"
Date: Fri, 14 May 2010 09:31:43 +0000
Message-ID: <20100514093822.893923000@mlists.thewrittenword.com>
References: <20100514093131.249094000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 14 11:38:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCrLh-0001z6-Gx
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 11:38:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758813Ab0ENJiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 05:38:25 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:61026 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758789Ab0ENJiX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 05:38:23 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 5015F5C48
	for <git@vger.kernel.org>; Fri, 14 May 2010 09:55:15 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 5015F5C48
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 2719DCD4;
	Fri, 14 May 2010 09:38:23 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id 0A12511D4D1; Fri, 14 May 2010 09:38:22 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=no-inline.patch
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147068>

Compiler support for inline is sometimes buggy, and occasionally
missing entirely.  This patch adds a test for inline support, and
redefines the keyword with the preprocessor if necessary at compile
time.

Signed-off-by: Gary V. Vaughan <gary@thewrittenword.com>
---
 Makefile      |    7 +++++++
 config.mak.in |    1 +
 configure.ac  |    6 ++++++
 3 files changed, 14 insertions(+)

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
@@ -1090,6 +1093,10 @@ else
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
