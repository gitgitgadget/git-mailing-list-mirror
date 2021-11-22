Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB77C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 22:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhKVWud (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 17:50:33 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65121 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhKVWuc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 17:50:32 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 49444F5F34;
        Mon, 22 Nov 2021 17:47:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=UWeN80ZIiJG6
        R+dkYwsHyyuNo6F0SUHVJJZ8dFZxYEQ=; b=Gb5J8D+Nt0p0fF6yyPFCrbCNcGAh
        77YtsfouTQvxcEDDH/Ypnj2R+SmhZ1b9BU33IKBsF0bOGcuN2ePIoPP8cjPPpELX
        F93LNgsWOLd4mYHAYwkCjI3EeXTC8m288ksGDHb44c/DWDa94EKo9OTL3A/qTNxk
        vAj9MbR5Kss70oQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 408CCF5F33;
        Mon, 22 Nov 2021 17:47:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 79929F5F32;
        Mon, 22 Nov 2021 17:47:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com,
        thomas.wolf@paranor.ch, Alexander Veit <alexander.veit@gmx.net>
Subject: Re: [PATCH] editor: only save (and restore) the terminal if using a
 tty
References: <04ab7301-ea34-476c-eae4-4044fef74b91@gmail.com>
        <20211122222850.674-1-carenas@gmail.com>
Date:   Mon, 22 Nov 2021 14:47:22 -0800
In-Reply-To: <20211122222850.674-1-carenas@gmail.com> ("Carlo Marcelo Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Mon, 22 Nov 2021 14:28:50 -0800")
Message-ID: <xmqqee77byf9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2877C4DA-4BE6-11EC-A1D9-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> If the editor is invoked without a controlling terminal, then
> saving the state and restoring it later is not very useful and
> could generate signals that the invoking process wouldn't know
> how to handle.
>
> if git's standard output is not connected to a terminal, then
> presume there is no need to worry if the invoking terminal could
> garble it.
>
> Reported-by: Alexander Veit <alexander.veit@gmx.net>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  editor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/editor.c b/editor.c
> index 674309eed8..214e3834cb 100644
> --- a/editor.c
> +++ b/editor.c
> @@ -86,7 +86,7 @@ static int launch_specified_editor(const char *editor=
, const char *path,
>  		p.env =3D env;
>  		p.use_shell =3D 1;
>  		p.trace2_child_class =3D "editor";
> -		term_fail =3D save_term(1);
> +		term_fail =3D isatty(1) ? save_term(1) : 1;
>  		if (start_command(&p) < 0) {
>  			if (!term_fail)
>  				restore_term();

I am tempted to say that for 2.34.1 we should revert the offending
commit, and for 2.35 and later we should re-queue the offending
commit with this fix squashed in.

Unless it can be verified that this fix just works for the reporter
in 24 hours, that is.

Thanks.
