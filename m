Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE8B420899
	for <e@80x24.org>; Thu, 17 Aug 2017 20:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753246AbdHQUiq (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 16:38:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56114 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753195AbdHQUip (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 16:38:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 77AB28F9F2;
        Thu, 17 Aug 2017 16:38:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KcmTF5uENnkPreIveATXEY64qp4=; b=bOcflk
        jGE/n2kzcH4D29r60eXnr+C2FbgXfa0PrYV2S88TWBsSEp28S2VOpXBXL63LRznX
        ng8T5La/yEIkhUGFXaeQNt7hM2kU4sLf18rcFuIzhfiFQtLtVGCj2qNGvI45eGOM
        5lezn9vIxt0Vsf571wHCV9Yyc00xWv3kgbzWg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QM4FZDeQqJBnwBFO8MaCyTwzfdYEcqO6
        7Ra4FG33Qpss5GgLqXr6hLduKnh8jPBT9PTo250TBGnmXsxbE/xJzcXRnDHWApfZ
        VJRFeikGLP3rAQM3YAYGi2Hz1rGFBFfNW5bI1COxiUIrXW7xofsZufSqSsncjQOg
        ukh1nxuQiws=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E6418F9F0;
        Thu, 17 Aug 2017 16:38:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D48778F9EF;
        Thu, 17 Aug 2017 16:38:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     Jeff King <peff@peff.net>,
        "Carlsson\, Magnus" <Magnus.Carlsson@arris.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git fetch with refspec does not include tags?
References: <1502960406180.9006@arris.com> <1502960572292.1402@arris.com>
        <20170817092853.hteuzni5lxia4ejf@sigill.intra.peff.net>
        <xmqq1soagf1p.fsf@gitster.mtv.corp.google.com>
        <20170817202257.GC3839@alpha.vpn.ikke.info>
Date:   Thu, 17 Aug 2017 13:38:36 -0700
In-Reply-To: <20170817202257.GC3839@alpha.vpn.ikke.info> (Kevin Daudt's
        message of "Thu, 17 Aug 2017 22:22:57 +0200")
Message-ID: <xmqqk222expv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0C0C09A4-838C-11E7-A4B8-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Daudt <me@ikke.info> writes:

> On Thu, Aug 17, 2017 at 12:38:58PM -0700, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>> 
>> >   # no tags, we just populate FETCH_HEAD because of the bare URL
>> >   git fetch ../parent
>> >
>> >   # this does fetch tags, because we're storing the result according to
>> >   # the configured refspec ("refs/heads/*:refs/remotes/origin/*").
>> >   git fetch origin
>> 
>> The above two look good.
>> 
>> >   # this doesn't fetch tags, as the main command is "just" populating
>> >   # FETCH_HEAD. But then our logic for "hey, we fetched the ref for
>> >   # refs/remotes/origin/master, so let's update it on the side" kicks
>> >   # in. And we end up updating FETCH_HEAD _and_ the tracking branch, but
>> >   # not the tags. Weird.
>> >   git fetch origin master
>> 
>> Yes, it looks weird, but I suspect that it is probably more correct
>> not to fetch tags in this case.  I wonder if it would be a solution
>> not to do the "on the side" thing---after all the user didn't tell
>> us to update refs/remotes/origin/master with this command line.
>
> Isn't that how git fetch used to behave, or am I misunderstanding what
> you mean? It used to be that git fetch <remote> <branch> would not
> update any remote tracking branches.
>
> From the 1.8.4 release notes:
>
>> "git fetch origin master" unlike "git fetch origin" or "git fetch"
>> did not update "refs/remotes/origin/master"; this was an early
>> design decision to keep the update of remote tracking branches
>> predictable, but in practice it turns out that people find it more
>> convenient to opportunistically update them whenever we have a
>> chance, and we have been updating them when we run "git push" which
>> already breaks the original "predictability" anyway.

No, you are not misunderstanding anything.  The "pretend that we
immediately turned around and fetched" done by "git push" was
already breaking the predictability, but the change in 1.8.4 made it
even worse.  I am saying that going back to the old behaviour may be
one option to address the issue being discussed in this thread.

