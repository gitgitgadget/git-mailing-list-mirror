Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0117E1F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 14:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388696AbfJ2OGX (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 10:06:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:32912 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727255AbfJ2OGX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 10:06:23 -0400
Received: (qmail 31769 invoked by uid 109); 29 Oct 2019 14:06:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Oct 2019 14:06:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9876 invoked by uid 111); 29 Oct 2019 14:09:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Oct 2019 10:09:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 29 Oct 2019 10:06:21 -0400
From:   Jeff King <peff@peff.net>
To:     Davide Berardi <berardi.dav@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Segmentation fault on non-commit objects.
Message-ID: <20191029140621.GC2843@sigill.intra.peff.net>
References: <20191029092735.GA84120@carpenter.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191029092735.GA84120@carpenter.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 29, 2019 at 10:27:35AM +0100, Davide Berardi wrote:

> Fixed segmentation fault that can be triggered using
> $ git clone --branch $object $repository
> with object pointing to a non-commit (e.g. a blob).

One subtle thing here is that $object still needs to be at the tip of a
ref (an easy real-world case is "-b junio-gpg-pub" against git.git).

It might be nice to cover this with a test.

> diff --git a/builtin/clone.c b/builtin/clone.c
> index f665b28ccc..6ad2d8fe77 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -720,6 +720,9 @@ static void update_head(const struct ref *our, const struct ref *remote,
> 	} else if (our) {
> 		struct commit *c = lookup_commit_reference(the_repository,
> 							   &our->old_oid);
> +		/* Check if --branch specifies a non-commit. */
> +		if (c == NULL)
> +			die(_("unable to update HEAD (cannot find commit)"));

This is definitely a strict improvement over the current behavior
(though I agree with Dscho's comments on the error message). A few
further thoughts:

  - we'll have successfully completed the rest of the clone at this
    point. Should we leave the objects and refs in place to allow the
    user to fix it up, as we do when "git checkout" fails?

    We'd have to leave _something_ in HEAD for it to be a valid repo. I
    guess just "refs/heads/master" would be fine, or perhaps we could
    fall back to whatever the other side had in their HEAD (i.e.,
    pretending that "-b" wasn't specified).

  - there's a related case just above the lines you touched: what
    happens if the other side feeds us a non-commit in their
    refs/heads/? That shouldn't happen (i.e., their repo is broken), but
    should we be protecting ourselves on the receiving side more?

    Likewise in "else" below just above your lines.

    I think in either case we wouldn't segfault (because we don't try to
    dereference to a commit ourselves), but we'd produce a bogus on-disk
    state.

-Peff
