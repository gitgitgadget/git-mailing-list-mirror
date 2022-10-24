Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9ACFA373D
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 22:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiJXWpi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 18:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbiJXWo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 18:44:56 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0F91D20FE
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 14:07:12 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9F6261CB760;
        Mon, 24 Oct 2022 16:47:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VENgaiqMX2V/b7zm7t0dyD8/Bv7HXUOxMcZQid
        QnaQE=; b=mhQkU36WX6nEMaf57R15zf8TqOCgR+c4d9VoyrmgzDFlEyrBfAUFhL
        cge4Q65NRnbk/Vbgp4MUgDy/cKNNeHS3b7jNLZdCpV86RDQeIZyntRGL8I0r4B4D
        Ng1womnZf0VCJgcVTSW940IZthk8pZyPMCfhJ8O2H7Or8rKxOfDUE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9822E1CB75F;
        Mon, 24 Oct 2022 16:47:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B15FE1CB75E;
        Mon, 24 Oct 2022 16:47:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/4] builtin/repack.c: pass "out" to `prepare_pack_objects`
References: <cover.1666636974.git.me@ttaylorr.com>
        <1dd4136f6199ac050cec5eb671c36ae05fbf3bdd.1666636974.git.me@ttaylorr.com>
Date:   Mon, 24 Oct 2022 13:47:11 -0700
In-Reply-To: <1dd4136f6199ac050cec5eb671c36ae05fbf3bdd.1666636974.git.me@ttaylorr.com>
        (Taylor Blau's message of "Mon, 24 Oct 2022 14:43:03 -0400")
Message-ID: <xmqqa65lrltc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 094F8A0C-53DD-11ED-A256-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> `builtin/repack.c`'s `prepare_pack_objects()` is used to prepare a set
> of arguments to a `pack-objects` process which will generate a desired
> pack.
>
> A future patch will add an `--expire-to` option which allows `git
> repack` to write a cruft pack containing the pruned objects out to a
> separate repository. Prepare for this by teaching that function to write
> packs to an arbitrary location specified by the caller.
>
> All existing callers of `prepare_pack_objects()` will pass `packtmp` for
> `out`, retaining the existing behavior.

It does make sense to allow the caller to specify the name of the
temporary file to be used, but is "out" a good name for that?  The
other two arguments are self explanatory both by their type and the
name, but this is of type "const char *" that does not convey what
the string is about at all, so giging a good name to the parameter
is more important than for others.

The patch text itself is very straight-forward.  Thanks.


>  static void prepare_pack_objects(struct child_process *cmd,
> -				 const struct pack_objects_args *args)
> +				 const struct pack_objects_args *args,
> +				 const char *out)
>  {
>  	strvec_push(&cmd->args, "pack-objects");
>  	if (args->window)
> @@ -211,7 +212,7 @@ static void prepare_pack_objects(struct child_process *cmd,
>  		strvec_push(&cmd->args,  "--quiet");
>  	if (delta_base_offset)
>  		strvec_push(&cmd->args,  "--delta-base-offset");
> -	strvec_push(&cmd->args, packtmp);
> +	strvec_push(&cmd->args, out);
>  	cmd->git_cmd = 1;
>  	cmd->out = -1;
>  }
> @@ -275,7 +276,7 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
>  	FILE *out;
>  	struct strbuf line = STRBUF_INIT;
>  
> -	prepare_pack_objects(&cmd, args);
> +	prepare_pack_objects(&cmd, args, packtmp);
>  	cmd.in = -1;
>  
>  	/*
> @@ -673,7 +674,7 @@ static int write_cruft_pack(const struct pack_objects_args *args,
>  	FILE *in, *out;
>  	int ret;
>  
> -	prepare_pack_objects(&cmd, args);
> +	prepare_pack_objects(&cmd, args, packtmp);
>  
>  	strvec_push(&cmd.args, "--cruft");
>  	if (cruft_expiration)
> @@ -861,7 +862,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  
>  	sigchain_push_common(remove_pack_on_signal);
>  
> -	prepare_pack_objects(&cmd, &po_args);
> +	prepare_pack_objects(&cmd, &po_args, packtmp);
>  
>  	show_progress = !po_args.quiet && isatty(2);
