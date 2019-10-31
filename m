Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A80651F454
	for <e@80x24.org>; Thu, 31 Oct 2019 20:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbfJaUHk (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 16:07:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:35370 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726741AbfJaUHk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 16:07:40 -0400
Received: (qmail 19609 invoked by uid 109); 31 Oct 2019 20:07:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 31 Oct 2019 20:07:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4967 invoked by uid 111); 31 Oct 2019 20:10:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Oct 2019 16:10:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Oct 2019 16:07:39 -0400
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git branch --edit-description a custom file
Message-ID: <20191031200739.GA19313@sigill.intra.peff.net>
References: <20191030183950.GA21277@generichostname>
 <20191030202835.GB29013@sigill.intra.peff.net>
 <20191030224328.GB44961@generichostname>
 <20191031061832.GA20830@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1910311119080.46@tvgsbejvaqbjf.bet>
 <20191031181920.GB70819@generichostname>
 <4ef79cfb-b970-2b2b-131d-3f47e6b0e308@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ef79cfb-b970-2b2b-131d-3f47e6b0e308@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 31, 2019 at 07:53:18PM +0000, Phillip Wood wrote:

> > So how would you envision the workflow for this? Would it be something
> > like,
> > 
> > 	$ git checkout feature-1
> > 
> > 	$ git branch --edit-description=ref # instead of =config
> 
> Personally I'd prefer a config setting that meant --edit-description stored
> the description in a ref instead of the current config key (or perhaps as
> well as so format-patch can just get the latest branch description from the
> config key)

Yes, a config option makes much more sense to me. Both the writers and
readers will need to know where to find the data.

> > * Since we're planning on sharing these descriptions with the outside
> >    world, how would the ref layout look like? If we're not using the
> >    refs/remotes namespace will it make fetching and merging notes harder?
> >    I know that collaborating with notes is a pain so how do we avoid
> >    making the same mistake?
> 
> I'd love to see a consensus around putting remote versions of refs/foo under
> refs/remote/<remote-name>/foo. To share notes I add a refspec that fetches
> to refs/remote/<remote-name>/notes. It is a pain that 'git pull' wont merge
> them for me though.

The trouble with that sort of scheme is that it conflicts with the
current namespace scheme, which puts the remote "notes" branch in
"refs/remotes/<remote-name>/notes". And it's not just a problem if you
want to have a branch called "notes". Think about what "git fetch
--prune" would do.

I do think the world would be a better place if we mapped (all or a
subset of) the remote "refs/" into "refs/remotes/<remote-name>/". I.e.,
really creating "refs/remotes/origin/heads" and even
"refs/remotes/origin/tags". But we'd need to re-adjust the way that some
ref lookups work (e.g., looking in refs/remotes/*/tags for tags).

There was some work by Johan Herland around the v1.8 time-frame, but it
stalled:

  https://public-inbox.org/git/AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com/

And here's some later discussion:

  https://public-inbox.org/git/CA+P7+xpj+8DZ=K0pna299Mu3nsQ4+JV_JUK=WFzzAFnJN+Bkbg@mail.gmail.com/

So in short, I agree very much with the direction you're discussing, but
I think there's some fundamental work that needs done first.

-Peff
