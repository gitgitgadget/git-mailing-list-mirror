Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA0462042F
	for <e@80x24.org>; Wed, 16 Nov 2016 23:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937085AbcKPXob (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 18:44:31 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60455 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S936584AbcKPXob (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 18:44:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8AA3051B35;
        Wed, 16 Nov 2016 18:44:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8SxKPwMwovmzcuZq62QvD2S6RXk=; b=Um5oBF
        N9wnn9VCrTzMnl+ty2nqCW8jTcSmJ9N6+9RuWhkdrbuAkXWIOH0LEqT6Uod0ZgJp
        4xMvxyyl5AXG+SABuHDdnl5+U8PsAqnrDYXOrNwn6vp1mC3P2gp5+HwWRrYjSbpl
        BTdqHUN1ywfe4JEYBKZ6aaVKbw5HIqVVviORA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OrDkm3DQlIWNTtY2y0W9YEMsk68m/tB1
        d8cC3dQci4pEByabpEn87inEHy5nzZLSZEFsoEdLuRbNfUE20b/owXYKXjbAeh3y
        ACpdwrIVXMIt7CRHGeUJg1azs+6hlghnO8V9vcFFBl0Ak1jVebGrUi4VTv12svEr
        OhVcYgtkdfE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 826AF51B34;
        Wed, 16 Nov 2016 18:44:29 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 01AE151B33;
        Wed, 16 Nov 2016 18:44:28 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Norbert Kiesel <nkiesel@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Rebasing cascading topic trees
References: <CAM+g_Nsiu_qqapB+FvwJCBfwEYLTPdHg4DueQWHq4XDNXMCgpQ@mail.gmail.com>
Date:   Wed, 16 Nov 2016 15:44:27 -0800
In-Reply-To: <CAM+g_Nsiu_qqapB+FvwJCBfwEYLTPdHg4DueQWHq4XDNXMCgpQ@mail.gmail.com>
        (Norbert Kiesel's message of "Wed, 16 Nov 2016 15:39:40 -0800")
Message-ID: <xmqq7f83ouqs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D749BC6-AC56-11E6-B595-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Norbert Kiesel <nkiesel@gmail.com> writes:

> I currently have a situation with cascading topic branches that I need to rebase
> regularly.  In the picture below, I want to rebase the tree starting with `E` to
> be rebased onto master (my actually cascade is 4 branches deep).
>
> A--B--C--D (master)
>    \
>     E--F (topic1)
>        \
>         G--H (topic2)
>
> After running `git rebase --onto master master topic1`, I end up with
>
> A--B--C--D (master)
>    |     \
>    \      E'--F' (topic1)
>     E--F
>        \
>         G--H (topic2)
>
> I then need to also run `git rebase --onto topic1 F topic2` to arrive at the
> desired
>
> A--B--C--D (master)
>    |     \
>    \      E'--F' (topic1)
>     E--F      \
>        |       G'--H' (topic2)
>        \
>         G--H
>
> Problem here is that I don't have a nice symbolic name for `F` anymore after the
> first rebase. Rebasing `topic2` first is not really possible, because I do not
> have a new graft-point yet.  I currently write down `F` ahead of time (or use
> `reflog` if I forgot) `F`, but I wonder if there is a better solution.

Doesn't topic1@{1} point at "F" after the rebase of the topic1
finishes?

