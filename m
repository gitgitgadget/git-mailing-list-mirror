Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3BDF1F859
	for <e@80x24.org>; Sat, 27 Aug 2016 11:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751321AbcH0LGP (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Aug 2016 07:06:15 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:19891 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbcH0LGN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2016 07:06:13 -0400
Received: from PhilipOakley ([92.22.43.186])
        by smtp.talktalk.net with SMTP
        id dbPEblbKHxR4bdbPEbjVhq; Sat, 27 Aug 2016 12:04:09 +0100
X-Originating-IP: [92.22.43.186]
X-Spam: 0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=c/aLR0OYuympRvq5/eaaXg==:117
 a=c/aLR0OYuympRvq5/eaaXg==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=UaQKl5Aqtk9RLs4EqcgA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
 a=wPNLvfGTeEIA:10 a=0RhZnL1DYvcuLYC8JZ5M:22 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <CD6AE25418644EB688D4488F8AB40155@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Git List" <git@vger.kernel.org>
References: <2FA1998250474E76A386B82AD635E56A@PhilipOakley> <xmqqfuprdtwh.fsf@gitster.mtv.corp.google.com>
Subject: Re: Are --first-parent and --ancestry-path compatible rev-list options?
Date:   Sat, 27 Aug 2016 12:04:08 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfGh3MLs1/Esj09PCby6bNFcy0uZsOnkmAfhHeGTUrbAVJlAitZYLr4PDnropQKgqEKfFO49b22wJvD1NiBvhMOF6+1hg0Q3O/pYXgb9DQ0q2/RfG9/6U
 r5lUJMMbq7HGe82Qz8d0J49fhTl4JiBb3pVWFRAOZ0RkpPZdsgqiH7tBeYpvoZzgi6aawWtZzxruVw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> The commit graph. We are looking for F based on knowing J.
>>
>> . A - B - C - D -- E -- F -- G - H    <-first parent, --merges (C,F,H)
>> .  \  |  /    \        /    /
>> .   ----Z     |       /    /
>> .     |       |       |   /
>> .      \       \     /   /
>> .       I -[J]- K - L - M             <-since J, children of J
>> .        \         /
>> .         N - O - P
>
> I think these two operations are fundamentally incompatible.

If I run them independently, they both find the desired INTERESTED commit, 
hence the expectation that together they will still find that commit as an 
intersection between the two sets.

>
> Because the first-parent traversal is what the name says, i.e.,
> forbids the positive side of revision traversal to stray into side
> branches, the positive side of a traversal that begins at H will not
> see M, L and K.

But it does see F the ultimately desired commit.
Philip@PhilipOakley MINGW32 /usr/src/test (master)

$ git log --oneline --first-parent --merges :/j..

d089efa g

ac811d4 f

1db59e5 c

Then we have:
--ancestry-path
    Limit the displayed commits to those directly on the ancestry chain 
between the "from" and "to" commits in the given commit range.

So one would expect, from a user viewepoint that this is commit selection, 
not internal algorithm implementation, that it would only list G and F, and 
the C would not be displayed.

>  The negative side would traverse in the normal way
> to paint commits starting J and its ancestors as UNINTERESTING, so
> the traversal over the artificial "first-parent only" history, i.e.
> H, G, F, E, D, C, B, A would eventually stop before showing an
> ancestor of J.
>

> On the other hand, to compute the ancestry-path, you need to make a
> full traversal of the real history to find a subgraph J..H and then
> post-process it to cull paths that do not contain J.

The culling order isn't clear. It's easy to expect that --first parent is a 
cull.
The documentation implies (to me) this different computation.


This explains why its happening, but it does feel rather contrary to user 
(rather than developer) expectation. It's the confusion between traversal 
limiting and marking a commit as Interesting (i.e. UNINTERSTING has two 
meanings which may not align when multiple options are given.)

It does seem odd that in the Git world, with its feature branch approach, 
that this hasn't come up before. I know that I haven't even bothered to try 
this 'search', and just use gitk to manually follow the breadcrumbs.

Perhaps a `--first-parent-ancestor` option to determine the places where a 
commit from a feature series was merged in to the mainline would be rather 
helpful.
> --
Philip 

