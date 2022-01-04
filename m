Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6BFC433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 22:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbiADWEs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 17:04:48 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65173 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbiADWEr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 17:04:47 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D82CD1760D0;
        Tue,  4 Jan 2022 17:04:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bu+BLYJNQnNFgBDNdLjSO1riL1RMr3295AHrFh
        YOfHw=; b=lofQiNCzMs9bXpsxvCHN8d1nKZ3NRuStg7L24kqFxOVdn+8N73+vUW
        wW83gCdtin82SYyhENynOxCxg5TB8pZ/dg7ftZOFbSRsnQH8CgwxhOex2AjgS0MD
        q6q9Gm7wxFthdXEQ3v18O65iy9dXbkNTE+l6IsCdkyHovXi7Izzro=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D07C91760CF;
        Tue,  4 Jan 2022 17:04:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2519F1760CB;
        Tue,  4 Jan 2022 17:04:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3] builtin/reflog.c: use parse-options api for expire,
 delete subcommands
References: <pull.1175.v2.git.git.1641223223.gitgitgadget@gmail.com>
        <pull.1175.v3.git.git.1641318061821.gitgitgadget@gmail.com>
Date:   Tue, 04 Jan 2022 14:04:41 -0800
In-Reply-To: <pull.1175.v3.git.git.1641318061821.gitgitgadget@gmail.com> (John
        Cai via GitGitGadget's message of "Tue, 04 Jan 2022 17:41:01 +0000")
Message-ID: <xmqq8rvvb1ja.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5224C0D6-6DAA-11EC-BB76-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> Switching out manual arg parsing for the parse-options API for the
> expire and delete subcommands.
>
> Move explicit_expiry flag into cmd_reflog_expire_cb struct so callbacks
> can set both the value of the timestamp as well as the explicit_expiry
> flag.
>
> Signed-off-by: "John Cai" <johncai86@gmail.com>

Makes sense.

> -/* NEEDSWORK: switch to using parse_options */
> -static const char reflog_expire_usage[] =
> -N_("git reflog expire [--expire=<time>] "
> -   "[--expire-unreachable=<time>] "
> -   "[--rewrite] [--updateref] [--stale-fix] [--dry-run | -n] "
> -   "[--verbose] [--all] <refs>...");

...

> +static const char * reflog_expire_usage[] = {
> +	N_("git reflog expire [--expire=<time>] "
> +   "[--expire-unreachable=<time>] "
> +   "[--rewrite] [--updateref] [--stale-fix] [--dry-run | -n] "
> +   "[--verbose] [--all] <refs>..."),

Funny indentation?  Let's align the opening double-quote of all the
other lines to that of the first line on a fixed-column terminal,
like was done in the original.

>  static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
>  {
>  	struct cmd_reflog_expire_cb cmd = { 0 };
>  	timestamp_t now = time(NULL);
>  	int i, status, do_all, all_worktrees = 1;
> -	int explicit_expiry = 0;
>  	unsigned int flags = 0;
>  	int verbose = 0;
>  	reflog_expiry_should_prune_fn *should_prune_fn = should_expire_reflog_ent;
> +	const struct option options[] = {

This does not seem to apply.  Please leave a note on how the 'base'
was chosen when sending a patch that requires something not yet in
'master'.

I've based the topic for this patch by prepar ng a merge of
'ab/reflog-prep' into 'master', at least for now.

Other than that, looks nicely done.  The new approach seems much
simpler and sensible than the previous round.

Thanks.
