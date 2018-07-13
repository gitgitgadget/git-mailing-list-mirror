Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98A771F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 19:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731493AbeGMTyB (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 15:54:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:58816 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730017AbeGMTyB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 15:54:01 -0400
Received: (qmail 464 invoked by uid 109); 13 Jul 2018 19:38:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Jul 2018 19:38:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6568 invoked by uid 111); 13 Jul 2018 19:38:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 13 Jul 2018 15:38:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jul 2018 15:38:00 -0400
Date:   Fri, 13 Jul 2018 15:38:00 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jason@zx2c4.com,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] fsck: check skiplist for object in fsck_blob()
Message-ID: <20180713193759.GB10354@sigill.intra.peff.net>
References: <20180628114912.GA12901@sigill.intra.peff.net>
 <0a18acbd-0124-1c92-0046-05b8b035dd28@ramsayjones.plus.com>
 <20180628174501.GC31766@sigill.intra.peff.net>
 <db7683ab-1025-d7bb-d0ce-fc4ee28681e1@ramsayjones.plus.com>
 <20180628220332.GA5128@sigill.intra.peff.net>
 <9162ed69-d245-8b2f-0dcc-3b345264b029@ramsayjones.plus.com>
 <20180703143416.GA23556@sigill.intra.peff.net>
 <80fad203-8196-c4b6-ed9e-10def0890d59@ramsayjones.plus.com>
 <20180707013239.GA4687@sigill.intra.peff.net>
 <2ad1b00c-70ff-c4b2-8cbc-9ef55c174221@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2ad1b00c-70ff-c4b2-8cbc-9ef55c174221@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 11, 2018 at 08:31:34PM +0100, Ramsay Jones wrote:

> >> Simply, I have found (for many different reasons) that, if there
> >> is no good reason to execute some code, it is _far_ better to not
> >> do so! ;-)
> > 
> > Heh. I also agree with that as a guiding principle. But I _also_ like
> > the principle of "if you do not need to do add this code, do not add
> > it". So the two are a little at odds here. :)
> 
> I agree with that also! ;-) However, in this case, I can't
> imagine having to do less, to do nothing - if you see what
> I mean! So, I think "don't execute code you don't need to"
> trumps "don't add code you don't need to" here.

Fair enough. I'm OK with it either way, then.

> > @@ -76,6 +75,7 @@ static struct oidset gitmodules_done = OIDSET_INIT;
> >  	FUNC(NUL_IN_COMMIT, WARN) \
> >  	/* infos (reported as warnings, but ignored by default) */ \
> >  	FUNC(BAD_TAG_NAME, INFO) \
> > +	FUNC(GITMODULES_PARSE, INFO) \
> >  	FUNC(MISSING_TAGGER_ENTRY, INFO)
> >  
> >  #define MSG_ID(id, msg_type) FSCK_MSG_##id,
> > 
> 
> So, just squinting at this in my email client, if this allowed
> a push/fetch to succeed (along with an 'info' message), while
> providing an admin the means to configure it to loudly deny
> the push/fetch - then I think we have a winner! ;-)
> 
> Sorry for not testing the patch.

No problem. I didn't get back to it until today. And indeed, the patch
works as advertised, but there's one additional bit needed (in the
preparatory patch below).

So here's what I came up with, which I think is pretty reasonable. The
commit message for the second one is quite long, but I tried to lay out
the pros and cons from our discussion. And I think what we discussed
here may end up being the blueprint for how we consider similar cases in
the future, so I tried to be exhaustive.

I built these two on top of my earlier four patches (which Junio has
queued as jk/fsck-gitmodules-gently). The code change itself is
orthogonal to silencing the config code, but I built on top of the test
added earlier. If we want to back-port this to v2.17 or earlier, I can
build it the other way around.

If this is what we decide to do upstream, then I'll lobby to flip
GitHub's defaults to match. Other hosters (especially ones using other
implementations) may consider doing the same.

  [1/2]: fsck: split ".gitmodules too large" error from parse failure
  [2/2]: fsck: downgrade gitmodulesParse default to "info"

 fsck.c                     | 5 +++--
 t/t7415-submodule-names.sh | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

-Peff
