Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63410C433F5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 17:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4185C60FE3
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 17:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbhKLRfy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 12:35:54 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51351 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbhKLRfx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 12:35:53 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7520616B985;
        Fri, 12 Nov 2021 12:33:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=aDkp0oyrproL
        4h4VLfvpggcGqoJlkk4H/EBJg2VQTd8=; b=YX/P2No5KdtLdmBuhC0NXE+oLs2A
        u3q8o6LCSyRrvYr9xwM8xyw/6U2kHmmWBQijchrrpIondgO5tEEOkY76HMARE0Gi
        Yaf09+5Uo9PUcgoGEeOUhaFKDANKQkULLnccPDzCKQswvy3o0bwYX+uQVmo2xp5W
        S843kv+8WWDwXcI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6DD6016B984;
        Fri, 12 Nov 2021 12:33:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C118D16B981;
        Fri, 12 Nov 2021 12:32:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 6/8] grep API: call grep_config() after grep_init()
References: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com>
        <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com>
        <patch-v2-6.8-917944f79a5-20211110T013632Z-avarab@gmail.com>
Date:   Fri, 12 Nov 2021 09:32:58 -0800
In-Reply-To: <patch-v2-6.8-917944f79a5-20211110T013632Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 10 Nov
 2021 02:43:48
        +0100")
Message-ID: <xmqq7ddds2id.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 94B0C18E-43DE-11EC-94B2-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The grep_init() function used the odd pattern of initializing the
> passed-in "struct grep_opt" with a statically defined "grep_defaults"
> struct, which would be modified in-place when we invoked
> grep_config().
>
> So we effectively (b) initialized config, (a) then defaults, (c)
> followed by user options. Usually those are ordered as "a", "b" and
> "c" instead.
>
> As the comments being removed here show the previous behavior needed
> to be carefully explained as we'd potentially share the populated
> configuration among different instances of grep_init(). In practice we
> didn't do that, but now that it can't be a concern anymore let's
> remove those comments.

OK, so we did this because we wanted to be able to

   1. call grep_config() only once to populate the template;

   2. call grep_init() more than once, and match the grep_opt to
      what the config wanted, without having to call grep_config()
      once per grep_init() invocation.

   3. each invocation of grep_init() in 2. may be followed by
      parse_options() to further tweak grep_opt.

And now we instead have to do

   1. call grep_init()
   2. call grep_config()
   3. parse_options() to tweak

for each instance of grep_opt, which is much more common.

OK.

> diff --git a/builtin/log.c b/builtin/log.c
> index f75d87e8d7f..bfddacdfa6c 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -505,8 +505,6 @@ static int git_log_config(const char *var, const ch=
ar *value, void *cb)
>  		return 0;
>  	}
> =20
> -	if (grep_config(var, value, cb) < 0)
> -		return -1;

This used to tweak the "default template", which we no longer use,
so can go?  And in its place ...

>  	if (git_gpg_config(var, value, cb) < 0)
>  		return -1;
>  	return git_diff_ui_config(var, value, cb);
> @@ -521,6 +519,8 @@ int cmd_whatchanged(int argc, const char **argv, co=
nst char *prefix)
>  	git_config(git_log_config, NULL);
> =20
>  	repo_init_revisions(the_repository, &rev, prefix);
> +	git_config(grep_config, &rev.grep_filter);
> +

... each command in the "log" family tweaks the grep_opt used for
real from the configuration.

>  	rev.diff =3D 1;
>  	rev.simplify_history =3D 0;
>  	memset(&opt, 0, sizeof(opt));
> @@ -635,6 +635,8 @@ int cmd_show(int argc, const char **argv, const cha=
r *prefix)
> =20
>  	memset(&match_all, 0, sizeof(match_all));
>  	repo_init_revisions(the_repository, &rev, prefix);
> +	git_config(grep_config, &rev.grep_filter);
> +

Ditto.  OK, the new pattern makes sense.

> diff --git a/grep.h b/grep.h
> index 62deadb885f..30a7dfd3294 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -171,12 +171,34 @@ struct grep_opt {
>  	int show_hunk_mark;
>  	int file_break;
>  	int heading;
> +	void *caller_priv;

This is unrelated and unexplained change, isn't it?

>  	void *priv;
> =20
>  	void (*output)(struct grep_opt *opt, const void *data, size_t size);
>  	void *output_priv;
>  };
> =20
> +#define GREP_OPT_INIT { \
> +	.relative =3D 1, \
> +	.pathname =3D 1, \
> +	.max_depth =3D -1, \
> +	.pattern_type_option =3D GREP_PATTERN_TYPE_UNSPECIFIED, \
> +	.colors =3D { \
> +		[GREP_COLOR_CONTEXT] =3D "", \
> +		[GREP_COLOR_FILENAME] =3D "", \
> +		[GREP_COLOR_FUNCTION] =3D "", \
> +		[GREP_COLOR_LINENO] =3D "", \
> +		[GREP_COLOR_COLUMNNO] =3D "", \
> +		[GREP_COLOR_MATCH_CONTEXT] =3D GIT_COLOR_BOLD_RED, \
> +		[GREP_COLOR_MATCH_SELECTED] =3D GIT_COLOR_BOLD_RED, \
> +		[GREP_COLOR_SELECTED] =3D "", \
> +		[GREP_COLOR_SEP] =3D GIT_COLOR_CYAN, \
> +	}, \
> +	.only_matching =3D 0, \
> +	.color =3D -1, \
> +	.output =3D std_output, \
> +}

Other than the mysterious caller_priv bit, the change makes sense to
me.

Thanks.
