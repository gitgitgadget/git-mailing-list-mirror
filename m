Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307C0C433FE
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391178AbiDUSQ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391088AbiDUSQ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:16:26 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07734B1D6
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:13:33 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E5FB118415;
        Thu, 21 Apr 2022 14:13:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=cEYoT0Vi16N1
        q0g7qLY54Dx6Jdz97slpryUMsydrmrM=; b=QKLRrNBTM+/A74gEwhhFlL0n14VP
        UrNBbXM3ay/y55ZWaDv032jGksv/XJ8PzmWVtdaVOwjls6uVgK5/ue65wWcz9WNb
        YFUVOJJwqJbbg5fIcs+FXNaa9gmQP3YED+j02P58IBmu53wsrxPX+u08fk7huCmF
        lUF3tMmPysuKcz0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 16A8D118414;
        Thu, 21 Apr 2022 14:13:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 827BB118413;
        Thu, 21 Apr 2022 14:13:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Gregory David <gregory.david@p1sec.com>,
        ptm-dev <ptm-dev@p1sec.com>
Subject: Re: [PATCH v3 1/2] show-branch: refactor in preparation for next
 commit
References: <225b410d-2d98-8c0b-c289-22f753c175d4@p1sec.com>
        <cover-v3-0.2-00000000000-20220421T152704Z-avarab@gmail.com>
        <patch-v3-1.2-879930b7a66-20220421T152704Z-avarab@gmail.com>
Date:   Thu, 21 Apr 2022 11:13:31 -0700
In-Reply-To: <patch-v3-1.2-879930b7a66-20220421T152704Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 21 Apr
 2022 17:33:47
        +0200")
Message-ID: <xmqqr15qi9tg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C0D02410-C19E-11EC-9D4B-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Move the code in cmd_show_branch() that formats a reflog message for
> us into a function,

Makes quite a lot of sense.

"factoring out the formatting of reflog message, given a single
reflog entry", is a very good unit of work that is independently
good and can be evaluated as such.

> and change the "flags" variable that we never
> change into a "const", in addition to moving it up a scope in
> preparation for the subsequent commit.

Perhaps doing that as part of the next step is better (or not doing
it if it can be helped)?  Mixing it in contaminates a good isolation
done with an unrelated change.  We somehow ended up seeing too many
"while at it" in the recent patches, and I think that needs to stop.
We should go back to better patch hygiene.

Other than that, looks sensible.  Let's see what 2/2 does.

Thanks.


> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/show-branch.c | 34 +++++++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 13 deletions(-)
>
> diff --git a/builtin/show-branch.c b/builtin/show-branch.c
> index 330b0553b9d..499ef76a508 100644
> --- a/builtin/show-branch.c
> +++ b/builtin/show-branch.c
> @@ -618,6 +618,24 @@ static int parse_reflog_param(const struct option =
*opt, const char *arg,
>  	return 0;
>  }
> =20
> +static char *fmt_reflog(char *const logmsg, const timestamp_t ts, cons=
t int tz,
> +			const char *fmt)
> +{
> +	char *const end =3D strchr(logmsg, '\n');
> +	const char *msg;
> +	char *ret;
> +
> +	if (end)
> +		*end =3D '\0';
> +
> +	msg =3D *logmsg ? logmsg : "(none)";
> +
> +	ret =3D xstrfmt(fmt, show_date(ts, tz, DATE_MODE(RELATIVE)), msg);
> +	free(logmsg);
> +
> +	return ret;
> +}
> +
>  int cmd_show_branch(int ac, const char **av, const char *prefix)
>  {
>  	struct commit *rev[MAX_REVS], *commit;
> @@ -640,6 +658,7 @@ int cmd_show_branch(int ac, const char **av, const =
char *prefix)
>  	int topics =3D 0;
>  	int dense =3D 1;
>  	const char *reflog_base =3D NULL;
> +	const unsigned int flags =3D 0;
>  	struct option builtin_show_branch_options[] =3D {
>  		OPT_BOOL('a', "all", &all_heads,
>  			 N_("show remote-tracking and local branches")),
> @@ -720,7 +739,6 @@ int cmd_show_branch(int ac, const char **av, const =
char *prefix)
>  		struct object_id oid;
>  		char *ref;
>  		int base =3D 0;
> -		unsigned int flags =3D 0;
> =20
>  		if (ac =3D=3D 0) {
>  			static const char *fake_av[2];
> @@ -761,8 +779,6 @@ int cmd_show_branch(int ac, const char **av, const =
char *prefix)
>  		for (i =3D 0; i < reflog; i++) {
>  			char *logmsg;
>  			char *nth_desc;
> -			const char *msg;
> -			char *end;
>  			timestamp_t timestamp;
>  			int tz;
> =20
> @@ -773,16 +789,8 @@ int cmd_show_branch(int ac, const char **av, const=
 char *prefix)
>  				break;
>  			}
> =20
> -			end =3D strchr(logmsg, '\n');
> -			if (end)
> -				*end =3D '\0';
> -
> -			msg =3D (*logmsg =3D=3D '\0') ? "(none)" : logmsg;
> -			reflog_msg[i] =3D xstrfmt("(%s) %s",
> -						show_date(timestamp, tz,
> -							  DATE_MODE(RELATIVE)),
> -						msg);
> -			free(logmsg);
> +			reflog_msg[i] =3D fmt_reflog(logmsg, timestamp, tz,
> +						   "(%s) %s");
> =20
>  			nth_desc =3D xstrfmt("%s@{%d}", *av, base+i);
>  			append_ref(nth_desc, &oid, 1);
