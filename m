Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0434BC433FE
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 04:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiJRECj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 00:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiJRECi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 00:02:38 -0400
Received: from box.elsiehupp.com (box.elsiehupp.com [104.131.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F23288DC6
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 21:02:34 -0700 (PDT)
Received: from authenticated-user (box.elsiehupp.com [104.131.30.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by box.elsiehupp.com (Postfix) with ESMTPSA id 838F9FC4AE;
        Tue, 18 Oct 2022 00:02:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=elsiehupp.com;
        s=mail; t=1666065751;
        bh=daPxN8S+NUWcthlYLkS11EjIQ7MamaTHrixm47QffYU=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=ldJ0Ajc7F/eyqVDQqhztn/Wyg1jC8UYq8zRzsABf0HS8UcGM2jNOfhWZ3nEiLfKUr
         gcXQhhLgCAA/AZVstV1WkwCPR1SxbrPKK0NZVBKup/wQYKmRIwCNEEIEXvWm9y6Ndt
         wyrKTltIre3G5l10CblCAs2XLoN5wLfUmBen6dR90YxeS/WApSGzurBBvlvLLW4+y5
         jCwLlaDPORbBeSVrZ7FFUEE16HXUc6WAUUlGXmyrSGXEZ+qimi5yxWaBPDB3vdeFtz
         m0QlArrC7lWun2RojjJC+cpJ0kcqMG3ZKMkINvFhQiceqggEEDAdB9BDGZu9+0eyKJ
         mYDOGhiYyF3FQ==
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0
Subject: Re: Multiple --global config workspaces?
From:   Elsie Hupp <git@elsiehupp.com>
In-Reply-To: <Y0m64fHWIjZoXoTQ@coredump.intra.peff.net>
Date:   Tue, 18 Oct 2022 00:02:30 -0400
Cc:     Junio C Hamano <gitster@pobox.com>, reto@labrat.space,
        philipoakley@iee.email, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <ACFF4036-3DD1-4647-90BB-77F029326715@elsiehupp.com>
References: <C4E3A512-2E2C-4EA5-9F2E-3662BCF0F165@elsiehupp.com>
 <xmqqwn96x61t.fsf@gitster.g> <Y0Vr/4IeA236nxzF@coredump.intra.peff.net>
 <03B277AB-DE33-443D-AC9C-FAB7A2F93AB3@elsiehupp.com>
 <Y0m64fHWIjZoXoTQ@coredump.intra.peff.net>
To:     Jeff King <peff@peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A response to this:

>> And I tried the following to no avail (despite both paths resolving =
when using cat):
>>=20
>> [includeIf "gitdir:github/"] path =3D ./**/github/.gitconfig
>>=20
>> [includeIf "gitdir:github/"] path =3D ./*/github/.gitconfig
>=20
> Right, the value of an include path expands to a single file, and we =
do
> not do any globbing. I suppose it would be possible to do, and we'd =
read
> each file in sequence. But I'm not sure I'm convinced of the utility =
of
> that (and again, it doesn't help the discoverability problem you had).

My thought is that globbing (I=E2=80=99m not sure of the terminology) =
should be supported to the extent that it=E2=80=99s valid bash syntax, =
and breaking consistency with bash could cause more confusion than just =
letting the user do weird or inadvisable things with the path variable =
that nonetheless have entirely predictable outcomes.

So, because, e.g., the following works:

> elsiehupp@Alpha:~$ cat ./**/github/.gitconfig
> [user]
> 	email =3D github@elsiehupp.com

=E2=80=A6one would expect, e.g., this gitconfig line to work, as well:

> [include] path =3D ./**/github/.gitconfig


For comparison, I can also do:

> elsiehupp@Alpha:~$ cat ./**/**/.gitconfig
> [user]
> 	email =3D github@elsiehupp.com
> [user]
> 	email =3D gitlab@elsiehupp.com
> [user]
> 	email =3D gnome@elsiehupp.com
> [user]
> 	email =3D launchpad@elsiehupp.com
> [user]
> 	email =3D github@elsiehupp.com
> [user]
> 	email =3D xdg@elsiehupp.com

If I pipe the above into a new ~/.gitconfig, I can then do:

> elsiehupp@Alpha:~$ git config --get-all user.email
> github@elsiehupp.com
> gitlab@elsiehupp.com
> gnome@elsiehupp.com
> launchpad@elsiehupp.com
> github@elsiehupp.com
> xdg@elsiehupp.com

I don=E2=80=99t know off the top of my head what happens when a single =
variable is defined multiple times. I do get the following output, =
though:

> elsiehupp@Alpha:~$ git config --get user.email
> xdg@elsiehupp.com

Basically one might expect [include] to behave like cat in bash=E2=80=A6 =
more for consistency and predictability than anything else.

None of the various cat command-line options seem particularly =
applicable to [include], so my commentary here mainly concerns [include] =
recognizing and working with path wildcards and the like along otherwise =
established patterns of behavior.

(Now, to change my gitconfig back to the conditional includes=E2=80=A6)

