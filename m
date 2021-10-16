Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48C2C433EF
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 18:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAFCF61152
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 18:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244582AbhJPSqu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 14:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244569AbhJPSqt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 14:46:49 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E286BC061765
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 11:44:40 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id bl14so11641170qkb.4
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 11:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=v/6cVlRIPxhFTca8jiGjBRavOQD8Y39h3/jl4xd95as=;
        b=HUnVy2vW8Rciz0k/6/DntXkA1Q9H4dA4zE26mzhpVct6nSZiE6i9KMeieA1+TwT4u7
         6HkymqwBc3BsDztpu2dUZuDZDG5ZHP42XH8qzoWX03wpntIEXmB1+kU+miq3/QVfAp2+
         z1QEEmtpjzMgdfpS97mslCAk4C0eIShPli8yZOS6S880d/5lzpt52eQ/MC8vhGLp/1hn
         L9OWtp573kRr7axK1vPpm0SavW4mDBMLNJN74Dh1wygMzQq0lRyz1mvdKs35LAC/PWso
         tVYPDmYft6OhoSa1znXvYqYHCaX8OOQJOEcpxZXc7WEDrGxDiqJy6Y8RZcsAouHoG78G
         Ff5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=v/6cVlRIPxhFTca8jiGjBRavOQD8Y39h3/jl4xd95as=;
        b=cBKQLcx1vSMYx50ETVdCoY6QXbYlBsmhi5O6wIxEZGKrk3kgPcbGMjBLruu6Hn4gQR
         e7T/PNvBBX1fEvKG2HPQ6eHEifKlMx/7WWoaiFcMaGHjd/iqLOmjLj51vOTQWpod4oji
         WJpv9UhXEKRM87ZfGVEZjUHTewHulee1Q9QsD6Y1uYw2Ki6yvNAC4HmWWibmVbEmsNoh
         4Kesiu6ah7Sqvm9NJcALj29bSr2z6KSyBjNjyWlZ9E6uiXO8+B5aCTETZMcW9SD748rs
         9nbFuSmr3pQ1cOjHSRV0cRTZZfX4hm++8vZ28FgxIxtqGmZSNyoZPzmsBXdN6AVFJPJT
         cqNA==
X-Gm-Message-State: AOAM533vw4TTOrLKK+SWPw1O8VDIg9of/uG/3nGABcuCOWuZgtcMIuVP
        bLlv99TSKXJWlMODIb4CSXRhF5tx9q06JEPs9FBQEtHc4zM=
X-Google-Smtp-Source: ABdhPJxDZvQhq1wh3LUGWFfHFkeVtcb/mYurlpS/C/8C3p08agFNfb18lqq/9rONJoRlfP7z+v5bel11sOXtWA/fB8w=
X-Received: by 2002:a37:95c5:: with SMTP id x188mr15440648qkd.260.1634409879949;
 Sat, 16 Oct 2021 11:44:39 -0700 (PDT)
MIME-Version: 1.0
From:   Adam Hutchings <adam.abahot@gmail.com>
Date:   Sat, 16 Oct 2021 11:44:04 -0700
Message-ID: <CADTYju0PpHHG1=S3N4MDWk5yZqb5t_KUhiDvZ_2i-vXFUT_LDw@mail.gmail.com>
Subject: Possible bug with checkout and submodules
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I may have found a bug in Git but I'm not sure if it's intentional or not. I

checked out to a new branch to test a PR on my repo, and the PR added a

submodule. I init'ed and updated the submodule, and when I was done testing, I

went back to my main branch. However, it did not remove the submodule, and

produced this message:


```

$ git checkout main

warning: unable to rmdir 'glfw': Directory not empty

Switched to branch 'main'

$

```


A friend of mine has managed to reproduce this behavior. We believe the expected

outcome is to remove the submodule folder, but this does not seem to happen. Is

this intentional?


Best,



Adam Hutchings
