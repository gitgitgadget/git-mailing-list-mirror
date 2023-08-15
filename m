Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A5EC001B0
	for <git@archiver.kernel.org>; Tue, 15 Aug 2023 20:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239110AbjHOUw1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Aug 2023 16:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239993AbjHOUwR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2023 16:52:17 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965D610D1
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 13:52:08 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A3C9E2FA40;
        Tue, 15 Aug 2023 16:52:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=045hRPtJQyDF
        HiwwlOPsxFqCSMj5tl53hbDTyJ2TiDk=; b=BE8XzySWawHpkQIpxQt2lluBguRy
        uA+r2GncI9f2rixwK2n2a+BlA4jx3Tfb65OlBNf58lRiuv4xiuW2kwoAdRDiht8H
        inTjC2ICLqA1FIYyPUDzKVac7ocHklWsAmWs3uWVlUPZtMl6TuHFdunCevEeRsq9
        u3ZmWEi6CUPkxsA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9C0482FA3F;
        Tue, 15 Aug 2023 16:52:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 43C042FA3E;
        Tue, 15 Aug 2023 16:52:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [Bug???] In `git-rev-list(1)`, using the `--objects` flag
 doesn't work well with the `--not` flag, as non-commit objects are not
 excluded
References: <CAOLa=ZQmjroDiOcUsu_MHtQ-88QHU9qeZPOPh+KJJ3dFoF2q0A@mail.gmail.com>
Date:   Tue, 15 Aug 2023 13:52:01 -0700
In-Reply-To: <CAOLa=ZQmjroDiOcUsu_MHtQ-88QHU9qeZPOPh+KJJ3dFoF2q0A@mail.gmail.com>
        (Karthik Nayak's message of "Tue, 15 Aug 2023 18:44:18 +0200")
Message-ID: <xmqq350khvv2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 95C189C8-3BAD-11EE-A830-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Karthik Nayak <karthik.188@gmail.com> writes:

> Hello!
>
> What did you do before the bug happened? (Steps to reproduce your issue=
)
>
> Assume a repository structure as follows:
>
> - commit1 9f2aa2eb987c2281bb4901dbccd1398ad2c39722
>   - tree: 205f6b799e7d5c2524468ca006a0131aa57ecce7
>     - 100644 blob 257cc5642cb1a054f08cc83f2d943e56fd3ebe99    foo
>       - content: foo
> - commit2 9e02481f4df3a8997335b0a68882580e3b9b588f (parent:
> 9f2aa2eb987c2281bb4901dbccd1398ad2c39722)
>   - tree: 672d0aa883d095369c56416587bc397eee4ac37e
>     - 100644 blob 257cc5642cb1a054f08cc83f2d943e56fd3ebe99    foo
>       - content: foo
>     - 100644 blob eec8c88a93f6ee1515fb8348f2c122cfda4302cd    moo
>       - content: moo
> - commit3 91fa9611a355db77a07f963c746d57f75af380da (parent:
> 9e02481f4df3a8997335b0a68882580e3b9b588f)
>    - tree 0c16a6cc9eef3fdd3034c1ffe2fc5e6d0bba2192
>      - tree 086885f71429e3599c8c903b0e9ed491f6522879    bar
>        - 100644 blob 7a67abed5f99fdd3ee203dd137b9818d88b1bafd    goo
>          - content: goo
>      - 100644 blob 257cc5642cb1a054f08cc83f2d943e56fd3ebe99    foo
>        - content: foo
>      - 100644 blob eec8c88a93f6ee1515fb8348f2c122cfda4302cd    moo
>        - content: moo
>      - 100644 blob 8baef1b4abc478178b004d62031cf7fe6db6f903    abc
>        - content: abc
> - commit4 6b52ed5b176604a0740689b5bb9be7bd79f4bced (parent:
> 9f2aa2eb987c2281bb4901dbccd1398ad2c39722)
>   - tree ff05824d2f76436c61d2c971e11a27514aba6948
>     - tree 086885f71429e3599c8c903b0e9ed491f6522879    bar
>       - 100644 blob 7a67abed5f99fdd3ee203dd137b9818d88b1bafd    goo
>         - content: goo
>     - 100644 blob 257cc5642cb1a054f08cc83f2d943e56fd3ebe99    foo
>       - content: foo
>     - 100644 blob 8baef1b4abc478178b004d62031cf7fe6db6f903    abc
>       - content: abc

The differences in commit object names become distracting, but I do
not think your example depends on them, so a minimum reproduction
recipe should be

	$ rm -fr new ; git init new ; cd new
	$ echo foo >foo
	$ git add -A; git commit -m one; git rev-parse HEAD:
	205f6b799e7d5c2524468ca006a0131aa57ecce7
	$ echo moo >moo
	$ git add -A; git commit -m two; git rev-parse HEAD:
	672d0aa883d095369c56416587bc397eee4ac37e
	$ mkdir bar; echo goo >bar/goo; echo abc >abc
	$ git add -A; git commit -m three; git rev-parse HEAD:
	0c16a6cc9eef3fdd3034c1ffe2fc5e6d0bba2192
	$ git rm moo; git commit -m four; git rev-parse HEAD:
	ff05824d2f76436c61d2c971e11a27514aba6948

	$ git rev-list --objects HEAD^..HEAD
	5a1b93c9c4c0c9e5c969f8e0b92a02184f8f9aab
	ff05824d2f76436c61d2c971e11a27514aba6948

that output lists HEAD and HEAD^{tree} in this order, which seems to
be what you are expecting.

I am consistently getting the same result with Git 2.42-rc2, 2.41,
2.21, and 2.20 (I do not have ones older than 2.20 around).

> What did you expect to happen? (Expected behavior)
>
> In such a repository, the output for the command, should have the
> output provided below
>
> =E2=9D=AF git rev-list --objects 6b52ed5b176604a0740689b5bb9be7bd79f4bc=
ed
> --not 91fa9611a355db77a07f963c746d57f75af380da
> 6b52ed5b176604a0740689b5bb9be7bd79f4bced
> ff05824d2f76436c61d2c971e11a27514aba6948
>
> What happened instead? (Actual behavior)
>
> Instead, the output is as follows:
>
> =E2=9D=AF git rev-list --objects 6b52ed5b176604a0740689b5bb9be7bd79f4bc=
ed
> --not 91fa9611a355db77a07f963c746d57f75af380da
> 6b52ed5b176604a0740689b5bb9be7bd79f4bced
> ff05824d2f76436c61d2c971e11a27514aba6948
> 8baef1b4abc478178b004d62031cf7fe6db6f903 abc
> 086885f71429e3599c8c903b0e9ed491f6522879 bar
> 7a67abed5f99fdd3ee203dd137b9818d88b1bafd bar/goo

So, there is something else going on in *your* build of Git, or the
repository you prepared for testing, or both.

