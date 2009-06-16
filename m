From: Jeff King <peff@peff.net>
Subject: [PATCH v2 1/2] Makefile: refactor regex compat support
Date: Tue, 16 Jun 2009 15:07:40 -0400
Message-ID: <20090616190740.GA23197@coredump.intra.peff.net>
References: <20090616190550.GA22905@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Bito <jwbito@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jun 16 21:07:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGe0d-0007S0-3V
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 21:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759683AbZFPTHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 15:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757488AbZFPTHk
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 15:07:40 -0400
Received: from peff.net ([208.65.91.99]:33632 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753962AbZFPTHk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 15:07:40 -0400
Received: (qmail 5921 invoked by uid 107); 16 Jun 2009 19:09:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 16 Jun 2009 15:09:26 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Jun 2009 15:07:40 -0400
Content-Disposition: inline
In-Reply-To: <20090616190550.GA22905@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121705>

There was no tweakable knob to use the regex compat code; it
was embedded in the mingw build. Since other platforms may
want to use it, let's factor it out in the usual way for
build configuration knobs.

Signed-off-by: Jeff King <peff@peff.net>
---
Rebased on today's master to resolve textual conflicts.

 Makefile |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 41ab8e9..0cb21da 100644
--- a/Makefile
+++ b/Makefile
@@ -194,6 +194,8 @@ all::
 #
 # Define USE_NED_ALLOCATOR if you want to replace the platforms default
 # memory allocators with the nedmalloc allocator written by Niall Douglas.
+#
+# Define NO_REGEX if you have no or inferior regex support in your C library.
 
 GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -884,9 +886,10 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	USE_NED_ALLOCATOR = YesPlease
 	UNRELIABLE_FSTAT = UnfortunatelyYes
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
-	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/regex -Icompat/fnmatch
+	NO_REGEX = YesPlease
+	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/fnmatch
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
-	COMPAT_OBJS += compat/mingw.o compat/fnmatch/fnmatch.o compat/regex/regex.o compat/winansi.o
+	COMPAT_OBJS += compat/mingw.o compat/fnmatch/fnmatch.o compat/winansi.o
 	EXTLIBS += -lws2_32
 	X = .exe
 ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
@@ -1200,6 +1203,10 @@ endif
 ifdef UNRELIABLE_FSTAT
 	BASIC_CFLAGS += -DUNRELIABLE_FSTAT
 endif
+ifdef NO_REGEX
+	COMPAT_CFLAGS += -Icompat/regex
+	COMPAT_OBJS += compat/regex/regex.o
+endif
 
 ifdef USE_NED_ALLOCATOR
        COMPAT_CFLAGS += -DUSE_NED_ALLOCATOR -DOVERRIDE_STRDUP -DNDEBUG -DREPLACE_SYSTEM_ALLOCATOR -Icompat/nedmalloc
-- 
1.6.3.2.411.gffb5
