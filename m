Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20024C001DB
	for <git@archiver.kernel.org>; Thu,  3 Aug 2023 16:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbjHCQOB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Aug 2023 12:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjHCQOA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2023 12:14:00 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627E5173F
        for <git@vger.kernel.org>; Thu,  3 Aug 2023 09:13:59 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AD22E1A8841;
        Thu,  3 Aug 2023 12:13:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4nh8Ue56VdUj
        0QWSx8+1/ohw26SoFK6o0ZMhQ4IwIl8=; b=de6SJ1BMxLBPXu9fXRfw6BqBePfW
        DeP5jUpBJYIQbsteOW3miBtU3WLeyFeSwW0WeBrzC4qcO2l1y1LKOJxY6r2GNBAz
        pYJC9+2rqHcMAH/CqNz5uj3Mu1sY5ZtIbCd/oWpMAjEweENBHYVtoEhJ98DLZeVz
        PXGQFbpOxDxxH70=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A54F71A8840;
        Thu,  3 Aug 2023 12:13:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0DA6C1A883F;
        Thu,  3 Aug 2023 12:13:57 -0400 (EDT)
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
Subject: Re: [PATCH 2/3] run-command: teach locate_in_PATH about Windows
References: <pull.1560.git.1691058498.gitgitgadget@gmail.com>
        <bf8b34aaef32a64b85f778ab219aeb41238f2bf2.1691058498.git.gitgitgadget@gmail.com>
Date:   Thu, 03 Aug 2023 09:13:56 -0700
In-Reply-To: <bf8b34aaef32a64b85f778ab219aeb41238f2bf2.1691058498.git.gitgitgadget@gmail.com>
        ("Matthias =?utf-8?Q?A=C3=9Fhauer?= via GitGitGadget"'s message of "Thu, 03
 Aug 2023
        10:28:17 +0000")
Message-ID: <xmqq7cqc5cjf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C03AD220-3218-11EE-87A9-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthias A=C3=9Fhauer via GitGitGadget"  <gitgitgadget@gmail.com>
writes:

> diff --git a/run-command.c b/run-command.c
> index 60c94198664..8f518e37e27 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -182,13 +182,10 @@ int is_executable(const char *name)
>   * Returns the path to the command, as found in $PATH or NULL if the
>   * command could not be found.  The caller inherits ownership of the m=
emory
>   * used to store the resultant path.
> - *
> - * This should not be used on Windows, where the $PATH search rules
> - * are more complicated (e.g., a search for "foo" should find
> - * "foo.exe").
>   */
>  static char *locate_in_PATH(const char *file)
>  {
> +#ifndef GIT_WINDOWS_NATIVE
>  	const char *p =3D getenv("PATH");
>  	struct strbuf buf =3D STRBUF_INIT;
> =20
> @@ -217,6 +214,9 @@ static char *locate_in_PATH(const char *file)
> =20
>  	strbuf_release(&buf);
>  	return NULL;
> +#else
> +	return mingw_path_lookup(file,0);
> +#endif
>  }

It may be cleaner to make the above more like

	#ifndef locate_in_PATH
	static char *locate_in_PATH(const char *file)
	{
	    ... original implementation without any #ifdef ...
	}
	#endif

and redo the [1/3] patch so that it does not rename or otherwise
touch path_lookup() in any way, and instead implements a
mingw_locate_in_PATH() in terms of path_lookup() and make it public,
declare it in <compat/mingw.h>, together with #define
locate_in_PATH(), i.e. [1/3] will essentially become something like:

    (add to compat/mingw.c)
    char *mingw_locate_in_PATH(const char *file)
    {
	return path_lookup(file, 0);
    }

    (add to compat/mingw.h)
    extern char *mingw_locate_in_PATH(const char *);
    #define locate_in_PATH(file) mingw_locate_in_PATH(file)

That way, the second non-UNIXy system can add its own way to locate
an executable in PATH without having to touch the main part of the
system, right?
