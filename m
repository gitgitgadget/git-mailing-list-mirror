Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68444202A0
	for <e@80x24.org>; Thu,  2 Nov 2017 03:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751908AbdKBDLo (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 23:11:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50492 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751428AbdKBDLn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 23:11:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DC7F6AC3B4;
        Wed,  1 Nov 2017 23:11:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+25+UhmnhvEV
        T/QAsgBJ1mvNPJM=; b=IdrVMs2zVCSD4dU0YdyM45o0KXPDRheK1m4DBqC1azrc
        2BybpJQf9DRI2SPIPiy8b1lteob144OJskKG7TQYt7D/s6pJxABT9z61sH5uOl+f
        0xoTO5UCUKySgoZhk7ZCIcinJwC3Y3MWPLSyBm/ZKHWrCpeJrpJdfqW3LZOKjHE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=DLpXTy
        g9u0aKMAOoPIIbqttaRWQoaX46pgmBnNLGG4Th+G49ejcUOLx+JBhnjqM8Dd9Kec
        vBuwyaDupKtmlMVYbBwNT/UC7PQTIm+3+JiBUtezZrPSunlTRrLLLvjn2zySLMj6
        2te23XnCHtUQbh0dUddho0zpkFK+ogWryPjIA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D301FAC3B3;
        Wed,  1 Nov 2017 23:11:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 49AF8AC3B1;
        Wed,  1 Nov 2017 23:11:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] reduce_heads: fix memory leaks
References: <20171101090326.8091-1-martin.agren@gmail.com>
Date:   Thu, 02 Nov 2017 12:11:38 +0900
In-Reply-To: <20171101090326.8091-1-martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
        message of "Wed, 1 Nov 2017 10:03:26 +0100")
Message-ID: <xmqq7ev9s7bp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8BAA6F4A-BF7B-11E7-AF1E-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> diff --git a/builtin/merge-base.c b/builtin/merge-base.c
> index 6dbd167d3..b1b7590c4 100644
> --- a/builtin/merge-base.c
> +++ b/builtin/merge-base.c
> @@ -59,6 +59,8 @@ static int handle_independent(int count, const char *=
*args)
>  		commit_list_insert(get_commit_reference(args[i]), &revs);
> =20
>  	result =3D reduce_heads(revs);
> +	free_commit_list(revs);
> +
>  	if (!result)
>  		return 1;

The post-context of this hunk continues like so:

	while (result) {
		printf("%s\n", oid_to_hex(&result->item->object.oid));
		result =3D result->next;
	}
	return 0;
}

and we end up leaking "result".  This function is directly called from
cmd_merge_base() and its value is returned to main(), so leaking it
is not that a grave offence, but that excuse applies equally well to
revs. =20

I can see you are shooting for minimum change in this patch, but if
we were writing this code in a codebase where reduce_heads_replace()
is already available, I would imagine that we wouldn't use two separate
variables, perhaps?

> diff --git a/commit.c b/commit.c
> index 1e0e63379..cab8d4455 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1090,6 +1090,13 @@ struct commit_list *reduce_heads(struct commit_l=
ist *heads)
>  	return result;
>  }
> =20
> +void reduce_heads_replace(struct commit_list **heads)
> +{
> +	struct commit_list *result =3D reduce_heads(*heads);
> +	free_commit_list(*heads);
> +	*heads =3D result;
> +}
> +

Looks good.

> diff --git a/commit.h b/commit.h
> index 6d769590f..99a3fea68 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -313,7 +313,23 @@ extern int interactive_add(int argc, const char **=
argv, const char *prefix, int
>  extern int run_add_interactive(const char *revision, const char *patch=
_mode,
>  			       const struct pathspec *pathspec);
> =20
> -struct commit_list *reduce_heads(struct commit_list *heads);
> +/*
> + * Takes a list of commits and returns a new list where those
> + * have been removed that can be reached from other commits in
> + * the list. It is useful for, e.g., reducing the commits
> + * randomly thrown at the git-merge command and removing
> + * redundant commits that the user shouldn't have given to it.
> + *
> + * This function destroys the STALE bit of the commit objects'
> + * flags.
> + */
> +extern struct commit_list *reduce_heads(struct commit_list *heads);
> +
> +/*
> + * Like `reduce_heads()`, except it replaces the list. Use this
> + * instead of `foo =3D reduce_heads(foo);` to avoid memory leaks.
> + */
> +extern void reduce_heads_replace(struct commit_list **heads);

Looks excellent.

Thanks.
