Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADC511F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 17:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403990AbeKWELb (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 23:11:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:48740 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732076AbeKWELb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 23:11:31 -0500
Received: (qmail 26455 invoked by uid 109); 22 Nov 2018 17:31:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Nov 2018 17:31:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23728 invoked by uid 111); 22 Nov 2018 17:30:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 22 Nov 2018 12:30:34 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Nov 2018 12:31:09 -0500
Date:   Thu, 22 Nov 2018 12:31:09 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Subject: Re: insteadOf and git-request-pull output
Message-ID: <20181122173109.GI28192@sigill.intra.peff.net>
References: <20181115182826.GB25806@pure.paranoia.local>
 <20181116115639.GO890086@genre.crustytoothpaste.net>
 <xmqq7ehci1td.fsf@gitster-ct.c.googlers.com>
 <20181117122722.GB4094@sigill.intra.peff.net>
 <xmqq7ehbhk63.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7ehbhk63.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 17, 2018 at 11:07:32PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I suspect it would be less confusing if the rewrite were inverted, like:
> >
> >   [url "gh:"]
> >   rewriteTo = https://github.com
> >   rewritePrivate
> >
> >   [url "git://github.com"]
> >   rewriteTo = https://github.com
> >
> > where the mapping of sections to rewrite rules must be one-to-one, not
> > one-to-many (and you can see that the flip side is that we have to
> > repeat ourselves).
> >
> > I hate to introduce two ways of doing the same thing, but maybe it is
> > simple enough to explain that url.X.insteadOf=Y is identical to
> > url.Y.rewriteTo=X. I do think people have gotten confused by the
> > ordering of insteadOf over the years, so this would let them specify it
> > in whichever way makes the most sense to them.
> 
> I do admit that the current "insteadOf" was too cute a way to
> configure this feature and I often have to read it aloud twice
> before convincing myself I got X and Y right.  It would have been
> cleaner if the definition were in the opposite direction, exactly
> because you can rewrite a single thing into just one way, but we do
> want to support that many things mapping to the same, and the
> approach to use "url.Y.rewriteTo=X" does express it better.

In case anybody is interested in picking this up, the code is actually
quite simple (the underlying data structure remains the same; we're just
inverting the order in the config). It would need documentation and
tests, and probably a matching pushRewriteTo.

    diff --git a/remote.c b/remote.c
    index 28c7260ed1..26b1a7b119 100644
    --- a/remote.c
    +++ b/remote.c
    @@ -345,6 +345,11 @@ static int handle_config(const char *key, const char *value, void *cb)
     				return config_error_nonbool(key);
     			rewrite = make_rewrite(&rewrites_push, name, namelen);
     			add_instead_of(rewrite, xstrdup(value));
    +		} else if (!strcmp(subkey, "rewriteto")) {
    +			if (!value)
    +				return config_error_nonbool(key);
    +			rewrite = make_rewrite(&rewrites, value, strlen(value));
    +			add_instead_of(rewrite, xmemdupz(name, namelen));
     		}
     	}
     

However, I did notice the cleanup below as part of writing that. It may
be worth applying independently.

-- >8 --
Subject: [PATCH] remote: check config validity before creating rewrite struct

When parsing url.foo.insteadOf, we call make_rewrite() and only then
check to make sure the config value is a string (and return an error if
it isn't). This isn't quite a leak, because the struct we allocate is
part of a global array, but it does leave a funny half-finished struct.

In practice, it doesn't make much difference because we exit soon after
due to the config error anyway. But let's flip the order here to avoid
leaving a trap for somebody in the future.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index b850f2feb3..28c7260ed1 100644
--- a/remote.c
+++ b/remote.c
@@ -336,14 +336,14 @@ static int handle_config(const char *key, const char *value, void *cb)
 		if (!name)
 			return 0;
 		if (!strcmp(subkey, "insteadof")) {
-			rewrite = make_rewrite(&rewrites, name, namelen);
 			if (!value)
 				return config_error_nonbool(key);
+			rewrite = make_rewrite(&rewrites, name, namelen);
 			add_instead_of(rewrite, xstrdup(value));
 		} else if (!strcmp(subkey, "pushinsteadof")) {
-			rewrite = make_rewrite(&rewrites_push, name, namelen);
 			if (!value)
 				return config_error_nonbool(key);
+			rewrite = make_rewrite(&rewrites_push, name, namelen);
 			add_instead_of(rewrite, xstrdup(value));
 		}
 	}
-- 
2.20.0.rc1.703.g93fba25b62

