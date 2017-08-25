Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95F48208DB
	for <e@80x24.org>; Fri, 25 Aug 2017 15:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933556AbdHYPQt (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 11:16:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55599 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933541AbdHYPQs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 11:16:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EA9169B77B;
        Fri, 25 Aug 2017 11:16:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jrTQcpn7QsmxM/Pz2xWK/C/DG08=; b=nOVG1y
        VnDxQ7U3OapCBOmroj3KFrBzeAO37coFuUPe+RkAevRZJ4akQl86yuyP6Fic52xI
        Z4/xmrNmMnZzVL7MvDiSIjdyhNOGqIszC12VGRNsBH6zbpCQL+qTp+uRtqjSLVfb
        LwU7jQH68UzbRHJ5PsN5tDFK9HiiK5pw/9Eao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eueRr+pIRWhONdUSmd0mRXG47ndaF1Yg
        IEuC8z4htkkaV987MQQDJ3K+vDF2OjNXJJwrAy3uIZg1kdN7J90QBaBW1SOqfgL4
        U2E7HqoSSHGYRzPXVrAuve01R7dfzcsUSDLce7w2oAdusd/fnNSzLjVdq3SKeF+7
        YU53hCnZJ30=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E2FDE9B77A;
        Fri, 25 Aug 2017 11:16:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3F6AF9B778;
        Fri, 25 Aug 2017 11:16:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin Langhoff <martin.langhoff@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Should rerere auto-update a merge resolution?
References: <CACPiFCJH7RSb_rz6M6ADuGi0q+oeWYhE1fNMQC0EUcCn_kCJwg@mail.gmail.com>
        <xmqqlgmaxbuc.fsf@gitster.mtv.corp.google.com>
        <CACPiFCJCgKtTbKX8jCSC3QgMKZ7Usu2ojqXe5w_QAHwk7T4M-A@mail.gmail.com>
Date:   Fri, 25 Aug 2017 08:16:44 -0700
In-Reply-To: <CACPiFCJCgKtTbKX8jCSC3QgMKZ7Usu2ojqXe5w_QAHwk7T4M-A@mail.gmail.com>
        (Martin Langhoff's message of "Wed, 23 Aug 2017 17:12:04 -0400")
Message-ID: <xmqqwp5ru17n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 68BC86CA-89A8-11E7-9178-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Langhoff <martin.langhoff@gmail.com> writes:

>  - when I tell it to forget, won't it forget the pre-resolution state?

I do not recall the details of what I did ;-) so I played around a
bit.  Here is what I did:

	git checkout master^0
	git merge --no-ff --no-edit pb/trailers-from-command-line
	git merge --no-ff --no-edit jk/trailers-parse

I know that the last one I know gets conflict and triggers rerere
to replay the recorded resolution.  Imagine that I earlier botched
resolution and the working tree contents is wrong or something at
this point.

	make test ;# fails, perhaps

So I can do:

	git rerere forget <path>

After git rerere forget, I observe (check subdirectories in
.git/rr-cache/ whose timestamps are recent) that postimage gets
removed but preimage and thisimage stay.

I can then edit that file, and say "git rerere" again, which is
greeted by "Recorded resolution for '<path>'".

I do not recall if I designed it that way or not, but it even seems
to work correctly if you had "git add -u" after the botched auto
application (i.e.  between the "make test" step and "rerere forget"
step in the above sequence).  I never do "add -u" myself before
testing so I didn't notice.

If you want to _see_ the conflicts again while fixing a botched
resolution, then you'd need to do a bit more involved recovery.
After seeing "make test" fail and realize your older resolution is
botched, you'd probably do:

	git checkout -m <path>

to unmerge, "rerere forget <path>", fix the botched resolution and
then finally "rerere" to record the correction.

