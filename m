Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01BD720A40
	for <e@80x24.org>; Sun,  3 Dec 2017 05:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751851AbdLCFPd (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 00:15:33 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59048 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750718AbdLCFPc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 00:15:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9195CBAACD;
        Sun,  3 Dec 2017 00:15:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WSflBN2PV9RpRmufW3jxDLvD2/g=; b=ZE2EjX
        zXnGesgSOHLA+MLDaF560iHswcFjV38piFCYm3cez18wJANNrUBSyPVYiwgYkdHu
        QY+V2VPkDglwEhEC8bH7QtELpyRsKrLyDkf4FhUao5rm09zSOLfGAzfjP3itEhzc
        S3P0VysEZWVlR0O5z3ZWgAgYecMER/nhXdUJo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pQ8tRTJOXYHGJYHzBTRLVOw3GnCG7/hT
        UHhZjfYolDXR6a3ZG7+oX3YT0EOmJpB3NJ/oy216qmL8vNaqwk6n2ZDfYa5V1ZqC
        x9QxCps+g1eIjwzuGG9k/yWMjB0Ts8smtx45T30nUPAaw+RVZJbA63TQvHshEP3I
        FrquEzt+9rI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 87138BAACC;
        Sun,  3 Dec 2017 00:15:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E35E1BAACA;
        Sun,  3 Dec 2017 00:15:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org,
        sbeller@google.com, sunshine@sunshineco.com,
        kaartic.sivaraam@gmail.com, sandals@crustytoothpaste.net,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v4 2/2] launch_editor(): indicate that Git waits for user input
References: <20171129143752.60553-1-lars.schneider@autodesk.com>
        <20171129143752.60553-3-lars.schneider@autodesk.com>
        <20171130205137.GC3313@sigill.intra.peff.net>
Date:   Sat, 02 Dec 2017 21:15:29 -0800
In-Reply-To: <20171130205137.GC3313@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 30 Nov 2017 15:51:37 -0500")
Message-ID: <xmqqvahojssu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB837E9E-D7E8-11E7-BFCE-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I tried to think of ways this "show a message and then delete it" could
> go wrong. It should work OK with editors that just do curses-like
> things, taking over the terminal and then restoring it at the end.
> ...

I think that it is not worth to special-case "dumb" terminals like
this round of the patches do.  If it so much disturbs reviewers that
"\e[K" may not work everywhere, we can do without the "then delete
it" part.  It was merely trying to be extra nice, and the more
important part of the "feature" is to be noticeable, and I do think
that not showing anything on "dumb", only because the message cannot
be retracted, is putting the cart before the horse.  

Since especially now people are hiding this behind an advise.*
thing, I think it is OK to show a message and waste a line, even.

> An even worse case (and yes, this is really reaching) is:
>
>   $ GIT_EDITOR='echo one; printf "two\\r"; vim' git commit
>   hint: Waiting for your editor input...one
>   Aborting commit due to empty commit message.
>
> There we ate the "two" line.

Yes, I would have to agree that this one is reaching, as there isn't
any valid reason other than "the editor then wanted to do \e[K
later" for it to end its last line with CR.  So our eating that line
is not a problem.
