Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9075C43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 16:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbiGYQt1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 12:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiGYQtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 12:49:25 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A3ECE31
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 09:49:24 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DA1AF1B0E88;
        Mon, 25 Jul 2022 12:49:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7mb/5i7BTVN0
        JqmxOn6GdPt/r8YwkAjOQL/mB79T0dM=; b=m1xTDraoRnxAU/mK9cyFxWZ4XJZC
        RH1iWg/BNdQRQcI0+WPoiYVpjndiPrjPevbCVjscWGe6BF3nyrHSGJDf6dGpEQXQ
        PfUbgb5x5mXndh/bSeakOUc2qn9m+0xC7Ji/7r6pbrIV1ULwophGM3JwaPXgXV9v
        0usmlL0h5p8p3PM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B8E841B0E87;
        Mon, 25 Jul 2022 12:49:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5C4661B0E82;
        Mon, 25 Jul 2022 12:49:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 15/20] builtin/notes.c: let parse-options parse subcommands
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
        <20220725123857.2773963-16-szeder.dev@gmail.com>
Date:   Mon, 25 Jul 2022 09:49:19 -0700
In-Reply-To: <20220725123857.2773963-16-szeder.dev@gmail.com> ("SZEDER
        =?utf-8?Q?G=C3=A1bor=22's?= message of "Mon, 25 Jul 2022 14:38:52 +0200")
Message-ID: <xmqq7d416sts.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BABC22AA-0C39-11ED-A6E1-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> 'git notes' parses its subcommands with a long list of if-else if
> statements.  parse-options has just learned to parse subcommands, so
> let's use that facility instead, with the benefits of shorter code,
> handling unknown subcommands, and listing subcommands for Bash
> completion.  Make sure that the default operation mode doesn't accept
> any arguments.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  builtin/notes.c | 43 +++++++++++++++++--------------------------
>  1 file changed, 17 insertions(+), 26 deletions(-)
>
> diff --git a/builtin/notes.c b/builtin/notes.c
> index a3d0d15a22..42cbae4659 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -994,17 +994,31 @@ static int get_ref(int argc, const char **argv, c=
onst char *prefix)
> =20
>  int cmd_notes(int argc, const char **argv, const char *prefix)
>  {
> -	int result;
>  	const char *override_notes_ref =3D NULL;
> +	parse_opt_subcommand_fn *fn =3D list;
>  	struct option options[] =3D {
>  		OPT_STRING(0, "ref", &override_notes_ref, N_("notes-ref"),
>  			   N_("use notes from <notes-ref>")),
> +		OPT_SUBCOMMAND("list", &fn, list),
> +		OPT_SUBCOMMAND("add", &fn, add),
> +		OPT_SUBCOMMAND("copy", &fn, copy),
> +		OPT_SUBCOMMAND("append", &fn, append_edit),
> +		OPT_SUBCOMMAND("edit", &fn, append_edit),
> +		OPT_SUBCOMMAND("show", &fn, show),
> +		OPT_SUBCOMMAND("merge", &fn, merge),
> +		OPT_SUBCOMMAND("remove", &fn, remove_cmd),
> +		OPT_SUBCOMMAND("prune", &fn, prune),
> +		OPT_SUBCOMMAND("get-ref", &fn, get_ref),
>  		OPT_END()
>  	};

Reading the series backwards from the end, I would expect that the
above to replicate the current behaviour to allow commands to have
both "command wide" options and "per subcommand" options, e.g.

    $ git notes get-ref --ref=3Damlog
    error: unknown option `ref=3Damlog`
    usage: git notes get-ref
    $ git notes --ref=3Damlog get-ref
    refs/notes/amlog

Assuming that is how the new OPT_SUBCOMMAND() interacts with the
dashed options in a single "struct option []", everything I saw
so far in [10-20/20] makes sense.  [17/20] has another instance
of the above, dashed-options and subcommands mixed in an array,
to parse the option for "git remote --verbose <subcmd>" that applies
to all subcommands.

Thanks.


