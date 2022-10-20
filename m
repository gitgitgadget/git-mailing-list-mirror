Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934FAC433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 02:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiJTCaF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Oct 2022 22:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiJTCaD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2022 22:30:03 -0400
Received: from box.elsiehupp.com (box.elsiehupp.com [104.131.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E85DF4197
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 19:29:59 -0700 (PDT)
Received: from authenticated-user (box.elsiehupp.com [104.131.30.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by box.elsiehupp.com (Postfix) with ESMTPSA id 953EEFC4A1;
        Wed, 19 Oct 2022 22:29:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=elsiehupp.com;
        s=mail; t=1666232983;
        bh=F0LlcljwaHDUJJoAmmK/LG6O1JqRlSxrnz6MvquSFoM=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=pOefgtSTSdfPByN+Rq6vZbmNgWjgdzTC8j1rudav0Hx4Z1TISh4pQLv01FPLSaE66
         nicGBmGI50HNVteGDwDO1XTL8NpcNDQWoOwSFn7efPIHXj3rkh2vRHWN4WPW2sjUBl
         Ktl9MCoyXuXw3m8ziUWSgJ8o/P+LvOCh32mDeiq2zSOmBGsYcw+rY3peuxXGD5vDGd
         ouMFTPQhPylMfsJpLzeTc3J+TNdiR1ArRrclHT7RgWpd/KM3CzyHpoK4YmK8yeS7er
         GrawON+N7PotKwcDKTyLeBk4H3OofqcY5WQAVxXvq5fuvd+vopAhIn2I35nk9Hq4zg
         iXoo0E3WFLyIg==
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0
Subject: Re: Multiple --global config workspaces?
From:   Elsie Hupp <git@elsiehupp.com>
In-Reply-To: <Y08SRgwIvDcsWF0Z@coredump.intra.peff.net>
Date:   Wed, 19 Oct 2022 22:29:42 -0400
Cc:     Junio C Hamano <gitster@pobox.com>, reto@labrat.space,
        philipoakley@iee.email, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <90F9456A-6ABC-4555-8127-FF2DB0449EF1@elsiehupp.com>
References: <C4E3A512-2E2C-4EA5-9F2E-3662BCF0F165@elsiehupp.com>
 <xmqqwn96x61t.fsf@gitster.g> <Y0Vr/4IeA236nxzF@coredump.intra.peff.net>
 <03B277AB-DE33-443D-AC9C-FAB7A2F93AB3@elsiehupp.com>
 <Y0m64fHWIjZoXoTQ@coredump.intra.peff.net>
 <ACFF4036-3DD1-4647-90BB-77F029326715@elsiehupp.com>
 <Y08SRgwIvDcsWF0Z@coredump.intra.peff.net>
To:     Jeff King <peff@peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The expansion of the glob is done by the shell. But it is "cat" which =
is
> happy to receive multiple files as input. But many other commands are
> not, and include.path is not.
>=20
> None of which is to say you're wrong to think of it this way. It's a
> perfectly valid mental model. It just happens not to be the mental =
model
> we used when implementing it.

The only reason I thought of trying it in the first place is that while =
reading the git-config documentation, I saw that [include]:gitdir uses =
implicit globbing:

=
https://git-scm.com/docs/git-config#Documentation/git-config.txt-codegitdi=
rcode

> =E2=80=A2 If the pattern does not start with either ~/, ./ or /, **/ =
will be automatically prepended. For example, the pattern foo/bar =
becomes **/foo/bar and would match /any/path/to/foo/bar.
> =E2=80=A2 If the pattern ends with /, ** will be automatically added. =
For example, the pattern foo/ becomes foo/**. In other words, it matches =
"foo" and everything inside, recursively.

Like literally I did not think to try the wildcard characters with =
[include] until the mentions of [include]:gitdir, [include]:onbranch, =
and [include]:hasconfig:remote.*.url suggested it to me.

Admittedly, the examples here are for *implicit* glowing, rather than =
*explicit* globbing, but this support in one way or another does create =
a stronger proximate case for consistency than cat does.

>  1. I'd be more convinced by a concrete use case. It sounds like
>     conditional includes were the real sticking point for yours. Maybe
>     somebody wants to do include.path on ".gitconfig.d/*" or =
something?
>     I dunno.

Basically what I would like as a concrete example is the ability to =
specify the path, e.g., ~/Repositories/github/.gitconfig without having =
to specify the name =E2=80=9CRepositories=E2=80=9D, as other users might =
prefer, e.g., ~/Projects/github/.gitconfig instead.

>> I don=E2=80=99t know off the top of my head what happens when a =
single
>> variable is defined multiple times. I do get the following output,
>> though:
>=20
> It depends on the variable. Most single-value options in Git are "last
> one wins", but some are lists (e.g., remote.*.fetch). We also hold
> config values for other porcelain scripts whose semantics we may not
> even know ourselves. There are options to "git config" for specifying
> how to handle these (e.g., --get-all).

I mean this is where the desired behavior would have to be defined. =46rom=
 my somewhat ignorant position, =E2=80=9Clast one wins=E2=80=9D does =
seem reasonable in the case of, say, user.email.

> if somebody wants to go to the trouble to implement

Yeah this somebody is almost certainly not going to be me, considering =
my complete and utter unfamiliarity with the codebase, among other =
things. =F0=9F=98=AC

As for proceeding, I think what I can do personally is submit a draft =
pull request to the Git Book repository with instructions for how to =
accomplish my own use case as well as, say, the personal/school/work use =
case with the functionality that already exists, and then based on how =
that goes things could go from there=E2=80=A6?

Best,
Elsie

