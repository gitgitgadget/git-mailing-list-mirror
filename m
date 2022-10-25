Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97949C04A95
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 16:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbiJYQfu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 12:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbiJYQfq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 12:35:46 -0400
X-Greylist: delayed 309 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Oct 2022 09:35:41 PDT
Received: from mermet.sourcephile.fr (revolt129.abo.ilico.org [80.67.180.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58C9A7A99
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 09:35:38 -0700 (PDT)
Date:   Tue, 25 Oct 2022 18:30:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sourcephile.fr;
        s=20200101; t=1666715424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=9BYU5S0Vm7OHbk5QV1vhbM7VZCbwUg09FovYJ7knTCU=;
        b=22hVgZKoHPnTWapsTfbZyM3G3HweWZ0Yy9MULrI0BEI3sj2NyYVPW6ZzAM195ApB+wc5Bv
        EAWOq43VHnex1kabnUH3o3zSAmA+aVk6Y2XO9d+9R9x5Nb/tZd+4wHNN1z1TUV+Uj4rXdo
        bNZ3oXWM9qBLo9oBhgi9y+23yWhWMOW0mOkCj/EJbUOUY6DX4QNGld7OWMhU4PpHgFfUFf
        TeXTQ4T8zXIw5AVRI6u/UJJFfAApmMg+C482WOAZICOLB0tN3KwY1fYEVL5dCQf6sGAILV
        VpsZhvT/3+IFw2OIcgvidoD1qHeY4h+cnUwtfNO1o2hULVMsOzgjzyg2zYpwdAMj4SK0US
        NsADXbI8QTlG1kZUDPX5AAPWVwD9ckrxZ3u+q2fWXDq2O+cFCPMiTkzO04SWt36OIIAkgU
        Wo5RTf/TJ0X4G1ZhHQt6MnJOHCgreJVo4+hyXXoElsFOfn3rgflpDD0tZReQfWvYjTE7RG
        cA0R+fzsnTroK+fHZLKQu6gk/7c5uJUkt8yYUIW5EceZcd4xJRlgBCaF77B7UwIJ3sX8sO
        EZ6yJ54ORbpI/gVMTN7s/HC1/skpPoqR9ReYRwFx/KPvrARtrYpU/EBoBvsGC7sTvMJZiY
        aqN2UaFEuWNw/vAzcbQ6r9TvoYaQtgew9aAupUPhpwn/MSZgjv6ik=
From:   Julien Moutinho <julm+git@sourcephile.fr>
To:     git@vger.kernel.org
Cc:     Eric Wong <e@80x24.org>
Subject: FORCE_DIR_SET_GID denied inside nix's build sandbox
Message-ID: <20221025163024.uutqv7w24yi4eo5i@sourcephile.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

While running public-inbox's tests inside nix's build sandbox
I've noticed that when core.sharedRepository is set to 0600
git still tries in adjust_shared_perm()
to set the g+s bit on directories.
https://github.com/git/git/blob/1fc3c0ad407008c2f71dd9ae1241d8b75f8ef886/path.c#L901-L905

However, nix's build sandbox denies g+s
(such chmod returning EPERM)
because it could be leveraged to break the isolation
of the build user.
https://github.com/NixOS/nix/blob/b3d2a05c59266688aa904d5fb326394cbb7e9e90/src/libstore/sandbox-defaults.sb#L5-L7

So, on meta@public-inbox.org we were wondering whether
git should maybe strip S_ISGID and retry to chmod() if it hits EPERM?
https://public-inbox.org/meta/20221025101756.M341966@dcvr/T/#m3f4e9eba9b903a263221ab82ce7ddcd44248d033

Any thoughts on that matter?
Thanks!
