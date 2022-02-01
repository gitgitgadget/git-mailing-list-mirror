Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29379C433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 21:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236485AbiBAV6n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 16:58:43 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60901 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236439AbiBAV6l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 16:58:41 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B3FA7105091;
        Tue,  1 Feb 2022 16:58:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nkQsX7rRniIW
        hVkaSaUUIJH8Cj+WaKLXvdQmJece6JQ=; b=qw1Apkome30Tdlddq33w6htaYnzY
        pGH6LtzGBQevMqxXewWtHs+3jJHTv2HRd503LMxVp+vri+GVvyXz1u1DI9d28q7k
        YCYg9qgxXYzpaDVPeUvdSP6ZN2fotBXdAuvM+b3k/+GgFqXAMeqwkXVfcJGbLyrC
        kw+DjrzDCf+Q7+k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ABBC7105090;
        Tue,  1 Feb 2022 16:58:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1380410508F;
        Tue,  1 Feb 2022 16:58:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: Re: [PATCH] perl Git.pm: don't ignore signalled failure in
 _cmd_close()
References: <patch-1.1-86353c3b366-20220201T205218Z-avarab@gmail.com>
Date:   Tue, 01 Feb 2022 13:58:38 -0800
In-Reply-To: <patch-1.1-86353c3b366-20220201T205218Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 1 Feb
 2022 21:52:52 +0100")
Message-ID: <xmqqwnieb65t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1D4DE53E-83AA-11EC-97AD-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Fix misbehavior in Git.pm that dates back to the very first version of
> the library in git.git added in b1edc53d062 (Introduce Git.pm (v4),
> 2006-06-24). When we fail to execute a command we shouldn't ignore all
> signals, those can happen e.g. if abort() is called, or if the command
> segfaults.

Good find.

> All of our tests pass even without the SIGPIPE exception being added
> here, but as the code appears to have been trying to ignore it let's
> keep ignoring it for now.
>

Sounds OK-ish to me.

> +sub _is_sig {
> +	my ($v, $n) =3D @_;
> +
> +	# We are avoiding a "use POSIX qw(SIGPIPE SIGABRT)" in the hot
> +	# Git.pm codepath.
> +	require POSIX;
> +	no strict 'refs';
> +	$v =3D=3D *{"POSIX::$n"}->();
> +}



