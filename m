Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B85520899
	for <e@80x24.org>; Wed, 23 Aug 2017 17:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932394AbdHWR5K (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 13:57:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55886 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932111AbdHWR5K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 13:57:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 21DD2A54F8;
        Wed, 23 Aug 2017 13:57:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/pafEXN2qtKOPZ/owPa6jAJszFU=; b=jgABMk
        9I8EYJeKBOXLgfbtKwGI40IXy/xd4iS6kn8UUTxtEPSdJ3VovZXkcnJXa0IzhoLa
        VYUmVKhnMeEFFdZYlINUb5P34C56rhpnkTov5qfU8DF3MHmzHU7IxBvokOQ1xTdi
        prNsPb38sLzuxb8d8LY8+Sp1j72Z3SWaiWxM8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=r/Xs86mwvF8kfO/fAYghHdbZymqxCGgy
        bxA5a27exl6nHL5nBT+DFja+oftIBDbvEtT5wC6lERFpb0vw2thPC9HJcPNMXfk2
        3vhgjJPeJgyCrurqfhHfccx00RJcNLeS6XgvV97tsJ+eOlDPEq2X51VHW6wb+kYl
        yjQQxgLSoyo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 193BEA54F7;
        Wed, 23 Aug 2017 13:57:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 73500A54F6;
        Wed, 23 Aug 2017 13:57:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: sequencer status
References: <8e25c42f-80f2-e0d4-38e4-b4fe9c8074e0@morey-chaisemartin.com>
Date:   Wed, 23 Aug 2017 10:57:07 -0700
In-Reply-To: <8e25c42f-80f2-e0d4-38e4-b4fe9c8074e0@morey-chaisemartin.com>
        (Nicolas Morey-Chaisemartin's message of "Wed, 23 Aug 2017 10:10:49
        +0200")
Message-ID: <xmqqshgiyxos.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B3156FA-882C-11E7-99FB-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com> writes:

> Two questions:
> - Could this be a candidate for contrib/ ?
> - Would it be interesting to add the relevant code to sequencer.c
> so that all sequencer based commands could have a --status option

I actually think we would want a "git sequencer" command, which can
be fed an arbitrary instruction sheet created by a third-party and
told to "run" it.  A new command $cmd that wants to rewrite history
(like "rebase -i", "cherry-pick A..B", etc. do) can only concentrate
on preparing the sequence of instructions and then internally invoke
"git sequencer run" until it gives the control back to the end user.
When the user tells $cmd to continue, it can relay that request to
"git sequencer continue" under the hood.  

Once its use is established, it might be even possible to let users
run "git sequencer continue", bypassing frontends for individual
commands, e.g. "git cherry-pick --continue", etc., but I do not know
if that is generally a good idea or not.  In any case, having such a
front-end will help third-party scripts that want to build a custom
workflow using the sequecing machinery we have.

And in such a world, we would need "git sequencer status" command
to give us where in a larger sequence of instrutions we are.  

So I tend to think this should be part of the core, not contrib/,
and should become part of a new command "git sequencer".
