Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA53C433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 13:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42C5C611AD
	for <git@archiver.kernel.org>; Tue, 18 May 2021 13:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245494AbhEROAY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 10:00:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:57930 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231285AbhEROAX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 10:00:23 -0400
Received: (qmail 15459 invoked by uid 109); 18 May 2021 13:59:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 May 2021 13:59:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8300 invoked by uid 111); 18 May 2021 13:59:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 May 2021 09:59:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 May 2021 09:59:04 -0400
From:   Jeff King <peff@peff.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@jeffhostetler.com, git@vger.kernel.org,
        'SZEDER =?utf-8?Q?G=C3=A1bor'?= <szeder.dev@gmail.com>,
        'Johannes Schindelin via GitGitGadget' 
        <gitgitgadget@gmail.com>, jeffhost@microsoft.com
Subject: Re: [BUG] Unix Builds Requires Pthread Support (was [PATCH v4 00/12]
 Simple IPC Mechanism)
Message-ID: <YKPIKHnyeU1MHgXp@coredump.intra.peff.net>
References: <009d01d74b44$9efe8a60$dcfb9f20$@nexbridge.com>
 <YKN5lXs4AoK/JFTO@coredump.intra.peff.net>
 <00f301d74bea$fb39d220$f1ad7660$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00f301d74bea$fb39d220$f1ad7660$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 18, 2021 at 09:37:38AM -0400, Randall S. Becker wrote:

> >+# All simple-ipc requires threads, and then individual # mechanisms
> >+have their own requirements.
> >+ifndef NO_PTHREADS
> >+	BASIC_CFLAGS += -DSUPPORTS_SIMPLE_IPC
> > 	LIB_OBJS += compat/simple-ipc/ipc-shared.o
> >+ifndef NO_UNIX_SOCKETS
> > 	LIB_OBJS += compat/simple-ipc/ipc-unix-socket.o
> > endif
> >-
> > ifdef USE_WIN32_IPC
> >-	LIB_OBJS += compat/simple-ipc/ipc-shared.o
> > 	LIB_OBJS += compat/simple-ipc/ipc-win32.o  endif
> >+endif
> >
> > ifdef NO_ICONV
> > 	BASIC_CFLAGS += -DNO_ICONV
> >diff --git a/simple-ipc.h b/simple-ipc.h index dc3606e30b..0f58be7945 100644
> >--- a/simple-ipc.h
> >+++ b/simple-ipc.h
> >@@ -4,11 +4,6 @@
> > /*
> >  * See Documentation/technical/api-simple-ipc.txt
> >  */
> >-
> >-#if defined(GIT_WINDOWS_NATIVE) || !defined(NO_UNIX_SOCKETS) -#define SUPPORTS_SIMPLE_IPC -#endif
> >-
> > #ifdef SUPPORTS_SIMPLE_IPC
> > #include "pkt-line.h"
> 
> I'm not sure this is going to work. The platform *does* support UNIX
> sockets (and not disabled) and pthreads, but we have disabled pthreads
> in our build. So in the above, ipc-unix-socket.o will be included at
> the ifndef NO_UNIX_SOCKETS. If NO_PTHREADS, not being pedantic, there
> should be no pthread references, regardless of other considerations.
> Although, at some point, I hope to resolve why pthreads (PUT) is
> having issues in git on the platform but not at this point.

Unless I screwed something up, it shouldn't be. There's an outer ifndef
for NO_PTHREADS. Double negation aside, that means that we don't even
hit the ifndef NO_UNIX_SOCKETS inside it unless we now pthreads are
supported. And so we do not include ipc-unix-socket.o.

For the SUPPORTS_SIMPLE_IPC flag, I just moved the logic into the
Makefile. It could continue to live in simple-ipc.h, too (but then that
is basically a repetition of the Makefile logic; it would have to learn
the same "only if pthreads are available" conditional, too).

-Peff
