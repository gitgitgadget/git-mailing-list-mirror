Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA502C38A2D
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 23:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiJXXLW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 19:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiJXXKo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 19:10:44 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8A72DA77A
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 14:31:41 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6C5851B76A3;
        Mon, 24 Oct 2022 17:30:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5+kkQX4fXFCGLCgwrquN4A9NOkVa9+d8bWaZkS
        difug=; b=qil/RCc2GaFPf5XiNjImdXmTmople/wRlt16OQdS5yG+ONzllZ5Vgn
        XuOEbnRHv1sU9WHT82GTqQGLHcsjTrpkNbrOibw+dskvK57XeT4Y4CpYQNW2U2ga
        2CJ1vYbelzPGtnhD1AilUQRk2QbkUwvk6F5i0pn87K25Uq/PQQs5c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 647921B76A2;
        Mon, 24 Oct 2022 17:30:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 916061B76A1;
        Mon, 24 Oct 2022 17:30:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 3/4] builtin/repack.c: write cruft packs to arbitrary
 locations
References: <cover.1666636974.git.me@ttaylorr.com>
        <c0f4ec92a057fdab905447bb917ff09e9bcaaab3.1666636974.git.me@ttaylorr.com>
Date:   Mon, 24 Oct 2022 14:30:49 -0700
In-Reply-To: <c0f4ec92a057fdab905447bb917ff09e9bcaaab3.1666636974.git.me@ttaylorr.com>
        (Taylor Blau's message of "Mon, 24 Oct 2022 14:43:09 -0400")
Message-ID: <xmqq1qqwsyd2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 21AE12A2-53E3-11ED-B32E-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> In the following commit, a new write_cruft_pack() caller will be added
> which wants to write a cruft pack to an arbitrary location. Prepare for
> this by adding a parameter which controls the destination of the cruft
> pack.
>
> For now, provide "packtmp" so that this commit does not change any
> behavior.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  builtin/repack.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 1184e8c257..a5386ac893 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -662,6 +662,7 @@ static int write_midx_included_packs(struct string_list *include,
>  }
>  
>  static int write_cruft_pack(const struct pack_objects_args *args,
> +			    const char *destination,
>  			    const char *pack_prefix,
>  			    const char *cruft_expiration,
>  			    struct string_list *names,
> @@ -673,8 +674,10 @@ static int write_cruft_pack(const struct pack_objects_args *args,
>  	struct string_list_item *item;
>  	FILE *in, *out;
>  	int ret;
> +	const char *scratch;
> +	int local = skip_prefix(destination, packdir, &scratch);

Hmph.  In an earlier step we got rid of the hardcoded assumption on
where the packtmp is, and we are passing destination in (where the
existing callers call us with packtmp) to make it even better, but
we acquire the dependency on packdir global with this step.  It's
just a couple of file-scope static global variables, so it is not a
huge deal.

> -	prepare_pack_objects(&cmd, args, packtmp);
> +	prepare_pack_objects(&cmd, args, destination);
>  
>  	strvec_push(&cmd.args, "--cruft");
>  	if (cruft_expiration)
> @@ -714,7 +717,12 @@ static int write_cruft_pack(const struct pack_objects_args *args,
>  		if (line.len != the_hash_algo->hexsz)
>  			die(_("repack: Expecting full hex object ID lines only "
>  			      "from pack-objects."));
> -		string_list_append(names, line.buf);
> +                /*
> +		 * avoid putting packs written outside of the repository in the
> +		 * list of names
> +		 */
> +		if (local)
> +			string_list_append(names, line.buf);
>  	}

Even if we do not want to contaminate the "names" list with packs
that are not in the repository, wouldn't our caller still want to be
able to tell what packs they are?

What I am wondering is if it makes more sense to have the caller
pass &names (which can be NULL to just discard the output from the
pack-objects command) so that this function can concentrate on what
it does (i.e. formulate the command to write cruft packs and then
report the packs that are created), without having to worry about
the management of the &names thing, which can be done by the caller
of this function?  We are already passing &names, so it may be the
matter of caller deciding to pass &names or NULL based on the value
of destination it passes to the function?

> @@ -986,7 +994,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  		cruft_po_args.local = po_args.local;
>  		cruft_po_args.quiet = po_args.quiet;
>  
> -		ret = write_cruft_pack(&cruft_po_args, pack_prefix,
> +		ret = write_cruft_pack(&cruft_po_args, packtmp, pack_prefix,
>  				       cruft_expiration, &names,
>  				       &existing_nonkept_packs,
>  				       &existing_kept_packs);

For example, this callsite will always want to pass &names because
it is always about local pack, right?

Thanks.
