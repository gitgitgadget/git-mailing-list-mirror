From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] Makefile: refactor regex compat support
Date: Tue, 16 Jun 2009 08:11:26 -0400
Message-ID: <20090616121126.GA11918@coredump.intra.peff.net>
References: <20090616120737.GA5227@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	git <git@vger.kernel.org>
To: John Bito <jwbito@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 14:11:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGXVo-0004Iv-Mh
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 14:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756884AbZFPML1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 08:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756196AbZFPML0
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 08:11:26 -0400
Received: from peff.net ([208.65.91.99]:35991 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755083AbZFPML0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 08:11:26 -0400
Received: (qmail 4123 invoked by uid 107); 16 Jun 2009 12:13:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 16 Jun 2009 08:13:12 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Jun 2009 08:11:26 -0400
Content-Disposition: inline
In-Reply-To: <20090616120737.GA5227@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121677>

There was no tweakable knob to use the regex compat code; it
was embedded in the mingw build. Since other platforms may
want to use it, let's factor it out in the usual way for
build configuration knobs.

Signed-off-by: Jeff King <peff@peff.net>
---
This should behave the same as before on all platforms. The only one I
might have screwed up by doing it wrong is mingw, but I have no machine
to test on. Johannes, can you confirm that it is right?

 Makefile |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 04bf8b1..a1e4e45 100644
--- a/Makefile
+++ b/Makefile
@@ -182,6 +182,8 @@ all::
 #
 # Define NO_CROSS_DIRECTORY_HARDLINKS if you plan to distribute the installed
 # programs as a tar, where bin/ and libexec/ might be on different file systems.
+#
+# Define NO_REGEX if you have no or inferior regex support in your C library.
 
 GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -863,10 +865,11 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	USE_WIN32_MMAP = YesPlease
 	UNRELIABLE_FSTAT = UnfortunatelyYes
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
-	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/regex -Icompat/fnmatch
+	NO_REGEX = YesPlease
+	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/fnmatch
 	COMPAT_CFLAGS += -DSNPRINTF_SIZE_CORR=1
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
-	COMPAT_OBJS += compat/mingw.o compat/fnmatch/fnmatch.o compat/regex/regex.o compat/winansi.o
+	COMPAT_OBJS += compat/mingw.o compat/fnmatch/fnmatch.o compat/winansi.o
 	EXTLIBS += -lws2_32
 	X = .exe
 endif
@@ -1157,6 +1160,10 @@ endif
 ifdef UNRELIABLE_FSTAT
 	BASIC_CFLAGS += -DUNRELIABLE_FSTAT
 endif
+ifdef NO_REGEX
+	COMPAT_CFLAGS += -Icompat/regex
+	COMPAT_OBJS += compat/regex/regex.o
+endif
 
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK=NoThanks
-- 
1.6.3.2.225.gb8364.dirty
