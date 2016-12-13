Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30000209B4
	for <e@80x24.org>; Tue, 13 Dec 2016 21:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753543AbcLMV5l (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 16:57:41 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55333 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753402AbcLMV5k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 16:57:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C113A57244;
        Tue, 13 Dec 2016 16:51:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=moxBerP5so+djx60B5IxmzrYfBI=; b=eK6H+U
        GDmJqySYV6um0CI8oIb1e9xyxD/zP8s3VJEkP4YP+LcVX+tPhr4ZOqdeuH20nkq6
        ncYCdYfoHhwYeys8AFVOlCD6z9znJwo8D/4uPc21ah9RodXU/sLo7AntpZsvg0hO
        b7sKB0mp1AFbmwx40vn5R4v1WArfZzl5PfFCI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=whzfU4vfQ5Zh4HMFqix7MPjvprX3fLNv
        pMR5PeNfv/fU7AZoAKA9FSG0neyQEVRUAck6gdNbGT8PYvwQAryU7RStovfM3WIx
        Xpgy0Vk3I4RCNQ5o/DWiTvy8I53qRrYZcgKpllqeOdcW7eG2fEuh5vAGaFrplTA+
        ZpzQ3+JlJCc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B8B1E57243;
        Tue, 13 Dec 2016 16:51:37 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3BDFB57242;
        Tue, 13 Dec 2016 16:51:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 05/34] sequencer (rebase -i): learn about the 'verbose' mode
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
        <cover.1481642927.git.johannes.schindelin@gmx.de>
        <1d1f8d8b0696769bb85dd8a2269dc281aa91eede.1481642927.git.johannes.schindelin@gmx.de>
Date:   Tue, 13 Dec 2016 13:51:36 -0800
In-Reply-To: <1d1f8d8b0696769bb85dd8a2269dc281aa91eede.1481642927.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Tue, 13 Dec 2016 16:29:53 +0100
        (CET)")
Message-ID: <xmqq37hr1orb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 525337D2-C17E-11E6-8039-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> @@ -1493,9 +1498,26 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
>  	}
>  
>  	if (is_rebase_i(opts)) {
> +		struct strbuf buf = STRBUF_INIT;
> +
>  		/* Stopped in the middle, as planned? */
>  		if (todo_list->current < todo_list->nr)
>  			return 0;
> +
> +		if (opts->verbose) {
> +			const char *argv[] = {
> +				"diff-tree", "--stat", NULL, NULL
> +			};
> +
> +			if (!read_oneliner(&buf, rebase_path_orig_head(), 0))
> +				return error(_("could not read '%s'"),
> +					rebase_path_orig_head());
> +			strbuf_addstr(&buf, "..HEAD");
> +			argv[2] = buf.buf;
> +			run_command_v_opt(argv, RUN_GIT_CMD);
> +			strbuf_reset(&buf);
> +		}
> +		strbuf_release(&buf);
>  	}

It's a bit curious that the previous step avoided running a separate
process and instead did "diff-tree -p" all in C, but this one does not.

I think it is because this one is outside the loop?  The original,
being a scripted Porcelain, formulates a lazy and loose command
line, but you may want to tighten it up a bit if you spawn a
process.  If your user happens to have a file whose name is
$orig_head..HEAD, the command line you are creating (which is
identical to the scripted version) will barf with "ambiguous
argument".

One good thing about a complete C rewrite is that it won't have an
issue like this one because you'd be working with in-core objects.

> diff --git a/sequencer.h b/sequencer.h
> index cb21cfddee..f885b68395 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -24,6 +24,7 @@ struct replay_opts {
>  	int allow_empty;
>  	int allow_empty_message;
>  	int keep_redundant_commits;
> +	int verbose;
>  
>  	int mainline;
