Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E07C00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 14:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbiHHOrF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 10:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbiHHOrE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 10:47:04 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F210FB7CF
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 07:47:02 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 600271B1FE2;
        Mon,  8 Aug 2022 10:47:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=wDRT/ogeo4KiO4Y5cWW1ao+MZ
        b9wd3E+Uvn9Brx/kB4=; b=gL4bld+2NmtRdA/vJhK0T+pXdiBMUfLgVqNJ3N1Nw
        06NsYP9KQARmCkKNYarZLuazOG/uEUdZbjcXthihKCNAtcGeEwq89NwwOd9LujFO
        Y5r6OF45wg6g0GLmJSk4UHs/h0VbwuZ0pRfJQmvpMYIXTBSdGqwMXzWWZupVpOhi
        z8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5983F1B1FE1;
        Mon,  8 Aug 2022 10:47:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 048C51B1FDF;
        Mon,  8 Aug 2022 10:46:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n_Justo_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Subject: Re: [PATCH] branch: allow "-" as a short-hand for "previous branch"
References: <pull.1315.git.1659910949556.gitgitgadget@gmail.com>
Date:   Mon, 08 Aug 2022 07:46:57 -0700
Message-ID: <xmqq4jymvllq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F4BA7CE6-1728-11ED-8CE2-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Rub=C3=A9n Justo via GitGitGadget"  <gitgitgadget@gmail.com> writes:

> From: rjusto <rjusto@gmail.com>
>
> Align "branch" with the intuitive use of "-" as a short-hand
> for "@{-1}", like in "checkout" and "merge" commands.
>
> $ git branch -d -      # short-hand for: "git branch -d @{-1}"
> $ git branch -D -      # short-hand for: "git branch -D @{-1}"

The "-d" and "-D" options being the more detructive ones among other
operation modes of the command, I am not sure if this change is even
desirable.  Even if it were, the implementation to special case a
single argument case like this ...

> +	if ((argc =3D=3D 1) && !strcmp(argv[0], "-")) {
> +		argv[0] =3D "@{-1}";
> +	}

... (by the way, we don't write braces around a single statement
block) would invite cries from confused users why none of these ...

 $ git branch -m - new-name
 $ git branch new-branch -
 $ git branch --set-upstream-to=3D<upstream> -
   =20
work and "-" works only for deletion.

So, I dunno.
