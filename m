Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59109C43334
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 04:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbiFIE5s (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 00:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiFIE5p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 00:57:45 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9531BE17
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 21:57:44 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id w27so29589184edl.7
        for <git@vger.kernel.org>; Wed, 08 Jun 2022 21:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=2Otgh/svqHPdohhYs9M6E5JGUd/fvDBM0aDue42uFlk=;
        b=IHQOkbOYe8AOHkUIQL7VeyIu0aefJhQic9BxPijOaR5HanUL0RT9gU0fpMZ5ZzJTZy
         5bTi4BC90KRZcOfw7iW/UmUTctj9fMLNK3YR4ilFi1WMLJxnX0vTMMXK7DCOLTOdL9xw
         qkuQ+v/OVHdJBjJv6vC/NSEB00ahQlX67pBPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=2Otgh/svqHPdohhYs9M6E5JGUd/fvDBM0aDue42uFlk=;
        b=f16S0XjxGz+qD40NdFq2bqKvfpKTi5sEnASu2gEZDtKnP8rLxk7n89bg3UpGy6KREg
         Xew1B0gLtu4ThbIkFBXN88tebd9wJ/cxcoadvlpksrvihezVN9kXMC2hvFrxpgiZeQyh
         G2gCoYOwmFl4+4TUf3dUk9VUx6ymwSQTVX7rqrxgEe+y0B2yPwWudeNER9WEpaSjL8cW
         Us8dz5IXdKs5zV1NVrscP0Cuqvt6SIjZ0Ytfng/5gnEyCcdQCRsaW1ZMrdoq7WNyzRS5
         Ljyua3aJP5lqTbmk7gLHQtzgPlx+ngMiOaUCbcY/xArti+U5/1QK3Mihz7XoEvhCwr91
         iDCg==
X-Gm-Message-State: AOAM533X8abKWJOvSNOfmW70NqjY++F4qXfqH/P+ao6T2WpDurldU3+v
        bH9Vm4lBjiD+JHmSQeso16ryUZN4V7MF8ArRgmfMwZdDHkTHi5+S
X-Google-Smtp-Source: ABdhPJxR0yVjQ4LxAFnCVmbATtd6qfwepczkKjnDNYv0usJmCP/ljrrW6o4KODzwlcEsfB01boyygoiZB2I6Z14/SbU=
X-Received: by 2002:a05:6402:d0a:b0:425:d455:452 with SMTP id
 eb10-20020a0564020d0a00b00425d4550452mr42669950edb.259.1654750663240; Wed, 08
 Jun 2022 21:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpojwV+f=z9sgc_GaUOTFBCUVdbrGW8WjatWWmC3WTcsoXw@mail.gmail.com>
 <YqEiPf/JR/MEc3C/@camp.crustytoothpaste.net>
In-Reply-To: <YqEiPf/JR/MEc3C/@camp.crustytoothpaste.net>
From:   Tao Klerks <tao@klerks.biz>
Date:   Thu, 9 Jun 2022 06:57:31 +0200
Message-ID: <CAPMMpoi=4Ke=Zq1ZRR7Y4nbO_1jTBe4to7p9qKtuY-UoFxaXRw@mail.gmail.com>
Subject: Re: Git apply fails on case-only rename on case-insensitive filesystem
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Tao Klerks <tao@klerks.biz>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 9, 2022 at 12:27 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> Git wants to create the new
> file before deleting the old one, but it already exists.
>

Ah, thanks for that observation, I didn't consider that git might
generally want to do renames in a "safe" order.

> The way we could determine this on Unix would be to stat both files and
> compare device and inode data when we get EEXIST, but I don't think our
> Windows stat emulation supports that.  Having said that, for
> case-insensitive macOS, I think the rename detection could be fixed here
> using that technique.

I have not yet tried to find out whether this "sameness determination"
is possible in windows, but I have one more interesting observation: I
just realized that "git checkout" probably wants to do the same thing
in the same safe order, and indeed, when I do "git config
core.ignorecase false" the "checkout" command fails with a very
similar error:

error: The following untracked working tree files would be overwritten
by checkout:
        file1
Please move or remove them before you switch branches.
Aborting

(in fact, even "git mv" fails with a similar error)

This suggests that there is a strategy based on the "core.ignorecase"
config, which might not hinge on determining the "sameness" of
differing-only-in-case files, which is applied in other places and
simply wasn't considered in "git apply" yet.

> I don't think anyone's working on such a thing at
> the moment, though.

Thanks, I'll try to look a little deeper at some point.
