Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B8F7200B9
	for <e@80x24.org>; Tue,  8 May 2018 14:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932563AbeEHOlb (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 10:41:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:60458 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932375AbeEHOla (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 10:41:30 -0400
Received: (qmail 3090 invoked by uid 109); 8 May 2018 14:41:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 08 May 2018 14:41:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5458 invoked by uid 111); 8 May 2018 14:41:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 08 May 2018 10:41:33 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 May 2018 10:41:28 -0400
Date:   Tue, 8 May 2018 10:41:28 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 11/12] config doc: document core.disambiguate
Message-ID: <20180508144128.GB30183@sigill.intra.peff.net>
References: <20180501120651.15886-1-avarab@gmail.com>
 <20180501184016.15061-12-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180501184016.15061-12-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 01, 2018 at 06:40:15PM +0000, Ævar Arnfjörð Bjarmason wrote:

> The core.disambiguate variable was added in
> 5b33cb1fd7 ("get_short_sha1: make default disambiguation
> configurable", 2016-09-27) but never documented.

Thanks, this seems reasonable. It was originally added as a tool to let
people experiment with different defaults, and I never really expected
it to be something normal people would set. But I'm not sure if anybody
really did much experimentation (I still suspect that setting it to
"commit" or "committish" would make most people happy).

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 2659153cb3..14a3d57e77 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -910,6 +910,19 @@ core.abbrev::
>  	abbreviated object names to stay unique for some time.
>  	The minimum length is 4.
>  
> +core.disambiguate::
> +	If Git is given a SHA-1 that's ambigous it'll suggest what
> +	objects you might mean. By default it'll print out all
> +	potential objects with that prefix regardless of their
> +	type. This setting, along with the `^{<type>}` peel syntax
> +	(see linkgit:gitrevisions[7]), allows for narrowing that down.

This isn't just about what we print, but also about excluding objects
from consideration that don't match.

> +Is set to `none` by default to show all object types. Can also be
> +`commit` (peel syntax: `$sha1^{commit}`), `committish` (commits and
> +tags), `tree` (peel: `$sha1^{tree}`), `treeish` (everything except
> +blobs, peel syntax: `$sha1:`), `blob` (peel: `$sha1^{blob}`) or `tag`
> +(peel: `$sha1^{tag}`). The peel syntax will override any config value.

These peel references would need updating pending the discussion over
the earlier patches.

I suspect there are other things besides peel syntax which may override
this. It's really just the fallback when the caller does not give the
lookup machinery any other context. Certainly the peel specifiers are
one way to get syntax, but I think there are others. Grepping for
GET_OID_, I see that the revision dot syntax infers committish context,
as does anything that passes REVARG_COMMITTISH (so git-log, for
example).

-Peff
