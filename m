Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23778C47095
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 08:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0617A61364
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 08:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237229AbhFIIMY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 04:12:24 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56955 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236372AbhFIIMX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 04:12:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8E516147845;
        Wed,  9 Jun 2021 04:10:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=2tkgE16vLQhqUKCrHEDfUDD/9
        L/7NkDqAqucdOcGVlE=; b=M9erGTb6MMbjyKlH428fjBSVfRIsAlJiItjjYZ9+i
        Tp/XbeGwBZXeenapQphCaSDt4FIK3OiQnGwLexxrHgXCcO3rDk/LrmiOn8CWe4zB
        zgIZ9nVWQEB4YKk42s8gW+BaK8ylFFLM8T9O0CyfPSuJQUl5eRit0owJwG5ZkFTA
        ho=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 877E8147844;
        Wed,  9 Jun 2021 04:10:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D2B63147841;
        Wed,  9 Jun 2021 04:10:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 3/4] pack-objects.c: do stdin parsing via revision.c's API
References: <cover-0.4-0000000000-20210608T121008Z-avarab@gmail.com>
        <patch-3.4-1a9eb26587-20210608T121008Z-avarab@gmail.com>
Date:   Wed, 09 Jun 2021 17:10:25 +0900
Message-ID: <xmqqk0n3ihla.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 25EFA332-C8FA-11EB-92C7-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> @@ -3761,39 +3789,11 @@ static void get_object_list(int ac, const char =
**av)
>  	/* make sure shallows are read */
>  	is_repository_shallow(the_repository);
> =20
> +	revs.stdin_handling =3D REV_INFO_STDIN_ALWAYS_READ;
> +	revs.handle_stdin_line =3D get_object_list_handle_stdin_line;
> +	revs.stdin_line_priv =3D &flags;
>  	setup_revisions(ac, av, &revs, &s_r_opt);
> =20
> -	save_warning =3D warn_on_object_refname_ambiguity;
> -	warn_on_object_refname_ambiguity =3D 0;
> -
> -	while (fgets(line, sizeof(line), stdin) !=3D NULL) {
> -		int len =3D strlen(line);
> -		if (len && line[len - 1] =3D=3D '\n')
> -			line[--len] =3D 0;
> -		if (!len)
> -			break;
> -		if (*line =3D=3D '-') {
> -			if (!strcmp(line, "--not")) {
> -				flags ^=3D UNINTERESTING;
> -				write_bitmap_index =3D 0;
> -				continue;
> -			}
> -			if (starts_with(line, "--shallow ")) {
> -				struct object_id oid;
> -				if (get_oid_hex(line + 10, &oid))
> -					die("not an object name '%s'", line + 10);
> -				register_shallow(the_repository, &oid);
> -				use_bitmap_index =3D 0;
> -				continue;
> -			}
> -			die(_("not a rev '%s'"), line);
> -		}
> -		if (handle_revision_arg(line, &revs, flags, REVARG_CANNOT_BE_FILENAM=
E))
> -			die(_("bad revision '%s'"), line);
> -	}
> -
> -	warn_on_object_refname_ambiguity =3D save_warning;
> -

OK, so this shows the primary value of the entire series---we
managed to lose handwritten loop around a logic that gets migrated
into a callback function that has been used to read revisions from
the standard input elsewhere in the system.

All four patches are cleanly explained and nicely done.

Thanks.
