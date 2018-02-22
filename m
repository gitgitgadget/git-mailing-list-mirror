Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A5371F576
	for <e@80x24.org>; Thu, 22 Feb 2018 09:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753203AbeBVJse (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 04:48:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:60656 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752961AbeBVJsd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 04:48:33 -0500
Received: (qmail 26155 invoked by uid 109); 22 Feb 2018 09:48:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Feb 2018 09:48:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1234 invoked by uid 111); 22 Feb 2018 09:49:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 22 Feb 2018 04:49:20 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Feb 2018 04:48:31 -0500
Date:   Thu, 22 Feb 2018 04:48:31 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        jrnieder@gmail.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 13/35] ls-refs: introduce ls-refs server command
Message-ID: <20180222094831.GB12442@sigill.intra.peff.net>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-14-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180207011312.189834-14-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 06, 2018 at 05:12:50PM -0800, Brandon Williams wrote:

> +ls-refs takes in the following parameters wrapped in packet-lines:
> +
> +    symrefs
> +	In addition to the object pointed by it, show the underlying ref
> +	pointed by it when showing a symbolic ref.
> +    peel
> +	Show peeled tags.
> +    ref-pattern <pattern>
> +	When specified, only references matching the one of the provided
> +	patterns are displayed.

How do we match those patterns? That's probably an important thing to
include in the spec.

Looking at the code, I see:

> +/*
> + * Check if one of the patterns matches the tail part of the ref.
> + * If no patterns were provided, all refs match.
> + */
> +static int ref_match(const struct argv_array *patterns, const char *refname)

This kind of tail matching can't quite implement all of the current
behavior. Because we actually do the normal dwim_ref() matching, which
includes stuff like "refs/remotes/%s/HEAD".

The other problem with tail-matching is that it's inefficient on the
server. Ideally we could get a request for "master" and only look up
refs/heads/master, refs/tags/master, etc. And if there are 50,000 refs
in refs/pull, we wouldn't have to process those at all. Of course this
is no worse than the current code, which not only looks at each ref but
actually _sends_ it. But it would be nice if we could fix this.

There's some more discussion in this old thread:

  https://public-inbox.org/git/20161024132932.i42rqn2vlpocqmkq@sigill.intra.peff.net/

> +{
> +	char *pathbuf;
> +	int i;
> +
> +	if (!patterns->argc)
> +		return 1; /* no restriction */
> +
> +	pathbuf = xstrfmt("/%s", refname);
> +	for (i = 0; i < patterns->argc; i++) {
> +		if (!wildmatch(patterns->argv[i], pathbuf, 0)) {
> +			free(pathbuf);
> +			return 1;
> +		}
> +	}
> +	free(pathbuf);
> +	return 0;
> +}

Does the client have to be aware that we're using wildmatch? I think
they'd need "refs/heads/**" to actually implement what we usually
specify in refspecs as "refs/heads/*". Or does the lack of WM_PATHNAME
make this work with just "*"?

Do we anticipate that the client would left-anchor the refspec like
"/refs/heads/*" so that in theory the server could avoid looking outside
of /refs/heads/?

-Peff
