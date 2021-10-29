Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D82C433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 05:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45FF960FC0
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 05:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhJ2F54 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 01:57:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59630 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbhJ2F5z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 01:57:55 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A5D3CF75FC;
        Fri, 29 Oct 2021 01:55:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7i2Q39ntI3y4
        9yNRGkA1HXYzjrfC5FYHWQmPqr45fVA=; b=iGOPYp6gTd233KP/AmKxOvlJKtNf
        b7EToWAZXsUCLXfTyXsyu1pzilvhMXiBOAgNYVjRrXd5Hd67SPbVbO4SxZLoQjsC
        U3C3CawHQCNDrnTy55xdXKfUC0PV1bXZ+ZxwP4TrW/lHoVSdMXVH+F9R7/d0sBLY
        rpTG2I6jLwJvjxs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C7E0F75FB;
        Fri, 29 Oct 2021 01:55:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 03FD8F75FA;
        Fri, 29 Oct 2021 01:55:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v3 05/13] hooks: convert 'post-checkout' hook to hook
 library
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
        <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com>
        <patch-v3-05.13-2a747a65829-20211019T231647Z-avarab@gmail.com>
Date:   Thu, 28 Oct 2021 22:55:24 -0700
In-Reply-To: <patch-v3-05.13-2a747a65829-20211019T231647Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 20 Oct
 2021 01:20:43
        +0200")
Message-ID: <xmqqfsskml2r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D01E4524-387C-11EC-894B-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>  	if (!ret && opts->checkout) {
> -		const char *hook =3D find_hook("post-checkout");
> -		if (hook) {
> -			const char *env[] =3D { "GIT_DIR", "GIT_WORK_TREE", NULL };
> -			cp.git_cmd =3D 0;
> -			cp.no_stdin =3D 1;
> -			cp.stdout_to_stderr =3D 1;
> -			cp.dir =3D path;
> -			cp.env =3D env;
> -			cp.argv =3D NULL;
> -			cp.trace2_hook_name =3D "post-checkout";
> -			strvec_pushl(&cp.args, absolute_path(hook),
> -				     oid_to_hex(null_oid()),
> -				     oid_to_hex(&commit->object.oid),
> -				     "1", NULL);
> -			ret =3D run_command(&cp);
> -		}
> +		struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
> +
> +		strvec_pushl(&opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
> +		strvec_pushl(&opt.args,
> +			     oid_to_hex(null_oid()),
> +			     oid_to_hex(&commit->object.oid),
> +			     "1",
> +			     NULL);
> +		opt.dir =3D path;
> +		opt.absolute_path =3D 1;
> +
> +		ret =3D run_hooks_oneshot("post-checkout", &opt);

I can see how passing opt from the caller gives more flexibility
like allowing to pass arbitrary environments.  The interface still
looks a bit unwieldy as I expect passing command line args would be
a much more common need than tweaking the environment, but let's
keep reading.


