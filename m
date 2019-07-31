Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAF6A1F732
	for <e@80x24.org>; Wed, 31 Jul 2019 20:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbfGaU0Q (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 16:26:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55398 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbfGaU0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 16:26:16 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D69415AFDC;
        Wed, 31 Jul 2019 16:26:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+D4GDHHWVsZ3dvrWZ0cj4J51uVg=; b=ekkYA+
        hUkEH8dNmmihlWbH/C+kPapqEN/l5B/ZNH9czyjwvXSsdMVTmBBXcGCKlnSRrnTr
        cZiU2lBc5SVLZNBTl2nHjtadpoyRmW0WYqR5WCA8VrZxHzMfopRPgRw3XYZrJi66
        jYGk4pjjcZVfR1NizC5R7JSgabPBCStuUAyHM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TnW+tDj9SHuuyq7LpvwPLYmrQhrKAvMF
        5R7Fpv/bdQnhfMyLTRIEUtO3adI1p2WnnNQ5PCMAVF04R1TxZIDZGC0QdI3FOwT2
        lx7dOTsw7AZ+bnyFI9SX8LJiaNVD7vQ8xuDLmEovfC2Fzpuhq4UvhM1kMGJnpabw
        Ysjl0KZjzyo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0419915AFDB;
        Wed, 31 Jul 2019 16:26:14 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6854B15AFDA;
        Wed, 31 Jul 2019 16:26:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Gregory Szorc <gregory.szorc@gmail.com>,
        Eric Wong <e@80x24.org>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] repack: silence warnings when auto-enabled bitmaps cannot be built
References: <20190731053703.GA16709@sigill.intra.peff.net>
        <20190731053927.GB16941@sigill.intra.peff.net>
Date:   Wed, 31 Jul 2019 13:26:12 -0700
In-Reply-To: <20190731053927.GB16941@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 31 Jul 2019 01:39:27 -0400")
Message-ID: <xmqqftmmosrf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 70DAE4DC-B3D1-11E9-AC73-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> @@ -3313,8 +3319,13 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  			    N_("do not hide commits by grafts"), 0),
>  		OPT_BOOL(0, "use-bitmap-index", &use_bitmap_index,
>  			 N_("use a bitmap index if available to speed up counting objects")),
> -		OPT_BOOL(0, "write-bitmap-index", &write_bitmap_index,
> -			 N_("write a bitmap index together with the pack index")),
> +		OPT_SET_INT(0, "write-bitmap-index", &write_bitmap_index,
> +			    N_("write a bitmap index together with the pack index"),
> +			    WRITE_BITMAP_TRUE),
> +		OPT_SET_INT_F(0, "write-bitmap-index-quiet",
> +			      &write_bitmap_index,
> +			      N_("write a bitmap index if possible"),
> +			      WRITE_BITMAP_QUIET, PARSE_OPT_HIDDEN),

The receiving end of this communication is pretty easy to follow.
I'd have named an option to trigger "if possible" behaviour after
that "if possible" phrase and not "quiet", but this is entirely
internal that it does not matter.

> diff --git a/builtin/repack.c b/builtin/repack.c
> index 30982ed2a2..db93ca3660 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -345,13 +345,14 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  		die(_("--keep-unreachable and -A are incompatible"));
>  
>  	if (write_bitmaps < 0) {
> -		write_bitmaps = (pack_everything & ALL_INTO_ONE) &&
> -				 is_bare_repository() &&
> -				 keep_pack_list.nr == 0 &&
> -				 !has_pack_keep_file();
> +		if (!(pack_everything & ALL_INTO_ONE) ||
> +		    !is_bare_repository() ||
> +		    keep_pack_list.nr != 0 ||
> +		    has_pack_keep_file())
> +			write_bitmaps = 0;

This side of communication is a bit harder to follow, but not
impossible ;-) We leave it "negative" to signal "the user did not
specify, but we enabled it by default" here.

>  	}
>  	if (pack_kept_objects < 0)
> -		pack_kept_objects = write_bitmaps;
> +		pack_kept_objects = !!write_bitmaps;

And non-zero write_bitmaps replaces "true" in the older world.

>  	if (write_bitmaps && !(pack_everything & ALL_INTO_ONE))

So this does not have to change.

>  		die(_(incremental_bitmap_conflict_error));
> @@ -375,8 +376,10 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	argv_array_push(&cmd.args, "--indexed-objects");
>  	if (repository_format_partial_clone)
>  		argv_array_push(&cmd.args, "--exclude-promisor-objects");
> -	if (write_bitmaps)
> +	if (write_bitmaps > 0)
>  		argv_array_push(&cmd.args, "--write-bitmap-index");
> +	else if (write_bitmaps < 0)
> +		argv_array_push(&cmd.args, "--write-bitmap-index-quiet");

And "enabled by user" and "enabled by default" are mapped to the two
options.

All makes sense.

Thanks.
