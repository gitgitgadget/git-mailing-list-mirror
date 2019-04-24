Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B73E1F453
	for <e@80x24.org>; Wed, 24 Apr 2019 22:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfDXWrK (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 18:47:10 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:37086 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbfDXWrI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 18:47:08 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id D2ACE3C00D1;
        Thu, 25 Apr 2019 00:47:04 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1zLCOq6g4p26; Thu, 25 Apr 2019 00:46:57 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id A47683C0034;
        Thu, 25 Apr 2019 00:46:57 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 25 Apr
 2019 00:46:57 +0200
Date:   Thu, 25 Apr 2019 00:46:54 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
CC:     <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Julia Lawall <julia.lawall@lip6.fr>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH 2/2] diffcore-pickaxe: add --pickaxe-raw-diff for use
 with -G
Message-ID: <20190424224539.GA23849@vmlxhi-102.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o94vs9cp.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar,

Thanks for the amazingly fast reply and for the useful feature (yay!).

On Wed, Apr 24, 2019 at 05:37:10PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Apr 24 2019, Ævar Arnfjörð Bjarmason wrote:
> 
> > Add the ability for the -G<regex> pickaxe to search only through added
> > or removed lines in the diff, or even through an arbitrary amount of
> > context lines when combined with -U<n>.
> >
> > This has been requested[1][2] a few times in the past, and isn't
> > currently possible. Instead users need to do -G<regex> and then write
> > their own post-parsing script to see if the <regex> matched added or
> > removed lines, or both. There was no way to match the adjacent context
> > lines other than running and grepping the equivalent of a "log -p -U<n>".
> >
> > 1. https://public-inbox.org/git/xmqqwoqrr8y2.fsf@gitster-ct.c.googlers.com/
> > 2. https://public-inbox.org/git/20190424102609.GA19697@vmlxhi-102.adit-jv.com/
> 
> I see now once I actually read Eugeniu Rosca's E-Mail upthread instead
> of just knee-jerk sending out patches that this doesn't actually solve
> his particular problem fully.
> 
> I.e. if you want some AND/OR matching support this --pickaxe-raw-diff
> won't give you that, but it *does* make it much easier to script up such
> an option. Run it twice with -G"\+<regex>" and -G"-<regex>", "sort |
> uniq -c" the commit list, and see which things occur once or twice.
> 
> Of course that doesn't give you more complex nested and/or cases, but if
> git-log grew support for that like git-grep has the -G option could use
> that, although at that point we'd probably want to spend effort on
> making the underlying machinery smarter to avoid duplicate work.

Purely from user's standpoint, I feel more comfortable with `git grep`
and `git log --grep` particularly b/c they support '--all-match' [2],
allowing more flexible multi-line searches. Based on your feedback, it
looks to me that `git log -G/-S` did not have a chance to develop their
features to the same level.

> 
> Furthermore, and quoting Eugeniu upthread:
> 
>     In the context of [1], I would like to find all Linux commits which
>     replaced:
>     	'devm_request_threaded_irq(* IRQF_SHARED *)'
>     by:
>     	'devm_request_threaded_irq(* IRQF_ONESHOT *)'
> 
> Such AND/OR machinery would give you what you wanted *most* of the time,
> but it would also find removed/added pairs that were "unrelated" as well
> as "related". Solving *that* problem is more complex, but something the
> diff machinery could in principle expose.

I expect some false positives, since git is agnostic on the language
used to write the versioned files (the latter sounds like a research
topic to me - I hope there is somebody willing to experiment with that
in future).

> 
> But the "-G<regex> --pickaxe-raw-diff" feature I have as-is is very
> useful, 

I agree. I am a bit bothered by the fact that
`git log --oneline -Ux -G<regex> --pickaxe-raw-diff` outputs the
contents/patch of a commit. My expectation is that we have the
`log -p` knob for that?

> I've had at least two people off-list ask me about a problem
> that would be solved by it just in the last 1/2 year (unrelated to them
> having seen the WIP patch I sent last October).
> 
> It's more general than Junio's suggested --pickaxe-ignore-{add,del}

As a user, I would be happier to freely grep in the raw commit contents
rather than learning a dozen of new options which provide small subsets
of the same functionality. So, I personally vote for the approach taken
by --pickaxe-raw-diff. This would also reduce the complexity of my
current git aliases and/or allow dropping some of them altogether.

Quite off topic, but I also needed to come up with a solution to get
the C functions modified/touched by a git commit [3]. It is my
understanding that --pickaxe-raw-diff can't help here and I still have
to rely on parsing the output of `git log -p`?

> options[1], but those could be implemented in terms of this underlying
> code if anyone cared to have those as aliases. You'd just take the
> -G<regex> and prefix the <regex> with "^\+" or "^-" as appropriate and
> turn on the DIFF_PICKAXE_G_RAW_DIFF flag.
> 
> 1. https://public-inbox.org/git/xmqqwoqrr8y2.fsf@gitster-ct.c.googlers.com/

Thanks!

[2] https://gitster.livejournal.com/30195.html
[3] https://stackoverflow.com/questions/50707171/how-to-get-all-c-functions-modified-by-a-git-commit

-- 
Best regards,
Eugeniu.
