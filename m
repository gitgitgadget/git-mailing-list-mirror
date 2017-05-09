Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B8E12018D
	for <e@80x24.org>; Tue,  9 May 2017 22:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750767AbdEIWQe (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 18:16:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:48405 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750727AbdEIWQd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 18:16:33 -0400
Received: (qmail 22314 invoked by uid 109); 9 May 2017 22:16:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 May 2017 22:16:32 +0000
Received: (qmail 29126 invoked by uid 111); 9 May 2017 22:17:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 May 2017 18:17:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 May 2017 18:16:30 -0400
Date:   Tue, 9 May 2017 18:16:30 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: always allow fetching of literal SHA1s
Message-ID: <20170509221629.3z35qcz36oiix3kh@sigill.intra.peff.net>
References: <20170509182042.28389-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170509182042.28389-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 09, 2017 at 11:20:42AM -0700, Jonathan Tan wrote:

> fetch-pack, when fetching a literal SHA-1 from a server that is not
> configured with uploadpack.allowtipsha1inwant (or similar), always
> returns an error message of the form "Server does not allow request for
> unadvertised object %s". However, it is sometimes the case that such
> object is advertised.
> 
> Teach fetch-pack to also check the SHA-1s of the refs in the received
> ref advertisement if a literal SHA-1 was given by the user.

Hmm. That makes sense generally, as the request should succeed. But it
seems like we're creating a client that will sometimes succeed and
sometimes fail, and the reasoning will be somewhat opaque to the user.
I have a feeling I'm missing some context on when you'd expect this to
kick in.

> +static int is_literal_sha1(const struct ref *ref)
> +{
> +	struct object_id oid;
> +	return !get_oid_hex(ref->name, &oid) &&
> +	       !ref->name[40] &&
> +	       !oidcmp(&oid, &ref->old_oid);
> +}

I think the preferred method these days is to avoid the bare "40":

  struct object_oid oid;
  const char *end;
  return !parse_oid_hex(ref->name, &oid, &end) &&
         !*end &&
	 !oidcmp(&oid, &ref->old_oid);

I was confused at first why we need this oidcmp() and the one below. But
this one is checking "does the name parse to itself", and the other is
checking "does this parse to our sought ref?". So both checks are
needed.

> +			for (i = 0; i < nr_sought; i++) {
> +				struct ref *s = sought[i];
> +				if (!strcmp(ref->name, s->name) ||
> +				    (is_literal_sha1(s) &&
> +				     !oidcmp(&ref->old_oid, &s->old_oid))) {
> +					keep = 1;
> +					s->match_status = REF_MATCHED;
>  				}
> -				i++;
>  			}

This will reparse ref->name as an oid via is_literal_sha1() for each
pass through the loop. Should it be hoisted out? Maybe that is just
premature optimization, though.

Other than those minor nits, the code itself looks fine to me.

-Peff
