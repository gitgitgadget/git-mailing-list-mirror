Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F0E71FF32
	for <e@80x24.org>; Fri, 13 Oct 2017 10:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756900AbdJMKhh (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 06:37:37 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:35332 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751607AbdJMKhf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 06:37:35 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.89)
        (envelope-from <mh@glandium.org>)
        id 1e2xLG-00048u-CS; Fri, 13 Oct 2017 19:37:22 +0900
Date:   Fri, 13 Oct 2017 19:37:22 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Constantine <hi-angel@yandex.ru>, git <git@vger.kernel.org>
Subject: Re: git-clone causes out of memory
Message-ID: <20171013103722.rvr7536mu2hoo4wb@glandium.org>
References: <515b1400-4053-70b0-18e2-1f61ebc3b2d7@yandex.ru>
 <20171013100603.5eed26sjjigph2il@glandium.org>
 <CAP8UFD1KuBdUCo=x_q4__s1kW15CWMH1jJkKzXqmf3=T3jcrng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD1KuBdUCo=x_q4__s1kW15CWMH1jJkKzXqmf3=T3jcrng@mail.gmail.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 13, 2017 at 12:26:46PM +0200, Christian Couder wrote:
> On Fri, Oct 13, 2017 at 12:06 PM, Mike Hommey <mh@glandium.org> wrote:
> > On Fri, Oct 13, 2017 at 12:51:58PM +0300, Constantine wrote:
> >> There's a gitbomb on github. It is undoubtedly creative and funny, but since
> >> this is a bug in git, I thought it'd be nice to report. The command:
> >>
> >>       $ git clone https://github.com/x0rz/ShadowBrokersFiles
> >
> > What fills memory is actually the checkout part of the command. git
> > clone -n doesn't fail.
> >
> > Credit should go where it's due: https://kate.io/blog/git-bomb/
> > (with the bonus that it comes with explanations)
> 
> Yeah, there is a thread on Hacker News about this too:
> 
> https://news.ycombinator.com/item?id=15457076
> 
> The original repo on GitHub is:
> 
> https://github.com/Katee/git-bomb.git
> 
> After cloning it with -n, there is the following "funny" situation:
> 
> $ time git rev-list HEAD
> 7af99c9e7d4768fa681f4fe4ff61259794cf719b
> 18ed56cbc5012117e24a603e7c072cf65d36d469
> 45546f17e5801791d4bc5968b91253a2f4b0db72
> 
> real    0m0.004s
> user    0m0.000s
> sys     0m0.004s
> $ time git rev-list HEAD -- d0/d0/d0/d0/d0/d0/d0/d0/d0/d0/f0
> 
> real    0m0.004s
> user    0m0.000s
> sys     0m0.000s
> $ time git rev-list HEAD -- d0/d0/d0/d0/d0/d0/d0/d0/d0/d0
> 
> real    0m0.004s
> user    0m0.000s
> sys     0m0.000s
> $ time git rev-list HEAD -- d0/d0/d0/d0/d0/d0/d0/d0/
> 45546f17e5801791d4bc5968b91253a2f4b0db72
> 
> real    0m0.005s
> user    0m0.008s
> sys     0m0.000s
> $ time git rev-list HEAD -- d0/d0/d0/d0/d0/
> 45546f17e5801791d4bc5968b91253a2f4b0db72
> 
> real    0m0.203s
> user    0m0.112s
> sys     0m0.088s
> $ time git rev-list HEAD -- d0/d0/d0/d0/
> 45546f17e5801791d4bc5968b91253a2f4b0db72
> 
> real    0m1.305s
> user    0m0.720s
> sys     0m0.580s
> $ time git rev-list HEAD -- d0/d0/d0/
> 45546f17e5801791d4bc5968b91253a2f4b0db72
> 
> real    0m12.135s
> user    0m6.700s
> sys     0m5.412s
> 
> So `git rev-list` becomes exponentially more expensive when you run it
> on a shorter directory path, though it is fast if you run it without a
> path.

That's because there are 10^7 files under d0/d0/d0, 10^6 under
d0/d0/d0/d0/, 10^5 under d0/d0/d0/d0/d0/ etc.

So really, this is all about things being slower when there's a crazy
number of files. Picture me surprised.

What makes it kind of special is that the repository contains a lot of
paths/files, but very few objects, because it's duplicating everything.

All the 10^10 blobs have the same content, all the 10^9 trees that point
to them have the same content, all the 10^8 trees that point to those
trees have the same content, etc.

If git wasn't effectively deduplicating identical content, the repository
would be multiple gigabytes large.

Mike
