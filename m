From: Peter Simons <simons@cryp.to>
Subject: [PATCH] Makefile: Improve support for static linking.
Date: 21 Feb 2007 00:43:13 +0100
Organization: private
Message-ID: <87ps84v1im.fsf@write-only.cryp.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 21 00:55:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJepP-0001RR-MR
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 00:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161101AbXBTXzU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 18:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161102AbXBTXzU
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 18:55:20 -0500
Received: from main.gmane.org ([80.91.229.2]:38787 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161101AbXBTXzT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 18:55:19 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HJep4-0001up-5W
	for git@vger.kernel.org; Wed, 21 Feb 2007 00:55:03 +0100
Received: from e178091029.adsl.alicedsl.de ([85.178.91.29])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Feb 2007 00:55:02 +0100
Received: from simons by e178091029.adsl.alicedsl.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Feb 2007 00:55:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: e178091029.adsl.alicedsl.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40266>

The naive approach to build a statically linked git toolset, "make
LDFLAGS=-static", fails for two reasons:

 * Libraries git depends on might depend on other libraries this
   Makefile can't know about. Curl, for example, can be compiled with or
   without support for international domain names. If that capability is
   compiled in, linking curl needs "-lidn". Also, static linking often
   adds a dependency on dlopen() and friends, so "-ldl" must be
   specified too.

 * Linking statically requires the libraries to be specified in top-down
   order.

Guessing how to build a static binary on any given platform is quite
difficult, but this patch gets us a littler closer to that goal. The
changes are:

 * Support "make LIBS=-ldl".

 * Use curl-config(1) to determine $CURL_LIBCURL defaults.

 * Reorder $LIB_4_CRYPTO to "-lssl -lcrypto" (if NEEDS_SSL_WITH_CRYPTO).

 * Always specify $BASIC_LIBS (formerly $LIBS) last.
---
 Makefile |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index 289decd..b07b2b8 100644
--- a/Makefile
+++ b/Makefile
@@ -167,6 +167,7 @@ SPARSE_FLAGS = -D__BIG_ENDIAN__ -D__powerpc__
 # but it still might be nice to keep that distinction.)
 BASIC_CFLAGS =
 BASIC_LDFLAGS =
+BASIC_LIBS =
 
 SCRIPT_SH = \
 	git-bisect.sh git-checkout.sh \
@@ -454,7 +455,8 @@ ifndef NO_CURL
 	ifdef CURLDIR
 		# Try "-Wl,-rpath=$(CURLDIR)/lib" in such a case.
 		BASIC_CFLAGS += -I$(CURLDIR)/include
-		CURL_LIBCURL = -L$(CURLDIR)/lib $(CC_LD_DYNPATH)$(CURLDIR)/lib -lcurl
+		CURL_LIBCURL  = $(shell curl-config --libs)
+		CURL_LIBCURL += -L$(CURLDIR)/lib $(CC_LD_DYNPATH)$(CURLDIR)/lib -lcurl
 	else
 		CURL_LIBCURL = -lcurl
 	endif
@@ -484,7 +486,7 @@ else
 	OPENSSL_LIBSSL =
 endif
 ifdef NEEDS_SSL_WITH_CRYPTO
-	LIB_4_CRYPTO = $(OPENSSL_LINK) -lcrypto -lssl
+	LIB_4_CRYPTO = $(OPENSSL_LINK) -lssl -lcrypto
 else
 	LIB_4_CRYPTO = $(OPENSSL_LINK) -lcrypto
 endif
@@ -607,7 +609,7 @@ prefix_SQ = $(subst ','\'',$(prefix))
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
 
-LIBS = $(GITLIBS) $(EXTLIBS)
+BASIC_LIBS += $(GITLIBS) $(EXTLIBS) $(LIBS)
 
 BASIC_CFLAGS += -DSHA1_HEADER='$(SHA1_HEADER_SQ)' $(COMPAT_CFLAGS)
 LIB_OBJS += $(COMPAT_OBJS)
@@ -636,7 +638,7 @@ strip: $(PROGRAMS) git$X
 git$X: git.c common-cmds.h $(BUILTIN_OBJS) $(GITLIBS) GIT-CFLAGS
 	$(CC) -DGIT_VERSION='"$(GIT_VERSION)"' \
 		$(ALL_CFLAGS) -o $@ $(filter %.c,$^) \
-		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
+		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(BASIC_LIBS)
 
 help.o: common-cmds.h
 
@@ -754,7 +756,7 @@ http-fetch.o: http-fetch.c http.h GIT-CFLAGS
 endif
 
 git-%$X: %.o $(GITLIBS)
-	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
+	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(BASIC_LIBS)
 
 ssh-pull.o: ssh-fetch.c
 ssh-push.o: ssh-upload.c
@@ -769,11 +771,11 @@ git-imap-send$X: imap-send.o $(LIB_FILE)
 http.o http-fetch.o http-push.o: http.h
 git-http-fetch$X: fetch.o http.o http-fetch.o $(GITLIBS)
 	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
-		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
+		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(BASIC_LIBS)
 
 git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
 	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
-		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
+		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(BASIC_LIBS)
 
 $(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
 $(patsubst git-%$X,%.o,$(PROGRAMS)): $(LIB_H) $(wildcard */*.h)
@@ -832,13 +834,13 @@ test-date$X: test-date.c date.o ctype.o
 	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) test-date.c date.o ctype.o
 
 test-delta$X: test-delta.o diff-delta.o patch-delta.o $(GITLIBS)
-	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
+	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(BASIC_LIBS)
 
 test-dump-cache-tree$X: dump-cache-tree.o $(GITLIBS)
-	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
+	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(BASIC_LIBS)
 
 test-sha1$X: test-sha1.o $(GITLIBS)
-	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
+	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(BASIC_LIBS)
 
 check-sha1:: test-sha1$X
 	./test-sha1.sh
-- 
1.5.0
