Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FCC91F406
	for <e@80x24.org>; Thu, 28 Dec 2017 19:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753755AbdL1TXc (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 14:23:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56731 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751220AbdL1TXb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 14:23:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C35AFCA877;
        Thu, 28 Dec 2017 14:23:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=R2B8cfM0caWn
        6JvwZxwIyhdwvMs=; b=wi9I9NU+rfET3+12FnaH5JdruxCIt/kIbbtV00ED/e9T
        JHiAuN3qb/Ci84OiQACUmihhnbuU63An69hmFwg32NKaCyrs+VIp/oHvJwut0+7A
        778gC4NQAnxdTDZkHLCWD+DP5K/Dy6Aig9e2vAguY7I80Tw8KiZehFY8pL8XVSo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=yI3vKV
        ZpMFRXyOZTbVRdKmhCP5VjCh+j8UTiXvFOcg1AyIZQ+OW8+QxSAqQgz7JOrKftM4
        +wlQkJnLgDNaTs1oQHJ6MomJqQx/NllDLxeV93PwEnyyLrS35/l6fg8vP45OEBlq
        z6f3xs9p4fMu/QhrzgSF2hrlATdMyCAwhBkug=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF13FCA876;
        Thu, 28 Dec 2017 14:23:30 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 16DEDCA875;
        Thu, 28 Dec 2017 14:23:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     suzuki toshiya <mpsuzuki@hiroshima-u.ac.jp>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-archive: accepts --owner --group aslike GNU tar.
References: <20171228090527.25056-1-mpsuzuki@hiroshima-u.ac.jp>
Date:   Thu, 28 Dec 2017 11:23:28 -0800
In-Reply-To: <20171228090527.25056-1-mpsuzuki@hiroshima-u.ac.jp> (suzuki
        toshiya's message of "Thu, 28 Dec 2017 18:05:27 +0900")
Message-ID: <xmqqy3lmk66n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 96249B48-EC04-11E7-B479-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

suzuki toshiya <mpsuzuki@hiroshima-u.ac.jp> writes:

> Current tar output by git-archive has always root:root.

Thanks for a patch.  On top of =C3=86var's comments...

> ...
> * t/t5005-archive-uid-gid.sh: a test script comparing
>   uid, gid, uname, gname between the options and
>   generated tar file.
> ---

Before the "---" line, we need to get the patch signed off by the
author (see Documentation/SubmittingPatches).

> diff --git a/archive-tar.c b/archive-tar.c
> index c6ed96ee7..8546a6229 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -204,10 +204,10 @@ static void prepare_header(struct archiver_args *=
args,
>  	xsnprintf(header->size, sizeof(header->size), "%011lo", S_ISREG(mode)=
 ? size : 0);
>  	xsnprintf(header->mtime, sizeof(header->mtime), "%011lo", (unsigned l=
ong) args->time);
> =20
> -	xsnprintf(header->uid, sizeof(header->uid), "%07o", 0);
> -	xsnprintf(header->gid, sizeof(header->gid), "%07o", 0);
> -	strlcpy(header->uname, "root", sizeof(header->uname));
> -	strlcpy(header->gname, "root", sizeof(header->gname));
> +	xsnprintf(header->uid, sizeof(header->uid), "%07o", args->uid);
> +	xsnprintf(header->gid, sizeof(header->gid), "%07o", args->gid);
> +	strlcpy(header->uname, args->uname ? args->uname : "root", sizeof(hea=
der->uname));
> +	strlcpy(header->gname, args->gname ? args->gname : "root", sizeof(hea=
der->gname));

Would it be cleaner to make sure aregs->[gu]name is always set
(i.e. stuff "root" when it is not given)?

>  	xsnprintf(header->devmajor, sizeof(header->devmajor), "%07o", 0);
>  	xsnprintf(header->devminor, sizeof(header->devminor), "%07o", 0);
> =20
> diff --git a/archive.c b/archive.c
> index 0b7b62af0..db69041f1 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -8,6 +8,7 @@
>  #include "parse-options.h"
>  #include "unpack-trees.h"
>  #include "dir.h"
> +#include "git-compat-util.h"

The coding guideline says that "git-compat-util.h" (or one of the
well-known header that includes it) should be the first file to be
included, and we already include "cache.h" as the first thing, so
I do not think you want this addition here.

> @@ -417,6 +418,57 @@ static void parse_treeish_arg(const char **argv,
>  	{ OPTION_SET_INT, (s), NULL, (v), NULL, "", \
>  	  PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_HIDDEN, NULL, (p) }
> =20
> +static void set_args_uname_uid(struct archiver_args *args,
> +		const char* tar_owner, int set_gid_too)

The asterisk sticks to the variable name, not the type name, i.e.

	const char *tar_owner

> +{
> +	if (!args || !tar_owner)
> +		return;
> +
> +	const char* col_pos =3D strchr(tar_owner, ':');
> +	struct passwd* pw =3D NULL;

Decl after statement.

> +	if (col_pos) {
> +		args->uname =3D xstrndup(tar_owner, col_pos - tar_owner);
> +		args->uid =3D atoi(col_pos + 1);
> +		return;
> +	}
> +
> +	args->uname =3D xstrndup(tar_owner, strlen(tar_owner));
> +	pw =3D getpwnam(tar_owner);
> +	if (!pw)
> +		return;

This means that upon error, the caller gets a half-filled args
structure and without any indication.

> diff --git a/t/parse-tar-file.py b/t/parse-tar-file.py

Hmph.  Do we still use Python around here?
