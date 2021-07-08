Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E12C07E96
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 22:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA44861434
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 22:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhGHWY2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 18:24:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61343 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhGHWY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 18:24:28 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2788FDA00B;
        Thu,  8 Jul 2021 18:21:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=mkc8v4Ibo74O
        NAgfZ1FscRmQpfuXufD6p/0LXTpaOQQ=; b=X/5kB3rM3NhYkeicuUGbGgWBQXAj
        nrj22m3yAYZWr5ueuESLmWxf70CFYtGA7ojNMwcrZdEtkhszSP0478IMIl/wMLjl
        GSQkgQ3qKiHoW4hPgW7cOMu3O9j/TVaSc6nQd7LOOk6F9dap5SlTlOoLGQ/3UhfD
        Owsx6Xzryd76i4w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F915DA00A;
        Thu,  8 Jul 2021 18:21:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A202DDA009;
        Thu,  8 Jul 2021 18:21:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 4/4] pack-objects.c: make use of
 REV_INFO_STDIN_LINE_PROCESS
References: <cover-0.4-0000000000-20210617T105537Z-avarab@gmail.com>
        <cover-0.4-00000000000-20210621T150651Z-avarab@gmail.com>
        <patch-4.4-34750ab81cf-20210621T150651Z-avarab@gmail.com>
Date:   Thu, 08 Jul 2021 15:21:43 -0700
In-Reply-To: <patch-4.4-34750ab81cf-20210621T150651Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 21 Jun
 2021 17:10:16 +0200")
Message-ID: <xmqqmtqwa1l4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E0A897C2-E03A-11EB-96D2-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> @@ -3758,28 +3758,25 @@ static void mark_bitmap_preferred_tips(void)
>  static enum rev_info_stdin_line get_object_list_handle_stdin_line(
>  	struct rev_info *revs, struct strbuf *line_sb, void *stdin_line_priv)
>  {
> -	int *flags =3D stdin_line_priv;
>  	char *line =3D line_sb->buf;
> =20
> -	if (*line =3D=3D '-') {
> -		if (!strcmp(line, "--not")) {
> -			*flags ^=3D UNINTERESTING;
> -			write_bitmap_index =3D 0;
> -			return REV_INFO_STDIN_LINE_CONTINUE;
> -		}
> -		if (starts_with(line, "--shallow ")) {
> -			struct object_id oid;
> -			if (get_oid_hex(line + 10, &oid))
> -				die("not an object name '%s'", line + 10);
> -			register_shallow(the_repository, &oid);
> -			use_bitmap_index =3D 0;
> -			return REV_INFO_STDIN_LINE_CONTINUE;
> -		}
> +	if (*line !=3D '-')
> +		return REV_INFO_STDIN_LINE_PROCESS;
> +
> +	if (!strcmp(line, "--not")) {
> +		revs->revarg_flags ^=3D UNINTERESTING;
> +		write_bitmap_index =3D 0;
> +		return REV_INFO_STDIN_LINE_CONTINUE;
> +	} else if (starts_with(line, "--shallow ")) {
> +		struct object_id oid;
> +		if (get_oid_hex(line + 10, &oid))
> +			die("not an object name '%s'", line + 10);
> +		register_shallow(the_repository, &oid);
> +		use_bitmap_index =3D 0;
> +		return REV_INFO_STDIN_LINE_CONTINUE;
> +	} else {
>  		die(_("not a rev '%s'"), line);
>  	}
> -	if (handle_revision_arg(line, revs, *flags, REVARG_CANNOT_BE_FILENAME=
))
> -			die(_("bad revision '%s'"), line);
> -	return REV_INFO_STDIN_LINE_CONTINUE;
>  }

Now, this does make things slightly more modular (specifically, it
no longer is necessary for handle_revision_arg() to be visible
outside revision.c).

Having said that, it is not immediately obvious if the amount of
code churn by 3/4 and 4/4 is justified.  This still looks more like
"we can add a new API, so we added it" than "we needed a new API for
such and such reasons---now we can do this more easily then before".

It's not wrong per-se, but I am not all that impressed.  Sorry.
