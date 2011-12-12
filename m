From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 2/2] Makefile: optionally exclude code that needs Unix sockets
Date: Mon, 12 Dec 2011 22:12:56 +0100
Message-ID: <4EE66E58.6040404@kdbg.org>
References: <20111210103943.GA16478@sigill.intra.peff.net> <20111210104130.GI16648@sigill.intra.peff.net> <4EE66DAB.5070407@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 12 22:13:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaDBJ-00033Q-AE
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 22:13:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754169Ab1LLVNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 16:13:00 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:44123 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753963Ab1LLVM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 16:12:59 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 3D1A52C4002;
	Mon, 12 Dec 2011 22:13:35 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id E073B19F5F7;
	Mon, 12 Dec 2011 22:12:56 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <4EE66DAB.5070407@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186948>

Introduce a configuration option NO_UNIX_SOCKETS to exclude code that
depends on Unix sockets and use it in MSVC and MinGW builds.

Notice that unix-socket.h was missing from LIB_H before; fix that, too.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
All or most of the tests introduced by the series fail on Windows.
What is the preferred way to exclude them? Mark the all with a
prerequisite? Or exit early at the beginning of the test file?

 Makefile |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 5b7f6a8..77c85db 100644
--- a/Makefile
+++ b/Makefile
@@ -143,6 +143,8 @@ all::
 #
 # Define NO_IPV6 if you lack IPv6 support and getaddrinfo().
 #
+# Define NO_UNIX_SOCKETS if your system does not offer unix sockets.
+#
 # Define NO_SOCKADDR_STORAGE if your platform does not have struct
 # sockaddr_storage.
 #
@@ -430,8 +432,6 @@ PROGRAM_OBJS += show-index.o
 PROGRAM_OBJS += upload-pack.o
 PROGRAM_OBJS += http-backend.o
 PROGRAM_OBJS += sh-i18n--envsubst.o
-PROGRAM_OBJS += credential-cache.o
-PROGRAM_OBJS += credential-cache--daemon.o
 PROGRAM_OBJS += credential-store.o
 
 PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
@@ -709,7 +709,6 @@ LIB_OBJS += transport-helper.o
 LIB_OBJS += tree-diff.o
 LIB_OBJS += tree.o
 LIB_OBJS += tree-walk.o
-LIB_OBJS += unix-socket.o
 LIB_OBJS += unpack-trees.o
 LIB_OBJS += url.o
 LIB_OBJS += usage.o
@@ -1112,6 +1111,7 @@ ifeq ($(uname_S),Windows)
 	NO_SYS_POLL_H = YesPlease
 	NO_SYMLINK_HEAD = YesPlease
 	NO_IPV6 = YesPlease
+	NO_UNIX_SOCKETS = YesPlease
 	NO_SETENV = YesPlease
 	NO_UNSETENV = YesPlease
 	NO_STRCASESTR = YesPlease
@@ -1206,6 +1206,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_LIBGEN_H = YesPlease
 	NO_SYS_POLL_H = YesPlease
 	NO_SYMLINK_HEAD = YesPlease
+	NO_UNIX_SOCKETS = YesPlease
 	NO_SETENV = YesPlease
 	NO_UNSETENV = YesPlease
 	NO_STRCASESTR = YesPlease
@@ -1584,6 +1585,12 @@ ifdef NO_INET_PTON
 	LIB_OBJS += compat/inet_pton.o
 	BASIC_CFLAGS += -DNO_INET_PTON
 endif
+ifndef NO_UNIX_SOCKETS
+	LIB_OBJS += unix-socket.o
+	LIB_H += unix-socket.h
+	PROGRAM_OBJS += credential-cache.o
+	PROGRAM_OBJS += credential-cache--daemon.o
+endif
 
 ifdef NO_ICONV
 	BASIC_CFLAGS += -DNO_ICONV
-- 
1.7.8.216.g2e426
