Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F24818A
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 00:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UlB8JKxt"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A361AB
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 17:13:04 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8DF941C3E13;
	Sun, 29 Oct 2023 20:12:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Z7FdnkYKoJn2
	lkTQrtM+TII5jShrx/m09OtWWAULJT0=; b=UlB8JKxtXqFLXA+Cpgv1ya44iaTJ
	sBv5qbEj5LSbrh+YM+I/zISa0rr17zu0HzdLAlprv+OYqre9axYu4WH83bslo/YQ
	MvLvo0SC9prAzx3YTE4wlrbsveVKMSlDV40dBXxcNQUmlYXSD2W8N9TbVDE4GN16
	hpgorSH8zKxkDs4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 86D3F1C3E12;
	Sun, 29 Oct 2023 20:12:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E6E6C1C3E11;
	Sun, 29 Oct 2023 20:12:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] parse-options: make CMDMODE errors more precise
In-Reply-To: <cefdba32-db0b-4f68-954e-9d31fc12b1a0@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sat, 28 Oct 2023 13:53:01 +0200")
References: <cefdba32-db0b-4f68-954e-9d31fc12b1a0@web.de>
Date: Mon, 30 Oct 2023 09:12:57 +0900
Message-ID: <xmqqfs1tge7q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 1512478A-76B9-11EE-9BF9-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Store the argument of PARSE_OPT_CMDMODE options of type OPTION_CALLBACK
> as well to allow taking over the responsibility for compatibility
> checking from the callback function.  The next patch will use this
> capability to fix the messages for git am --show-current-patch.
>
> Use a linked list for storing the PARSE_OPT_CMDMODE variables.  This
> somewhat outdated data structure is simple and suffices, as the number
> of elements per command is currently only zero or one.  We do support
> multiple different command modes variables per command, but I don't
> expect that we'd ever use a significant number of them.  Once we do we
> can switch to a hashmap.

Makes quite a lot of sense.  I would have expected to see this in
the parse_options_check() function, where other sanity checks are
done, but I think the reason you added the call to its caller
because parse_options_check() does not take the context.

It is not like we want to perform a sanity check that is independent
from a particular invocation of parse_options() on the options[]
array only just once, and want to reuse the array that is known to
be sane multiple times.  The check is called once for every
invocation, so with or without this change, I do not see a good
reason for parse_options_check() not to take context, though.

> +static enum parse_opt_result get_value(struct parse_opt_ctx_t *p,
> +				       const struct option *opt,
> +				       enum opt_parsed flags)
> +{
> +	const char *arg =3D NULL;
> +	enum parse_opt_result result =3D do_get_value(p, opt, flags, &arg);
> +	struct parse_opt_cmdmode_list *elem =3D p->cmdmode_list;
> +	char *opt_name, *other_opt_name;
> +
> +	for (; elem; elem =3D elem->next) {
> +		if (*elem->value_ptr =3D=3D elem->value)
> +			continue;
> +
> +		if (elem->opt &&
> +		    (elem->opt->flags | opt->flags) & PARSE_OPT_CMDMODE)
> +			break;
> +
> +		elem->opt =3D opt;
> +		elem->arg =3D arg;
> +		elem->flags =3D flags;
> +		elem->value =3D *elem->value_ptr;
> +	}
> +
> +	if (result || !elem)
> +		return result;
> +
> +	opt_name =3D optnamearg(opt, arg, flags);
> +	other_opt_name =3D optnamearg(elem->opt, elem->arg, elem->flags);
> +	error(_("%s is incompatible with %s"), opt_name, other_opt_name);
> +	free(opt_name);
> +	free(other_opt_name);
> +	return -1;
> +}

Looks quite involved but the overhead is number of supported cmdmode
options per each command line option, and the problems outlined in
the proposed log message are worth addressing.  OK.

> @@ -1006,6 +1041,11 @@ int parse_options(int argc, const char **argv,
>  	precompose_argv_prefix(argc, argv, NULL);
>  	free_preprocessed_options(real_options);
>  	free(ctx.alias_groups);
> +	for (struct parse_opt_cmdmode_list *elem =3D ctx.cmdmode_list; elem;)=
 {
> +		struct parse_opt_cmdmode_list *next =3D elem->next;
> +		free(elem);
> +		elem =3D next;
> +	}
>  	return parse_options_end(&ctx);
>  }

OK.

