Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 892641F859
	for <e@80x24.org>; Wed, 31 Aug 2016 19:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759000AbcHaTC5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 15:02:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57590 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753198AbcHaTC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 15:02:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D4A39371EB;
        Wed, 31 Aug 2016 15:01:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z+5fG1w4+UmnPxrxkln6b11I93c=; b=BUtSDi
        6vhRsAUc4I8J+Nl3GZxj3qrbE8fMlhLlcLjzAOOkm9wBU0B8CC8pvPlzy1VxQPGu
        ET5D6281tE7GzMxpZxcPUPtJkAiBNsSUW8ab9AyZMhlGnJK5BHhpFmMut4VP8/o7
        HnKi7D4pIiLIsE04awvXq5EvN/rmhJrG9Z+Tc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RUxrT6XXkxAvKcrbEiSPE1Coxc76ZNDS
        TJrVYO0/tXMCAFSehmscHF7EPAC0NM0JYAlcKjEbLw3BywyBYqCn9agr0X3zubGA
        qVYaVHnTj65wp/dSJS9P8n0ikKjXUJbsfwzrL+b90ktEtp9iZl+Znq4Z19++S6cu
        qZQhpmwFv5U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CD34B371EA;
        Wed, 31 Aug 2016 15:01:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 53F2F371E5;
        Wed, 31 Aug 2016 15:01:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 08/22] sequencer: remove overzealous assumption
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
        <3c8c60e0799fdf176c72e7e17c257d33b2a362bc.1472457609.git.johannes.schindelin@gmx.de>
        <09fd1436-301a-b0e1-c32a-81a47e4eb351@gmail.com>
        <alpine.DEB.2.20.1608311706400.129229@virtualbox>
Date:   Wed, 31 Aug 2016 12:01:31 -0700
In-Reply-To: <alpine.DEB.2.20.1608311706400.129229@virtualbox> (Johannes
        Schindelin's message of "Wed, 31 Aug 2016 20:36:32 +0200 (CEST)")
Message-ID: <xmqqd1ko225w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 555D622C-6FAD-11E6-9556-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The problem is that the `git-rebase-todo` most definitely does *not* want
> to be restricted to a single command.

Looking at the test in question, it is about what happens when "git
cherry-pick A..B" runs, and the test assumes it gets a sequence of
"pick".  It would be a bug to see any "revert" in there if you are
doing a multi cherry-pick.

And what is checked is if "cherry-pick --continue" notices a
malformed instruction that has something other than "pick".

If the final invocation were "sequencer --continue", then I
perfectly well understand why it is not a good idea to limit the set
of instructions only to "pick" (or "revert").  But I do not think
the test performed here is for that general case.  The user knows
Git stopped in the middle of cherry-pick and expects cherry-pick to
continue.

> So if you must have a patch that disagrees with this overzealous check,
> the "revamp todo parsing" one is probably the first. But it is better to
> think of this at a higher level than just patches: it is wrong to limit
> the todo script to contain only identical commands.

So if you think of this at even higher level, the check done in
parse_insn_line() that _assumes_ that opts->action must match the
actions on each line is _WRONG_, but what this test expects to see
is perfectly reasonable, I would think.

It is a different matter if it makes sense to _verify_ that the user
didn't make nonsensical change to the generated insn and error out
when s/he did.  I tend to think it is pointless, and I wouldn't object
if this test is removed due to that reason.

