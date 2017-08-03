Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7E121F991
	for <e@80x24.org>; Thu,  3 Aug 2017 17:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751238AbdHCRTx (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 13:19:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53345 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751133AbdHCRTw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 13:19:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 119E2AF7E7;
        Thu,  3 Aug 2017 13:19:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5oeU8JPkBvraBIlXm1JOErEg8t0=; b=fWtEF7
        8M4cJzoyxk7kJC2wAjjgmr+zUNb+YSNVW54HE0tDouA48AmlD1CYZMCER5T0vN9d
        31SoSSNBE6QI1YHmOLtzL2Mge7QbCJAKPGBP3tffBgRbW5VLOH9k+4/PIeyEIU2A
        kk2HwCZA7RhSKMhAuuhAwAlMhlQDThSypWtts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nTjNxzSv8FxQ25O6We384al35ln6w+9V
        BKAImHTlMyQykZtxIaf3/3EUT8FdZh1etcZxfjuBHXtGrtBrEZuGMNyY77NxFVfo
        Le/Q+fFEtwntEWjA7kwV/B3pLYRkC07iUzy8nQaYuw7Rlld5bap2atRNEBv1kEAI
        CXPP0VSbHNo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 06953AF7E6;
        Thu,  3 Aug 2017 13:19:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6637CAF7E4;
        Thu,  3 Aug 2017 13:19:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 6/6] cherry-pick/revert: reject --rerere-autoupdate when continuing
References: <20170802104420.12809-1-phillip.wood@talktalk.net>
        <20170802104420.12809-7-phillip.wood@talktalk.net>
        <xmqqpocdr5tu.fsf@gitster.mtv.corp.google.com>
        <xmqqlgn1r4bu.fsf@gitster.mtv.corp.google.com>
        <6a7c9661-9f12-99c9-1fc1-4a4abd3d0660@talktalk.net>
Date:   Thu, 03 Aug 2017 10:19:41 -0700
In-Reply-To: <6a7c9661-9f12-99c9-1fc1-4a4abd3d0660@talktalk.net> (Phillip
        Wood's message of "Thu, 3 Aug 2017 11:15:48 +0100")
Message-ID: <xmqqy3r0po0i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F02DF822-786F-11E7-9D29-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> On 02/08/17 23:29, Junio C Hamano wrote:
> ...
>> The
>> latter makes it more in line with how "am -3" followed by "am --no-3
>> --continue" behaves.
>
> I'm a bit confused about what am does when you pass extra options to
> --continue. It looks like they do not persist if there's another
> conflict and may only apply to the first patch that is applied when
> resuming - I'd need to spend more time looking at the code or run a test
> to be sure.

I think you got what "am" wants to do.  

The idea is that the user would say she does not trust the three-way
fallback when she starts to apply many patches in an mbox, i.e.

   $ git am mbox

Upon seeing a message that does not apply, she would examine the
patch that caused _this_ stoppage, and then decide that it is safe
to apply _this_ patch (but not necessarily later ones) with
three-way fallback and move on:

    $ git am -3 --continue

I have not thought too deeply if the parallel applies to
multi-commit pick, though.  

"am" (rather, its underlying machinery "apply") is designed to be
all-or-none, so a failed --no-3way application would leave the index
and the working tree intact.  "-3 --continue" can retry the failed
step, with "--3way" processing turned on for only one message, from
that state.

But a multi-commit cherry-pick/revert would stop _after_ it munges
the conflicted paths in the index into an unmerged state and writes
the conflicted state into the working tree files.  For "--continue
--rerere-autoupdate" to work more like "am --continue -3", it would
have to learn to reset to the state before the failed cherry-pick
first, before re-attempting the failed cherry-pick with the auto
update enabled only for the single commit and keep going.  So it may
not as trivial as "am --continue", even though it sounds doable.



