Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3040E201A7
	for <e@80x24.org>; Wed, 17 May 2017 13:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753705AbdEQNik (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 09:38:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:53674 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753323AbdEQNij (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 09:38:39 -0400
Received: (qmail 6284 invoked by uid 109); 17 May 2017 13:38:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 May 2017 13:38:38 +0000
Received: (qmail 9648 invoked by uid 111); 17 May 2017 13:39:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 May 2017 09:39:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 May 2017 09:38:36 -0400
Date:   Wed, 17 May 2017 09:38:36 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH 22/23] ref-filter: limit traversal to prefix
Message-ID: <20170517133835.s3m3giccjo3jqstg@sigill.intra.peff.net>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
 <1f50142ccbb84a4e5d7a1cd67e6f9d30edc1d73a.1495014840.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1f50142ccbb84a4e5d7a1cd67e6f9d30edc1d73a.1495014840.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 02:05:45PM +0200, Michael Haggerty wrote:

> From: Jeff King <peff@peff.net>

This patch did originate with me, but I know you had to fix several
things to integrate it in your series. So I'll review it anyway, and
give you full blame for any bugs. :)

> When we are matching refnames "as path" against a pattern, then we
> know that the beginning of any refname that can match the pattern has
> to match the part of the pattern up to the first glob character. For
> example, if the pattern is `refs/heads/foo*bar`, then it can only
> match a reference that has the prefix `refs/heads/foo`.

That first sentence confused me as to what "as path" meant (I know
because I worked on this code, and even then it took me a minute to
parse it).

Maybe just "When we are matching refnames against a pattern" and then
later something like:

  Note that this applies only when the "match_as_path" flag is set
  (i.e., when for-each-ref is the caller), as the matching rules for
  git-branch and git-tag are subtly different.

> +/*
> + * Find the longest prefix of pattern we can pass to
> + * for_each_fullref_in(), namely the part of pattern preceding the
> + * first glob character.
> + */
> +static void find_longest_prefix(struct strbuf *out, const char *pattern)
> +{
> +	const char *p;
> +
> +	for (p = pattern; *p && !is_glob_special(*p); p++)
> +		;
> +
> +	strbuf_add(out, pattern, p - pattern);
> +}

If I were reviewing this from scratch, I'd probably ask whether it is OK
in:

  refs/heads/m*

to return "refs/heads/m" as the prefix, and not stop at the last
non-wildcard component ("refs/heads/"). But I happen to know we
discussed this off-list and you checked that for_each_ref and friends
are happy with an arbitrary prefix. But I'm calling it out here for
other reviewers.

> +/*
> + * This is the same as for_each_fullref_in(), but it tries to iterate
> + * only over the patterns we'll care about. Note that it _doesn't_ do a full
> + * pattern match, so the callback still has to match each ref individually.
> + */
> +static int for_each_fullref_in_pattern(struct ref_filter *filter,
> [...]

The rest of it looks good to me.

-Peff
