Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7318420966
	for <e@80x24.org>; Thu, 30 Mar 2017 18:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934366AbdC3Sit (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 14:38:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51660 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934299AbdC3Sis (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 14:38:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 81C4C6D70D;
        Thu, 30 Mar 2017 14:38:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=QrIAQx9ZLluT
        nBNdJUtNv3jQjyw=; b=qdRD9IRzOsjJNkkZDZ2UIO3gs9wBSVP6bUGLCcxxLaXJ
        kINSgxqAADeS46W/8U63j3CTYMsgvHJ6CpDUMNLT0PaLAJbq8fs9ZBFo3eVDq71D
        xTtZVVWN1YpdjcDCmdf2umSBNKkywMHUBRLqbdmnPyfFfSO/9wwq0GGYoVlLQFM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=E77oyv
        8ZZPtm8+P8yRqSKOqN1UIALFZPftp8e5U8w5QqzoHRw48M7K738WQ/OSsN71o20j
        wDerhvhKj9fRIpOcOQ0hoNUXm5ul5/cyA+CjSf+jjYcMlNKzLbO3xl09vljv8eSE
        JsmNCz7QiC+KMdg7Q1wbLXQjsdLPXnnfVxWhw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7ACF86D70C;
        Thu, 30 Mar 2017 14:38:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E80CD6D70B;
        Thu, 30 Mar 2017 14:38:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, tboegi@web.de
Subject: Re: [PATCH 2/2] config: resolve symlinks in conditional include's patterns
References: <20170325130549.GA20618@ash>
        <20170330113723.20474-1-pclouds@gmail.com>
        <20170330113723.20474-2-pclouds@gmail.com>
Date:   Thu, 30 Mar 2017 11:38:44 -0700
In-Reply-To: <20170330113723.20474-2-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Thu, 30 Mar 2017 18:37:23 +0700")
Message-ID: <xmqqinmq4nkb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1B7EF676-1578-11E7-885D-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> $GIT_DIR returned by get_git_dir() is normalized, with all symlinks
> resolved (see setup_work_tree function). In order to match paths (or
> patterns) against $GIT_DIR char-by-char, they have to be normalized
> too. There is a note in config.txt about this, that the user need to
> resolve symlinks by themselves if needed.
>
> The problem is, we allow certain path expansion, '~/' and './', for
> convenience and can't ask the user to resolve symlinks in these
> expansions. Make sure the expanded paths have all symlinks resolved.

That sounds sensible but I fail to see why 1/2 is the right approach
to do this, and I must be missing something.  Wouldn't you get the
same result if you run realpath() yourself on expanded, after
receiving the return value of expand_user_path() in it?

Can you add a test to demonstrate the issue (which would need to be
protected with SYMLINKS prereq)?

Thanks.

> PS. The strbuf_realpath(&text, get_git_dir(), 1) is still needed becaus=
e
> get_git_dir() may return relative path.
>
> Noticed-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> ---
>  config.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/config.c b/config.c
> index f036c721e6..d5ba848b65 100644
> --- a/config.c
> +++ b/config.c
> @@ -177,7 +177,7 @@ static int prepare_include_condition_pattern(struct=
 strbuf *pat)
>  	char *expanded;
>  	int prefix =3D 0;
> =20
> -	expanded =3D expand_user_path(pat->buf, 0);
> +	expanded =3D expand_user_path(pat->buf, 1);
>  	if (expanded) {
>  		strbuf_reset(pat);
>  		strbuf_addstr(pat, expanded);
> @@ -191,7 +191,7 @@ static int prepare_include_condition_pattern(struct=
 strbuf *pat)
>  			return error(_("relative config include "
>  				       "conditionals must come from files"));
> =20
> -		strbuf_add_absolute_path(&path, cf->path);
> +		strbuf_realpath(&path, cf->path, 1);
>  		slash =3D find_last_dir_sep(path.buf);
>  		if (!slash)
>  			die("BUG: how is this possible?");
> @@ -213,7 +213,7 @@ static int include_by_gitdir(const char *cond, size=
_t cond_len, int icase)
>  	struct strbuf pattern =3D STRBUF_INIT;
>  	int ret =3D 0, prefix;
> =20
> -	strbuf_add_absolute_path(&text, get_git_dir());
> +	strbuf_realpath(&text, get_git_dir(), 1);
>  	strbuf_add(&pattern, cond, cond_len);
>  	prefix =3D prepare_include_condition_pattern(&pattern);
