Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1863A1F453
	for <e@80x24.org>; Mon, 24 Sep 2018 18:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbeIYAUt (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 20:20:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:57534 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728424AbeIYAUt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 20:20:49 -0400
Received: (qmail 5295 invoked by uid 109); 24 Sep 2018 18:17:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Sep 2018 18:17:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28750 invoked by uid 111); 24 Sep 2018 18:17:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 24 Sep 2018 14:17:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Sep 2018 14:17:22 -0400
Date:   Mon, 24 Sep 2018 14:17:22 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, "H . Merijn Brand" <h.m.brand@xs4all.nl>,
        Harald Nordgren <haraldnordgren@gmail.com>,
        Olga Telezhnaia <olyatelezhnaya@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ref-filter: don't look for objects when outside of a
 repository
Message-ID: <20180924181722.GA25341@sigill.intra.peff.net>
References: <20180922124215.0c8172d1@pc09.procura.nl>
 <20180922141145.10558-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180922141145.10558-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 22, 2018 at 04:11:45PM +0200, SZEDER Gábor wrote:

> The command 'git ls-remote --sort=authordate <remote>' segfaults when
> run outside of a repository, ever since the introduction of its
> '--sort' option in 1fb20dfd8e (ls-remote: create '--sort' option,
> 2018-04-09).
> 
> While in general the 'git ls-remote' command can be run outside of a
> repository just fine, its '--sort=<key>' option with certain keys does
> require access to the referenced objects.  This sorting is implemented
> using the generic ref-filter sorting facility, which already handles
> missing objects gracefully with the appropriate 'missing object
> deadbeef for HEAD' message.  However, being generic means that it
> checks replace refs while trying to retrieve an object, and while
> doing so it accesses the 'git_replace_ref_base' variable, which has
> not been initialized and is still a NULL pointer when outside of a
> repository, thus causing the segfault.
> 
> Make ref-filter more careful and only attempt to retrieve an object
> when we are in a repository.  Also add a test to ensure that 'git
> ls-remote --sort' fails gracefully when executed outside of a
> repository.

This all makes sense, and I think your fix is going in the right
direction.

But...

> I'm not quite sure that this is the best place to add this check...
> but hey, it's a Saturday afternoon after all ;)

I also wonder about this. For refs, we already catch these cases at a
low-level and BUG(). That's better than a segfault, and I suspect we
should be doing the same here in oid_object_info_extended(). But that
just shifts the segfault to a BUG().

For the refs code, we've generally tried to catch things at a high-level
and report a more human-friendly error explaining the situation. So
doing the same thing here would mean adding code to ls-remote. But I
think the plumbing gets pretty tricky, since it has no way to ask
ref-filter "hey, are we doing to need to look at objects?".

That's a thing that I think ref-filter _should_ support (it knows it
after having parsed the format string). But it probably ought to come
along with other refactoring, and shouldn't hold up this fix.

So this probably _is_ a reasonable place to check it. However...

> diff --git a/ref-filter.c b/ref-filter.c
> index e1bcb4ca8a..3555bc29e7 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1473,7 +1473,8 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
>  		oi->info.sizep = &oi->size;
>  		oi->info.typep = &oi->type;
>  	}
> -	if (oid_object_info_extended(the_repository, &oi->oid, &oi->info,
> +	if (!have_git_dir() ||
> +	    oid_object_info_extended(the_repository, &oi->oid, &oi->info,
>  				     OBJECT_INFO_LOOKUP_REPLACE))
>  		return strbuf_addf_ret(err, -1, _("missing object %s for %s"),
>  				       oid_to_hex(&oi->oid), ref->refname);

Would we perhaps want to give the user a hint that the object is not
really missing, but rather that we're not in a repository? E.g.,
something like:

  if (!have_git_dir())
	return strbuf_addf_ret(err, -1, "format specifier requires a repository");
  if (oid_object_info_extended(...))
	return ...;

?

-Peff
