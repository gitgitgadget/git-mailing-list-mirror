Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E9591F461
	for <e@80x24.org>; Thu, 11 Jul 2019 18:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbfGKSzQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 14:55:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55958 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfGKSzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 14:55:16 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5965E164184;
        Thu, 11 Jul 2019 14:55:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Dci7PeQVfezq89HA+epcuyXQ044=; b=CQgnCe
        PEnd3LIsoKTHsDA5cldPCVkwFz2mZcywNaeB3/EVPUKaQ7eU8XeTglM7ZW3Ssrba
        kTLFrTAb+kLk3uq4ioC0G4m+JUFoWDtRK1wIGTxaXIXYQe3FXF4RpvhhXqWa6FZq
        w19CX2eCm8P2DNhPRuNDQVyolNyP1Vhcjqo1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xDUFls/eP49bKh5US1HwRnVGFQUaJ+X2
        3pCJvG13g39FMxTptPPLpo7hXyAcWwfjQl51+1mrf4sVO7HmtgULqiuwwykJvR9r
        /nGWjsHPB+vooYRxSqDCXAPCgtnNyrNSEGtQO9DWb3kILhDhiqQ5iASPRt1H+zra
        TliYzUfK6QA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 52960164182;
        Thu, 11 Jul 2019 14:55:11 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AD55C164181;
        Thu, 11 Jul 2019 14:55:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     paulus@samba.org, max@max630.net, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] gitk: fix --all behavior combined with --not
References: <20190704080907.GA45656@book.hvoigt.net>
        <xmqq4l3wz6y8.fsf@gitster-ct.c.googlers.com>
        <xmqqr26zx0wr.fsf@gitster-ct.c.googlers.com>
        <xmqqk1crwzwd.fsf@gitster-ct.c.googlers.com>
        <20190710075835.GB65621@book.hvoigt.net>
        <xmqqa7dlu40d.fsf@gitster-ct.c.googlers.com>
        <20190711122452.GC65621@book.hvoigt.net>
Date:   Thu, 11 Jul 2019 11:55:09 -0700
In-Reply-To: <20190711122452.GC65621@book.hvoigt.net> (Heiko Voigt's message
        of "Thu, 11 Jul 2019 14:24:52 +0200")
Message-ID: <xmqq7e8os8oi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 688F3586-A40D-11E9-ADA0-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heiko Voigt <hvoigt@hvoigt.net> writes:

>      if {$revs eq {}} {
>         set revs HEAD
> -    } elseif {[lsearch -exact $revs --all] >= 0} {
> -       lappend revs HEAD
> +    } else {
> +       linsert revs 0 --all-include-head
>      }

OK.  So the new option means "from here on, the meaning of the
'--all' option changes its meaning from 'all refs' to 'all refs and
HEAD'".  That way, gitk does not have to guess if '--all' found on
the command line is an option or something else (e.g. pathspec etc.)

That makes sense.  It would be a no-op if '--all' is not used, which
is also good.

>> To put it the other way around, what use case would we have that we
>> want to enumerate all refs but not HEAD, *and* exclude HEAD only
>> when HEAD is detached?  I can see the use of "what are commits
>> reachable from the current HEAD but not reachable from any of the
>> refs/*?" and that would be useful whether HEAD is detached or is on
>> a concrete branch, so "rev-parse --all" that does not include
>> detached HEAD alone does not feel so useful at least to me.
>
> What about my example. My use case is: Show me everything that is not merged
> into a stable branch (i.e. origin/master). For a human viewer it does not
> really matter if an extra detachted HEAD is shown, but for a CI script it
> might. Ok this might be quite artificial, what do you think?

That is, to drive "gitk --all ^origin/master"?  If HEAD is detached,
isn't the history that leads to it something that is "not merged
into a stable branch", too?  IOW, I think you would want the same
behaviour as "git log --all ^origin/master" for that use case, and
treat HEAD just like any of the refs.

Back in the days, detached HEAD was mostly tentative state, but
these days, especially for those who use submodules, wouldn't it be
a norm to have your checkout associated with a detached HEAD?  I
think treating (detached) HEAD just like any of the refs matches
the end-user expectations even more these days.

>> I am reasonably sure that back when "rev-parse --all" was invented,
>> the use of detached HEAD was not all that prevalent (I would not be
>> surprised if it hadn't been invented yet), so it being documented to
>> enumerate all refs does not necessarily contradict to include HEAD
>> if it is different from any of the ref tips (i.e. detached).
>
> I just dug up the old discussion to this to find some reasoning why this was
> not changed. So you have changed your mind about this? [1]

Yup.  See above.  I think the time has changed the needs.

Thanks.
