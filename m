Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8263E20756
	for <e@80x24.org>; Sat,  7 Jan 2017 21:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753361AbdAGVtD (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jan 2017 16:49:03 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54838 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750770AbdAGVtB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2017 16:49:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AB1F95B023;
        Sat,  7 Jan 2017 16:49:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tJExD4bn19sjaDC0xFE5/c25fuM=; b=kj1gBF
        1OaaLg3R01yZ62cqYeeixstqSmWw4f/FKb3Wf0lmbDpjvno5pMyZQI/uLFVTLGV0
        TxLNKG43jau3SZsT5v6+rgmDbH1v/oxflw+r1PtpYgTRkSnqVhLUkAF4tuGYW9FO
        UO56YgXzlmQQbgM8nRiNWoC8RuBpPDH2PR5Gg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fzgH1DMT5DFh9tHYhsN33Y5EhvGEXlQa
        XjEB3B4XB5RFuMX9nEciFUlKojPwCG03c/uehM9BOekUOxGWQ/Vvl9ctmK+MdAkv
        KzT0lGPzX2YFVNiZ8xRvYGAINpTTVj3ikbKziaBbC0NOg4aKUgWCoNwgU1RJQB5l
        H5iMYjCiqwo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9F2A25B022;
        Sat,  7 Jan 2017 16:49:00 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EA36D5B021;
        Sat,  7 Jan 2017 16:48:59 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 05/34] sequencer (rebase -i): learn about the 'verbose' mode
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
        <cover.1481642927.git.johannes.schindelin@gmx.de>
        <1d1f8d8b0696769bb85dd8a2269dc281aa91eede.1481642927.git.johannes.schindelin@gmx.de>
        <xmqq37hr1orb.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1701021610590.3469@virtualbox>
Date:   Sat, 07 Jan 2017 13:48:58 -0800
In-Reply-To: <alpine.DEB.2.20.1701021610590.3469@virtualbox> (Johannes
        Schindelin's message of "Mon, 2 Jan 2017 16:11:36 +0100 (CET)")
Message-ID: <xmqqk2a635it.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 18E705BA-D523-11E6-B1C4-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Tue, 13 Dec 2016, Junio C Hamano wrote:
>
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> 
>> > @@ -1493,9 +1498,26 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
>> >  	}
>> >  
>> >  	if (is_rebase_i(opts)) {
>> > +		struct strbuf buf = STRBUF_INIT;
>> > +
>> >  		/* Stopped in the middle, as planned? */
>> >  		if (todo_list->current < todo_list->nr)
>> >  			return 0;
>> > +
>> > +		if (opts->verbose) {
>> > +			const char *argv[] = {
>> > +				"diff-tree", "--stat", NULL, NULL
>> > +			};
>> > +
>> > +			if (!read_oneliner(&buf, rebase_path_orig_head(), 0))
>> > +				return error(_("could not read '%s'"),
>> > +					rebase_path_orig_head());
>> > +			strbuf_addstr(&buf, "..HEAD");
>> > +			argv[2] = buf.buf;
>> > +			run_command_v_opt(argv, RUN_GIT_CMD);
>> > +			strbuf_reset(&buf);
>> > +		}
>> > +		strbuf_release(&buf);
>> >  	}
>> 
>> It's a bit curious that the previous step avoided running a separate
>> process and instead did "diff-tree -p" all in C, but this one does not.
>
> I guess my only defence is that I tried to be a little lazy.

I actually was alluding to going the other way around, spawning
"diff-tree -p" in the other codepath like this one does.
