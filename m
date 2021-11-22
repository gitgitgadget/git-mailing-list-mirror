Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD340C433FE
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 23:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhKVXGo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 18:06:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50513 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhKVXGn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 18:06:43 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D2FCE9D35;
        Mon, 22 Nov 2021 18:03:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rF01xZL9BNmH
        +e6OubGM0O53vKOlgMkKFBkbWSFrjlY=; b=rojxmDJmsYmAUXMqls6aFH9e7EO4
        0VtqtljCsNJb726420GCq4dEzWhYyjroBOny/thi3Ret/swoTvZe4BlTsEZ44edE
        NV2c/hIpXaVqw44vWjrj/QAxzsyqSIQnu09noxgybG71C8y98Ob83a1wkwS0qA4a
        50q7U7g8t5OJXuw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 936C5E9D34;
        Mon, 22 Nov 2021 18:03:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 00BB4E9D33;
        Mon, 22 Nov 2021 18:03:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com,
        thomas.wolf@paranor.ch, Alexander Veit <alexander.veit@gmx.net>
Subject: Re: [PATCH] editor: only save (and restore) the terminal if using a
 tty
References: <04ab7301-ea34-476c-eae4-4044fef74b91@gmail.com>
        <20211122222850.674-1-carenas@gmail.com>
Date:   Mon, 22 Nov 2021 15:03:32 -0800
In-Reply-To: <20211122222850.674-1-carenas@gmail.com> ("Carlo Marcelo Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Mon, 22 Nov 2021 14:28:50 -0800")
Message-ID: <xmqqa6hvbxob.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6B880A3A-4BE8-11EC-8A56-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
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

Shouldn't the logic apply equally to all callers of save_term()?

In other words, why aren't we doing this check inside save_term()
implementation?  i.e. before opening /dev/tty, we can do isatty(1)
and return -1 if it is false, or something?  That way, when we gain
the second caller to save/restore other than editor (prehaps the
pager code path wants to do this?  I dunno), we do not have to
remember that isatty() check must be made before doing save_term(),
no?

In any case, I am quite tempted to just revert the offending topic
for now, but later accept a resurrection patch with this isatty
check rolled in (either at this caller, or inside save_term) when
the dust settles.

Thanks.


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
