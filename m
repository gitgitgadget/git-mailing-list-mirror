Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F795C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 11:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbhLHLne (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 06:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbhLHLnA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 06:43:00 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030F0C07E5C5
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 03:38:36 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id p37so4113562uae.8
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 03:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=BOExVr3bQEa+Jm2P1PFVTgy6K2N3H3wpd1BWCOY5MXQ=;
        b=BIydpFC2EW1wVFHwUWOVBAfRq4jywbkG7siFDIEcDrMaM3kDlwle6dluEXH6ZBGiZO
         od7suyOgJpbWZqRiErjltOgA4jGT98Jf5kFpbbeCvdsLTqvLMosNZ7A9BwpgMPPiVzMw
         9uxfMYZyeNtXMEDOMkCxGKSqnKzAB1ve3C6uFiHZfB1DhClEItIPyKJenf7QapWZy3UZ
         NpJQGTAYWVmBb8pJiHyz7ssuu8m8osf6vKVl+9jXeHu7zG5MG/YYzInTvhmGgx7lVmFF
         LMYO8BW1hEfO8B2Z5TH/0NfWKmjKjGLrqw6wcbju49c7F7KHaWeRpQAduFebPFXUEdSw
         NZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=BOExVr3bQEa+Jm2P1PFVTgy6K2N3H3wpd1BWCOY5MXQ=;
        b=N4yoZz80g/xM/r12ntiG8m5WwE8HR2GEuruJqHVqnbb0lCjKKlGGFrM1aTq/630wVu
         8qKnBLHZ0F/bqeTka+Mw6xmnpYG0qMhGZG2NJE+VeH7rqLlxym0O09oqVx86qlqYcUz7
         qwA0qmS6ABVMZCpnVpUSIjpJv5ihyJOy9m6B9ay+wRdcc2Vq8eDSwt3ryfmyki0NyvDz
         HVz44fQZ30JkDI46ndijnUKQIpwEV3zcRc9QBG8NwX+VgLkcHOj8F1QCVghu/i7Wdya1
         j/rK7yzmUffAf0gEI9DxdYVRPhr1x4US0k4ErSKyTSNT3dVo5HhcoBM34hMtFXDa7JQX
         PU7Q==
X-Gm-Message-State: AOAM531wpKDXRz/XfoPfcyiH9PhSbxl9jeN9zjV5zF+wf+rGUBUwYEuQ
        uKRvozpXFFiFSpuju9LrW0cnZRE479wbA2O5txRPRwNd/uNFxw==
X-Google-Smtp-Source: ABdhPJz6jpx0eAQvcopw76/KR3m2qWRvS0A+GzofB+OzSguqzYlRbxIeqlkvN4Wf+iBt+5yHFgU6tUAKzK8gWTvVCTw=
X-Received: by 2002:a67:cd19:: with SMTP id u25mr19158158vsl.70.1638963514910;
 Wed, 08 Dec 2021 03:38:34 -0800 (PST)
MIME-Version: 1.0
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 8 Dec 2021 12:38:23 +0100
Message-ID: <CAFQ2z_NHXKss4LVBAFVpE7LFXt2OeOz9P9wi-z8riwHXWDb28w@mail.gmail.com>
Subject: errno oversight
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In refs.c in origin/next and origin/seen, we have the following fragment:

                   if (refs_read_raw_ref(refs, refname, oid, &sb_refname,
                                      &read_flags, failure_errno)) {
                        *flags |=3D read_flags;
                        if (errno)
                                *failure_errno =3D errno;

overwriting failure_errno looks like an oversight?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
