Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0A9EE14C3
	for <git@archiver.kernel.org>; Sat,  9 Sep 2023 22:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345062AbjIIW0l (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Sep 2023 18:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235260AbjIIW0l (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2023 18:26:41 -0400
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E3819E
        for <git@vger.kernel.org>; Sat,  9 Sep 2023 15:26:36 -0700 (PDT)
Message-ID: <0a0a157f88321d25fdb0be771a454b3410a449f3.camel@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1694298391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vN498ZSBHcICH0bVcLqnLd2Buz5ywCh+Ilk8y3Nq0Jo=;
        b=C+zvaV0roG2ai+m+IWEEBTPSOdyPiX6nHfXsxPrjWywhmMCb9ervF/8zgN8MRKlIGJeutx
        pRVPGwmijcW8Lz0ZDHKUswuz/GMBqnC/yaVdnditfXX6xXzVQ58Ew1Z9CSbSUwm/TuZl8V
        5YPWvdUmD3pabYDQu08cMgpshMtEadv8ttlglyI+4EiRBox/MC/EywxvIjeCJEXfjHa3Rj
        ayIBk30q+gN2pI5nTt2KqWFdfvb9RKBxr+TLxvBKUyo9S8dRsVl5ELjQt7s/V3lYLsjJ6Y
        l3ur3tnggvXPJ/u7H31MaIylt5saDgswFzVx52CJ0juuieMhoFl2fMsR1oqeXHdnzJsrXs
        MC2eCYHdbFsO3DdNH1iTdk2kjDSJrRAVgjnGye5HDZY88oFQZML301hKko7h4bsrzOmnGA
        hZPZRH2FTtg+ah6F+2mWgkIvK2oKFJXedSjha2pbpP+oi1s2aa3I2/YbAkVnVp01Hsx22C
        V6/uCP0pNc2wRlxyTK1KcMtUz0bJkO5HWn6nXILV5pOoks4yh50x0ft/HzPftci5qRdhOd
        8cnKwpxQ5oUaQ7V2keZopgk1pgJoRb3bPtHOvIbbUPF80c0ih1lFAJaFmfA/CECuv8QJBy
        uUikJArdqCm0xqIarDorl55nNS7hfpC8AuGet9VjNl2xX5mqXW66M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1694298391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vN498ZSBHcICH0bVcLqnLd2Buz5ywCh+Ilk8y3Nq0Jo=;
        b=hS3idGxsGhV+auFU3sI60XSiDZM7DxHWYiAg9qMsfxLG7uNNCtf4upvNxqSwItIF3Gf5ub
        BbreYMQ1KwDj79Aw==
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=heftig smtp.mailfrom=heftig@archlinux.org
Subject: Bug: git submodule set-url does not handle name != path correctly
From:   "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>
To:     git@vger.kernel.org
Date:   Sun, 10 Sep 2023 00:26:30 +0200
In-Reply-To: <cafa28e0bfe1f603204a74f619ac713518989a40.camel@archlinux.org>
References: <cafa28e0bfe1f603204a74f619ac713518989a40.camel@archlinux.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2023-07-24 at 06:21 +0200, Jan Alexander Steffens (heftig)
wrote:
> Hi,
>=20
> I've encountered this problem with the flatpak-builder repository:
>=20
> https://github.com/flatpak/flatpak-builder/blob/main/.gitmodules
>=20
> [submodule "libglnx"]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0path =3D subprojects/libg=
lnx
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0url =3D https://gitlab.gn=
ome.org/GNOME/libglnx.git
> [submodule "debugedit"]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0path =3D subprojects/debu=
gedit
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0url =3D https://sourcewar=
e.org/git/debugedit.git
>=20
> After 'git submodule init', using 'git submodule set-url libglnx foo'
> successfully modifies .gitmodules but does not touch .git/config.
> However, a subsequent 'git submodule sync' does sync the modified url
> to the local config.
>=20
> I've investigated a bit and it seems 'git submodule set-url' calls
> sync_submodule with "libglnx" as the path, which does not work, while
> 'git submodule sync' calls it with "subprojects/libglnx" as the path,
> which does work.
>=20
> Greetings,
> Jan

Friendly bump.

The docs say set-url needs the path to the submodule, not its name, so
it should be 'git submodule set-url subprojects/libglnx foo'.

However, using that actually creates a new
'submodule.subprojects/libglnx.url' option instead of modifying the
existing 'submodule.libglnx.url'.

It looks like set-url needs to translate the path to the name for
modifying .gitmodules but does not do so.

'git submodule set-branch' is also affected by this.

