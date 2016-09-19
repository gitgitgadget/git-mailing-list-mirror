Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB6F12070F
	for <e@80x24.org>; Mon, 19 Sep 2016 19:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751543AbcISTb5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 15:31:57 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:43756 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbcISTb4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 15:31:56 -0400
Received: from PhilipOakley ([92.22.33.116])
        by smtp.talktalk.net with SMTP
        id m4IDbeo6SxR4bm4IDbydMh; Mon, 19 Sep 2016 20:31:54 +0100
X-Originating-IP: [92.22.33.116]
X-Spam: 0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=7PoCAWDTb98b1EGiAsJI/w==:117
 a=7PoCAWDTb98b1EGiAsJI/w==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=cCri8_SAAAAA:8 a=I0cF6Oeq6GmzXziQt6AA:9 a=wPNLvfGTeEIA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=sbRuPzbSW-bVi6QwGVni:22
Message-ID: <989F47918A374EEF8C7FECD3CFC6767E@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>,
        "Michael J Gruber" <git@drmicha.warpmail.net>
Cc:     "Git List" <git@vger.kernel.org>
References: <2AD952BD65034D25BF26C7F138D24F25@PhilipOakley>        <3b06b9ee-3975-acf1-41d8-02b774a2dd3c@drmicha.warpmail.net> <xmqq8tunhns4.fsf@gitster.mtv.corp.google.com>
Subject: Re: clarification of `rev-list --no-walk ^<rev>`?
Date:   Mon, 19 Sep 2016 20:31:55 +0100
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
X-CMAE-Envelope: MS4wfFEYFwSdPOOiA/MgzeumExyxbLMP95HKHtaMIlKRcr8ccouviG3+1jd2KWNslLG7DfiSnM0FJ4S4zYFQLqQv9RtbmeyUESxCWC3JVfubc4smFSrzknL+
 6deOqXpnp3a/BQkI/f7jqxXiHHBrcyiVeHktVYJOc/tpTw4nmnWXGPWwOoZHGkM15vvh4GkOQcgGsphl9oo1DPEB3cDeYN3QbwMK3+6iGSHMvZ7OLvdHPbUJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> Michael J Gruber <git@drmicha.warpmail.net> writes:
>
>>> It can be read that
>>>
>>> $ git cherry-pick maint next
>>>
>>> would pick two single commits, while
>>>
>>> $ git cherry-pick maint next ^master
>>>
>>> could implicitly be read as
>>>
>>> $ git cherry-pick maint next --do-walk ^master
>
> You can read it as "master..next maint" that does force walking.
>
>>> Clearly that's not what is intended, which is
>>>
>>> $ git cherry-pick --do-walk maint next ^master
>
> I do not see the distinction betwee the above two you seem to be
> trying to make.  Care to explain?
>
>>> but it is open to interpretation as to where in the command line the 
>>> caret
>>> range prefix's --do-walk (to countermand the --no-walk) should applied.
>
> I do not think it can be position dependent.

OK. (background, long story) When I first read the man page, and in trying 
to explain a user confusion between cherry pick commits and am'ing the same 
commits via format-patch (where sometimes the patches had coverlapping 
context issues), I was trying to confirm for myself that 'git cherry-pick B 
C' and 'git cherry-pick C B' should get the same end result, and not be 
mistaken (e.g. user misunderstanding) for a range.

I first spotted the 'git help cherry-pick's line:

<commit> - no traversal is done by default, as if the --no-walk option was 
specified, see git-rev-list(1).

So off I goes to rev-list, and see that the options no-walk/do-walk are said 
(implied) to be position dependent.

--do-walk  - Overrides a previous --no-walk.

Meanwhile the --no-walk option says:

 --no-walk - This (option) has no effect if a range is specified.

So at this point I am wondering about the command line ordering and what 
comprises the range if the negative ref is given last, or at least just 
before a --do-walk.

Thus (at this point) it felt like one of those specification rabbit-holes 
that I often see at $dayjob. It was unclear as to the point at which the 
'range' was to be applied in to the command line to get the expected 
examples.


Climbing back out of the rabbit-hole. I now see that after the end of the 
cherry-pick <commit> line I quoted, there is a secondary "Note that 
specifying a range will feed all <commit>. arguments to a single revision 
walk", which at the time did not register (a classic human error.. Three 
Mile Island et al.).

Similarly, in the rev-list --no-walk option, its says (mid-para) "This has 
no effect if a range is specified." so in some ways that confirms the cherry 
pick statement, but again a less obvious corollary.

However, there is still a small step missing, which is to confirm that using 
a negative ^ref anywhere(?) makes the whole list of refs into a range (i.e. 
it will look-back along the command line) to cancel any --no-walk options in 
place.

Given that a walk usually requires a range, I'm now having difficulty seeing 
how the --no-walk <revs> --do-walk can be combined anyway.

The bits I felt was missing (in the docs) was to say explicitly somewhere 
that a negative ref defined that we had a range (to link back to those 
walk-no-walk statements), and the extent of rev paramaters it applied to.

And after re-reading, that some of those corollary statements about ranges 
flipping the walk-no-walk condition should be brought forward to be more 
obvious within the primary rev-list (to avoid the typical reader error).


>     Philip probably has a
> confused notion that "rev-list A..B C..D" is somehow a union of set
> A..B and C..D?

That wasn't the issue. Though it does beg the question that it's the same as 
"rev-list D B ^A ^C" isn't it?

>
>>> If the user did want just the single commit at the tip of maint, and 
>>> then
>>> the range master..next, what would be their command line, and also, how
>>> would the man page warn against false expectations?
>
> Yeah, this can show us that all of the have is coming from that
> exact confusion I suspected Philip has.  We need to clarify in the
> documentation that rev-list set operation does *NOT* have union of
> multiple sets to unconfuse the readers.

I'd say it was the walk - no walk range confusion. Inclusion of any range 
definition of any sort (in particular ^rev) causes the expectation that an 
ordered list of single revs can be included, to be broken.
i.e. cherry-pick B D F G Q..T;  isn't B D F G R S T, is it?

I've also have a quick browse of the test scripts and didn't see any tests 
that actually cover the example of `git cherry-pick maint next ^master` 
where both have multiple commits to pick, so couldn't see what the test 
would expect.

--
Philip

