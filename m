Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4157020A29
	for <e@80x24.org>; Wed, 20 Sep 2017 19:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751609AbdITTOf (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 15:14:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:44994 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751462AbdITTOe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 15:14:34 -0400
Received: (qmail 8905 invoked by uid 109); 20 Sep 2017 19:14:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Sep 2017 19:14:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15302 invoked by uid 111); 20 Sep 2017 19:15:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Sep 2017 15:15:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Sep 2017 15:14:31 -0400
Date:   Wed, 20 Sep 2017 15:14:31 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        jrnieder@gmail.com, bturner@atlassian.com, git@jeffhostetler.com,
        jonathantanmy@google.com
Subject: Re: [PATCH 1.5/8] connect: die when a capability line comes after a
 ref
Message-ID: <20170920191431.emornzhse6f7s5mg@sigill.intra.peff.net>
References: <20170913215448.84674-1-bmwill@google.com>
 <20170920184832.146564-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170920184832.146564-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 20, 2017 at 11:48:32AM -0700, Brandon Williams wrote:

> Commit eb398797c (connect: advertized capability is not a ref,
> 2016-09-09) taught 'get_remote_heads()' to recognize that the
> 'capabilities^{}' line isn't a ref but required that the
> 'capabilities^{}' line came during the first response from the server.
> A future patch will introduce a version string sent by the server during
> its first response which can then cause a client to unnecessarily die if
> a 'capabilities^{}' line sent as the first ref.
> 
> Teach 'get_remote_heads()' to instead die if a 'capabilities^{}' line is
> sent after a ref.

Hmm. I think I understand why you'd want this loosening. But why are we
sending a version line to a client that we don't know is speaking v2?
IOW, shouldn't we be reporting the version to the client in the normal
capabilities when we don't know for sure that they can handle the new
field? Otherwise we're breaking existing clients.

Or is this only for v2 clients, and we've changed the protocol but
get_remote_heads() just needs to be updated, too?

> diff --git a/connect.c b/connect.c
> index df56c0cbf..af5096ec6 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -124,10 +124,11 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
>  	 * response does not necessarily mean an ACL problem, though.
>  	 */
>  	int saw_response;
> +	int seen_ref;
>  	int got_dummy_ref_with_capabilities_declaration = 0;
> 
>  	*list = NULL;
> -	for (saw_response = 0; ; saw_response = 1) {
> +	for (saw_response = 0, seen_ref = 0; ; saw_response = 1) {

If we're not going to update it in the right-hand side of the for-loop,
should we perhaps not be initializing it in the left-hand side? I.e.,
can we just do:

  seen_ref = 0;

above the loop, like we initialize "list"?

(For that matter, could we just be checking whether *list is NULL?)

> @@ -165,6 +166,8 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
> 
>  		name_len = strlen(name);
>  		if (len != name_len + GIT_SHA1_HEXSZ + 1) {
> +			if (seen_ref)
> +				; /* NEEDSWORK: Error out for multiple capabilities lines? */
>  			free(server_capabilities);
>  			server_capabilities = xstrdup(name + name_len + 1);
>  		}

Interesting question. Probably it would be fine to. Coincidentally I ran
across a similar case. It seems that upload-pack will read multiple
capabilities lines back from the client. I.e., if it gets:

  want 1234abcd... foo
  want 5678abcd... bar

then it will turn on both the "foo" and "bar" capabilities. I'm pretty
sure this is unintended, and is somewhat counter to the way that clients
handle multiple lines (which is to forget the old line and respect only
the new one, as shown in the quoted hunk).

I wonder if we should be outlawing extra capabilities in both
directions. I don't _think_ we've ever relied on that working, and I
don't have much sympathy for any 3rd-party implementation that does
(though I doubt that any exists).

That tangent aside, I do this hunk is kind of orthogonal to the point of
your patch. We're talking about potential _tightening_ here, whereas the
point of your patch is loosening. And it's not clear to me what we want
to tighten:

  - should capabilities come as part of the first response, even if we
    have no refs? In which case we really want "if (saw_response)" here.

  - should they came as part of the first ref (or pseudo-ref), in which
    case "if (seen_ref)" is the right thing.

  - should we loosen it to complaining when there are multiple
    capabilities sent. In which case "if (server_capabilities)" is the
    right thing.

I'm not sure which we'd want, but it really seems like a separate topic
that should be explored on top.

-Peff
