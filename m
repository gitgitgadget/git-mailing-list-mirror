Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFFDC433EF
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 19:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbhL0Ttq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 14:49:46 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61160 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhL0Ttp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 14:49:45 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BC05BF769A;
        Mon, 27 Dec 2021 14:49:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+L+KzfzU9O8sy4MBDuxDNfPHHblLqMFsgUu0Kf
        OryJ0=; b=kOu2OaBD6HRp9dXCKBIoW+VS3Ph8h0ch4FiRLnSmtrRXTRvbF2h2ND
        BSy2HMUZ8kqU/PmoCKWmG/jNGE0VRKvQA4JWDdfFkx7K5JeD6kWiim0H7fg8NSGw
        L8aw5riESFO/SbNUN9f7fYHDQQeaKwxz9s6q9CnNo6NHuKjqKKXHw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B3432F7699;
        Mon, 27 Dec 2021 14:49:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1A0D1F7698;
        Mon, 27 Dec 2021 14:49:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] name-rev: deprecate --stdin in favor of --annotate-text
References: <pull.1171.git.git.1640492910432.gitgitgadget@gmail.com>
Date:   Mon, 27 Dec 2021 11:49:42 -0800
In-Reply-To: <pull.1171.git.git.1640492910432.gitgitgadget@gmail.com> (John
        Cai via GitGitGadget's message of "Sun, 26 Dec 2021 04:28:30 +0000")
Message-ID: <xmqqpmphx1yh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 236F2C84-674E-11EC-A698-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

As name-rev is Dscho's brainchild, I think it is benefitial to ask input
from him, so I added an address to the CC: list.

> From: John Cai <johncai86@gmail.com>
>
> Introduce a --annotate-text that is functionally equivalent of --stdin.
> --stdin does not behave as --stdin in other subcommands, such as
> pack-objects whereby it takes one argument per line. Since --stdin can
> be a confusing and misleading name, rename it to --annotate-text.
>
> This change adds a warning to --stdin warning that it will be removed in
> the future.

I know I've suggested the name, but 'text' in --annotate-text is a
low value word in an option name where every byte is precious.
"Annotate" is very good to convey what is done to the object of the
verb, but "text" stresses the wrong thing (we do not annotate
binary,o we annotate text) without saying where the text comes from
(i.e.  standard input).  Perhaps "--annotate-stdin" would be a much
better name.

I agree that letting "--stdin" to deviate so much from an emulation
of "xargs git name-rev" was indeed a mistake that caused the
confusion that led to the other thread.  If the mode had a better
name from the day 1, the thread would have been avoided.

What I am not sure about is how much this transition would hurt
existing users and scripts.

> +	For example:
> ++
> +----------
> +$ cat sample.txt
> +
> +An abbreviated revision 2ae0a9cb82 will not be substituted.
> +The full name after substitution is 2ae0a9cb8298185a94e5998086f380a355dd8907,
> +while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
> +
> +$ git name-rev --annotate-text < sample.txt

Lose SP between the redirection operator '<' and its file 'sample.txt'.

> +
> +An abbreviated revision 2ae0a9cb82 will not be substituted.
> +The full name after substitution is 2ae0a9cb8298185a94e5998086f380a355dd8907
> +(master),
> +while its tree object is 70d105cc79e63b81cfdcb08a15297c23e60b07ad
> +
> +$ git name-rev --name-only --annotate-text < sample.txt

Ditto.

> +	if (transform_stdin) {
> +		warning("--stdin is deprecated. Please use --annotate-text instead, "
> +					"which is functionally equivalent.\n"
> +					"This option will be removed in a future release.");
> +		annotate_text = 1;

I guess that is sensible.  To squelch the warning, they can switch
to the new option.

> +	}
> +
> +	if (all + annotate_text + !!argc > 1) {
>  		error("Specify either a list, or --all, not both!");
>  		usage_with_options(name_rev_usage, opts);
>  	}
> -	if (all || transform_stdin)
> +	if (all || annotate_text)
>  		cutoff = 0;
>  
>  	for (; argc; argc--, argv++) {
> @@ -613,7 +622,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
>  	for_each_ref(name_ref, &data);
>  	name_tips();
>  
> -	if (transform_stdin) {
> +	if (annotate_text) {
>  		char buffer[2048];
>  
>  		while (!feof(stdin)) {

Not a suggestion to change anything in this patch, but just an
observation.

 - If the mode is useful enough for many users, certainly somebody
   would have rewritten this loop to lift the line-length limit, but
   nobody noticed and complained about this 2k limit for the past 17
   years.  I am not sure if that is an indication that nobody uses
   the option in its current form.

 - A low hanging fruit, if we do not go full strbuf_getline(), at
   least we should narrow the scope of buffer[] array.

