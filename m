Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD0291FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 19:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758775AbcLPTTP (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 14:19:15 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57811 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758762AbcLPTTH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 14:19:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 66F6C55EEE;
        Fri, 16 Dec 2016 14:19:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7DbxtRhG0+qr5iy8nY65+IFNQ9Q=; b=t8C3tK
        1Xf2Fqiea63VfRY9eA7rIac/C3FQbTrL8wB+rVCb68N2yTNA52yeEgNF96RjglL7
        1iDaRqU/RiLOSlljexxu5k8qtZaQ0no/sLPMlx1n1b+nY2nkkIlHB+/B+lIZBlRc
        eFMvSrrE9Z4peoG5WHBpEyheBY4sFpPvU+Ylw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=T9AT1UVddvARcEu7pnlGO/7/gfa4W0Fj
        vlGwSKLN/iPLwYOz5KLiy04SUljvRKFPao3DVKk8b4mM/oeCAjxeHT7JLSHCex2h
        qAA8fYX0YqMRH/+ukZjNO1frzss+SJU1U4wUL0ytoxwJE+ea5xVz1i6Ak5h2ke4E
        ZNhzXNwWgNk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5EDA555EED;
        Fri, 16 Dec 2016 14:19:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D08F555EEC;
        Fri, 16 Dec 2016 14:19:05 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 14/34] sequencer (rebase -i): update refs after a successful rebase
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
        <cover.1481642927.git.johannes.schindelin@gmx.de>
        <596e3cf410a339c3212eea76394fe49be1c05ef8.1481642927.git.johannes.schindelin@gmx.de>
Date:   Fri, 16 Dec 2016 11:19:04 -0800
In-Reply-To: <596e3cf410a339c3212eea76394fe49be1c05ef8.1481642927.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Tue, 13 Dec 2016 16:30:53 +0100
        (CET)")
Message-ID: <xmqq8trfsmvr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 82E96A7C-C3C4-11E6-97A0-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> An interactive rebase operates on a detached HEAD (to keep the reflog
> of the original branch relatively clean), and updates the branch only
> at the end.
>
> Now that the sequencer learns to perform interactive rebases, it also
> needs to learn the trick to update the branch before removing the
> directory containing the state of the interactive rebase.
>
> We introduce a new head_ref variable in a wider scope than necessary at
> the moment, to allow for a later patch that prints out "Successfully
> rebased and updated <ref>".
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index a6625e765d..a4e9b326ba 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -100,6 +100,8 @@ static GIT_PATH_FUNC(rebase_path_stopped_sha, "rebase-merge/stopped-sha")
>  static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
>  static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
>  static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
> +static GIT_PATH_FUNC(rebase_path_head_name, "rebase-merge/head-name")
> +static GIT_PATH_FUNC(rebase_path_onto, "rebase-merge/onto")
>  
>  static inline int is_rebase_i(const struct replay_opts *opts)
>  {
> @@ -1793,12 +1795,39 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
>  	}
>  
>  	if (is_rebase_i(opts)) {
> -		struct strbuf buf = STRBUF_INIT;
> +		struct strbuf head_ref = STRBUF_INIT, buf = STRBUF_INIT;
>  
>  		/* Stopped in the middle, as planned? */
>  		if (todo_list->current < todo_list->nr)
>  			return 0;
>  
> +		if (read_oneliner(&head_ref, rebase_path_head_name(), 0) &&
> +				starts_with(head_ref.buf, "refs/")) {
> +			unsigned char head[20], orig[20];
> +
> +			if (get_sha1("HEAD", head))
> +				return error(_("cannot read HEAD"));
> +			if (!read_oneliner(&buf, rebase_path_orig_head(), 0) ||
> +					get_sha1_hex(buf.buf, orig))
> +				return error(_("could not read orig-head"));
> +			strbuf_addf(&buf, "rebase -i (finish): %s onto ",
> +				head_ref.buf);
> +			if (!read_oneliner(&buf, rebase_path_onto(), 0))
> +				return error(_("could not read 'onto'"));
> +			if (update_ref(buf.buf, head_ref.buf, head, orig,
> +					REF_NODEREF, UPDATE_REFS_MSG_ON_ERR))
> +				return error(_("could not update %s"),
> +					head_ref.buf);
> +			strbuf_reset(&buf);
> +			strbuf_addf(&buf,
> +				"rebase -i (finish): returning to %s",
> +				head_ref.buf);
> +			if (create_symref("HEAD", head_ref.buf, buf.buf))
> +				return error(_("could not update HEAD to %s"),
> +					head_ref.buf);

All of the above return error() calls leak head_ref.buf; in addition
some leak buf.buf, too.

> +			strbuf_reset(&buf);
> +		}
> +
>  		if (opts->verbose) {
>  			const char *argv[] = {
>  				"diff-tree", "--stat", NULL, NULL
> @@ -1813,6 +1842,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
>  			strbuf_reset(&buf);
>  		}
>  		strbuf_release(&buf);
> +		strbuf_release(&head_ref);
>  	}
>  
>  	/*
