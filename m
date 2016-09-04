Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 011B920193
	for <e@80x24.org>; Sun,  4 Sep 2016 11:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752022AbcIDLr5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 07:47:57 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:31917 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751095AbcIDLr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 07:47:56 -0400
Received: from PhilipOakley ([92.22.24.43])
        by smtp.talktalk.net with SMTP
        id gVtxb4MSMxR4bgVtxbozWr; Sun, 04 Sep 2016 12:47:54 +0100
X-Originating-IP: [92.22.24.43]
X-Spam: 0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=ZBOQwd+zDMuFpFo4vDT3kw==:117
 a=ZBOQwd+zDMuFpFo4vDT3kw==:17 a=8nJEP1OIZ-IA:10 a=xtxXYLxNAAAA:8
 a=gu6fZOg2AAAA:8 a=cqZ_avYSBaRN5RCVGbAA:9 a=wPNLvfGTeEIA:10 a=-FEs8UIgK8oA:10
 a=NWVoK91CQyQA:10 a=xts0dhWdiJbonKbuqhAr:22 a=2RSlZUUhi9gRBrsHwhhZ:22
Message-ID: <8F7471262D1C45D9A7BD1C29277004AD@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        "Junio C Hamano" <gitster@pobox.com>
Cc:     "Robert Dailey" <rcdailey.lists@gmail.com>,
        "Git" <git@vger.kernel.org>
References: <CAHd499AQFDRps6POF2xuUjbYv5DJYxt3DA8aFFArXF=qQEz_CA@mail.gmail.com>        <55512A8927384A0790DDC7F526B09053@PhilipOakley> <xmqq60qdsoxj.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1609040923390.129229@virtualbox>
Subject: Re: Fixup of a fixup not working right
Date:   Sun, 4 Sep 2016 12:47:55 +0100
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
X-CMAE-Envelope: MS4wfPRHj+rzh8H95eQJREHFJ2p4VqPTBYfcpmQHDBFlpbih8ICFmguP+tZBTfFQrJkyzCthW9RLQHSwzpkiOdVQXsclyVimK6+2ai+SjdA9wvZd4rdoHqXP
 mdVakx2HX7nnmzzytyzt/G/3H12yvlZtZwHCKd6wDmIs7oqZ6s7LBIU6qu281UGDuca3yUjBvuP+K3RzMLu/RzoloKgRlruGDrXumPdnM1viy7Vrzh9y5bWo
 nx2nR0dUFob40OPDUb6gQfxWGypFEGlEmmIUChPrL0k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
> Hi Junio & Philip,
>
> On Fri, 2 Sep 2016, Junio C Hamano wrote:
>
>> "Philip Oakley" <philipoakley@iee.org> writes:
>>
>> > As I understand this it's implied by design. The issue is that the
>> > rebase is looking for that named commit within its current rebase
>> > range, and can't find it, so ignores it.
>> >
>> > There is a separate issue that all the fixup! fixup! messages are
>> > essentially treated as being concatenations of the original fixup!, no
>> > matter how many time the fiup is present.
>>
>> They can be handled separately, but they come from the same "design"
>> that could be improved.  When the "original" is not in the range to
>> be rebased for whatever reason (including the most likely one, i.e.
>> it has already graduated to become part of the public history), the
>> best thing the user could do at that point may be, as you suggested
>> to Robert in your message, to turn the "fixup! original" that did
>> not make in time before "original" hit the public record into a
>> standalone "fix original" follow-up change, and then to squash
>> subsequent "fixup! fixup! original" (and other "fixup! original",
>> too) into that commit.  And a good direction forward may be to see
>> if "rebase -i" can be taught to be more helpful for the user who
>> wants to do that.
>>
>> Perhaps a change like this to "rebase -i":
>>
>>  - The search for "original" when handling "pick fixup! original",
>>    when it does not find "original", could turn it into "reword
>>    fixup! original" without changing its position in the instruction
>>    sequence.
>>
>>  - The search for "original" when handling "pick fixup! fixup!
>>    original", could be (probably unconditionally) changed to look
>>    for "fixup! original" to amend, instead of looking for "original"
>>    as the current code (this is your "separate issue").  The same
>>    "if the commit to be amended is not found, turn it into reword"
>>    rule from the above applies to this one, too.
>>
>> may be an improvement?
>
> I would be *very* careful with such a change.

I agree about the need for care. The use case must be well understood.

> The point is that fixup! messages are really special, and are always
> intended to be squashed into the referenced commit *before* the latter
> hits `master`.

I think it's here that we have the hidden use case. I agree that all fixups 
should be squashed before they hit the blessed golden  repository.

I suspect that some use cases have intermediate repositories that contain a 
'master' branch (it's just a name ;-) that isn't blessed and golden, e.g. at 
the team review repo level. In such cases it is possible for a fixup! to be 
passed up as part of the review, though it's not the current 
norm/expectation.

>
> The entire design of the fixup! feature (using the commit subject as
> identifier, which is only "unique enough" in a topic branch that is still
> being developed) points to that.
>
> I am fairly certain that we would run into tons of problems if we diluted
> the concept of fixup! commits by changing the design so that fixup!
> commits all of a sudden become their own, "real" commits that can be fixed
> up themselves, as much of the current code simply does not expect that.

We already had that. the commit 22c5b13 (rebase -i: handle fixup! fixup! 
in --autosquash, 2013-06-27) was an attempt to work around misunderstandings 
about what fixed what.

In Robert's scenario (IIUC) that patch was too aggressive for the case where 
the original commit is not part of the rebase. The patch lept in a little 
too early in the processing so as to pretend that if it saw repeated "fixup! 
" strings at the start of the messages it pretented there was only one, so 
that they all applied in the original sequence.

I _think_ that the right approach would be to just bring such fixups 
together in the to-do list ("as normal"), but still have the minimal common 
commit message string still present, so that it would, in this case, still 
have a resulting squashed commit that starts "!fixup ". It's important to be 
moderately lenient to user choices - they may know something we don't, or at 
least accept that their use case is 'unusual' [1]

>
> In short, I am opposed to this change.

It's not like G4W doesn't need fixup!s on the side branches e.g. 5eaffe9 
("fixup! Handle new t1501 test case properly with MinGW", 2016-07-12)

> And even if I am overruled, I would strongly suggest to implement this on
> top of my rebase-i-extra branch (i.e. in the rebase--helper instead of the
> shell script) to avoid double churn.

I definitely agree there.

>
> Ciao,
> Johannes
>
--
Philip
[1] The removal of the "theirs" merge strategy is one I'd add to that list. 
Calling it, for example, "reversed" would have kept it available while 
reduced it's visibility. See http://marc.info/?l=git&m=121637513604413&w=2 

