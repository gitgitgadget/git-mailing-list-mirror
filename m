Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6BAC4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 14:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02CF561042
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 14:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240810AbhHYOGy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 10:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240704AbhHYOGy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 10:06:54 -0400
X-Greylist: delayed 15410 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Aug 2021 07:06:08 PDT
Received: from forward105j.mail.yandex.net (forward105j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57205C061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 07:06:08 -0700 (PDT)
Received: from sas2-599c596a5fe6.qloud-c.yandex.net (sas2-599c596a5fe6.qloud-c.yandex.net [IPv6:2a02:6b8:c08:b999:0:640:599c:596a])
        by forward105j.mail.yandex.net (Yandex) with ESMTP id 066414ECACD3
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 17:06:05 +0300 (MSK)
Received: from sas2-34ddad429748.qloud-c.yandex.net (sas2-34ddad429748.qloud-c.yandex.net [2a02:6b8:c08:b787:0:640:34dd:ad42])
        by sas2-599c596a5fe6.qloud-c.yandex.net (mxback/Yandex) with ESMTP id J9yMo3ZHKs-64HmZC9o;
        Wed, 25 Aug 2021 17:06:04 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1629900364;
        bh=bEdaV5HozBcReLf20DJAtgvS7LDDlZkKbPpFN+ATAAs=;
        h=Date:To:From:Subject:Message-ID;
        b=Y6ZrM+M3RBKqT154OQ2Rle2yuGkLoRSqNVjA53miFBWmF0GQkyRsJTskqXSXnaeHv
         GTmOlEoCLIimU12rXrF4lmOmWB+ZOUYeLPfXb7lN9F5Bty0BIdgHWUcnNNIAhU4r7C
         wrhrkKNPJvC4SGWE1AOfC3UZys9/2+ha7N1/56pA=
Authentication-Results: sas2-599c596a5fe6.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas2-34ddad429748.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id sycej6RBjP-64ca91uT;
        Wed, 25 Aug 2021 17:06:04 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Message-ID: <eda317b080a2e75a170c051c339a76115cce5ad7.camel@yandex.ru>
Subject: How to interactively rebase-and-reword nth commit?
From:   Konstantin Kharlamov <hi-angel@yandex.ru>
To:     git@vger.kernel.org
Date:   Wed, 25 Aug 2021 17:06:03 +0300
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think, one of the most frequent git features used is `rebase -i`. There's a common
workflow I think everyone knows: you have commits 1, 2, 3, then you decide "Nah, 2nd
commit needs a change", so you do `git rebase -i HEAD~2`, then in popped up editor
you modify the `pick` on the first line to become `edit`, then you do the change,
then `git rebase --continue`.

The boilerplate part here: even though you know that you want to edit HEAD~2, there
is no way to tell git that right away. Every time you have to launch editor, edit the
line manually, then save it, close it.

I have seen here some discussions about improving that, someone even posted patches,
but I'm not aware if it went anywhere. So I created 2 years ago a shell wrapper
`rebase-at`¹, which upon called as `rebase-at e HEAD~2`, does the thing described
above automatically. Under the hood I simply substitute EDITOR with `sed` command
that replaces `pick` on the first line (the HEAD~2 commit) with `e`. If used with
shell autocompletion, it is now practically instantaneous.

I'm almost happy with `rebase-at`, except I don't know of any way to make it work
with `reword` git action. You see, "rewording a commit" requires to run EDITOR twice:
first to substitute `pick` with `reword`, and then to actually edit the commit
message. But since EDITOR was substituted with sed, the 2nd run won't give you an
actual editor to change the commit message.

Any ideas, how can I tell `git` that I want to "reword" nth commit right away? Sure,
I am not the first one to stumble upon it, am I? Any ideas?

1: https://github.com/Hi-Angel/dotfiles/blob/0b9418224e4ce7c9783dbc2d9473fd1991b9b0b2/.zshrc#L148-L160


