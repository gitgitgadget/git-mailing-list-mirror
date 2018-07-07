Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E0661F62D
	for <e@80x24.org>; Sat,  7 Jul 2018 01:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753976AbeGGBcn (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 21:32:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:50914 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753615AbeGGBcm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 21:32:42 -0400
Received: (qmail 25946 invoked by uid 109); 7 Jul 2018 01:32:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 07 Jul 2018 01:32:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30008 invoked by uid 111); 7 Jul 2018 01:32:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 06 Jul 2018 21:32:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Jul 2018 21:32:40 -0400
Date:   Fri, 6 Jul 2018 21:32:40 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jason@zx2c4.com,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] fsck: check skiplist for object in fsck_blob()
Message-ID: <20180707013239.GA4687@sigill.intra.peff.net>
References: <2fc2d53f-e193-2a2a-9f8f-b3e1d256d940@ramsayjones.plus.com>
 <20180628114912.GA12901@sigill.intra.peff.net>
 <0a18acbd-0124-1c92-0046-05b8b035dd28@ramsayjones.plus.com>
 <20180628174501.GC31766@sigill.intra.peff.net>
 <db7683ab-1025-d7bb-d0ce-fc4ee28681e1@ramsayjones.plus.com>
 <20180628220332.GA5128@sigill.intra.peff.net>
 <9162ed69-d245-8b2f-0dcc-3b345264b029@ramsayjones.plus.com>
 <20180703143416.GA23556@sigill.intra.peff.net>
 <80fad203-8196-c4b6-ed9e-10def0890d59@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <80fad203-8196-c4b6-ed9e-10def0890d59@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 04, 2018 at 01:12:40AM +0100, Ramsay Jones wrote:

> > True that we don't even bother doing the parsing with your patch. But I
> > think I talked myself out of that part being a significant savings
> > elsewhere.
> 
> [Sorry for the late reply - watching football again!]
> 
> I'm not interested in any savings - it would have to be a pretty
> wacky repo for there to be much in the way of savings!
> 
> Simply, I have found (for many different reasons) that, if there
> is no good reason to execute some code, it is _far_ better to not
> do so! ;-)

Heh. I also agree with that as a guiding principle. But I _also_ like
the principle of "if you do not need to do add this code, do not add
it". So the two are a little at odds here. :)

> > I'm not sure. This has been running on every push to GitHub for the past
> > 6 weeks, and this is the first report. It's hard to say what that means,
> > and technically speaking of course this _is_ a regression.
> 
> Hmm, are you concerned about old clients 'transmitting' the
> bad data via large hosting sites? (New clients would complain
> about a dodgy .gitmodules file, no matter were it came from,
> right?)

I just meant above that anybody with a broken .gitmodules would have had
their push rejected, and we haven't gotten any such reports beyond yours
and Mike's. So that's some evidence that it's relatively rare.

As far as why those fsck checks are there in the first place, yes, it's
about transmitting bad data to unpatched clients. Ultimately the
responsibility for not being vulnerable is on the clients themselves.
But in practice large hosting sites can help by not being vectors.

> Has the definition of the config file syntax changed recently?
> If not, then old client versions will see the same syntax errors
> as recently 'fixed' versions. So they should error out without
> 'looking' at the bad data, right? (ignoring the 'lets fix the
> obvious syntax error' idea).

No, it hasn't change. So as far as I know, loosening the syntax check
does not impact _this_ vulnerability, because it requires a file that
can be parsed, and the parser is the same for both cases. It might
affect future vulnerabilities. We could also tighten when those come to
light, or tighten in a way that blocks the specific bug. But there's
potentially some value in putting our foot down _now_ and saying that
we're going to enforce certain properties of special files, before it
gets any further out-of-hand.

And of course I could be wrong. We do occasionally fix bugs in the
parser, so I won't be surprised if there's some obscure case where git
<2.0 would not be protected or something like that. But frankly,
anything that old is probably already vulnerable to other ancient bugs,
too.

> > Thanks. If we're going to do any loosening, I think we may want to
> > address that _first_, so it can go directly on top of the patches in
> > v2.17.1 (because it's a bigger issue than the stray message, IMHO).
> 
> Agreed. I probably haven't given it sufficient thought, but my
> immediate reaction is to loosen the check - I don't see how
> this could be exploited to significantly reduce security. (My lack
> of imagination has been noted several times in the past, however!)
> 
> Having said that, I am no security expert, so I will let those who
> have security expertise decide what is best to do in this situation.

I think you have a grasp on the situation from what you wrote above.

What next? I was kind of leaning towards loosening, but it sounded like
Junio thought the opposite. One thing I didn't like about the patch I
sent earlier is that it removes the option for the admin to say "no, I
really do want to enforce this". I don't know if that's of value or not.

In an ideal world, I think we'd detect the problem and then react
according to the receiver's receive.fsck.* config. And we could just
flip the default for receive.fsck.gitmodulesParse to "warning". But
IIRC, the fsck code in index-pack does not bother distinguishing between
warnings and errors. I think it ought to, but that's too big a change to
go on maint.

It _might_ work to just flip the default to "ignore". That leaves the
paranoid admin with a way to re-enable it if they want, and I _think_ it
would be respected by index-pack.

[goes and looks at the code]

Hmm, we seem to have "info" these days, so maybe that would do what I
want. I.e., I wonder if the patch below does everything we'd want. It's
late here and I probably won't get back to this until Monday, but you
may want to play with it in the meantime.

diff --git a/fsck.c b/fsck.c
index 48e7e36869..0b0003055e 100644
--- a/fsck.c
+++ b/fsck.c
@@ -61,7 +61,6 @@ static struct oidset gitmodules_done = OIDSET_INIT;
 	FUNC(ZERO_PADDED_DATE, ERROR) \
 	FUNC(GITMODULES_MISSING, ERROR) \
 	FUNC(GITMODULES_BLOB, ERROR) \
-	FUNC(GITMODULES_PARSE, ERROR) \
 	FUNC(GITMODULES_NAME, ERROR) \
 	FUNC(GITMODULES_SYMLINK, ERROR) \
 	/* warnings */ \
@@ -76,6 +75,7 @@ static struct oidset gitmodules_done = OIDSET_INIT;
 	FUNC(NUL_IN_COMMIT, WARN) \
 	/* infos (reported as warnings, but ignored by default) */ \
 	FUNC(BAD_TAG_NAME, INFO) \
+	FUNC(GITMODULES_PARSE, INFO) \
 	FUNC(MISSING_TAGGER_ENTRY, INFO)
 
 #define MSG_ID(id, msg_type) FSCK_MSG_##id,
