From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Building git on NetBSD
Date: Sun, 13 Nov 2005 01:44:37 -0800
Message-ID: <7vlkzsc262.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0511120649430.2695@x2.ybpnyarg>
	<43760AF5.1010704@op5.se> <7vhdahclr5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 13 10:45:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbEPt-0002wh-5f
	for gcvg-git@gmane.org; Sun, 13 Nov 2005 10:44:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbVKMJol (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Nov 2005 04:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbVKMJol
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Nov 2005 04:44:41 -0500
Received: from eastrmmtao04.cox.net ([68.230.240.35]:50925 "EHLO
	eastrmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932226AbVKMJok (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2005 04:44:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by eastrmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051113094311.BLQ4997.eastrmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 13 Nov 2005 04:43:11 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <7vhdahclr5.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 12 Nov 2005 18:41:34 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11729>

Junio C Hamano <junkio@cox.net> writes:

> Andreas Ericsson <ae@op5.se> writes:
>
>> Yes it should. Currently the git makefile doesn't distinguish between 
>> CFLAGS and LDFLAGS which results in a fair few warnings.
>
> Very well.  Maybe LDFLAGS and ALL_LDFLAGS pair to parallel
> CFLAGS and ALL_CFLAGS (the former is for the end user to
> override from make command line, the latter is for Makefile to
> augment and use)?

Does this look OK?

-- >8 -- cut here -- >8 --
diff --git a/Makefile b/Makefile
index b75cb13..7713c05 100644
--- a/Makefile
+++ b/Makefile
@@ -52,10 +52,12 @@
 
 GIT_VERSION = 0.99.9.GIT
 
-# CFLAGS is for the users to override from the command line.
+# CFLAGS and LDFLAGS are for the users to override from the command line.
 
 CFLAGS = -g -O2 -Wall
+LDFLAGS =
 ALL_CFLAGS = $(CFLAGS)
+ALL_LDFLAGS = $(LDFLAGS)
 
 prefix = $(HOME)
 bindir = $(prefix)/bin
@@ -187,9 +189,11 @@ ifeq ($(uname_S),Darwin)
 	NEEDS_SSL_WITH_CRYPTO = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	## fink
-	ALL_CFLAGS += -I/sw/include -L/sw/lib
+	ALL_CFLAGS += -I/sw/include
+	ALL_LDFLAGS += -L/sw/lib
 	## darwinports
-	ALL_CFLAGS += -I/opt/local/include -L/opt/local/lib
+	ALL_CFLAGS += -I/opt/local/include
+	ALL_LDFLAGS += -L/opt/local/lib
 endif
 ifeq ($(uname_S),SunOS)
 	NEEDS_SOCKET = YesPlease
@@ -211,7 +215,13 @@ endif
 ifeq ($(uname_S),OpenBSD)
 	NO_STRCASESTR = YesPlease
 	NEEDS_LIBICONV = YesPlease
-	ALL_CFLAGS += -I/usr/local/include -L/usr/local/lib
+	ALL_CFLAGS += -I/usr/local/include
+	ALL_LDFLAGS += -L/usr/local/lib
+endif
+ifeq ($(uname_S),NetBSD)
+	NEEDS_LIBICONV = YesPlease
+	ALL_CFLAGS += -I/usr/pkg/include
+	ALL_LDFLAGS += -L/usr/pkg/lib -Wl,-rpath,/usr/pkg/lib
 endif
 ifneq (,$(findstring arm,$(uname_M)))
 	ARM_SHA1 = YesPlease
@@ -221,7 +231,7 @@ endif
 
 ifndef NO_CURL
 	ifdef CURLDIR
-		# This is still problematic -- gcc does not want -R.
+		# This is still problematic -- gcc does not always want -R.
 		ALL_CFLAGS += -I$(CURLDIR)/include
 		CURL_LIBCURL = -L$(CURLDIR)/lib -R$(CURLDIR)/lib -lcurl
 	else
@@ -369,12 +379,13 @@ git-cherry-pick: git-revert
 	$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 
 git-%$X: %.o $(LIB_FILE)
-	$(CC) $(ALL_CFLAGS) -o $@ $(filter %.o,$^) $(LIBS)
+	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
 git-mailinfo$X : SIMPLE_LIB += $(LIB_4_ICONV)
 $(SIMPLE_PROGRAMS) : $(LIB_FILE)
 $(SIMPLE_PROGRAMS) : git-%$X : %.o
-	$(CC) $(ALL_CFLAGS) -o $@ $(filter %.o,$^) $(LIB_FILE) $(SIMPLE_LIB)
+	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+		$(LIB_FILE) $(SIMPLE_LIB)
 
 git-http-fetch$X: fetch.o
 git-local-fetch$X: fetch.o
@@ -408,10 +419,10 @@ test: all
 	$(MAKE) -C t/ all
 
 test-date$X: test-date.c date.o ctype.o
-	$(CC) $(ALL_CFLAGS) -o $@ test-date.c date.o ctype.o
+	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) test-date.c date.o ctype.o
 
 test-delta$X: test-delta.c diff-delta.o patch-delta.o
-	$(CC) $(ALL_CFLAGS) -o $@ $^
+	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $^
 
 check:
 	for i in *.c; do sparse $(ALL_CFLAGS) $(SPARSE_FLAGS) $$i; done
