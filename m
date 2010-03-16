From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [patch 15/15] no-inline.patch
Date: Tue, 16 Mar 2010 05:42:35 +0000
Message-ID: <20100316054413.390539000@mlists.thewrittenword.com>
References: <20100316054220.075676000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 16 06:54:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrPjK-00038F-8b
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 06:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757625Ab0CPFw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 01:52:57 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:62394 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757345Ab0CPFwz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 01:52:55 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 80A2E5CE6
	for <git@vger.kernel.org>; Tue, 16 Mar 2010 06:03:35 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 80A2E5CE6
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 8C232DE9;
	Tue, 16 Mar 2010 05:44:13 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id 82ACA11D4D5; Tue, 16 Mar 2010 05:44:13 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=no-inline.patch
X-Virus-Scanned: clamav-milter 0.95.3 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142309>

Without this patch, git does not compile correctly on HPUX 11.11 and
earlier.

Compiler support for inline is sometimes buggy, and occasionally
missing entirely.  This patch adds a test for inline support, and
redefines the keyword with the preprocessor if necessary at compile
time.
---
 Makefile      |    4 ++++
 config.mak.in |    1 +
 configure.ac  |    7 +++++++
 3 files changed, 12 insertions(+)

Index: b/Makefile
===================================================================
--- a/Makefile
+++ b/Makefile
@@ -1076,6 +1076,10 @@ else
 BROKEN_PATH_FIX = '/^\# @@BROKEN_PATH_FIX@@$$/d'
 endif
 
+ifneq (inline,$(INLINE))
+	BASIC_CFLAGS += -Dinline=$(INLINE)
+endif
+
 ifneq (socklen_t,$(SOCKLEN_T))
 	BASIC_CFLAGS += -Dsocklen_t=$(SOCKLEN_T)
 endif
Index: b/configure.ac
===================================================================
--- a/configure.ac
+++ b/configure.ac
@@ -307,6 +307,13 @@ GIT_PARSE_WITH(tcltk))
 AC_MSG_NOTICE([CHECKS for programs])
 #
 AC_PROG_CC([cc gcc])
+AC_C_INLINE
+case $ac_cv_c_inline in
+  no)		AC_SUBST([INLINE], []) ;;
+  inline | yes)	AC_SUBST([INLINE], [inline]) ;;
+  *)		AC_SUBST([INLINE], [$ac_cv_c_inline]) ;;
+esac
+
 # which switch to pass runtime path to dynamic libraries to the linker
 AC_CACHE_CHECK([if linker supports -R], git_cv_ld_dashr, [
    SAVE_LDFLAGS="${LDFLAGS}"
Index: b/config.mak.in
===================================================================
--- a/config.mak.in
+++ b/config.mak.in
@@ -59,6 +59,7 @@ NO_INET_PTON=@NO_INET_PTON@
 NO_ICONV=@NO_ICONV@
 OLD_ICONV=@OLD_ICONV@
 NO_DEFLATE_BOUND=@NO_DEFLATE_BOUND@
+INLINE=@INLINE@
 SOCKLEN_T=@SOCKLEN_T@
 FREAD_READS_DIRECTORIES=@FREAD_READS_DIRECTORIES@
 SNPRINTF_RETURNS_BOGUS=@SNPRINTF_RETURNS_BOGUS@

-- 
Gary V. Vaughan (gary@thewrittenword.com)
