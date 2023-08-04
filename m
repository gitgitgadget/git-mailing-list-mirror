Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E056C04A6A
	for <git@archiver.kernel.org>; Fri,  4 Aug 2023 04:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjHDEYB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Aug 2023 00:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjHDEYA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2023 00:24:00 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBAE35BE
        for <git@vger.kernel.org>; Thu,  3 Aug 2023 21:23:59 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E4CEF2E9BC;
        Fri,  4 Aug 2023 00:23:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PIV4namb1azH
        RzR9cjA+J//rhSh1xUIweG8s9DlBp3o=; b=dAwSniL66yzVwCgtY7dIr7ac4w87
        Y0MK2Qj+/cvQAUcPRAM602mRyWd5kijK15itMp0MuSAsN6Fu9HQK8st4t50xcfIx
        zYgXhGWxQXZ9+B1zKa1s/kYmvWDcPl7iGdjwtzfEN6Ftod6QtZuX9C+wUhh0F7Md
        DaJdCAX0RrEqMN4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DCFAB2E9B9;
        Fri,  4 Aug 2023 00:23:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 21E8C2E9B8;
        Fri,  4 Aug 2023 00:23:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Matthias_A=C3=9Fhauer_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Louis Strous <Louis.Strous@intellimagic.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>
Subject: Re: [PATCH v2 2/3] compat/mingw: implement a native locate_in_PATH()
References: <pull.1560.git.1691058498.gitgitgadget@gmail.com>
        <pull.1560.v2.git.1691122124.gitgitgadget@gmail.com>
        <8b8c8c3f70a25f198335e36dfd501ffcb9d411c3.1691122124.git.gitgitgadget@gmail.com>
Date:   Thu, 03 Aug 2023 21:23:53 -0700
In-Reply-To: <8b8c8c3f70a25f198335e36dfd501ffcb9d411c3.1691122124.git.gitgitgadget@gmail.com>
        ("Matthias =?utf-8?Q?A=C3=9Fhauer?= via GitGitGadget"'s message of "Fri, 04
 Aug 2023
        04:08:43 +0000")
Message-ID: <xmqqjzub306e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B952B778-327E-11EE-A40C-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthias A=C3=9Fhauer via GitGitGadget"  <gitgitgadget@gmail.com>
writes:

> From: =3D?UTF-8?q?Matthias=3D20A=3DC3=3D9Fhauer?=3D <mha1993@live.de>
>
> since 5e1f28d (bisect--helper: reimplement `bisect_visualize()` shell
>  function in C, 2021-09-13) `git bisect visualize` uses exists_in_PATH(=
)
> to check wether it should call `gitk`, but exists_in_PATH() relies on
> locate_in_PATH() which currently only understands POSIX-ish PATH variab=
les
> (a list of paths, separated by colons) on native Windows executables
> we encounter Windows PATH variables (a list of paths that often contain
> drive letters (and thus colons), separated by semicolons). Luckily we d=
o
> already have a function that can lookup executables on windows PATHs:
> path_lookup(). Implement a small replacement for the existing
> locate_in_PATH() based on path_lookup().
>
> Reported-by: Louis Strous <Louis.Strous@intellimagic.com>
> Signed-off-by: Matthias A=C3=9Fhauer <mha1993@live.de>
> ---
>  compat/mingw.c | 5 +++++
>  compat/mingw.h | 3 +++
>  2 files changed, 8 insertions(+)

Makes perfect sense ;-)

> diff --git a/compat/mingw.c b/compat/mingw.c
> index d06cdc6254f..bc3669d2986 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1347,6 +1347,11 @@ static char *path_lookup(const char *cmd, int ex=
e_only)
>  	return prog;
>  }
> =20
> +char *mingw_locate_in_PATH(const char *cmd)
> +{
> +	return path_lookup(cmd, 0);
> +}
> +
>  static const wchar_t *wcschrnul(const wchar_t *s, wchar_t c)
>  {
>  	while (*s && *s !=3D c)
> diff --git a/compat/mingw.h b/compat/mingw.h
> index 209cf7cebad..b5262205965 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -175,6 +175,9 @@ pid_t waitpid(pid_t pid, int *status, int options);
>  #define kill mingw_kill
>  int mingw_kill(pid_t pid, int sig);
> =20
> +#define locate_in_PATH mingw_locate_in_PATH
> +char *mingw_locate_in_PATH(const char *cmd);
> +
>  #ifndef NO_OPENSSL
>  #include <openssl/ssl.h>
>  static inline int mingw_SSL_set_fd(SSL *ssl, int fd)
