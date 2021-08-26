Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD3FC4320A
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 18:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0881A6101A
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 18:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243345AbhHZSlC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 14:41:02 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:48414 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243343AbhHZSlC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 14:41:02 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Aug 2021 14:41:02 EDT
Received: by mail.z3ntu.xyz (Postfix, from userid 182)
        id 9A6AFCB07C; Thu, 26 Aug 2021 18:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1630002783; bh=OT3klwc8yzPyq0iH0DwHKUOJhl+h9/LADmW2iBbYPWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=LoPYkzoWExf7c/dPNXR6gg65W0y5+z35yk4eooAD5mYAe9veEA25uZQeUeDK6zx9N
         VwL71HstW3XWsKcSy2/iprqZwSxVqXo6sK909uFlUhvcVAWfbJbT352xHU2yXgCuVy
         eFw/577jhS198pUsz9EVm/Bim+aCXky4G94G185E=
Received: from g550jk.localnet (ip-213-127-63-121.ip.prioritytelecom.net [213.127.63.121])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id A7E99CB079;
        Thu, 26 Aug 2021 18:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1630002778; bh=OT3klwc8yzPyq0iH0DwHKUOJhl+h9/LADmW2iBbYPWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=kgd1HwPSLiKKdTxdyWWIS/HDfkCEpGqR0EjyESBiu4f6IICqxCl97S8nQ79Sl5uTk
         gr2Qpq22C5oIrtXswcL4kMA/IZ/KI04t1y87n0aL+SofsQLRzNpaiKtqhfKPePreF1
         iuHvczO/zxM8dUVWOXmlHmwmNExAwNwbgB5D4Jb8=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     phillip.wood@dunelm.org.uk, Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Luca Weiss via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 2/2] merge: make sure to terminate message with newline
Date:   Thu, 26 Aug 2021 20:32:57 +0200
Message-ID: <2333170.ZUCfCSpfzX@g550jk>
In-Reply-To: <YPMXqLESKApq2uPI@coredump.intra.peff.net>
References: <pull.1048.git.git.1626421416.gitgitgadget@gmail.com> <693954a7-af64-67c5-41b9-b648a9fe3ef2@gmail.com> <YPMXqLESKApq2uPI@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff and others,

On Samstag, 17. Juli 2021 19:47:20 CEST Jeff King wrote:
> [cut]
> So I think we'd probably want to see a 3-patch series:
> 
>   1. Make interpret-trailers handle input missing the final newline.
>      This isn't strictly necessary after patches 2 and 3, but it makes
>      sense to be more robust with unexpected input.
> 
>   2. Drop the newline-stripping from prepare_merge_message(). The
>      examples above show some ways we could cover this in the tests.
>      This will help --no-edit case, but also using merge.log with "-m"
>      or "-F".
> 
>   3. Teach prepare_to_commit() to add the extra newline before letting
>      hooks see the message. This should probably be done only when
>      cleanup_mode != COMMIT_MSG_CLEANUP_NONE.
> 
> Luca, do you want to try revising your series in that direction?
> 
> -Peff

I haven't found time to revisit the patches yet but I have found another 
unexpected behavior with git merge that is shown with these commands:

# git needs to be set up to sign commits with gpg
mkdir /tmp/test
cd /tmp/test
git init
git commit --allow-empty -m "Foo1"
git commit --allow-empty -m "Foo2"
git tag -s tag_foo -m "foooo!"
git checkout HEAD~1
git merge --no-ff --no-edit --log -m "Merge tag_foo" tag_foo
# git show

There are two problems with the resulting commit message:
* The newline between -m message and tag message is missing
* There's a big pgp signature (BEGIN PGP SIGNATURE) block included in the 
commit message. When using an editor this would be removed because the text 
starts with comments.

I don't think I have enough insight into where to fix this so I'd appreciate if 
somebody else could fix it :)

Regards
Luca


