From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Making CFLAGS compilant with GNU Coding Standards
Date: Sat, 06 Aug 2005 01:36:15 -0400
Message-ID: <1123306575.7588.17.camel@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Aug 06 07:37:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1HMA-0000zA-Lx
	for gcvg-git@gmane.org; Sat, 06 Aug 2005 07:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbVHFFgS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Aug 2005 01:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbVHFFgS
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Aug 2005 01:36:18 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:9859 "HELO
	roinet.com") by vger.kernel.org with SMTP id S262318AbVHFFgR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Aug 2005 01:36:17 -0400
Received: (qmail 14060 invoked from network); 6 Aug 2005 05:36:16 -0000
Received: from corporate.roinet.com (HELO mail.roinet.com) (192.168.1.2)
  by roinet.com with SMTP; 6 Aug 2005 05:36:16 -0000
Received: by mail.roinet.com (Postfix, from userid 65534)
	id 51A0D45DF44; Sat,  6 Aug 2005 01:36:16 -0400 (EDT)
Received: from [192.168.1.101] (unknown [192.168.1.1])
	(using SSLv3 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by mail.roinet.com (Postfix) with ESMTP id F1C1B45DF42
	for <git@vger.kernel.org>; Sat,  6 Aug 2005 01:36:15 -0400 (EDT)
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
X-Spam-Checker-Version: SpamAssassin 2.64 (2004-01-11) on mail.roinet.com
X-Spam-Level: 
X-Spam-Status: No, hits=-4.9 required=5.0 tests=AWL,BAYES_00,UPPERCASE_25_50 
	autolearn=no version=2.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello!

Quoting GNU Coding Standards ("info standards"):

"If there are C compiler options that _must_ be used for proper
compilation of certain files, do not include them in `CFLAGS'.  Users
expect to be able to specify `CFLAGS' freely themselves."

This patch renames COPTS to CFLAGS, because it's COPTS that was user
overridable.  Also, -Wall is moved there because it's optional.  What
was CFLAGS is now ALL_CFLAGS, which users should not override.

Defines are added to DEFINES.  Since ALL_CFLAGS is recursively expanded,
it uses the final value of DEFINES.

Implicit rules are made explicit since the implicit rules use CFLAGS
rather than ALL_CFLAGS.  I believe that serious projects should not rely
on implicit rules anyway.  Percent rules are used because they are used
already and because they don't need the .SUFFIXES target.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -34,8 +34,8 @@
 
 GIT_VERSION=0.99.3
 
-COPTS?=-g -O2
-CFLAGS+=$(COPTS) -Wall $(DEFINES)
+CFLAGS ?= -g -O2 -Wall
+ALL_CFLAGS = $(CFLAGS) $(DEFINES)
 
 prefix=$(HOME)
 bindir=$(prefix)/bin
@@ -125,7 +125,7 @@ ifndef NO_OPENSSL
 	LIB_OBJS += epoch.o
 	OPENSSL_LIBSSL=-lssl
 else
-	CFLAGS += '-DNO_OPENSSL'
+	DEFINES += '-DNO_OPENSSL'
 	MOZILLA_SHA1=1
 	OPENSSL_LIBSSL=
 endif
@@ -146,8 +146,8 @@ endif
 endif
 endif
 
-CFLAGS += '-DSHA1_HEADER=$(SHA1_HEADER)'
-CFLAGS += '-DDEFAULT_GIT_TEMPLATE_ENVIRONMENT="$(etcgitdir)/templates"'
+DEFINES += '-DSHA1_HEADER=$(SHA1_HEADER)'
+DEFINES += '-DDEFAULT_GIT_TEMPLATE_ENVIRONMENT="$(etcgitdir)/templates"'
 
 
 
@@ -156,9 +156,15 @@ CFLAGS += '-DDEFAULT_GIT_TEMPLATE_ENVIRO
 all: $(PROG)
 
 
+%.o: %.c
+	$(CC) -c $(ALL_CFLAGS) $<
+
+%.o: %.S
+	$(CC) -c $(ALL_CFLAGS) $<
+
 .PRECIOUS: %.o
 git-%: %.o $(LIB_FILE)
-	$(CC) $(CFLAGS) -o $@ $(filter %.o,$^) $(LIBS)
+	$(CC) $(ALL_CFLAGS) -o $@ $(filter %.o,$^) $(LIBS)
 
 git-http-pull: pull.o
 git-local-pull: pull.o
@@ -185,13 +191,13 @@ test: all
 	$(MAKE) -C t/ all
 
 test-date: test-date.c date.o
-	$(CC) $(CFLAGS) -o $@ test-date.c date.o
+	$(CC) $(ALL_CFLAGS) -o $@ test-date.c date.o
 
 test-delta: test-delta.c diff-delta.o patch-delta.o
-	$(CC) $(CFLAGS) -o $@ $^
+	$(CC) $(ALL_CFLAGS) -o $@ $^
 
 check:
-	for i in *.c; do sparse $(CFLAGS) $(SPARSE_FLAGS) $$i; done
+	for i in *.c; do sparse $(ALL_CFLAGS) $(SPARSE_FLAGS) $$i; done
 
 
 

-- 
Regards,
Pavel Roskin
