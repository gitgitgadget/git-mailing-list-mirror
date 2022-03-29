Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD72C433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 20:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiC2Uhg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 16:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiC2Uhf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 16:37:35 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9C2443DA
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 13:35:50 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E384C10C225;
        Tue, 29 Mar 2022 16:35:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=J9e1GztaZ2y4
        EOXYxF3tq747LeksjeGYiPphk9Wp+f8=; b=l/drs1pNVXrtqzudEBw8vH43/Vdn
        hp/0ER7l/fdIC6XJEWLPK5phWG1hVazTcevmaG8AM9TcecyJuejmVjXm6TygbHjm
        OsYkA7vXUgfGH7RjKMOY+tXrVj13q2F3B0wwg99oGFsuC0eB3/1J+wto1BiOWqHU
        6AMVtzT0mBLcHdk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D9F0F10C222;
        Tue, 29 Mar 2022 16:35:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 47FC310C221;
        Tue, 29 Mar 2022 16:35:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com
Subject: Re: [PATCH v3 0/3] object-info: add option for retrieving object info
References: <20220208235631.732466-1-calvinwan@google.com>
        <20220328191112.3092139-1-calvinwan@google.com>
Date:   Tue, 29 Mar 2022 13:35:48 -0700
In-Reply-To: <20220328191112.3092139-1-calvinwan@google.com> (Calvin Wan's
        message of "Mon, 28 Mar 2022 19:11:09 +0000")
Message-ID: <xmqq35j0ts2j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D19E674A-AF9F-11EC-875A-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> Sometimes it is useful to get information about an object without
> having to download it completely. The server logic has already been
> implemented as =E2=80=9Ca2ba162cda (object-info: support for retrieving=
 object
> info, 2021-04-20)=E2=80=9D. This patch implements the client option for=
 it.
>
> Add =E2=80=98--object-info=E2=80=99 option to fetch. This option allows=
 the client to
> make an object-info command request to a server that supports protocol
> v2. If the server is v2, but does not allow for the object-info
> command request, the entire object is fetched instead and the relevant
> information is returned.
>
> Patch 1 is a small refactor. Patch 2 adds a config option for
> advertisement of object-info.  Patch 3 is the main implementation of
> fetch object-info.
>
> Major changes since v2:
>  * Added a fallback for servers that do not
>    allow object-info
>  * Refactored the fetch object-info code by moving it to fetch_refs in
>    the vtable rather than having its own function in the vtable. This
>    allows for the code to easily transition to the fallback if
>    object-info fails.
>
> Calvin Wan (3):
>   fetch-pack: refactor how packet is written to be more generic
>   objectinfo.advertise: add config option to advertise object-info
>   object-info: add option for retrieving object info
>
>  Documentation/config/transfer.txt |   4 +
>  Documentation/fetch-options.txt   |   5 ++
>  Documentation/git-fetch.txt       |   1 +
>  builtin/fetch.c                   |  36 +++++++-
>  fetch-pack.c                      |  66 ++++++++++----
>  fetch-pack.h                      |   9 ++
>  protocol-caps.c                   |  11 +++
>  protocol-caps.h                   |   6 ++
>  serve.c                           |   2 +-
>  t/t5583-fetch-object-info.sh      | 138 ++++++++++++++++++++++++++++++
>  transport-helper.c                |   8 +-
>  transport-internal.h              |   1 +
>  transport.c                       |  75 +++++++++++++++-
>  transport.h                       |   9 ++
>  14 files changed, 349 insertions(+), 22 deletions(-)
>  create mode 100755 t/t5583-fetch-object-info.sh
>
>
> base-commit: f01e51a7cfd75131b7266131b1f7540ce0a8e5c1

I am getting the following failures when they are queued on this
base, or on a more recent tip of 'master/main'.

Test Summary Report
-------------------
t5555-http-smart-common.sh (Wstat: 256 Tests: 10 Failed: 1)
  Failed test:  9
  Non-zero exit status: 1
t5583-fetch-object-info.sh (Wstat: 256 Tests: 11 Failed: 1)
  Failed test:  5
  Non-zero exit status: 1
t5701-git-serve.sh        (Wstat: 256 Tests: 20 Failed: 2)
  Failed tests:  1, 20
  Non-zero exit status: 1
