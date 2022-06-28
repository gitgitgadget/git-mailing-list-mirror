Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3697C433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 22:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiF1Wf1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 18:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiF1Wf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 18:35:26 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931123A19B
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 15:35:25 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F0642198E35;
        Tue, 28 Jun 2022 18:35:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=urPTGR/tnStRdwcO7n9jHcd9yNye+AhoWhdjL2
        I5LMk=; b=CTojhEbDO6nf6Noqjxq91PLu9VAJP/33TqCac9223qoFFibh9gVEZJ
        AgNCTXIySFXxLwRJRUNgnbQxvP20AvH1fObxNn3ucrx47yWNjeIDbS16BUkYz3kO
        6uopsudza60CTad37pq2altSKCbACulldW3cRRP+vw14FPe++uonA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E946D198E34;
        Tue, 28 Jun 2022 18:35:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 44F6F198E32;
        Tue, 28 Jun 2022 18:35:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christoph Reiter <reiter.christoph@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] add --interactive: allow `update` to stage deleted files
References: <pull.1273.git.1656454964378.gitgitgadget@gmail.com>
Date:   Tue, 28 Jun 2022 15:35:20 -0700
In-Reply-To: <pull.1273.git.1656454964378.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Tue, 28 Jun 2022 22:22:44
        +0000")
Message-ID: <xmqqr138h0wn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 980BBE6C-F732-11EC-A66C-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/add-interactive.c b/add-interactive.c
> index 6047e8f6489..22fcd3412ca 100644
> --- a/add-interactive.c
> +++ b/add-interactive.c
> @@ -697,8 +697,16 @@ static int run_update(struct add_i_state *s, const struct pathspec *ps,
>  
>  	for (i = 0; i < files->items.nr; i++) {
>  		const char *name = files->items.items[i].string;
> -		if (files->selected[i] &&
> -		    add_file_to_index(s->r->index, name, 0) < 0) {
> +		struct stat st;
> +
> +		if (!files->selected[i])
> +			continue;
> +		if (lstat(name, &st) && is_missing_file_error(errno)) {
> +			if (remove_file_from_index(s->r->index, name) < 0) {
> +				res = error(_("could not stage '%s'"), name);
> +				break;
> +			}
> +		} else if (add_file_to_index(s->r->index, name, 0) < 0) {
>  			res = error(_("could not stage '%s'"), name);
>  			break;
>  		}

The fix looks quite straight-forward.  It is somewhat disappointing
that it was caught after this loooong time, but as they say, better
late than never.

Thanks for a quick report and a fix.

> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index fc26cb8bae8..b354fb39de8 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -103,6 +103,15 @@ test_expect_success 'status works (commit)' '
>  	grep "+1/-0 *+2/-0 file" output
>  '
>  
> +test_expect_success 'update can stage deletions' '
> +	>to-delete &&
> +	git add to-delete &&
> +	rm to-delete &&
> +	test_write_lines u t "" | git add -i &&
> +	git ls-files to-delete >output &&
> +	test_must_be_empty output
> +'
> +
>  test_expect_success 'setup expected' '
>  	cat >expected <<-\EOF
>  	index 180b47c..b6f2c08 100644
>
> base-commit: e4a4b31577c7419497ac30cebe30d755b97752c5
