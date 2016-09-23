Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 082C21F4F8
	for <e@80x24.org>; Fri, 23 Sep 2016 04:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751983AbcIWEh6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 00:37:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:47015 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750784AbcIWEh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 00:37:57 -0400
Received: (qmail 27913 invoked by uid 109); 23 Sep 2016 04:37:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Sep 2016 04:37:57 +0000
Received: (qmail 14543 invoked by uid 111); 23 Sep 2016 04:38:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Sep 2016 00:38:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Sep 2016 00:37:53 -0400
Date:   Fri, 23 Sep 2016 00:37:53 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonas Thiel <jonas.lierschied@gmx.de>,
        John Keeping <john@keeping.me.uk>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH] ident: handle NULL ai_canonname
Message-ID: <20160923043753.mfmiarneqc5rxgt3@sigill.intra.peff.net>
References: <trinity-9c8f1bd1-d6be-48f3-8575-03be09bd1243-1474213828361@3capp-gmx-bs53>
 <20160920110228.GA64315@book.hvoigt.net>
 <20160920110700.GB64315@book.hvoigt.net>
 <20160920191555.GB1673@john.keeping.me.uk>
 <20160921084841.phq7cfbagi5k7ku4@sigill.intra.peff.net>
 <trinity-7a55c197-21af-4808-9919-6fc26bdcece2-1474536212197@3capp-gmx-bs75>
 <CAGZ79kYUcyCrjPfqWtyWE-kaqbQZPG1qosc3qJrDfHixivyFew@mail.gmail.com>
 <20160923040730.76stbefz2ivyfy45@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160923040730.76stbefz2ivyfy45@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 23, 2016 at 12:07:30AM -0400, Jeff King wrote:

> I have access to an OS X system, but if I understand the bug correctly,
> reproducing it may involve re-setting the system hostname, which is not
> something I'll be able to do. But I'll give it a shot.

Actually, it turned out to be pretty simple to reproduce (after reading
3e8a00a that John found, anyway; hooray for detailed commit messages). 
We just have to fake the output of gethostname(), but that is easily
done since we can modify git's source. :)

So I was able to reproduce the bug, and indeed, the patch I posted fixes
it. Here it is with a commit message.

Jonas, I'd be curious to know what the output of "hostname" is on your
system.

-- >8 --
Subject: [PATCH] ident: handle NULL ai_canonname

We call getaddrinfo() to try to convert a short hostname
into a fully-qualified one (to use it as an email domain).
If there isn't a canonical name, getaddrinfo() will
generally return either a NULL addrinfo list, or one in
which ai->ai_canonname is a copy of the original name.

However, if the result of gethostname() looks like an IP
address, then getaddrinfo() behaves differently on some
systems. On OS X, it will return a "struct addrinfo" with a
NULL ai_canonname, and we segfault feeding it to strchr().

This is hard to test reliably because it involves not only a
system where we we have to fallback to gethostname() to come
up with an ident, but also where the hostname is a number
with no dots. But I was able to replicate the bug by faking
a hostname, like:

    diff --git a/ident.c b/ident.c
    index e20a772..b790d28 100644
    --- a/ident.c
    +++ b/ident.c
    @@ -128,6 +128,7 @@ static void add_domainname(struct strbuf *out, int *is_bogus)
                     *is_bogus = 1;
                     return;
             }
    +        xsnprintf(buf, sizeof(buf), "1");
             if (strchr(buf, '.'))
                     strbuf_addstr(out, buf);
             else if (canonical_name(buf, out) < 0) {

and running "git var GIT_AUTHOR_IDENT" on an OS X system.

Before this patch it segfaults, and after we correctly
complain of the bogus "user@1.(none)" address (though this
bogus address would be suitable for non-object uses like
writing reflogs).

Reported-by: Jonas Thiel <jonas.lierschied@gmx.de>
Diagnosed-by: John Keeping <john@keeping.me.uk>
Signed-off-by: Jeff King <peff@peff.net>
---
 ident.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.10.0.482.gae5a597

