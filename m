Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 706A91F462
	for <e@80x24.org>; Thu, 20 Jun 2019 03:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731322AbfFTDky (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 23:40:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63831 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfFTDky (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 23:40:54 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D91C2168B66;
        Wed, 19 Jun 2019 23:40:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BgKlAWWQ7Z2XJZ+oHGoDvN7DUEQ=; b=cFT0r+
        MeNkCym90Y5cOgmFQ/CkGwQVr6ODUIEHAENli0bQg0FTAXptS7j3MG0Ff0PLa8Pg
        wN8k27zuIPrWCu906qMR5MQeGQomddLcvV/MpwCq+hcj51dawn1w9IGc0DTJ/bRm
        E27ikT2nsHjKQoCdui3cV0GyA/l5PiTXihdws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=outcMr2f+e7IBMrPrvcHDMLyQ+4VJdpt
        DM6YauEYZtMsenOUUHgeeJMCXaLeyJXAF+ScbVUp32HdoteEs3mECx4NtUv2Z1zM
        EzO9qlF2ZShyMH4NrjCfOQugcvofzN2DPoXJF1g1gULU+dbvj55ArR5u4yp5XdTr
        lxjO2wIB7qY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CDA5F168B65;
        Wed, 19 Jun 2019 23:40:51 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4019E168B64;
        Wed, 19 Jun 2019 23:40:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        phillip.wood123@gmail.com, martin.agren@gmail.com,
        jrnieder@gmail.com
Subject: Re: [GSoC][PATCH v5 4/5] cherry-pick/revert: add --skip option
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
        <20190618170650.22721-1-rohit.ashiwal265@gmail.com>
        <20190618170650.22721-5-rohit.ashiwal265@gmail.com>
Date:   Wed, 19 Jun 2019 20:40:50 -0700
In-Reply-To: <20190618170650.22721-5-rohit.ashiwal265@gmail.com> (Rohit
        Ashiwal's message of "Tue, 18 Jun 2019 22:36:49 +0530")
Message-ID: <xmqqr27oq5z1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 331B7E66-930D-11E9-BCCF-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:

> +give_advice:
> +	advise(_("have you committed already?\n"
> +		 "try \"git %s --continue\""),
> +		 action == REPLAY_REVERT ? "revert" : "cherry-pick");
> +	return error(_("there is nothing to skip"));
> +}

Two comments.

The places touched by patch 1/5 emitted the error followed by an
advice message; this new one breaks the pattern by giving the "hint:"
first and then error.  Be consistent by swapping these two (and
return -1, as "error() that returns -1" will no longer be the last
thing executed in this function.

This one, and the in_progress_advice emitted from the patch 1/5, are
both bad in that they make calls to advise() without guarding it
with an advice.* configuration variable. This does not allow the
user to say say "I've learned this part of Git enough; do not tell
me verbosely."

Pick a random global variable that is defined near the top of
advice.c, and learn how they are set (to true by default, allowing
configuration to flip it off) and how they are used in order to
prevent a call to advise() getting made.  Then mimick that to guard
these calls to advise().

Thanks.
