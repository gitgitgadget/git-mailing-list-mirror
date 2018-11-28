Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCF5E1F609
	for <e@80x24.org>; Wed, 28 Nov 2018 11:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbeK1WdC convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 28 Nov 2018 17:33:02 -0500
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:46736 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727703AbeK1WdC (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 28 Nov 2018 17:33:02 -0500
Received: from app06-neu.ox.hosteurope.de ([92.51.170.140] helo=null); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        id 1gRy4C-0005p8-NG; Wed, 28 Nov 2018 12:31:40 +0100
Date:   Wed, 28 Nov 2018 12:31:40 +0100 (CET)
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Message-ID: <910459876.1655.1543404700658@ox.hosteurope.de>
In-Reply-To: <87k1l5zabd.fsf@evledraar.gmail.com>
References: <cover.1542831544.git.thomas.braun@virtuell-zuhause.de>
 <590f2ca6b5323c17365a1645b5d10e9ab30623c4.1542833244.git.thomas.braun@virtuell-zuhause.de>
 <87k1l5zabd.fsf@evledraar.gmail.com>
Subject: Re: [PATCH v1 1/2] log -G: Ignore binary files
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3
Importance: Medium
X-Originating-Client: open-xchange-appsuite
X-Mailer: Open-Xchange Mailer v7.8.4-Rev42
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1543404702;66140804;
X-HE-SMSGID: 1gRy4C-0005p8-NG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> hat am 22. November 2018 um 11:16 geschrieben:

[...]

> >
> > +test_expect_success 'log -G ignores binary files' '
> > +	rm -rf .git &&
> > +	git init &&
> > +	printf "a\0b" >data.bin &&
> > +	git add data.bin &&
> > +	git commit -m "message" &&
> > +	git log -G a >result &&
> 
> Would be less confusing as "-Ga" since that's the invocation we
> document, even though I see (but wasn't aware that...) "-G a" works too.

Done.

> > +	test_must_be_empty result
> > +'
> > +
> > +test_expect_success 'log -G looks into binary files with textconv filter' '
> > +	rm -rf .git &&
> > +	git init &&
> > +	echo "* diff=bin" > .gitattributes &&
> > +	printf "a\0b" >data.bin &&
> > +	git add data.bin &&
> > +	git commit -m "message" &&
> > +	git -c diff.bin.textconv=cat log -G a >actual &&
> > +	git log >expected &&
> > +	test_cmp actual expected
> > +'
> > +
> >  test_done
> 
> This patch seems like the wrong direction to me. In particular the
> assertion that "the concept of differences only makes sense for text
> files". That's just not true. This patch breaks this:
> 
>     (
>         rm -rf /tmp/g-test &&
>         git init /tmp/g-test &&
>         cd /tmp/g-test &&
>         for i in {1..10}; do
>             echo "Always matching thensome 5" >file &&
>             printf "a thensome %d binary \0" $i >>file &&
>             git add file &&
>             git commit -m"Bump $i"
>         done &&
>         git log -Gthensome.*5
>     )
> 
> Right now this will emit 3/10 patches, and the right ones! I.e. "Bump
> [156]". The 1st one because it introduces the "Always matching thensome
> 5". Then 5/6 because the add/remove the string "a thensome 5 binary",
> respectively. Which matches /thensome.*5/.

log -p does not show you the patch text in your example because it is treated
as binary. And currently "log -G" has a different opinion into what it looks
and what it ignores. My patch tries to bring both more in line.
 
> I.e. in the first one we do a regex match against the content here
> because we don't have both sides:
> https://github.com/git/git/blob/v2.19.2/diffcore-pickaxe.c#L48-L53
> 
> And then for the later ones where we have both sides we end up in
> diffgrep_consume():
> https://github.com/git/git/blob/v2.19.2/diffcore-pickaxe.c#L27-L36
> 
> I think there may be a real issue here to address, which might be some
> combination of:
> 
>  a) Even though the diffcore can do a binary diff internally, this is
>     not what it exposes with "-p", we just say "Binary files differ".
> 
>     I don't know how to emit the raw version we'll end up passing to
>     diffgrep_consume() in this case. Is it just --binary without the
>     encoding? I don't know...
> 
>  b) Your test case shows that you're matching a string at a \0
>     boundary. Is this perhaps something you ran into? I.e. that we don't
>     have some -F version of -G so we can't supply regexes that match
>     past a \0? I had some related work on grep for this that hasn't been
>     carried over to the diffcore:
> 
>         git log --grep='grep:.*\\0' --author=Ævar
> 
>  c) Is this binary diff we end up matching against just bad in some
>     cases? I haven't dug but that wouldn't surprise me, i.e. that it's
>     trying to be line-based so we'll overmatch in many cases.
> 
> So maybe this is something that should be passed down as a flag? See a
> recent discussion at
> https://public-inbox.org/git/87lg77cmr1.fsf@evledraar.gmail.com/ for how
> that could be done.

It is not about the \0 boundary. v2 of the patches will clarify that. My main
motiviation is to speed up "log -G" as that takes a considerable amount of time 
when it wades through MBs of binary files which change often. And in multiple places
I can already treat binary files differently (e.g. turn off delta compression, skip
trying to diff them, no EOL normalization). And for me making log -G ignore what git 
thinks are binary files is making the line clearer between what should be treated
as binary and what as text.

> Also if we don't have some tests already that were failing with this
> patch we really should have those as "let's test the current behavior
> first". Unfortunately tests in this area are really lacking, see
> e.g. my:
> 
>     git log --author=Junio --min-parents=2 --grep=ab/.*grep
> 
> For some series of patches to grep where to get one patch in I needed to
> often lead with 5-10 test patches to convince reviewers that I knew what
> I was changing, and also to be comfortable that I'd covered all the edge
> cases we currently supported, but weren't testing for.

I'm happy to add more test cases to convince everyone involved :)
