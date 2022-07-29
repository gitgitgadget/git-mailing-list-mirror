Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCC1C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 15:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237566AbiG2PWU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 11:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237567AbiG2PWB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 11:22:01 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F09252B6
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 08:21:31 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id p21so5504252ljh.12
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 08:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2MDO4LBKU7sLNHpbAT5WPnt7PDpbKEzcDAYZeEXB5Ac=;
        b=XVugzOKN9iLCoeae5CAbYcHWoep5iD6wWFbPkmyTjY4tp9anbw+EqQN2p4bJ8JB6Jq
         He/EAIcG29KaCOflKaAekT6twRCxUs9NM6tq87XQPtzReY3sZR3JkVxcf+Z/PfeWeZ8r
         zV4vebUieUhajy/npOEUsrPy4fUruo+NYtBVktZOq9RMJLRYGhqzH6ogOaJblTkBlG2S
         A/OScE0UR7P52Cgdr77mJkNJ/Rnn5r0utoFGipmvCWSDvB5S3QPF+vKxH2MB8AV9HH6n
         tBZBB4iAPz8OMIiZhRTW6raK41ZMz+SXAZTY7qUd5mxtzds/KzPjqRXU2jLL+thBhdc2
         dnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2MDO4LBKU7sLNHpbAT5WPnt7PDpbKEzcDAYZeEXB5Ac=;
        b=U+rUa0DKZpkl1GbAC3Ep09Kg1J5fjsEK5GnsKx+M3ve6Qu9ls9k+x0EE0nagSnqljs
         +fmvEp9llfMgAb4sjlksZGJ3/N9RgzQhTRQHd68w2HkD2AlBoKsyWz0SZ7r53YDD+4p9
         t79Ff5D62j/6rX9yZ5MSI6Lt8dDh98owNVObbVfxfSJ4L/puwFbq4QjaFpI2z1qKr+zY
         smQ0jJROB8065t9Mfb7PmXBVZOQTrNQdYueQ3WNTXqAzBEO+oWPINp8CYvYbnbi6iSZu
         tVzyKQQCwpSvoCjq0bCVj1MKceoGRBnj6Rl7CbXIz4jt/2GswlpQYZFg670IaHiKWjxu
         AVdQ==
X-Gm-Message-State: AJIora9OBvBDwSC6twIMh+9irwFGIY/hs1RzwW1yhZqGdnUQMdIsxUMD
        1Htwfm3WY+pzNtfzVDViNN4nvMFthyG/+o6zJD4x/lqgVySdeA==
X-Google-Smtp-Source: AGRyM1uAwsl4NHygv5ICLoHllmUqB4PscWybOxmlL+jwArRbTV6qrDfHOz9hNqzDPWihXrVVchV6nK32OWEuecN0L8k=
X-Received: by 2002:a2e:bc09:0:b0:25d:ffe9:aa45 with SMTP id
 b9-20020a2ebc09000000b0025dffe9aa45mr1344234ljf.118.1659108089331; Fri, 29
 Jul 2022 08:21:29 -0700 (PDT)
MIME-Version: 1.0
From:   Jesse Rittner <rittneje@gmail.com>
Date:   Fri, 29 Jul 2022 11:20:53 -0400
Message-ID: <CA+SRSSGkgLrmy0ATj+1OOL6=jR6J0SE+0Orbwh+=C5KcVp82kA@mail.gmail.com>
Subject: Bug in git submodule update --depth
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have a repository with a submodule. The submodule is on some fairly
old commit. Under git 2.27.0, the following worked without issue

`git submodule update --init --recursive --depth=3D1 [path]`

(This did a shallow clone of the specific submodule commit.)

However, in git 2.31.1, it fails. The same failure is observed in git
2.37.1. I am unsure when the bug was introduced.

git submodule update --init --recursive --depth=3D1 [submodule]
Submodule '[submodule]' (ssh://git@[redacted].git) registered for path
'[submodule]=E2=80=99
Cloning into '[repository]/[submodule]'...
remote: Total 0 (delta 0), reused 0 (delta 0)
remote: Total 0 (delta 0), reused 0 (delta 0)
fatal: bad object e6f1975700c8d6fec2c3812277e3260194cb5379
error: remote did not send all necessary objects
fatal: Fetched in submodule path '[submodule]', but it did not contain
e6f1975700c8d6fec2c3812277e3260194cb5379. Direct fetching of that
commit failed.

From testing, it seems that git is incorrectly doing a shallow clone
of the branch instead of the submodule commit.

Your assistance in this matter is greatly appreciated.

Thanks,
Jesse Rittner
