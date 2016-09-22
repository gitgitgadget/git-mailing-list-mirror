Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42EE91F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 17:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933345AbcIVRTh (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 13:19:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55048 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752210AbcIVRTg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 13:19:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B2EDE3F149;
        Thu, 22 Sep 2016 13:19:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=461RkHMDuR0UlZ8jgYPMROKx6Wg=; b=I/dd3G
        zxrvmhHeFAlYp+GCDvmkZU61vwkNfwK/WSwxUeV4rI9tDixvvu5qu6GAXbdh8hSD
        mw1aRyjSrXn8h4PDeI/UT5V9leBHl6nyLRzoxwcBNu7qnBN8qoQ4rvyjbISEEixY
        dKs2yPUC4iDhs5ua+fczTuwACCtSfQWairn10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nQIgx8R0lxb3YA90uFo4dXGtKXKak9FW
        wHa8tH8xf6IsnY0YanZ2RqaZtNynZ0JdSb39crksBOkzkt2F6LCEfrQ4mFtZdDan
        JoRughIzo2RUrppDoS4QmopEcxhwF0Yr02z46VZkb7oI1BspJHtnNaRnRRUeUiIG
        HlpFkENph0w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ABAD63F148;
        Thu, 22 Sep 2016 13:19:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2F33C3F145;
        Thu, 22 Sep 2016 13:19:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Anatoly Borodin <anatoly.borodin@gmail.com>, git@vger.kernel.org
Subject: Re: Bug: pager.<cmd> doesn't work well with editors
References: <nrmbrl$hsk$1@blaine.gmane.org> <nrmd6u$imf$1@blaine.gmane.org>
        <xmqqh99bho7a.fsf@gitster.mtv.corp.google.com>
        <20160920014733.7whjuxfuimx5ztdb@sigill.intra.peff.net>
        <xmqqponxb56a.fsf@gitster.mtv.corp.google.com>
        <20160922064730.277nzkqlxbcx2kjg@sigill.intra.peff.net>
Date:   Thu, 22 Sep 2016 10:19:32 -0700
In-Reply-To: <20160922064730.277nzkqlxbcx2kjg@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 22 Sep 2016 02:47:30 -0400")
Message-ID: <xmqqfuor6ee3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB274E3C-80E8-11E6-AB96-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I don't think it is a bad move overall. I use "pager.log" to pipe
> through a specific command (that is different than I would use for other
> commands).
>
> So I like the idea of configurability; the problem is just that it is
> happening at the wrong level.

The level at which configurability happens might be one issue
(i.e. you may want different pager for two operating modes for the
same command, hence your need to use "tag.list" not just "tag"), but
I think another issue is that it conflates if the output need to be
paged (on/off) and what pager should be used when the output is
paged.  When we see that a user sets "pager.tag", we should not have
made it an instruction to Git that _all_ output from "git tag" must
be paged.

If there were no need for supporting separate pagers per operating
mode of a Git command, say "git tag", you would not want to page the
output unless you are producing "git tag [-l]" listing.  You do not
want your interaction with the usual "git tag <name> [<an object>]"
to be paged, even if you want to use a pager different from GIT_PAGER
when you are viewing the tags.

It is good that each codepath can give default in this example

> The individual commands should be in
> charge of it, with something like:
>
>   setup_auto_pager("log", 1);
> ...
>   if (mode_list)
> 	  setup_auto_pager("tag.list", 0);

as the second parameter to setup_auto_pager(), but I think the first
parameter being "tag.list" vs "tag" is a separate issue.  Until
there comes another codepath in "git tag" that wants to call
setup_auto_pager(), it does not make any difference from the end-user's
point of view.  Starting with "tag.list" may futureproof it
(e.g. perhaps somebody wants to use a separate pager for "git tag --help"
and "tag.help" can be added without disrupting existing use of "tag.list")

So I think we are fundamentally on the same page; it is just you are
aiming higher than I was, but we both recognize the need for separate 
codepaths in a single command to decide if the output should be paged.

> I don't have a particular plan to work on it anytime soon, but maybe
> somebody could pick it up as relatively low-hanging fruit.

;-)
