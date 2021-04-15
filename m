Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9C4C433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 20:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC51761131
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 20:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbhDOUck (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 16:32:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58491 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbhDOUcj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 16:32:39 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CF220C79B6;
        Thu, 15 Apr 2021 16:32:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MfOIgw29ywQhX0XroExUONu6GdE=; b=CG95JL
        4kcsaGgo34TrJjRqpPw+0tNUiTHhCibd1mFTVVrHX/0YNZhq5yS+wUINNlgpm/d5
        Pvg0s8q5neDrri/ld3qelW/YfS7BJ6KB1B00+Cpm5IUWXoy6R5g/8QiPS3e+xS56
        rx9O3WUS3Jfxkp5b/MaVoECsld3hwOs8uHrK0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NR6M4RK/TJZ0mawOAw7BwZ0HueinPpyh
        a2qe9VD4zEw+a+TrJndm5pdMknmeARp9ChPAA9NL493mSqciyuhC/y99yenZof+s
        U1NNaQF9BonjDLkyssWaWCmq/VujoGXSwzEaAHhaf7PkMgtg32JANNpqqQL5dvwX
        jgKd3RxKaTo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C802BC79B5;
        Thu, 15 Apr 2021 16:32:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5CA61C79B4;
        Thu, 15 Apr 2021 16:32:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH] pkt-line: do not report packet write errors twice
References: <64b81865fdfcc505b6aa3e6ebaebf3b9ccb36eb1.1618513583.git.matheus.bernardino@usp.br>
        <xmqqtuo7pb2b.fsf@gitster.g>
        <CAHd-oW4sqJpeJywgRJCkchX0uZFSxD-UnguRJcRcQQywd+scbA@mail.gmail.com>
Date:   Thu, 15 Apr 2021 13:32:14 -0700
In-Reply-To: <CAHd-oW4sqJpeJywgRJCkchX0uZFSxD-UnguRJcRcQQywd+scbA@mail.gmail.com>
        (Matheus Tavares Bernardino's message of "Thu, 15 Apr 2021 17:24:52
        -0300")
Message-ID: <xmqqlf9jp9v5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA5C1C82-9E29-11EB-9F41-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:

> Nice! :) Maybe we could also avoid the static strings without
> repeating the literals by making `do_packet_write()` receive a `struct
> strbuf *err` and save the error message in it? Then the two callers
> can decide whether to pass it to error() or die() accordingly.

Sorry, but I do not understand what benefit we are trying to gain by
introducing an extra strbuf (which I assume is used to strbuf_add()
the error message into).  Wouldn't the caller need two messages and
flip between <error,error_errno> vs <die,die_errno> pair?


