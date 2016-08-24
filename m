Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B99E1F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 17:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754291AbcHXRcw (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 13:32:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:60568 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754248AbcHXRcw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 13:32:52 -0400
Received: (qmail 12604 invoked by uid 109); 24 Aug 2016 17:32:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Aug 2016 17:32:51 +0000
Received: (qmail 4787 invoked by uid 111); 24 Aug 2016 17:32:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Aug 2016 13:32:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Aug 2016 13:32:48 -0400
Date:   Wed, 24 Aug 2016 13:32:48 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 0/4] cat-file: optionally convert to worktree version
Message-ID: <20160824173248.ami3hgadea5zjvf3@sigill.intra.peff.net>
References: <cover.1471524357.git.johannes.schindelin@gmx.de>
 <cover.1472041389.git.johannes.schindelin@gmx.de>
 <xmqqk2f6rvx9.fsf@gitster.mtv.corp.google.com>
 <20160824161939.d2h4qlaxhhi6limm@sigill.intra.peff.net>
 <xmqqr39eqevk.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr39eqevk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 24, 2016 at 10:02:39AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Wed, Aug 24, 2016 at 09:09:06AM -0700, Junio C Hamano wrote:
> >
> >> >  +	if (!path)
> >> >  +		path = obj_context.path;
> >> >  +	else if (obj_context.mode == S_IFINVALID)
> >> >  +		obj_context.mode = 0100644;
> >> >  +
> >> >   	buf = NULL;
> >> >   	switch (opt) {
> >> >   	case 't':
> >> 
> >> The above two hunks make all the difference in the ease of reading
> >> the remainder of the function.  Very good.
> >
> > Yeah, I agree. Though it took me a moment to figure out why we were
> > setting obj_context.mode but not obj_context.path; the reason is that
> > "mode" is convenient to use as local storage, but "path" is not, because
> > it is not a pointer but an array.
> 
> Wait a minute.  Why is it a cascaded if/elseif, not two independent
> if statements that gives a default value?  In other words, wouldn't
> these two independent and orthogonal decisions?
> 
>  * When forced to use some path, we ignore obj_context.path
> 
>  * Whether we are forced to use a path or not, if we do not know the
>    mode from the lookup context, we want to use the regular blob
>    mode.
> 
> So that part of the patch is wrong after all, I would have to say.
> 
> 	if (!path)
>         	path = obj_context.path;
> 	if (obj_context.mode == S_IFINVALID)
>         	obj_context.mode = 0100644;
> 
> or something like that, perhaps.

Oh, hrm, you are right. I assumed we wanted to force the mode when
--path was in effect, but that is not what the original does. If you
say:

  --path=foo HEAD:bar

then we will take the mode for "bar", whatever it is (maybe a tree or
symlink). But if you say:

  --path=foo $(git rev-parse HEAD:bar)

then we will use 100644, regardless of what "bar" is in HEAD.

I have not thought about it enough to know if that is a good thing or a
bad thing. But I'll bet Dscho has, so I will wait for him to comment. :)

> >   if (!force_path) {
> > 	/* use file info from sha1 lookup */
> > 	path = obj_context.path;
> > 	mode = obj_context.mode;
> >   } else {
> > 	/* use path requested by user, and assume it is a regular file */
> > 	path = force_path;
> > 	mode = 0100644;
> >   }
> 
> Hmph, if you read it that way, then if/elseif makes some sense, but
> we need to assume that the obj_context.mode can be garbage and have
> a fallback for it.
> 
> Just like
> 
> 	git cat-file --filters --path=git.c HEAD:t
> 
> would error out because HEAD:t is not even a blob, I would expect
> 
> 	git cat-file --filters --path=git.c :RelNotes
> 
> to error out, because the object itself _is_ known to be a
> blob that is not a regular file.
> 
> And that kind of type checking will not be possible with "if the
> user gave us a path, assume it is a regular file".

Right, I agree that is the outcome, but I just wasn't sure that the
second case _should_ error out. IOW, does "--filters --path" mean "treat
this as a regular file at path X", or is the "regular file" part not
implied?

I don't suppose anybody cares that much either way, but it feels weird
to behave differently depending on how we looked up the blob (whereas
for the HEAD:t case, a tree is always a tree).

-Peff
