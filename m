Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEC3220958
	for <e@80x24.org>; Mon, 20 Mar 2017 17:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753283AbdCTRm5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 13:42:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:47827 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753217AbdCTRm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 13:42:56 -0400
Received: (qmail 11502 invoked by uid 109); 20 Mar 2017 17:42:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 17:42:44 +0000
Received: (qmail 3685 invoked by uid 111); 20 Mar 2017 17:42:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 13:42:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Mar 2017 13:42:40 -0400
Date:   Mon, 20 Mar 2017 13:42:40 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH 04/20] refs_verify_refname_available(): implement once
 for all backends
Message-ID: <20170320174240.gykldqzbqyva6kbs@sigill.intra.peff.net>
References: <cover.1490026594.git.mhagger@alum.mit.edu>
 <22abd274bfdada94b3654a811ee209822640765f.1490026594.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <22abd274bfdada94b3654a811ee209822640765f.1490026594.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2017 at 05:33:09PM +0100, Michael Haggerty wrote:

> It turns out that we can now implement
> `refs_verify_refname_available()` based on the other virtual
> functions, so there is no need for it to be defined at the backend
> level. Instead, define it once in `refs.c` and remove the
> `files_backend` definition.

Does this mean that backends can no longer provide storage for
D/F-conflicted refnames (i.e., "refs/foo" and "refs/foo/bar")? It looks
like the global verify_refname_available() has that logic baked in.

I know that was a complex subject because of the potential compatibility
issues (e.g., fetching from a server with a more capable backend), but
I'd just worry we are shutting a door on some options. OTOH, it probably
wouldn't be that hard for the global function to check a flag specific
to the ref_store, and allow such refs when it is set.

>  int refs_verify_refname_available(struct ref_store *refs,
>  				  const char *refname,
> -				  const struct string_list *extra,
> +				  const struct string_list *extras,
>  				  const struct string_list *skip,
>  				  struct strbuf *err)
>  {
> [...]
> +		/*
> +		 * We are still at a leading dir of the refname (e.g.,
> +		 * "refs/foo"; if there is a reference with that name,
> +		 * it is a conflict, *unless* it is in skip.
> +		 */
> +		if (skip && string_list_has_string(skip, dirname.buf))
> +			continue;
> +
> +		if (!refs_read_raw_ref(refs, dirname.buf, oid.hash, &referent, &type)) {
> +			strbuf_addf(err, "'%s' exists; cannot create '%s'",
> +				    dirname.buf, refname);
> +			goto cleanup;
> +		}

We don't really care about reading the ref value here; we just care if
it exists. Does that matter for efficiency (e.g., for the files backend
it's a stat() versus an open/read/close)? I guess the difference only
matters when it _does_ exist, which is the uncommon error case.

(Also, I suspect the loose ref cache always just reads everything in the
current code, though with the iterator approach in theory we could stop
doing that).

-Peff
