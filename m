Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0996EC432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 01:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D856361057
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 01:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241695AbhIABx3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 21:53:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:35906 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231396AbhIABx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 21:53:28 -0400
Received: (qmail 14907 invoked by uid 109); 1 Sep 2021 01:52:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Sep 2021 01:52:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1173 invoked by uid 111); 1 Sep 2021 01:52:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 31 Aug 2021 21:52:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 31 Aug 2021 21:52:31 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        phillip.wood@dunelm.org.uk, git@vger.kernel.org, e@80x24.org
Subject: Re: [PATCH/RFC 3/3] ci: run a pedantic build as part of the GitHub
 workflow
Message-ID: <YS7c3169x5Wk4PlA@coredump.intra.peff.net>
References: <CAPUEsphf9F1+=zOMKx3j=jH8xqDwQX99+9uHiYUpXhFE1nervg@mail.gmail.com>
 <20210809013833.58110-1-carenas@gmail.com>
 <20210809013833.58110-4-carenas@gmail.com>
 <1b096830-3e01-efbe-25dc-c0505c8bac7b@gmail.com>
 <87zgszxirn.fsf@evledraar.gmail.com>
 <CAPUEspj43=z8nSdh8UAiqZ+UR8UAZkSsQr1WviGtasQ7d-fHTQ@mail.gmail.com>
 <87bl5dwcx0.fsf@evledraar.gmail.com>
 <CAPUEsphbUHgt09A2qdy-5U0L1y13pkeNjBEUbjkE6JOPeqDVMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPUEsphbUHgt09A2qdy-5U0L1y13pkeNjBEUbjkE6JOPeqDVMA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 04:54:52PM -0700, Carlo Arenas wrote:

> On Tue, Aug 31, 2021 at 1:57 PM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
> >
> > On the other hand maybe we should just remove
> > USE_PARENS_AROUND_GETTEXT_N entirely, i.e. always use the parens.
> 
> that would break pedantic in all versions of gcc since it is a GNU
> extension and is not valid in any C standard.
> (unlike the ones we are using with weather balloons and that are valid C99)

I think Ævar might have mis-spoke there. It would make sense to get rid
of the feature and _never_ use parens, which is always valid C (and does
not tickle pedantic, but also does not catch any accidental string
concatenation).

That actually seems quite reasonable to me.

Something like this, I guess?

diff --git a/Makefile b/Makefile
index d1feab008f..4936e234bc 100644
--- a/Makefile
+++ b/Makefile
@@ -409,15 +409,6 @@ all::
 # Define NEEDS_LIBRT if your platform requires linking with librt (glibc version
 # before 2.17) for clock_gettime and CLOCK_MONOTONIC.
 #
-# Define USE_PARENS_AROUND_GETTEXT_N to "yes" if your compiler happily
-# compiles the following initialization:
-#
-#   static const char s[] = ("FOO");
-#
-# and define it to "no" if you need to remove the parentheses () around the
-# constant.  The default is "auto", which means to use parentheses if your
-# compiler is detected to support it.
-#
 # Define HAVE_BSD_SYSCTL if your platform has a BSD-compatible sysctl function.
 #
 # Define HAVE_GETDELIM if your system has the getdelim() function.
@@ -497,8 +488,7 @@ all::
 #
 #    pedantic:
 #
-#        Enable -pedantic compilation. This also disables
-#        USE_PARENS_AROUND_GETTEXT_N to produce only relevant warnings.
+#        Enable -pedantic compilation.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -1347,14 +1337,6 @@ ifneq (,$(SOCKLEN_T))
 	BASIC_CFLAGS += -Dsocklen_t=$(SOCKLEN_T)
 endif
 
-ifeq (yes,$(USE_PARENS_AROUND_GETTEXT_N))
-	BASIC_CFLAGS += -DUSE_PARENS_AROUND_GETTEXT_N=1
-else
-ifeq (no,$(USE_PARENS_AROUND_GETTEXT_N))
-	BASIC_CFLAGS += -DUSE_PARENS_AROUND_GETTEXT_N=0
-endif
-endif
-
 ifeq ($(uname_S),Darwin)
 	ifndef NO_FINK
 		ifeq ($(shell test -d /sw/lib && echo y),y)
diff --git a/config.mak.dev b/config.mak.dev
index 022fb58218..41d6345bc0 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -4,8 +4,6 @@ SPARSE_FLAGS += -Wsparse-error
 endif
 ifneq ($(filter pedantic,$(DEVOPTS)),)
 DEVELOPER_CFLAGS += -pedantic
-# don't warn for each N_ use
-DEVELOPER_CFLAGS += -DUSE_PARENS_AROUND_GETTEXT_N=0
 endif
 DEVELOPER_CFLAGS += -Wall
 DEVELOPER_CFLAGS += -Wdeclaration-after-statement
diff --git a/gettext.h b/gettext.h
index c8b34fd612..d209911ebb 100644
--- a/gettext.h
+++ b/gettext.h
@@ -55,31 +55,7 @@ const char *Q_(const char *msgid, const char *plu, unsigned long n)
 }
 
 /* Mark msgid for translation but do not translate it. */
-#if !USE_PARENS_AROUND_GETTEXT_N
 #define N_(msgid) msgid
-#else
-/*
- * Strictly speaking, this will lead to invalid C when
- * used this way:
- *	static const char s[] = N_("FOO");
- * which will expand to
- *	static const char s[] = ("FOO");
- * and in valid C, the initializer on the right hand side must
- * be without the parentheses.  But many compilers do accept it
- * as a language extension and it will allow us to catch mistakes
- * like:
- *	static const char *msgs[] = {
- *		N_("one")
- *		N_("two"),
- *		N_("three"),
- *		NULL
- *	};
- * (notice the missing comma on one of the lines) by forcing
- * a compilation error, because parenthesised ("one") ("two")
- * will not get silently turned into ("onetwo").
- */
-#define N_(msgid) (msgid)
-#endif
 
 const char *get_preferred_languages(void);
 int is_utf8_locale(void);
diff --git a/git-compat-util.h b/git-compat-util.h
index b46605300a..ddc65ff61d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1253,10 +1253,6 @@ int warn_on_fopen_errors(const char *path);
  */
 int open_nofollow(const char *path, int flags);
 
-#if !defined(USE_PARENS_AROUND_GETTEXT_N) && defined(__GNUC__)
-#define USE_PARENS_AROUND_GETTEXT_N 1
-#endif
-
 #ifndef SHELL_PATH
 # define SHELL_PATH "/bin/sh"
 #endif
