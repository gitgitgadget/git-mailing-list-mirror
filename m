Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE179C2D0E4
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 23:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65E67208CA
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 23:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgKTXwG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 18:52:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:37218 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727370AbgKTXwG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 18:52:06 -0500
Received: (qmail 7343 invoked by uid 109); 20 Nov 2020 23:52:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Nov 2020 23:52:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12506 invoked by uid 111); 20 Nov 2020 23:52:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Nov 2020 18:52:04 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 20 Nov 2020 18:52:03 -0500
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Dominik Salvet <dominik.salvet@gmail.com>
Subject: Re: [RFC/PATCH] Add fetch.updateHead option
Message-ID: <20201120235203.GA353076@coredump.intra.peff.net>
References: <20201118091219.3341585-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201118091219.3341585-1-felipe.contreras@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 18, 2020 at 03:12:19AM -0600, Felipe Contreras wrote:

> Users might change the behavior when running "git fetch" so that the
> remote's HEAD symbolic ref is updated at certain point.
> 
> For example after running "git remote add" the remote HEAD is not
> set like it is with "git clone".
> 
> Setting "fetch.updatehead = missing" would probably be a sensible
> default that everyone would want, but for now the default behavior is to
> never update HEAD, so there shouldn't be any functional changes.
> 
> For the next major version of Git, we might want to change this default.

Thanks for working on this. Regardless of whether we change the default
behavior, this seems like an obvious improvement (and I do think it
makes sense to eventually change the default; I'd even be OK switching
it to "missing" in the near term).

The implementation looks pretty straight-forward, but I have a few
comments below:

> --- a/Documentation/config/remote.txt
> +++ b/Documentation/config/remote.txt
> @@ -84,3 +84,6 @@ remote.<name>.promisor::
>  remote.<name>.partialclonefilter::
>  	The filter that will be applied when fetching from this
>  	promisor remote.
> +
> +remote.<name>.updateHead::
> +  Defines when to update the remote HEAD symbolic ref. See `fetch.updateHead`.

Nice. I think fetch.updateHead is likely to be the commonly used one,
but if this isn't hard to support, it's a nice bonus for flexibility.

> +static void update_head(int config, const struct ref *head, const struct remote *remote)
> +{
> +	struct strbuf ref = STRBUF_INIT, target = STRBUF_INIT;
> +	const char *r, *head_name = NULL;
> +
> +	if (!head || !head->symref || !remote)
> +		return;

I'd expect us to return early here, as well, if the config is set to
"never". I think your function will usually still do the right thing
(because we return early before writing), but it makes a pointless
lookup of the current origin/HEAD. But see below.

> +	strbuf_addf(&ref, "refs/remotes/%s/HEAD", remote->name);
> +	skip_prefix(head->symref, "refs/heads/", &head_name);

Should we bail or complain if this skip_prefix() doesn't match? I think
it would be a sign of weirdness on the remote side, since HEAD is never
supposed to point to anything except refs/heads/. But if we ever did see
it, it's probably better to bail than to point to
refs/remotes/origin/refs/foo/bar or whatever.

> +	strbuf_addf(&target, "refs/remotes/%s/%s", remote->name, head_name);
> +
> +	r = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
> +		ref.buf, RESOLVE_REF_READING,
> +		NULL, NULL);

This won't resolve a symref pointing to an unborn branch, so it would
count as "missing". I.e.:

  git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/nope
  git -c fetch.updatehead=missing fetch

will update it based on the remote HEAD.  I guess I could see some
argument for defining "missing" in that way, but I suspect it is not
what somebody in this situation would expect.

I think it's hard to get into this situation intentionally. If you clone
an empty repo, we won't write the symref at all (since we have nothing
to write into it), so both sides would be missing. But it's easy enough
to do the right thing; see symbolic-ref.c's check_symref() function
(basically drop the READING flag).

Likewise, I'd not expect to see a non-symref at that name, but what
should we do if we see one? I think overwrite it for "always", but not
for "missing". You can tell the difference by checking REF_ISSYMREF in
the returned flags, though the distinction may not matter if we follow
the semantics I just said.

> +	if (r) {
> +		if (config == FETCH_UPDATE_HEAD_MISSING)
> +			/* already present */
> +			return;
> +		else if (config == FETCH_UPDATE_HEAD_ALWAYS && !strcmp(r, target.buf))
> +			/* already up-to-date */
> +			return;
> +		else
> +			/* should never happen */
> +			return;
> +	}
> +
> +	if (create_symref(ref.buf, target.buf, "remote update head"))
> +		warning(_("could not set remote head"));
> +}

If we do update the symref, we should probably tell the user. Better
still if we can print it as part of the usual fetch output table.

> @@ -1382,8 +1420,18 @@ static int do_fetch(struct transport *transport,
>  				break;
>  			}
>  		}
> -	} else if (transport->remote && transport->remote->fetch.nr)
> +	} else if (transport->remote && transport->remote->fetch.nr) {
> +		if (transport->remote->update_head)
> +			update_head_config = transport->remote->update_head;
> +		else
> +			update_head_config = fetch_update_head;
> +
> +		need_update_head = update_head_config && update_head_config != FETCH_UPDATE_HEAD_NEVER;
> +
> +		if (need_update_head)
> +			strvec_push(&ref_prefixes, "HEAD");
>  		refspec_ref_prefixes(&transport->remote->fetch, &ref_prefixes);
> +	}

Good catch. We need this for:

  git fetch origin

since otherwise it doesn't ask about HEAD in a v2 exchange. What about:

  git fetch origin master

That won't report on HEAD either, even with your patch, because it hits
the part of the conditional before your "else if". What should it do?  I
can see an argument for "nothing, we only update head on full configured
fetches", but if so we should definitely make that clear in the
documentation. I can also see an argument for "always, if we happen to
have heard about it" (just like we opportunistically update tracking
refs even if they are fetched by name into FETCH_HEAD).

> diff --git a/remote.h b/remote.h
> index 3211abdf05..c16a2d7b2e 100644
> --- a/remote.h
> +++ b/remote.h

I wondered if we should be interacting with remote.[ch]'s
guess_remote_head() here, which is what powers "remote set-head -a", as
well as the initial clone decision. But I don't think it make sense. If
we were not explicitly given information about a symref, it does not
make much sense to guess without seeing all of the refs (which we may
well not, due to the v2 ref-prefix capability).

In most cases the distinction would not matter anyway. The "guess" part
comes in only for ancient pre-symref-capability versions of Git (which
we are unlikely to see and it's OK if they just don't make use of the
feature), or for remotes with detached HEADs (in which case not setting
our local origin/HEAD is probably the best thing, as a bad guess would
foul up a later use of the "missing" mode).

-Peff
