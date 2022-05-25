Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAF5C433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 21:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345324AbiEYVPO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 17:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343905AbiEYVPL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 17:15:11 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C26BBA989
        for <git@vger.kernel.org>; Wed, 25 May 2022 14:15:10 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 20A09196825;
        Wed, 25 May 2022 17:15:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=Z00BUtuDp6jHYO+UxoxtJX8JR
        rpB+ZS0GVvOyAEYDsY=; b=iX6T57x+otQKLxtNElC28z58EZZiat03Y6UXtq+es
        wBGLI5jUu3krA4b+rnDn0hBEVtYFmCnqhK4Wi86Sgra44uQX/NHs8dm2fEoFlvPA
        tCud9a0pKcvWx+cipzGnLcA1RIDdjvnxM40Y2qz8ZiPhla6w3wxArf1Rms90MZiG
        eI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 19789196824;
        Wed, 25 May 2022 17:15:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BD554196823;
        Wed, 25 May 2022 17:15:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 4/5] receive-pack: use bug() and BUG_if_bug()
References: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com>
        <patch-4.5-c590f4273c0-20220521T170939Z-avarab@gmail.com>
Date:   Wed, 25 May 2022 14:15:05 -0700
Message-ID: <xmqqa6b55n6u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C054EE80-DC6F-11EC-902E-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Amend code added in a6a84319686 (receive-pack.c: shorten the
> execute_commands loop over all commands, 2015-01-07) and amended to
> hard die in b6a4788586d (receive-pack.c: die instead of error in case
> of possible future bug, 2015-01-07) to the new bug() function instead.
>
> Let's also rename the warn_if_*() function that code is in to
> BUG_if_*(), its name became outdated in b6a4788586d.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/receive-pack.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index ad20b41e3c8..d1b3e5c419e 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1810,21 +1810,17 @@ static int should_process_cmd(struct command *c=
md)
>  	return !cmd->error_string && !cmd->skip_update;
>  }
> =20
> -static void warn_if_skipped_connectivity_check(struct command *command=
s,
> +static void BUG_if_skipped_connectivity_check(struct command *commands=
,
>  					       struct shallow_info *si)
>  {
>  	struct command *cmd;
> -	int checked_connectivity =3D 1;
> =20
>  	for (cmd =3D commands; cmd; cmd =3D cmd->next) {
> -		if (should_process_cmd(cmd) && si->shallow_ref[cmd->index]) {
> -			error("BUG: connectivity check has not been run on ref %s",
> -			      cmd->ref_name);
> -			checked_connectivity =3D 0;
> -		}
> +		if (!should_process_cmd(cmd) && si->shallow_ref[cmd->index])
> +			bug("connectivity check has not been run on ref %s",
> +			    cmd->ref_name);

OK.

>  	}
> -	if (!checked_connectivity)
> -		BUG("connectivity check skipped???");
> +	BUG_if_bug();

This is why I brought up the "shouldn't the concluding step allow
its own message?" earlier.  I suspect that the one in 5/5 shares the
same.

>  }
> =20
>  static void execute_commands_non_atomic(struct command *commands,
> @@ -2005,7 +2001,7 @@ static void execute_commands(struct command *comm=
ands,
>  		execute_commands_non_atomic(commands, si);
> =20
>  	if (shallow_update)
> -		warn_if_skipped_connectivity_check(commands, si);
> +		BUG_if_skipped_connectivity_check(commands, si);
>  }
> =20
>  static struct command **queue_command(struct command **tail,
