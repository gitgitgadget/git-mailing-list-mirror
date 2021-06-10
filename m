Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5AAC47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 14:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18171613CA
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 14:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhFJOiY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 10:38:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:51358 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230298AbhFJOiY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 10:38:24 -0400
Received: (qmail 7940 invoked by uid 109); 10 Jun 2021 14:36:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Jun 2021 14:36:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30724 invoked by uid 111); 10 Jun 2021 14:36:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Jun 2021 10:36:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 10 Jun 2021 10:36:27 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Nikhil Gupta <nikhilgupta2102@gmail.com>,
        git-packagers@googlegroups.com, Git List <git@vger.kernel.org>
Subject: Re: Build errors when building git on MacOS 11 (x86-64) and for M1
 macs
Message-ID: <YMIjaytMYslKjK6z@coredump.intra.peff.net>
References: <f5487adb-b7dc-4f97-bca1-749701337759n@googlegroups.com>
 <87sg1p24zc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sg1p24zc.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 10, 2021 at 03:52:09PM +0200, Ævar Arnfjörð Bjarmason wrote:

> I have no access to such a system, but I think think I see the problem
> from what you've supplied here.
> 
> You supplied a CFLAGS=-I/opt/chef-workstation/embedded/include which has
> an archive.h file that's unrelated to the archive.h file git expects.
> 
> Thus we include that and find things unrelated to git, and error when we
> encounter a function we expected to have declared in our own archive.h.

Yeah, I agree that is likely the problem.

> The solution is something like defining a config.mak file where you add
> flags with BASIC_CFLAGS +=, not =. See config.mak.uname for an
> example. You'll then add new directories after our own -I.

That would work, though I think in general we should consider
BASIC_CFLAGS to be an internal thing, and encourage people to use the
standard CFLAGS, etc.

> This is arguably a bug in git's Makefile in that we should have that
> "-I." in an ESSENTIAL_CFLAGS variable or something, I can't think of a
> scenario where git would compile without it. That or things in builtin/
> should include e.g. ../archive.h, perhaps such a thing isn't portable.

Yeah, we do say "-I." explicitly and unconditionally. I think we'd just
want to make sure it's before any user-provided flags. We could do
something like this:

diff --git a/Makefile b/Makefile
index 7d719ece46..b5794560e9 100644
--- a/Makefile
+++ b/Makefile
@@ -1241,7 +1241,7 @@ ALL_COMMANDS_TO_INSTALL += git-upload-archive$(X)
 ALL_COMMANDS_TO_INSTALL += git-upload-pack$(X)
 endif
 
-ALL_CFLAGS = $(DEVELOPER_CFLAGS) $(CPPFLAGS) $(CFLAGS)
+ALL_CFLAGS = $(DEVELOPER_CFLAGS) $(CPPFLAGS) $(BASIC_CFLAGS) $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
 
 comma := ,
@@ -2106,7 +2106,6 @@ PAGER_ENV_CQ = "$(subst ",\",$(subst \,\\,$(PAGER_ENV)))"
 PAGER_ENV_CQ_SQ = $(subst ','\'',$(PAGER_ENV_CQ))
 BASIC_CFLAGS += -DPAGER_ENV='$(PAGER_ENV_CQ_SQ)'
 
-ALL_CFLAGS += $(BASIC_CFLAGS)
 ALL_LDFLAGS += $(BASIC_LDFLAGS)
 
 export DIFF TAR INSTALL DESTDIR SHELL_PATH

but I imagine that it is helpful for other BASIC_CFLAGS to be
overrideable by the user's CFLAGS (especially other system-level -I
directives we may include!). So yes, having an $(ESSENTIAL_CFLAGS) would
work. Or perhaps even just:

diff --git a/Makefile b/Makefile
index 7d719ece46..72517db31e 100644
--- a/Makefile
+++ b/Makefile
@@ -1202,7 +1202,7 @@ endif
 CFLAGS = -g -O2 -Wall
 LDFLAGS =
 CC_LD_DYNPATH = -Wl,-rpath,
-BASIC_CFLAGS = -I.
+BASIC_CFLAGS =
 BASIC_LDFLAGS =
 
 # library flags
@@ -1241,7 +1241,7 @@ ALL_COMMANDS_TO_INSTALL += git-upload-archive$(X)
 ALL_COMMANDS_TO_INSTALL += git-upload-pack$(X)
 endif
 
-ALL_CFLAGS = $(DEVELOPER_CFLAGS) $(CPPFLAGS) $(CFLAGS)
+ALL_CFLAGS = -I. $(DEVELOPER_CFLAGS) $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
 
 comma := ,

since this "-I." really is special.

> I think (but have not confirmed) that you probably got this far because
> your compiler will stick -I. at the /end/ of the flags implicitly (or is
> that standardized C behavior? I can't remember).

The standard just says (for quoted #include lines):

  The named source file is searched for in an implementation-defined
  manner.

Most compilers put the directory of the source file at the start of the
search path. E.g., gcc says under -I:

  1. For the quote form of the include directive, the directory of the
     current file is searched first.

Which is why we need "-I." at all; we are finding "archive.h" from
"builtin/*.c". I'm not sure what "current file" there means, or how
portable it is. Is it the source file being filed, or the file
containing the #include directive?

I'd hope it's consistently the latter. Otherwise "foo.h" which includes
"bar.h" cannot be included as "../foo.h" (from builtin/foo.c) and as
"foo.h" (from top-level foo.c).

If so, then yeah, using "../archive.h" (and dropping -I. entirely) would
be an option. Which is nice, because it makes things less magical and
more predictable (think what confusion we'd see if we introduced
"archive.h" into builtin/ ourselves).

We do use "../foo.h" in lots of places already. But the fact that we
_also_ have "-I." means I don't think we have any data on the "what does
current file mean" question above. My gut feeling is that it probably
does consistently work as we'd want it to, though.

-Peff
