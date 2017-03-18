Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61F442095B
	for <e@80x24.org>; Sat, 18 Mar 2017 17:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751778AbdCRR6w (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 13:58:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62180 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751655AbdCRR6v (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 13:58:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C722832DC;
        Sat, 18 Mar 2017 13:54:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8RkFlibKI2JA
        M5C1IkRfOzZuVHg=; b=hlRNvoryxAoIBL7sbwfVTzyrOK7IPzKoWe7w6WOKbvl7
        M8mzVkhx8tmc9oKvIslJMT31UtT/fNRJ/DhTE04C6wieS+HfCKP4XEW6/7qwTVrs
        Z05UXhAtx/7IzbWc4pDYUmoj51PCz0NgLwCyuTsmWJWdVWt3atoFXvneVNwH65E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ChmVvG
        FvL76d3G2WIomEy3yP7Kvkg/QY7gwbdvLZ54nEJ+tZy/sMyAqxY8Je25EfCSA2pr
        bWjDbTe3W6ZqMqQQuR2NsAbMBwhCFY7a/IXWQds2FYqRslYUYx7HXRQoCCzfvSSf
        Mch1TL/n+41a4wsfH3GvzGJf3yq1gW92JTIPM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8403B832DB;
        Sat, 18 Mar 2017 13:54:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E8F91832DA;
        Sat, 18 Mar 2017 13:54:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 1/4] environment.c: fix potential segfault by get_git_common_dir()
References: <20170216120302.5302-1-pclouds@gmail.com>
        <20170318100206.5980-1-pclouds@gmail.com>
        <20170318100206.5980-2-pclouds@gmail.com>
Date:   Sat, 18 Mar 2017 10:54:48 -0700
In-Reply-To: <20170318100206.5980-2-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Sat, 18 Mar 2017 17:02:03 +0700")
Message-ID: <xmqq8to24gif.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FB5CA2F8-0C03-11E7-BA7E-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> setup_git_env() must be called before this function to initialize
> git_common_dir so that it returns a non NULL string. And it must return
> a non NULL string or segfault can happen because all callers expect so.
>
> Normally if somebody has called get_git_dir(), or set_git_dir() then
> setup_git_env() is already called. But if you do setup_git_directory()
> at top dir (which skips set_git_dir) and never call get_git_dir, you'll
> get NULL here.

Hmph, and the solution for the problem not being "so let's make sure
get_git_dir() is called even when the command is started at the top
directory" is because...?

> test-ref-store.c will hit this problem because it's very lightweight,
> just enough initialization to exercise refs code, and get_git_dir() wil=
l
> never be called until get_worktrees() is, which uses get_git_common_dir=
().
> ---

Missing sign-off.



>  environment.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/environment.c b/environment.c
> index 42dc3106d2..2986ee7200 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -214,6 +214,8 @@ const char *get_git_dir(void)
> =20
>  const char *get_git_common_dir(void)
>  {
> +	if (!git_dir)
> +		setup_git_env();
>  	return git_common_dir;
>  }
