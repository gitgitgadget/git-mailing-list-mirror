Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2738A20C11
	for <e@80x24.org>; Mon, 27 Nov 2017 23:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752967AbdK0XpX (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 18:45:23 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63887 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752706AbdK0XpX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 18:45:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CF56796B3B;
        Mon, 27 Nov 2017 18:45:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=neMtMYAbs7RmGubQ9qd4y0odyWc=; b=mCuU+T
        gasc3JFWpjwjrN4K/b8m9LPjXCc6hBLpVgIod7E/bOqdmVnKM8jImIOwQx4xpKoo
        wdxG7vWTnGUKJyiXahRr8oXY0uq9kRi3AbHWmUVoQDq/PEjl87//WborzXkSr9qU
        NTke2s2mhFxQ0U52jUbQ0kXWsPtDPW3yPfJHA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=N8l7EEMnFm/FU81T+ctV1T+qzicU7i6r
        /mtg6z2IgPMgHH2km3EGzpHC60BEdwUJx+TFedVOrRbteFM1nb1Y+ozh/QHj69Be
        uC/H4fJI8FT19YuIConHkuGyPqG9GK00ccSUWSXcIOJCf1hvrHzgp6d0V3NeVuI/
        sZRAGRA9Sx4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C78DC96B3A;
        Mon, 27 Nov 2017 18:45:22 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4C05896B39;
        Mon, 27 Nov 2017 18:45:22 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Liam Beguin <liambeguin@gmail.com>, git@vger.kernel.org,
        avarab@gmail.com
Subject: Re: [PATCH 3/5] rebase -i: add exec commands via the rebase--helper
References: <20171127045514.25647-1-liambeguin@gmail.com>
        <20171127045514.25647-4-liambeguin@gmail.com>
        <xmqq609we20v.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1711272230490.6482@virtualbox>
Date:   Tue, 28 Nov 2017 08:45:21 +0900
In-Reply-To: <alpine.DEB.2.21.1.1711272230490.6482@virtualbox> (Johannes
        Schindelin's message of "Mon, 27 Nov 2017 22:41:37 +0100 (CET)")
Message-ID: <xmqqk1yb9tgu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 088C5810-D3CD-11E7-B7BD-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> As the name of a public function, it does not feel that this hints
>> it strongly enough that it is from and a part of sequencer.c API.
>
> How about a "yes, and" instead? As in:
>
> To further improve this patch, let's use the name
> sequencer_add_exec_commands() for this function because it is defined
> globally now.

I would do so when I have a single "this is strictly better"
suggestion.  In this case, I didn't, but somebody who does not have
a "better suggestion" can still have a good sense of smell to tell
something is "not right".

>> > +	const char *todo_file = rebase_path_todo();
>> > +	struct todo_list todo_list = TODO_LIST_INIT;
>> > +	int fd, res, i, first = 1;
>> > +	FILE *out;
>> 
>> Having had to scan backwards while trying to see what the loop that
>> uses this variable is doing and if it gets affected by things that
>> happened before we entered the loop, I'd rather not to see 'first'
>> initialized here, left unused for quite some time until the loop is
>> entered.  It would make it a lot easier to follow if it is declared
>> and left uninitilized here, and set to 1 immediately before the
>> for() loop that uses it.
>
> Funny, I would have assumed it the other way round: since "first" always
> has to be initialized with 1, I would have been surprised to see an
> explicit assignment much later than it is declared.

Unfortunately that would force readers to see what happens before
the loop to see if there are cases where first is incremented, and
in this case there is not any.
