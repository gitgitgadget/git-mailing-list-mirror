Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA2DC433EF
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 00:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiAVAdx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 19:33:53 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55746 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiAVAdv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 19:33:51 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 896FE15CD03;
        Fri, 21 Jan 2022 19:33:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0R5mrUazBXq9
        Wn7ozgpxe/wnYJLuXhtfeDqhBFEchjA=; b=Wv8AnURs2QwYt7QBtxlBLwkfdIwT
        oWl4FQSBiLPUqsGvt11NcRHucAol8gcft1Pg+Rk9lh+cXKpQK5In23FKMmgND7T6
        SYmbOFv4WbYvVVNnL5TwfkPIw40bTA54qHfrx/O4glWoV5zkdQ8V5Fu6d+Y1e07v
        fFUR57jjnpewt28=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 834CF15CD02;
        Fri, 21 Jan 2022 19:33:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E683C15CD00;
        Fri, 21 Jan 2022 19:33:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Todd Zullinger <tmz@pobox.com>,
        Petr =?utf-8?B?xaBwbMOtY2hhbA==?= <psplicha@redhat.com>
Subject: Re: [PATCH] checkout: fix BUG() case in 9081a421a6
References: <YemTGQZ97vAPUPY0@pobox.com>
        <patch-1.1-21ddf7c628d-20220120T212233Z-avarab@gmail.com>
Date:   Fri, 21 Jan 2022 16:33:47 -0800
In-Reply-To: <patch-1.1-21ddf7c628d-20220120T212233Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 20 Jan
 2022 22:26:57 +0100")
Message-ID: <xmqqr190d2xg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F74658EA-7B1A-11EC-95E7-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 6a5dd2a2a22..52a47ef40e1 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1090,13 +1090,10 @@ static int switch_branches(const struct checkou=
t_opts *opts,
>  		FREE_AND_NULL(old_branch_info.path);
> =20
>  	if (old_branch_info.path) {
> -		const char *const prefix =3D "refs/heads/";
> -		const char *p;
> -		if (skip_prefix(old_branch_info.path, prefix, &p))
> -			old_branch_info.name =3D xstrdup(p);
> -		else
> -			BUG("should be able to skip past '%s' in '%s'!",
> -			    prefix, old_branch_info.path);
> +		const char *p =3D old_branch_info.path;
> +
> +		skip_prefix(old_branch_info.path, "refs/heads/", &p);
> +		old_branch_info.name =3D xstrdup(p);
>  	}

What we want is a faithful reversion wrt the behaviour, while
keeping the leakfix.

The old code did

	skip_prefix(old_branch_info.path, "refs/heads", &old_branch_info.name);

meaning that old_branch_info.name is left unchanged if .path did not
begin with "refs/heads".

The function that uses old_branch_info.name prepared at this point
in the flow is merge_working_tree(), where it uses .name for the
textual label for the "ancestor" tree.  It is preferrable to have a
branch name, but the code is prepared to see NULL in there, where it
comes up with an abbreviated commit object name.

                o.ancestor =3D old_branch_info->name;
                if (old_branch_info->name =3D=3D NULL) {
                        strbuf_add_unique_abbrev(&old_commit_shortname,
                                                 &old_branch_info->commit=
->object.oid,
                                                 DEFAULT_ABBREV);
                        o.ancestor =3D old_commit_shortname.buf;
                }

As 9081a421a6 properly 0-initializes old_branch_info, I think it is
sufficient to just drop the "else BUG" clause; we shouldn't have to
copy the .path that does not begin with "refs/heads/" there; .name
member would be NULL in such a case.

I do not care too much about reverting the constant that is only
used once into a literal.  So, how about doing it this way instead?

 builtin/checkout.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git i/builtin/checkout.c w/builtin/checkout.c
index 43d0275187..1fb34d537d 100644
--- i/builtin/checkout.c
+++ w/builtin/checkout.c
@@ -1094,9 +1094,6 @@ static int switch_branches(const struct checkout_op=
ts *opts,
 		const char *p;
 		if (skip_prefix(old_branch_info.path, prefix, &p))
 			old_branch_info.name =3D xstrdup(p);
-		else
-			BUG("should be able to skip past '%s' in '%s'!",
-			    prefix, old_branch_info.path);
 	}
=20
 	if (opts->new_orphan_branch && opts->orphan_from_empty_tree) {
