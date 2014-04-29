From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 09/12] Makefile: introduce CROSS_COMPILE variable
Date: Tue, 29 Apr 2014 13:12:03 +0400
Message-ID: <1398762726-22825-10-git-send-email-marat@slonopotamus.org>
References: <1398762726-22825-1-git-send-email-marat@slonopotamus.org>
Cc: marat@slonopotamus.org,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 11:12:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf45Z-0005GE-N8
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 11:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756824AbaD2JM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 05:12:26 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:45113 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbaD2JMX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 05:12:23 -0400
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1Wf45L-0006BN-RU; Tue, 29 Apr 2014 13:12:20 +0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1398762726-22825-1-git-send-email-marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247534>

To ease cross-compilation process, introduce a single variable
with the prefix to all compiler-related executables.

Define CROSS_COMPILE=foo- if your compiler and binary utilities
are foo-cc, foo-ar, foo-strip, etc.  More specific variables
override this, so if you set CC=gcc CROSS_COMPILE=ia64-linux-gnu-
then the compiler will be 'gcc', not 'ia64-linux-gnu-gcc'.

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---
 Makefile         | 19 +++++++++++++------
 config.mak.uname |  2 +-
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 74a929b..8406b94 100644
--- a/Makefile
+++ b/Makefile
@@ -350,6 +350,11 @@ all::
 #
 # Define GMTIME_UNRELIABLE_ERRORS if your gmtime() function does not
 # return NULL when it receives a bogus time_t.
+#
+# Define CROSS_COMPILE=foo- if your compiler and binary utilities
+# are foo-cc, foo-ar, foo-strip, etc.  More specific variables
+# override this, so if you set CC=gcc CROSS_COMPILE=ia64-linux-gnu-
+# then the compiler will be 'gcc', not 'ia64-linux-gnu-gcc'.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -361,7 +366,6 @@ CFLAGS = -g -O2 -Wall
 LDFLAGS =
 ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
-STRIP ?= strip
 
 # Among the variables below, these:
 #   gitexecdir
@@ -401,8 +405,12 @@ htmldir_relative = $(patsubst $(prefix)/%,%,$(htmldir))
 
 export prefix bindir sharedir sysconfdir gitwebdir localedir
 
-CC = cc
-AR = ar
+AR = $(CROSS_COMPILE)ar
+CC = $(CROSS_COMPILE)cc
+GCOV = $(CROSS_COMPILE)gcov
+RC = $(CROSS_COMPILE)windres
+STRIP = $(CROSS_COMPILE)strip
+
 RM = rm -f
 DIFF = diff
 TAR = tar
@@ -415,13 +423,12 @@ XGETTEXT = xgettext
 MSGFMT = msgfmt
 PTHREAD_LIBS = -lpthread
 PTHREAD_CFLAGS =
-GCOV = gcov
 
 export TCL_PATH TCLTK_PATH
 
 SPARSE_FLAGS =
 
-
+RCFLAGS =
 
 ### --- END CONFIGURATION SECTION ---
 
@@ -1796,7 +1803,7 @@ $(SCRIPT_LIB) : % : %.sh GIT-SCRIPT-DEFINES
 	mv $@+ $@
 
 git.res: git.rc GIT-VERSION-FILE
-	$(QUIET_RC)$(RC) \
+	$(QUIET_RC)$(RC) $(RCFLAGS) \
 	  $(join -DMAJOR= -DMINOR=, $(wordlist 1,2,$(subst -, ,$(subst ., ,$(GIT_VERSION))))) \
 	  -DGIT_VERSION="\\\"$(GIT_VERSION)\\\"" $< -o $@
 
diff --git a/config.mak.uname b/config.mak.uname
index b68a7d1..d5f7953 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -507,7 +507,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	EXTLIBS += -lws2_32
 	GITLIBS += git.res
 	PTHREAD_LIBS =
-	RC = windres -O coff
+	RCFLAGS += -O coff
 	NATIVE_CRLF = YesPlease
 	X = .exe
 	SPARSE_FLAGS = -Wno-one-bit-signed-bitfield
-- 
1.9.1
