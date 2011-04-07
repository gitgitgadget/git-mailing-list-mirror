From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 1/9] Makefile: Use cgcc rather than sparse in the check target
Date: Thu, 07 Apr 2011 19:22:18 +0100
Message-ID: <4D9E00DA.4060807@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, bebarino@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 20:55:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7uMC-00061r-I9
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 20:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756680Ab1DGSy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 14:54:58 -0400
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:39148 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756675Ab1DGSy6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Apr 2011 14:54:58 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1Q7uK9-00070k-kX; Thu, 07 Apr 2011 18:52:58 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171075>


cgcc is the recommended way to run sparse, since it provides
many -Defines suitable for the given gcc platform. Using an
"cgcc -no-compile" command runs sparse, with all the platform
specific definitions provided by cgcc, without also invoking
gcc.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Note that the "-isystem /usr/include/w32api" should be provided by
cgcc, but when adding cygwin support none of my projects (including
git) included any windows code, so I didn't notice.

 Makefile |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 92c1c5e..79bef43 100644
--- a/Makefile
+++ b/Makefile
@@ -323,9 +323,7 @@ GCOV = gcov
 
 export TCL_PATH TCLTK_PATH
 
-# sparse is architecture-neutral, which means that we need to tell it
-# explicitly what architecture to check for. Fix this up for yours..
-SPARSE_FLAGS = -D__BIG_ENDIAN__ -D__powerpc__
+SPARSE_FLAGS =
 
 
 
@@ -924,6 +922,7 @@ ifeq ($(uname_O),Cygwin)
 	X = .exe
 	COMPAT_OBJS += compat/cygwin.o
 	UNRELIABLE_FSTAT = UnfortunatelyYes
+	SPARSE_FLAGS = -isystem /usr/include/w32api -Wno-one-bit-signed-bitfield
 endif
 ifeq ($(uname_S),FreeBSD)
 	NEEDS_LIBICONV = YesPlease
@@ -1177,6 +1176,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	EXTLIBS += -lws2_32
 	PTHREAD_LIBS =
 	X = .exe
+	SPARSE_FLAGS = -Wno-one-bit-signed-bitfield
 ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
 	htmldir=doc/git/html/
 	prefix =
@@ -2160,11 +2160,12 @@ check-sha1:: test-sha1$X
 	./test-sha1.sh
 
 check: common-cmds.h
-	if sparse; \
+	@if sparse; \
 	then \
 		for i in $(patsubst %.o, %.c, $(GIT_OBJS)); \
 		do \
-			sparse $(ALL_CFLAGS) $(SPARSE_FLAGS) $$i || exit; \
+			echo '   ' SP $$i; \
+			cgcc -no-compile $(ALL_CFLAGS) $(SPARSE_FLAGS) $$i || exit; \
 		done; \
 	else \
 		echo 2>&1 "Did you mean 'make test'?"; \
-- 
1.7.4
