From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH 6/6] Fix compilation with Sun CC
Date: Tue, 15 Aug 2006 11:01:31 +0200
Message-ID: <20060815090131.5223.62594.stgit@leonov.stosberg.net>
References: <20060815090031.5223.27458.stgit@leonov.stosberg.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Aug 15 11:01:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCuns-0001xX-2Q
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 11:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965308AbWHOJBi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 05:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965306AbWHOJBh
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 05:01:37 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:63679 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S965309AbWHOJBf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Aug 2006 05:01:35 -0400
Received: from leonov.stosberg.net (p213.54.74.221.tisdip.tiscali.de [213.54.74.221])
	by ncs.stosberg.net (Postfix) with ESMTP id 625C5AEBA002
	for <git@vger.kernel.org>; Tue, 15 Aug 2006 11:01:29 +0200 (CEST)
Received: from leonov.stosberg.net (leonov.stosberg.net [127.0.0.1])
	by leonov.stosberg.net (Postfix) with ESMTP id E3BD2121739
	for <git@vger.kernel.org>; Tue, 15 Aug 2006 11:01:31 +0200 (CEST)
To: git@vger.kernel.org
In-Reply-To: <20060815090031.5223.27458.stgit@leonov.stosberg.net>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25450>

- Add the CFLAGS variable to config.mak.in to override the Makefile's
  default, which is gcc-specific and won't work with Sun CC.
- Prefer "cc" over "gcc", because Pasky's Git.pm will not compile with gcc
  on Solaris at all. On Linux and the free BSDs "cc" is linked to "gcc"
  anyway.
- Set correct flag to generate position-independent code.
- Add "-xO3" (= use default optimization level) to CFLAGS.

Signed-off-by: Dennis Stosberg <dennis@stosberg.net>
---

 Makefile      |    6 +++++-
 config.mak.in |    2 ++
 configure.ac  |    9 ++++++++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index d352901..aeefc4e 100644
--- a/Makefile
+++ b/Makefile
@@ -114,6 +114,7 @@ uname_P := $(shell sh -c 'uname -p 2>/de
 # CFLAGS and LDFLAGS are for the users to override from the command line.
 
 CFLAGS = -g -O2 -Wall
+PIC_FLAG = -fPIC
 LDFLAGS =
 ALL_CFLAGS = $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
@@ -408,6 +409,9 @@ endif
 ifneq (,$(findstring arm,$(uname_M)))
 	ARM_SHA1 = YesPlease
 endif
+ifeq ($(uname_M),sun4u)
+	USE_PIC = YesPlease
+endif
 ifeq ($(uname_M),x86_64)
 	USE_PIC = YesPlease
 endif
@@ -554,7 +558,7 @@ endif
 endif
 endif
 ifdef USE_PIC
-	ALL_CFLAGS += -fPIC
+	ALL_CFLAGS += $(PIC_FLAG)
 endif
 ifdef NO_ACCURATE_DIFF
 	BASIC_CFLAGS += -DNO_ACCURATE_DIFF
diff --git a/config.mak.in b/config.mak.in
index 038767e..1fd5f7e 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -2,6 +2,8 @@ # git Makefile configuration, included i
 # @configure_input@
 
 CC = @CC@
+CFLAGS = @CFLAGS@
+PIC_FLAG = @PIC_FLAG@
 AR = @AR@
 TAR = @TAR@
 #INSTALL = @INSTALL@		# needs install-sh or install.sh in sources
diff --git a/configure.ac b/configure.ac
index 6f1d87a..427ac23 100644
--- a/configure.ac
+++ b/configure.ac
@@ -95,7 +95,14 @@ AC_SUBST(PYTHON_PATH)
 ## Checks for programs.
 AC_MSG_NOTICE([CHECKS for programs])
 #
-AC_PROG_CC
+AC_PROG_CC([cc gcc])
+if test -n "$GCC"; then
+	PIC_FLAG="-fPIC"
+else
+	AC_CHECK_DECL(__SUNPRO_C, [CFLAGS="$CFLAGS -xO3"; PIC_FLAG="-KPIC"])
+fi
+AC_SUBST(PIC_FLAG)
+
 #AC_PROG_INSTALL		# needs install-sh or install.sh in sources
 AC_CHECK_TOOL(AR, ar, :)
 AC_CHECK_PROGS(TAR, [gtar tar])
