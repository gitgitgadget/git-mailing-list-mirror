Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69AB91F404
	for <e@80x24.org>; Sat, 17 Mar 2018 16:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752713AbeCQQIf (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 12:08:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:60854 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752589AbeCQQIe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 12:08:34 -0400
Received: (qmail 23259 invoked by uid 109); 17 Mar 2018 16:08:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 17 Mar 2018 16:08:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6479 invoked by uid 111); 17 Mar 2018 16:09:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 17 Mar 2018 12:09:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Mar 2018 12:08:32 -0400
Date:   Sat, 17 Mar 2018 12:08:32 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2] travis-ci: enable more warnings on travis linux-gcc
 job
Message-ID: <20180317160832.GB15772@sigill.intra.peff.net>
References: <20180303014605.10603-1-pclouds@gmail.com>
 <20180316193355.20161-1-pclouds@gmail.com>
 <20180316212208.GC12333@sigill.intra.peff.net>
 <CACsJy8A3_itjs0MRar+Aog=0yZDuAK2-x4MU=Rvqh2C6Le-7Aw@mail.gmail.com>
 <D8137CD9-9E11-4FBC-B89B-907C007FC6E9@gmail.com>
 <20180317145923.GA24689@duynguyen.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180317145923.GA24689@duynguyen.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 17, 2018 at 03:59:23PM +0100, Duy Nguyen wrote:

> On Sat, Mar 17, 2018 at 03:29:31PM +0100, Lars Schneider wrote:
> > I interpreted Peff's comment like this:
> > 
> > If DEVELOPER=1 is set and we detect a gcc-6 in the makefile, 
> > then we could set your additional flags in the makefile.
> > 
> > This way every developer with a new compiler would run these
> > flags locally (if DEVELOPER=1 is set).
> 
> Aha. Something like this? I split developer cflags out to a separate
> file because I imagine people may start to add gcc7, clang....

Yeah, gcc 7 is already standard on debian unstable, so...

> +GCC_VER := $(shell sh -c '$(CC) --version | grep ^gcc >/dev/null && $(CC) -dumpversion | cut -f 1 -d .')
> +
> +ifeq ($(GCC_VER),6)

...this probably needs to be "greater than or equal to".

Unfortunately I think that's hard to do in pure make. But we're already
relying on $(shell) here, so we could just move the logic there.

Something like the patch below, perhaps. It should do the right thing on
clang and gcc, and I added in an extra clang-only warning I've found
useful. Otherwise the list of flags comes from your patch.

The "clang4" limit is just what I happened to have on my system to test
with. Some of those flags might work for clang3, and some of the
gcc6-only flags might work on newer versions of clang.

I was puzzled by -Wno-maybe-uninitialized, though. I think that has
found bugs for us before (but also false positives, but we usually
squelch those in the code). And it's part of -Wall, not -Wextra, so we
shouldn't need it as part of this patch, should we?

diff --git a/Makefile b/Makefile
index a1d8775adb..9dfd152a1e 100644
--- a/Makefile
+++ b/Makefile
@@ -442,15 +442,6 @@ GIT-VERSION-FILE: FORCE
 # CFLAGS and LDFLAGS are for the users to override from the command line.
 
 CFLAGS = -g -O2 -Wall
-DEVELOPER_CFLAGS = -Werror \
-	-Wdeclaration-after-statement \
-	-Wno-format-zero-length \
-	-Wold-style-definition \
-	-Woverflow \
-	-Wpointer-arith \
-	-Wstrict-prototypes \
-	-Wunused \
-	-Wvla
 LDFLAGS =
 ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
@@ -1051,7 +1042,7 @@ include config.mak.uname
 -include config.mak
 
 ifdef DEVELOPER
-CFLAGS += $(DEVELOPER_CFLAGS)
+include config.mak.dev
 endif
 
 comma := ,
diff --git a/config.mak.dev b/config.mak.dev
new file mode 100644
index 0000000000..59aef342c4
--- /dev/null
+++ b/config.mak.dev
@@ -0,0 +1,28 @@
+CFLAGS += -Werror
+CFLAGS += -Wdeclaration-after-statement
+CFLAGS += -Wno-format-zero-length
+CFLAGS += -Wold-style-definition
+CFLAGS += -Woverflow
+CFLAGS += -Wpointer-arith
+CFLAGS += -Wstrict-prototypes
+CFLAGS += -Wunused
+CFLAGS += -Wvla
+
+COMPILER_FEATURES := $(shell ./detect-compiler $(CC))
+
+ifneq ($(filter clang4,$(COMPILER_FEATURES)),)
+CFLAGS += -Wtautological-constant-out-of-range-compare
+endif
+
+ifneq ($(or $(filter gcc6,$(COMPILER_FEATURES)),$(filter clang4,$(COMPILER_FEATURES))),)
+CFLAGS += -Wextra
+CFLAGS += -Wmissing-prototypes
+CFLAGS += -Wno-empty-body
+CFLAGS += -Wno-missing-field-initializers
+CFLAGS += -Wno-sign-compare
+CFLAGS += -Wno-unused-function
+CFLAGS += -Wno-unused-parameter
+ifneq ($(filter gcc6,$(COMPILER_FEATURES)),)
+CFLAGS += -Wno-maybe-uninitialized
+endif
+endif
diff --git a/detect-compiler b/detect-compiler
new file mode 100755
index 0000000000..043367828c
--- /dev/null
+++ b/detect-compiler
@@ -0,0 +1,32 @@
+#!/bin/sh
+#
+# Probe the compiler for vintage, version, etc. This is used for setting
+# optional make knobs under the DEVELOPER knob.
+
+CC="$*"
+
+print_flags() {
+	family=$1
+	version=$($CC -dumpversion | cut -f 1 -d .)
+
+	# Print a feature flag not only for the current version, but also
+	# for any prior versions we encompass. This avoids needing to do
+	# numeric comparisons in make, which are awkward.
+	while test "$version" -gt 0
+	do
+		echo $family$version
+		version=$((version - 1))
+	done
+}
+
+case "$($CC --version 2>&1)" in
+gcc*)
+	print_flags gcc
+	;;
+clang*)
+	print_flags clang
+	;;
+*)
+	: unknown compiler family
+	;;
+esac
-- 
2.17.0.rc0.402.ged0b3fd1ee

