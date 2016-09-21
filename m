Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE164209A9
	for <e@80x24.org>; Wed, 21 Sep 2016 08:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755631AbcIUIsr (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 04:48:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:45921 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755556AbcIUIso (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 04:48:44 -0400
Received: (qmail 9025 invoked by uid 109); 21 Sep 2016 08:48:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Sep 2016 08:48:43 +0000
Received: (qmail 28807 invoked by uid 111); 21 Sep 2016 08:48:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Sep 2016 04:48:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Sep 2016 04:48:41 -0400
Date:   Wed, 21 Sep 2016 04:48:41 -0400
From:   Jeff King <peff@peff.net>
To:     John Keeping <john@keeping.me.uk>
Cc:     Heiko Voigt <hvoigt@hvoigt.net>,
        Jonas Thiel <jonas.lierschied@gmx.de>, git@vger.kernel.org
Subject: Re: Re: Homebrew and Git
Message-ID: <20160921084841.phq7cfbagi5k7ku4@sigill.intra.peff.net>
References: <trinity-9c8f1bd1-d6be-48f3-8575-03be09bd1243-1474213828361@3capp-gmx-bs53>
 <20160920110228.GA64315@book.hvoigt.net>
 <20160920110700.GB64315@book.hvoigt.net>
 <20160920191555.GB1673@john.keeping.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160920191555.GB1673@john.keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 20, 2016 at 08:15:55PM +0100, John Keeping wrote:

> > BTW, here is the callstack inlined from the crashreport:
> > 
> > bsystem_platform.dylib      	0x00007fff840db41c _platform_strchr$VARIANT$Haswell + 28
> > 1   git                           	0x000000010ba1d3f4 ident_default_email + 801
> > 2   git                           	0x000000010ba1d68f fmt_ident + 66
> > 3   git                           	0x000000010ba4b495 files_log_ref_write + 175
> > 4   git                           	0x000000010ba4b0a6 commit_ref_update + 106
> > 5   git                           	0x000000010ba4c3a8 ref_transaction_commit + 468
> > 6   git                           	0x000000010b994dd8 s_update_ref + 271
> > 7   git                           	0x000000010b994556 fetch_refs + 1969
> > 8   git                           	0x000000010b9935f2 fetch_one + 1913
> > 9   git                           	0x000000010b992bc4 cmd_fetch + 549
> > 10  git                           	0x000000010b9666c4 handle_builtin + 478
> > 11  git                           	0x000000010b96602f main + 376
> > 12  libdyld.dylib                 	0x00007fff834ef5ad start + 1
> > 
> > Maybe someone else has an idea what might be causing this...
> 
> The only strchr I can see that could be called here is in
> canonical_name(), where it's called with addrinfo::ai_canonname.

There's one in add_domainname(), too, but it can never be NULL (we could
walk off the end of the buffer, but only if gethostname() lies to us
about its result code, which seems unlikely). So I agree it's probably
the call in canonical_name().

> Searching for OS X and ai_canonname, leads me straight back to this
> list, although 7 years ago!  I think ident.c needs a fix similar to
> commit 3e8a00a (daemon.c: fix segfault on OS X, 2009-04-27); from the
> commit message there:
> 
> 	On OS X (and maybe other unices), getaddrinfo(3) returns NULL
> 	in the ai_canonname field if it's called with an IP address for
> 	the hostname.

Interesting. We are already prepared for failure from getaddrinfo()
here, so probably:

diff --git a/ident.c b/ident.c
index e20a772..d17b5bd 100644
--- a/ident.c
+++ b/ident.c
@@ -101,7 +101,7 @@ static int canonical_name(const char *host, struct strbuf *out)
 	memset (&hints, '\0', sizeof (hints));
 	hints.ai_flags = AI_CANONNAME;
 	if (!getaddrinfo(host, NULL, &hints, &ai)) {
-		if (ai && strchr(ai->ai_canonname, '.')) {
+		if (ai && ai->ai_canonname && strchr(ai->ai_canonname, '.')) {
 			strbuf_addstr(out, ai->ai_canonname);
 			status = 0;
 		}

would be sufficient. Jonas, can you see if that patch helps?

-Peff
