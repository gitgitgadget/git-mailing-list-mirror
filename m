Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 311071F463
	for <e@80x24.org>; Mon, 23 Sep 2019 22:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391406AbfIWWYR (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 18:24:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:57670 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2390898AbfIWWYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 18:24:16 -0400
Received: (qmail 30876 invoked by uid 109); 23 Sep 2019 22:24:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 23 Sep 2019 22:24:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4891 invoked by uid 111); 23 Sep 2019 22:26:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Sep 2019 18:26:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 23 Sep 2019 18:24:15 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc:     qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
        berrange@redhat.com, stefanha@gmail.com,
        Greg Kurz <groug@kaod.org>, dgilbert@redhat.com,
        antonios.motakis@huawei.com, git@vger.kernel.org
Subject: Re: [Qemu-devel] [PATCH v6 0/4] 9p: Fix file ID collisions
Message-ID: <20190923222415.GA22495@sigill.intra.peff.net>
References: <cover.1566503584.git.qemu_oss@crudebyte.com>
 <305577c2-709a-b632-4056-6582771176ac@redhat.com>
 <20190909142511.GA20726@sigill.intra.peff.net>
 <56046367.TiUlWITyhT@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <56046367.TiUlWITyhT@silver>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 23, 2019 at 01:19:18PM +0200, Christian Schoenebeck wrote:

> >  	if (cmit_fmt_is_mail(pp->fmt)) {
> > -		if (pp->from_ident && ident_cmp(pp->from_ident, &ident)) {
> > +		if (pp->always_use_in_body_from ||
> > +		    (pp->from_ident && ident_cmp(pp->from_ident, &ident))) {
> >  			struct strbuf buf = STRBUF_INIT;
> > 
> >  			strbuf_addstr(&buf, "From: ");
> > 
> > but most of the work would be ferrying that option from the command line
> > down to the pretty-print code.
> > 
> > That would work in conjunction with "--from" to avoid a duplicate. It
> > might require send-email learning about the option to avoid doing its
> > own in-body-from management. If you only care about send-email, it might
> > be easier to just add the option there.
> 
> Would it simplify the changes in git if that would be made a
> "git config [--global]" setting only? That is, would that probably simplify 
> that task to one simple function call there in pretty.c?

I think a config option would make sense, but we generally try to avoid
adding a config option that doesn't have a matching command-line option.

I also think saving implementation work there is orthogonal. You can as
easily make a global "always_use_in_body_from" as you can call a global
config_get_bool("format-patch.always_use_in_body_from"). :)

And anyway, it's not _that_ much work to pass it around. At least as
much would go into writing documentation and tests. One of the reasons I
left the patch above as a sketch is that I'm not 100% convinced this is
a useful feature. Somebody caring enough about it to make a real patch
would send a signal there.

> On the other hand, considering the already existing --from argument and 
> "format.from" config option:
> https://git-scm.com/docs/git-config#Documentation/git-config.txt-formatfrom
> 
> Wouldn't it make sense to just drop the currently existing sender != author 
> string comparison in git and simply always add the "From:" line to the email's 
> body if "format.from yes" is used, instead of introducing a suggested 2nd 
> (e.g. "always-from") option? I mean sure automatically removing redundant 
> information in the generated emails if sender == author sounds nice on first 
> thought, but does it address anything useful in practice to justify 
> introduction of a 2nd related option?

Yes, the resulting mail would be correct, in the sense that it could be
applied just fine by git-am. But I think it would be uglier. IOW, I
consider the presence of the in-body From to be a clue that something
interesting is going on (like forwarding somebody else's patch). So from
my perspective, it would just be useless noise. Other communities may
have different opinions, though (I think I have seen some kernel folks
always including all of the possible in-body headers, including Date).
But it seems like it makes sense to keep both possibilities.

-Peff
