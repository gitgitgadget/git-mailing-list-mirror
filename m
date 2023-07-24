Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D0BEB64DD
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 04:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjGXE2n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 00:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjGXE2l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 00:28:41 -0400
X-Greylist: delayed 439 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 23 Jul 2023 21:28:39 PDT
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1771185
        for <git@vger.kernel.org>; Sun, 23 Jul 2023 21:28:39 -0700 (PDT)
Message-ID: <cafa28e0bfe1f603204a74f619ac713518989a40.camel@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1690172475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vtmDbuaD5EXHTotIeOTid+rrzGK5t/fIH8Qr4bKVwVI=;
        b=lf14CyhagIVqJAmeGxcV184bisTQs5IHZWsZz3DZkqaEeWTF3bogSTERMaqgzWc0E9EHWv
        ewyO6amqWyX6T3DZIgjm98y6tGnMQ34UWosfisEZi21btkc4szsWL3njIa1zyUsirX7N2q
        lVKAIPk1yO9CwJNPZiPhe43DwBJp4BaliyI2DJ9+ju1kD2nt1NpOmZpPJ42chD8dwJcFda
        7XCHIGWcCQ3PIg1Ds5ZybIK7YMnbKpHFE735ldhWNUuA9w3eDqdIvr3mX496rdOzoJgkCL
        MOUMDNmruj6C48z35PpfQGrj0qDGM/FvFuGC6xotYi/0Vs+nLJWojKo0FgJYrCs75q82lB
        oDFSYchMNG2/p0j/oiC+jeNpK1Y49w1+smtMWwrQaJzBe6Ywp2SQXMWQRqe3BZwSVY+vFo
        uP50vxa5UZiG5XP/+iYSY3Jg9sKHEDWO4EGBg+aTlbM+NTpWttYFbow3W1w4OkeKCAcHQH
        fxbWLC+Hs4T+3Pyo75ycfXVgDfyvodGal5b3seu9TUpGG0KdeQv/OVVg2MDKvILCSIVYlr
        ON8OpITCUUzcv3Eho6JSJOHf+DIvwFgoeIzrsINlMmwG8paHFDZw7jkudYsYbECohptq4K
        XBjNXxrj8+mjVTgSgkZJJuUNbrKHdy034nh8UPgLLkxqmHvHg6Ve8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1690172475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vtmDbuaD5EXHTotIeOTid+rrzGK5t/fIH8Qr4bKVwVI=;
        b=WHSfLTnhVQqVtjz5tW4IpliBuGoIErd8t3ys4l/m7rPrOApQZYbdNy8ukJPU6FX/0WM/7j
        d8AF4+nWVjtqUZAw==
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=heftig smtp.mailfrom=heftig@archlinux.org
Subject: git submodule set-url does not sync when name != path
From:   "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>
To:     git@vger.kernel.org
Date:   Mon, 24 Jul 2023 06:21:14 +0200
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi,

I've encountered this problem with the flatpak-builder repository:

https://github.com/flatpak/flatpak-builder/blob/main/.gitmodules

[submodule "libglnx"]
	path =3D subprojects/libglnx
	url =3D https://gitlab.gnome.org/GNOME/libglnx.git
[submodule "debugedit"]
	path =3D subprojects/debugedit
	url =3D https://sourceware.org/git/debugedit.git

After 'git submodule init', using 'git submodule set-url libglnx foo'
successfully modifies .gitmodules but does not touch .git/config.
However, a subsequent 'git submodule sync' does sync the modified url
to the local config.

I've investigated a bit and it seems 'git submodule set-url' calls
sync_submodule with "libglnx" as the path, which does not work, while
'git submodule sync' calls it with "subprojects/libglnx" as the path,
which does work.

Greetings,
Jan
-----BEGIN PGP SIGNATURE-----

iIsEARYIADMWIQQGaHodnU+rCLUP2Ss7lKgOUKR3xwUCZL38OhUcaGVmdGlnQGFy
Y2hsaW51eC5vcmcACgkQO5SoDlCkd8cfsAD+M6POceTxAkFpnnmAH7j3RYLBEjFP
w4kzY3U0UPVMU3wBAIPRBGjiwGFp/ws/iMeGQKif1E0ElqcxEbFAQ36HytIG
=3D4OVq
-----END PGP SIGNATURE-----
