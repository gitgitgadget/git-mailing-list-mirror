Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3A711F454
	for <e@80x24.org>; Thu,  1 Nov 2018 21:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbeKBGU5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 02:20:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:37088 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726343AbeKBGU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 02:20:57 -0400
Received: (qmail 5579 invoked by uid 109); 1 Nov 2018 21:16:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 01 Nov 2018 21:16:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29623 invoked by uid 111); 1 Nov 2018 21:15:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 01 Nov 2018 17:15:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Nov 2018 17:16:16 -0400
Date:   Thu, 1 Nov 2018 17:16:16 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v4 9/9] Documentation/config: add
 odb.<name>.promisorRemote
Message-ID: <20181101211616.GA3280@sigill.intra.peff.net>
References: <20180802061505.2983-1-chriscool@tuxfamily.org>
 <20180802061505.2983-10-chriscool@tuxfamily.org>
 <CAGZ79kYPik87zvLUPPKFzcATFUdBFcXrAkTYxpxvAQy6w1CcUw@mail.gmail.com>
 <CAP8UFD1ia1xWk9pjfTUQ3zD7=dP=8UjKzf=G0ptsz=qRH8_X+Q@mail.gmail.com>
 <20181016174304.GA221682@aiede.svl.corp.google.com>
 <CAP8UFD3nrhjANwNDqTwx5ZtnZNcnbAFqUN=u=LrvzuH4+3wQQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD3nrhjANwNDqTwx5ZtnZNcnbAFqUN=u=LrvzuH4+3wQQA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 31, 2018 at 07:28:09AM +0100, Christian Couder wrote:

> > For (2), I would like to see us improve the remote helper
> > infrastructure instead of introducing a new ODB helper.  Remote
> > helpers are already permitted to fetch some objects without listing
> > refs --- perhaps we will want to
> >
> >  i. split listing refs to a separate capability, so that a remote
> >     helper can advertise that it doesn't support that.  (Alternatively
> >     the remote could advertise that it has no refs.)
> >
> >  ii. Use the "long-running process" mechanism to improve how Git
> >      communicates with a remote helper.
> 
> Yeah, I agree that improving the remote helper infrastructure is
> probably better than what I have been trying to add. And I agree with
> the above 2 steps you propose.

One thing you might want to port over is the ability to ask the remote
helper "tell me the type and size of these objects". The reason I built
that into the original external-odb interface proposal was so that diff
could easily skip large objects without faulting them in (because
they're considered binary, and we'd just say "binary files differ"
anyway). That makes things like "git log -p" work a lot better (try it
with a blob-less partial clone now; it's pretty painful).

I know that's kind of the _opposite_ of how partial clones work now,
where we try really hard not to have to even tell the client the full
list of objects. That's good if the reason you want a partial clone is
because there are gigantic numbers of objects (e.g., the Windows repo).
But I think many people are interested in having a more moderate number
of large objects (e.g., things like game development that are using
git-lfs now). It would be great if we could support both use cases
easily.

-Peff
