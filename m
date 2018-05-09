Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC3DA1F42D
	for <e@80x24.org>; Wed,  9 May 2018 07:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933901AbeEIH4f (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 03:56:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:33104 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933715AbeEIH4e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 03:56:34 -0400
Received: (qmail 17855 invoked by uid 109); 9 May 2018 07:56:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 May 2018 07:56:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12201 invoked by uid 111); 9 May 2018 07:56:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 09 May 2018 03:56:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 May 2018 03:56:32 -0400
Date:   Wed, 9 May 2018 03:56:32 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 09/12] get_short_oid / peel_onion: ^{tree} should be
 tree, not treeish
Message-ID: <20180509075632.GA3327@sigill.intra.peff.net>
References: <20180501184016.15061-1-avarab@gmail.com>
 <20180501120651.15886-1-avarab@gmail.com>
 <20180501184016.15061-10-avarab@gmail.com>
 <xmqqzi1htij7.fsf@gitster-ct.c.googlers.com>
 <87wowlxko8.fsf@evledraar.gmail.com>
 <xmqqvac4tb64.fsf@gitster-ct.c.googlers.com>
 <87lgczyfq6.fsf@evledraar.gmail.com>
 <xmqq6040qf8x.fsf@gitster-ct.c.googlers.com>
 <20180508143408.GA30183@sigill.intra.peff.net>
 <87a7tax9m1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a7tax9m1.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 08, 2018 at 08:53:10PM +0200, Ævar Arnfjörð Bjarmason wrote:

> >> "X^{tree}" should *RESULT* in a tree, but it should *REQUIRE* X to
> >> be a tree-ish.  It is unclear "should be tree" is about the former
> >> and I read (perhaps mis-read) it as saying "it should require X to
> >> be a tree"---that statement is utterly incorrect as we agreed above.
> >
> > FWIW, I had the same feeling as you when reading this, that this commit
> > (and the one after) are doing the wrong thing. And these paragraphs sum
> > it up. The "^{tree}" is about asking us to peel to a tree, not about
> > resolving X in the first place. We can use it as a _hint_ when resolving
> > X, but the correct hint is "something that can be peeled to a tree", not
> > "is definitely a tree".
> 
> Maybe I'm just being dense, but I still don't get from this & Junio's
> E-Mails what the general rule should be.

Let me try to lay out my thinking a bit more clearly, and then I'll try
to respond to the points you laid out below.

Before we had any disambiguation code, resolving X^{tree} really was two
independent steps: resolve X, and then peel it to a tree. When we added
the disambiguation code, the goal was to provide a hint to the first
step in such a way that we could never eliminate any resolutions that
the user _might_ have meant. But it's OK to take a situation where every
case but one would result in an error, and assume the user meant that
case. Sort of a "do no harm" rule.

By disambiguating with just a tree and not a tree-ish, that hint is now
eliminating possibilities that would have worked in the second step,
which violates the rule.

Does thinking about it that way make more sense?

> I think a response to the part after "leaving that aside" of my upthread
> E-Mail
> (https://public-inbox.org/git/87lgczyfq6.fsf@evledraar.gmail.com/) would
> help me out.

I'll quote that bit here:

> But *leaving that aside*, i.e. I don't see why the use-case would make
> sense. What I *don't* get is why, if you think that, you only want to
> apply that rule to ^{tree}. I.e. wouldn't it then be consistent to say:
> 
>     # a)
>     ^{tag}    = tag
>     ^{commit} = tag, commit
>     ^{tree}   = tag, commit, tree
>     ^{blob}   = tag, blob (blobish)

Yes, that makes sense to me conceptually, and would follow the rule I
gave above. And I think that's what we do now, with the exception that
there is no blobish disambiguation. Presumably nobody ever bothered
because probably because tagged blobs are pretty rare (and obviously
though trees point to blobs, you cannot disambiguate that way since
there's no one-to-one correspondence).

So I doubt anybody really cares in practice, but I agree that it would
improve consistency to write a patch to introduce GET_OID_BLOBISH and
have "^{blob}" parsing use it.  And possibly add "blobish" to
core.disambiguate (or is it "blobbish"?), though that's almost certainly
something nobody would ever use.

> My understanding of what you two are saying is that somehow the peel
> semantics should be preserved when we take this beyond the 1=1 mapping
> case, but I don't see how if we run with that how we wouldn't need to
> introduce the concept of blobish for consistency as I noted upthread.

Yeah, I think the lack of blobish is a bug, just one that nobody has
ever really cared about.

> So it would be very useful to me if you or someone who understands the
> behavior you & Junio seem to want could write a version of the patch I
> have above where the last paragraph is different, and describes the
> desired semantics, because I still don't get it. Why would we 1=many
> peel commits to trees as a special case, but not 1=many do the same for
> trees & blobs?

I'm not sure I understand the mention of trees in the final sentence.
AFAICT tree disambiguation is consistent with the peeling rules.

-Peff
