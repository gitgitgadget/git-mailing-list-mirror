Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DAEC25B07
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 17:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbiHJReq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 13:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbiHJRem (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 13:34:42 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8847583F10
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 10:34:37 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9119014AC1B;
        Wed, 10 Aug 2022 13:34:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=STQVS8kLvL6aLEKS1mQBZWNpILk0V9YgJuHFHK
        Zs4Qw=; b=XMhRfLseW1rp3BI3+5NCs1A874/R/Pa2ZNpdNYemXiKPnvmtxp1ku9
        zQcmA0yuXNytGziPK2VRsOq4ZH5iNjIA7rXDJm3RaVyfDC9IRSNVCedtJqcd9pAP
        ixU1l3BcrcdcBSSx7Qxbbpoi0MFw3uU1RuioImMyjqs/XdMmecehA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 887EA14AC1A;
        Wed, 10 Aug 2022 13:34:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F409214AC19;
        Wed, 10 Aug 2022 13:34:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Li Linchao <lilinchao@oschina.cn>
Subject: Re: [PATCH v4] rev-list: support human-readable output for
 `--disk-usage`
References: <pull.1313.v3.git.1660111276934.gitgitgadget@gmail.com>
        <pull.1313.v4.git.1660130072657.gitgitgadget@gmail.com>
Date:   Wed, 10 Aug 2022 10:34:32 -0700
In-Reply-To: <pull.1313.v4.git.1660130072657.gitgitgadget@gmail.com> (Li
        Linchao via GitGitGadget's message of "Wed, 10 Aug 2022 11:14:32
        +0000")
Message-ID: <xmqqlerwm28n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B2CB0D68-18D2-11ED-B4D6-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Li Linchao via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 195e74eec63..5d3880874fc 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -242,6 +242,7 @@ ifdef::git-rev-list[]
>  	to `/dev/null` as the output does not have to be formatted.
>  
>  --disk-usage::
> +--disk-usage=human::
>  	Suppress normal output; instead, print the sum of the bytes used
>  	for on-disk storage by the selected commits or objects. This is
>  	equivalent to piping the output into `git cat-file
> @@ -249,6 +250,8 @@ ifdef::git-rev-list[]
>  	faster (especially with `--use-bitmap-index`). See the `CAVEATS`
>  	section in linkgit:git-cat-file[1] for the limitations of what
>  	"on-disk storage" means.
> +	When it accepts a value `human`, like: `--disk-usage=human`, this
> +	means to print objects size in human readable format.

"When it accepts" sounds wrong, because it implies there are two
cases, i.e. the user gives "--disk-usage=human" and the command
somehow decides to accept it, or to reject it, which is not what is
going on.  How about phrasing it more like ...

    With the optional value `human`, on-disk storage size is shown
    in human-readable string (e.g. 12.23 KiB, 3.50 MiB).

perhaps?

> @@ -46,6 +46,7 @@ static const char rev_list_usage[] =
>  "    --parents\n"
>  "    --children\n"
>  "    --objects | --objects-edge\n"
> +"    --disk-usage | --disk-usage=human\n"

Writing it like

	"--disk-usage[=human]\n"

would be more in line with ...

>  "    --[no-]object-names\n"

... this one.

> @@ -368,6 +370,17 @@ static int show_object_fast(
>  	return 1;
>  }
>  
> +static void print_disk_usage(off_t size)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	if (human_readable)
> +		strbuf_humanise_bytes(&sb, size);
> +	else
> +		strbuf_addf(&sb, "%"PRIuMAX, (uintmax_t)size);
> +	puts(sb.buf);
> +	strbuf_release(&sb);
> +}

Hmph, I am not sure if we want to make it a helper like this.  The
normal case does not need to prepare the string into a strbuf but
just can send the output to the standard output stream.

It is probably easy to fix, like so:

	if (!human_readable) {
		printf("%" PRIuMAX "\n", disk_usage);
	} else {
		strbuf sb = STRBUF_INIT;
		strbuf_humanise_bytes(&sb, disk_usage);
		puts(sb.buf);
		strbuf_release(&sb);
	}

>  static inline int parse_missing_action_value(const char *value)
>  {
>  	if (!strcmp(value, "error")) {
> @@ -473,6 +486,7 @@ static int try_bitmap_disk_usage(struct rev_info *revs,
>  				 int filter_provided_objects)
>  {
>  	struct bitmap_index *bitmap_git;
> +	off_t size_from_bitmap;

Questionably named variable.

>  	if (!show_disk_usage)
>  		return -1;
> @@ -481,8 +495,8 @@ static int try_bitmap_disk_usage(struct rev_info *revs,
>  	if (!bitmap_git)
>  		return -1;
>  
> -	printf("%"PRIuMAX"\n",
> -	       (uintmax_t)get_disk_usage_from_bitmap(bitmap_git, revs));
> +	size_from_bitmap = get_disk_usage_from_bitmap(bitmap_git, revs);
> +	print_disk_usage(size_from_bitmap);

It makes sense to make the function declare how it gets disk usage
in its name, but once we call the function to get what we want,
there is no need to keep saying we got it from bitmap.  If we ever
gained another function that obtains the disk usage from other
means, then this part of the code would become

	if (use_bitmap)
		variable = get_disk_usage_from_bitmap(...);
	else
		variable = get_disk_usage_from_other_means(...);

	print_disk_usage(variable);

Now, what should that variable be named?  It is clear that it
shouldn't be named "from_bitmap" at all, because it may very well
have come from somewhere else.

You call it simply 'size' in print_disk_usage(), and that would
probably be a good name to use here.  Or even better, "disk_usage".

However, I think all of the above badness stems from the horrible
way the existing code deals with "use_bitmap_index", and it is not
in the scope of this patch to fix it, let's keep the above code
as-is.  This is only called from the "if (use_bitmap_index)" so
the size can only be from bitmap.

> @@ -624,7 +638,20 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>  			continue;
>  		}
>  
> -		if (!strcmp(arg, "--disk-usage")) {
> +		if (skip_prefix(arg, "--disk-usage", &arg)) {
> +			if (*arg == '=') {
> +				if (!strcmp(++arg, "human")) {
> +					human_readable = 1;
> +				} else
> +					die(_("invalid value for '%s': '%s', try --disk-usage=human"), "--disk-usage", arg);

This makes the hardcoded "--disk-usage=human" subject to
translation, which it should not.  Perhaps like this:

	die(_("invalid value for '%s': '%s', the only allowed format is "%s"),
	    "--disk-usage=<format>", arg, "human");

The main point is to ensure that "human" that we are not allowing
the user to type in their language is left out of the
_("translatable string").

> +			} else if (*arg) {
> +				/*
> +				* Arguably should goto a label to continue chain of ifs?
> +				* Doesn't matter unless we try to add --disk-usage-foo
> +				* afterwards
> +				*/

Wrong indentation for a long comment?

> +				usage(rev_list_usage);
> +			}
