Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7E6EE4993
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 16:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237528AbjHWQXy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 12:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237526AbjHWQXx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 12:23:53 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F76AE78
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 09:23:50 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52713d2c606so7523867a12.2
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 09:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692807828; x=1693412628;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sCURObW4XubTGZs/1CmhQ9fmo45FcwOnz+xlYwR8VoY=;
        b=llQN0AHfFHqWJ4mafjpf4Dt1o3+Ny6+HkO9EhoEfR6iSCuaNW0ka82VyGBHMQLPm0I
         Nq3R6V+IlPNrCgLNwjjh91pYcnX9NqRLlhW2+Wm8imwjF/gkdbNy4X8ZVPRehFq2yIvx
         wUHolkmfZVldkJp+FTGtSmlDTIhjDvv/KDXoiO7oqOD2g6IkD9Yu4XwKeqysHdRXhT6o
         4m+JywIx4U6v8lFZDe4YCUzx4bfC+wPOVhbkAaN5Nj24Bil84hlM36Sq/igxwvaumBI9
         RItPYIwQaN9O+J7YMdUqnNeHbfHocDNZfUhOWOwPlKC6wBaNguhKuvOwfmrVEOV0V3oC
         dTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692807828; x=1693412628;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sCURObW4XubTGZs/1CmhQ9fmo45FcwOnz+xlYwR8VoY=;
        b=QraHqpNAyZW5SFgSK+b9his75Bq7a53kK0uRh5OD9ffrMv4Jr60YAQQRbTqI83hBCE
         AaW6JQ1eX7p8fnSe1CBd+d7l8ZnPBX/7SJ+kIZTph+zZVPIjYikUn1ype5iRa4TqhAg9
         Wgrt6BW3uCf38oBniL9P58empH+Wd/oqPzz+oXU5dsz8XrJgL3fRJObl/blNsCJsvLYj
         8R0jBaPQzm8HORWhJRsHIHoiz3UzNDwXQKEpLwjlqCDm+oywsdN5a2hotM0L0PC8aHSf
         WkES5f6uTF8EkixYiSaVXFzZtAgsRaQRgTgZ1W3dIyGOTaeu/Qw1UtfISwioEfLq81ar
         0lsA==
X-Gm-Message-State: AOJu0YxKoI8xodFuy57tpoA9p2zLiM7cgYn4Gj3pW1eLzbDHmfH6F48P
        QzrgHZeAndsTPbH+vb57F6+ZVIjGJV3bWoncLO+j1Ofllzhm
X-Google-Smtp-Source: AGHT+IGYjGJmhJl6Qg29fXeo9ZUSZEQk6xOTJAdqnA8Mo3uWOKMhhgzpOh+x7dTG/BF6ELBoHJHb1i6+0T2VKtfh64o=
X-Received: by 2002:a50:ed09:0:b0:525:6d9e:67c0 with SMTP id
 j9-20020a50ed09000000b005256d9e67c0mr10582790eds.23.1692807828267; Wed, 23
 Aug 2023 09:23:48 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Gabriel_N=C3=BCtzi?= <gnuetzi@gmail.com>
Date:   Wed, 23 Aug 2023 18:23:36 +0200
Message-ID: <CAA9rTuccfyXO66YApDfss6JM9+JuUzZxDiYyfG_qShfehyAEsQ@mail.gmail.com>
Subject: Git credential-cache manager is not treating `path=` correctly
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I report this potential bug:
https://stackoverflow.com/questions/76963207/git-credential-cache-does-not-matchpath-correctly

I really dont get Git `2.41.0` and its crude `git credential-cache` manager:

When I test `git credential-cache` with the below script (`setsid test.sh`).
if it can report 3 different passwords it will fail with

```
fatal: could not read Username for
'https://www.server.com/repos/1.git': No such device or address
```
on the first run,
and when the script runs **a second time** it will pass happily.

The `git credential-store` on the other hand does not work at all and
on the first `git credential fill` prompt the user.

**Question: What is going on here. This makes no sense and results in
peculiar fails on CI**

*Note: setsid is to detach from the controlling terminal that git does
not prompt or something.*
*Note: We need `useHttpPath=true` to tell Git to use the `path` in
credential `fill` statements (AFAIK).


```shell
#!/bin/bash
set -e
# set -x
# IMPORTANT: =======================================
# Execute this script inside a container
# and check if it reports all password correctly
#
# ==================================================

# git credential-cache exit || true

git config --global --unset-all credential.helper || true
git config --global --add credential.helper ""
# git config --global --add credential.helper "store" # Does not work at all.
git config --global --add credential.helper "cache --timeout=7200"

git config --global
"credential.https://www.server.com/repos/1.git.useHttpPath" true
git config --global
"credential.https://www.server.com/repos/2.git.useHttpPath" true

export GIT_TRACE=1

# Add 3 credentials, 2 specifics with `path=`
# 1 with general host.
{
    echo "protocol=https"
    echo "host=www.server.com"
    echo "path=repos/1.git"
    echo "username=banana"
    echo "password=banana1"
} | git credential approve

{
    echo "protocol=https"
    echo "host=www.server.com"
    echo "path=repos/2.git"
    echo "username=banana"
    echo "password=banana2"
} | git credential approve

{
    echo "protocol=https"
    echo "host=www.server.com"
    echo "username=banana"
    echo "password=general"
} | git credential approve

echo "Check the credentials"
# Check it
{
    echo "protocol=https"
    echo "host=www.server.com"
    echo "path=repos/1.git"
} | git credential fill | grep -q "password=banana1" || {
    echo "wrong pass banana1"
    exit 1
}

{
    echo "protocol=https"
    echo "host=www.server.com"
    echo "path=repos/2.git"
} | git credential fill | grep -q "password=banana2" || {
    echo "wrong pass banana2"
    exit 1
}

{
    echo "protocol=https"
    echo "host=www.server.com"
} | git credential fill | grep -q "password=general" || {
    echo "wrong pass general"
    exit 1
}

echo "all passwords correctly reported"
```
