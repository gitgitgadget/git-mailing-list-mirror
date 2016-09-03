Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F0151F6BF
	for <e@80x24.org>; Sat,  3 Sep 2016 22:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753600AbcICWeB (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Sep 2016 18:34:01 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:24096 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753239AbcICWeA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Sep 2016 18:34:00 -0400
Received: from PhilipOakley ([92.22.24.43])
        by smtp.talktalk.net with SMTP
        id gJVdbM7cr0KuvgJVdbWLH3; Sat, 03 Sep 2016 23:33:58 +0100
X-Originating-IP: [92.22.24.43]
X-Spam: 0
X-OAuthority: v=2.2 cv=RZjSMBlv c=1 sm=1 tr=0 a=ZBOQwd+zDMuFpFo4vDT3kw==:117
 a=ZBOQwd+zDMuFpFo4vDT3kw==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=ybZZDoGAAAAA:8 a=WBp14lFiTNleG6gekXwA:9 a=QEXdDO2ut3YA:10
 a=6kGIvZw6iX1k4Y-7sg4_:22 a=0RhZnL1DYvcuLYC8JZ5M:22
Message-ID: <539B8BADEBFE4539ADC8B7EB60B23B5B@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Robert Dailey" <rcdailey.lists@gmail.com>,
        "Junio C Hamano" <gitster@pobox.com>
Cc:     "Git" <git@vger.kernel.org>
References: <CAHd499AQFDRps6POF2xuUjbYv5DJYxt3DA8aFFArXF=qQEz_CA@mail.gmail.com> <55512A8927384A0790DDC7F526B09053@PhilipOakley> <xmqq60qdsoxj.fsf@gitster.mtv.corp.google.com> <CAHd499Bd7CHZ-O8HLd_iNnVNxz1C1=vO-4kxD80sEgBiesrMXg@mail.gmail.com>
Subject: Re: Fixup of a fixup not working right
Date:   Sat, 3 Sep 2016 23:33:59 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfEJiMzNgOTsp1NUz5O3tt4Ndssba5zra/DglynJlm+ha137PKgYx8nrcOIDMWhvxpUtUjG5BV90ArvVBu2C2FLx8XjVpGJaLtQTtQUsk8nfFzgpy8e+W
 yOvqF0FzoArX/37qbKn904MOZ9CWstlAkCWnjlja9mL6nahE+mLIxUTi3aIeKX3JdJZi/X5zEei1jMpdkO1aDlj8dr2jKuohP0NeFZGOYDRggaM/k8jAgFYv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Robert,
From: "Robert Dailey" <rcdailey.lists@gmail.com>
> On Fri, Sep 2, 2016 at 9:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Perhaps a change like this to "rebase -i":
>>
>>  - The search for "original" when handling "pick fixup! original",
>>    when it does not find "original", could turn it into "reword
>>    fixup! original" without changing its position in the instruction
>>    sequence.
>
[..]
> So this is mostly for my education, since I don't see a difference
> from a user-standpoint.

This was a problem in the past.

>   Why would "fixup! fixup! original" look for
> "original" instead of "fixup! original"? As far as I can see, the
> behavior would be the same and the order would be retained since you
> are essentially "chaining" the fixups together this way.

The patch that introduced the effect is 22c5b13 (rebase -i: handle fixup! 
fixup! in --autosquash, 2013-06-27). At the time it was possible that the 
commits would be re-ordered based on the full multi-fixup message, and so, 
if you thought you'd corrected a poor fixup, rather correcting the original, 
the conceptual order would change. While the combined diffs still notionally 
add to the same effect, the changes to the context lines may mean they don't 
apply cleanly - keeping them in order makes for a clean application. The 
solution was to ignore multiple fixup!s at the start.


> This also
> gives you the behavior you want directly because the algorithm will
> naturally tie to "fixup! original" even if "original" doesn't exist,
> because Git would expect that "fixup! original" will automatically
> manage its own order, and that subsequent processed nested "fixup!"
> commits would not need to depend on any other commits.

There is a question as to whether the commit you pushed upstream, is classed 
as 'published' and immutable, or still part of the review and modification 
process. At the moment the presumption, in general, is that it would be the 
former, so that you can't fixup the original. I don't see that changing, 
however Junio's suggestion that these extra fixups are 'reworded' so that 
they will rebase (--autosquash) locally to become one commit titled 
something like "fix! original", and then a final rebase that rewords that 
commit back to "fixup! " for pushing upstream to the 'review' process, where 
they can request that it be 'fixed';-) 

