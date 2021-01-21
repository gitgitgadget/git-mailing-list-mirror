Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAA7C433E0
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 20:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B29223A5C
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 20:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbhAUUtq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 15:49:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:34494 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbhAUUtg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 15:49:36 -0500
Received: (qmail 6806 invoked by uid 109); 21 Jan 2021 20:48:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Jan 2021 20:48:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5876 invoked by uid 111); 21 Jan 2021 20:48:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Jan 2021 15:48:53 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 21 Jan 2021 15:48:52 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v4 1/3] ls-refs: report unborn targets of symrefs
Message-ID: <YAnotHAiuSz4Du/0@coredump.intra.peff.net>
References: <20201211210508.2337494-1-jonathantanmy@google.com>
 <cover.1608673963.git.jonathantanmy@google.com>
 <a66e50626ef9343e0351fc6cfe8abcf4f9eed7f3.1608673963.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a66e50626ef9343e0351fc6cfe8abcf4f9eed7f3.1608673963.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 22, 2020 at 01:54:18PM -0800, Jonathan Tan wrote:

> -static int ls_refs_config(const char *var, const char *value, void *data)
> +static void send_possibly_unborn_head(struct ls_refs_data *data)
>  {
> +	struct strbuf namespaced = STRBUF_INIT;
> +	struct object_id oid;
> +	int flag;
> +	int oid_is_null;
> +
> +	memset(&oid, 0, sizeof(oid));
> +	strbuf_addf(&namespaced, "%sHEAD", get_git_namespace());
> +	resolve_ref_unsafe(namespaced.buf, 0, &oid, &flag);

It feels weird to call resolve_ref_unsafe() without checking the return
value. How do we detect errors?

I think the logic is that we make assumptions about which fields it will
touch (i.e., zeroing the flags, and not touching our zero'd oid), and
then check those. That feels a bit non-obvious and intimate with the
implementation, though (and was presumably the source of the "oops, we
need to clear the oid bug between v3 and v4).

I feel like that deserves a comment, but I also wonder if:

  refname = resolve_ref_unsafe(namespaced.buf, 0, &oid, &flag);
  if (!refname)
	return; /* broken, bad name, not even a symref, etc */

  /*
   * now we can look at oid even if we didn't memset() it, because
   * a successful return from resolve_ref_unsafe() means that it
   * has cleared it if appropriate
   */
  oid_is_null = is_null_oid(&oid);
  ...etc...

> +	if (!oid_is_null ||
> +	    (data->unborn && data->symrefs && (flag & REF_ISSYMREF)))
> +		send_ref(namespaced.buf, oid_is_null ? NULL : &oid, flag, data);

It likewise feels a bit funny that we determine the symref name in the
earlier call to resolve_ref_unsafe(), but we do not pass it here (and in
fact, we'll end up looking it up again!).

But that is not much different than what we do for normal refs passed to
the send_ref() callback. It would be nice if the iteration could pass in
"by the way, here is the symref value" to avoid that. But in practice it
isn't a big deal, since we only do the lookup when we see the ISSYMREF
flag set. So typically it is only one or two extra ref resolutions.

> @@ -91,7 +118,7 @@ int ls_refs(struct repository *r, struct strvec *keys,
>  
>  	memset(&data, 0, sizeof(data));
>  
> -	git_config(ls_refs_config, NULL);
> +	git_config(ls_refs_config, &data);

You will probably not be surprised that I would suggest defaulting
data->allow_unborn to 1 before this config call. :)

> @@ -103,14 +130,31 @@ int ls_refs(struct repository *r, struct strvec *keys,
>  			data.symrefs = 1;
>  		else if (skip_prefix(arg, "ref-prefix ", &out))
>  			strvec_push(&data.prefixes, out);
> +		else if (data.allow_unborn && !strcmp("unborn", arg))
> +			data.unborn = 1;
>  	}

So if we have not set allow_unborn, we will not accept the client saying
"unborn". Which makes sense, because we would not have advertised it in
that case.

But we use the same boolean for advertising, too. So this loses the
"allow us to accept it, but not advertise it" logic that your earlier
versions had, doesn't it? And that is the important element for making
things work across a non-atomic deploy of versions.

This straight-boolean version works as long as you can atomically update
the _config_ on each version. But that seems like roughly the same
problem (having dealt with this on GitHub servers, they are not
equivalent, and depending on your infrastructure, it definitely _can_ be
easier to do one versus the other. But it seems like a funny place to
leave this upstream feature).

Or is the intent that an unconfigured reader would silently ignore the
unborn flag in that case? That would at least not cause it to bail on
the client in a mixed-version environment. But it does feel like a
confusing result.

-Peff
