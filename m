Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB65BC433F5
	for <git@archiver.kernel.org>; Sat,  8 Oct 2022 04:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiJHERy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Oct 2022 00:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiJHERw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2022 00:17:52 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865CB92F4B
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 21:17:51 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7A6FB1A95ED;
        Sat,  8 Oct 2022 00:17:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4JkIIzzR/13z
        7DmLzzT9Wlr6eC9/DPnbhy/+B9HUeW8=; b=ujtxnn85V1vcluameCyIBlpdhk3u
        sdvJGY/z7+bkkniN1yCI3S+GqXxFF/V81ydOsUPJyKmTxPj4f4OErWDEobUWYLX3
        M1yGcb8V7IbIMy8oJWfkwt3Vw4cpBCYVzDeLJC39f44lf/ZWCfpMm3wxK7P/LuvR
        5gqB+JOZWSpyLHk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 72EBC1A95EC;
        Sat,  8 Oct 2022 00:17:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B060A1A95E9;
        Sat,  8 Oct 2022 00:17:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4] branch: support for shortcuts like @{-1}, completed
References: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
        <93b0b442-b277-66a6-3f5f-5a498593aa07@gmail.com>
        <7abdb5a9-5707-7897-4196-8d2892beeb81@gmail.com>
        <2e164aea-7dd8-5018-474a-01643553ea49@gmail.com>
Date:   Fri, 07 Oct 2022 21:17:46 -0700
In-Reply-To: <2e164aea-7dd8-5018-474a-01643553ea49@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Sat, 8 Oct 2022 03:00:21 +0200")
Message-ID: <xmqq8rlrc5jp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2A65EF30-46C0-11ED-9C07-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

>  	} else if (new_upstream) {
> -		struct branch *branch =3D branch_get(argv[0]);
> +		struct branch *branch;
> +		struct strbuf buf =3D STRBUF_INIT;
> =20
> -		if (argc > 1)
> +		if (!argc)
> +			branch =3D branch_get(NULL);
> +		else if (argc =3D=3D 1) {
> +			strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
> +			branch =3D branch_get(buf.buf);
> +		} else
>  			die(_("too many arguments to set new upstream"));
> =20
>  		if (!branch) {
> @@ -854,11 +867,17 @@ int cmd_branch(int argc, const char **argv, const=
 char *prefix)
>  		dwim_and_setup_tracking(the_repository, branch->name,
>  					new_upstream, BRANCH_TRACK_OVERRIDE,
>  					quiet);
> +		strbuf_release(&buf);
>  	} else if (unset_upstream) {
> -		struct branch *branch =3D branch_get(argv[0]);
> +		struct branch *branch;
>  		struct strbuf buf =3D STRBUF_INIT;
> =20
> -		if (argc > 1)
> +		if (!argc)
> +			branch =3D branch_get(NULL);
> +		else if (argc =3D=3D 1) {
> +			strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
> +			branch =3D branch_get(buf.buf);
> +		} else
>  			die(_("too many arguments to unset upstream"));

The above two are a bit repetitious.  A helper like

	static struct branch *interpret_local(int ac, const char **av)
	{
		struct branch *branch;
                if (!ac) {
                	branch =3D branch_get(NULL);
		} else if (ac =3D=3D 1) {
			struct strbuf buf =3D STRBUF_INIT;
			strbuf_branchname(&buf, av[0], INTERPRET_BRANCH_LOCAL);
			branch =3D branch_get(buf.buf);
			strbuf_release(&buf);
		} else {
			die(_("too many arguments"));
		}
		return branch;
	}

might be useful, and it frees the callers from worrying about
temporary allocations.

But the code written is OK as-is.
