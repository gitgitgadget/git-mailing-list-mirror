Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E4031F4C0
	for <e@80x24.org>; Fri,  1 Nov 2019 19:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbfKATgA (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Nov 2019 15:36:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:36534 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727710AbfKATgA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Nov 2019 15:36:00 -0400
Received: (qmail 29202 invoked by uid 109); 1 Nov 2019 19:36:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 Nov 2019 19:36:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14097 invoked by uid 111); 1 Nov 2019 19:39:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 Nov 2019 15:39:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 1 Nov 2019 15:35:58 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Davide Berardi <berardi.dav@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH] Segmentation Fault on non-commit --branch clone
Message-ID: <20191101193558.GA1169@sigill.intra.peff.net>
References: <20191101002432.GA49846@carpenter.lan>
 <nycvar.QRO.7.76.6.1911012000160.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1911012000160.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 01, 2019 at 08:08:10PM +0100, Johannes Schindelin wrote:

> > +static int fallback_on_noncommit(const struct ref *check,
> > +				 const struct ref *remote,
> > +				 const char *msg)
> > +{
> > +	if (check == NULL)
> > +		return 1;
> > +	struct commit *c = lookup_commit_reference_gently(the_repository,
> > +						   &check->old_oid, 1);
> > +	if (c == NULL) {
> > +		/* Fallback HEAD to fallback refs */
> > +		warning(_("%s is not a valid commit object, HEAD will fallback
> > to %s"),
> > +			check->name, FALLBACK_REF);
> 
> Quite honestly, I do not think that it is a good idea to fall back in
> this case. The user asked for something that cannot be accomplished, and
> the best way to handle this is to exit with an error, i.e. `die()`.

The main reason I proposed falling back here is that the user can
correct the situation without having to redo the clone from scratch
(which might have been very expensive). And we cannot just leave HEAD
empty there; we have to put _something_ in it.

I do think it's important, though, that we don't just fall back; we
should still report an error exit from the program (just as we do for
the similar case when clone's checkout step fails). Otherwise something
as simple as:

  git clone -b $url repo &&
  cd repo &&
  do_something

could have quite unexpected results.

I don't know how often this would actually help users, though. It _is_ a
pretty rare situation to ask for a non-commit. So maybe it's all
over-engineering, and we should start with just die(). If somebody comes
along later and wants to enhance it, it should be pretty
straightforward.

-Peff
