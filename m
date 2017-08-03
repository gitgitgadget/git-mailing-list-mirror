Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E1501F991
	for <e@80x24.org>; Thu,  3 Aug 2017 20:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751965AbdHCURk (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 16:17:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:57396 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751600AbdHCURj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 16:17:39 -0400
Received: (qmail 12022 invoked by uid 109); 3 Aug 2017 20:17:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 03 Aug 2017 20:17:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22503 invoked by uid 111); 3 Aug 2017 20:17:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 03 Aug 2017 16:17:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Aug 2017 16:17:37 -0400
Date:   Thu, 3 Aug 2017 16:17:37 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 10/40] Add initial external odb support
Message-ID: <20170803201736.b37ziyub3wdlh6iw@sigill.intra.peff.net>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
 <20170803091926.1755-11-chriscool@tuxfamily.org>
 <xmqqfud8xx6m.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfud8xx6m.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 03, 2017 at 12:34:25PM -0700, Junio C Hamano wrote:

> > +int external_odb_get_object(const unsigned char *sha1)
> > +{
> > +	struct odb_helper *o;
> > +	const char *path;
> > +
> > +	if (!external_odb_has_object(sha1))
> > +		return -1;
> 
> This probably would not matter, as I do not expect one repository to
> connect to and backed by very many external odb instances, but I
> would have expected that the interaction would go more like "ah, we
> need this object that is lacking locally. let's see if there is
> anybody with the object. now we found who claims to have the object,
> let's ask that guy (and nobody else) to give the object to us".
> 
> IOW, I would have expected two functions:
> 
>  - struct odb_helper *external_odb_with(struct object_id *oid);
>  - int external_odb_get(struct object_id *oid, struct odb_helper *odb);

One advantage of walking through them linearly and asking "can you get
it?" is that it gracefully handles external odbs which aren't available.
That can be used for redundancy, or for situations where a preferred
odb isn't always available (e.g., a fast server which is only available
when you're on a particular network).

-Peff
