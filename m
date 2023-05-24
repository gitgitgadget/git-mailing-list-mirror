Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE1FC77B7A
	for <git@archiver.kernel.org>; Wed, 24 May 2023 07:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239596AbjEXHAL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 May 2023 03:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239504AbjEXHAH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2023 03:00:07 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF016B3
        for <git@vger.kernel.org>; Wed, 24 May 2023 00:00:06 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-253e0edc278so500988a91.3
        for <git@vger.kernel.org>; Wed, 24 May 2023 00:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684911606; x=1687503606;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rNrqcbF5MhGyteVig5rQtzFtIHzUsS5GJ3C4jxk23fY=;
        b=l4Bb6iUtDWzCHsZWorbF5wuWe8DJQn18eCdg+3Cf7x+t5dCIRiU5qroC1tyZifDfG+
         alr2mtSj9S+0X3uLQzaAJa5UppytwPGPNNy0BEJi56+6bOlNJnqR6SVgyBbQU8iPLRp3
         b3nt0PDFRL0KQqU9oKlsilrMElfK9oSBW1xYm2VZTtr2K8dRCbU2AZ96gNxSFDZyG+y/
         vxkSiq7MupCvy/XCSxoeEKE0kK8cN9ufzOyB+B10EegrO1RCaJKsA+1hhx4bHgOCo91u
         PCT+P4ngcr0tCn9cf7wMvdZcccCO7aMo6KpP0Q9yKXCipVfK+qMNTtN5NXLXvDIspxb0
         qv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684911606; x=1687503606;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rNrqcbF5MhGyteVig5rQtzFtIHzUsS5GJ3C4jxk23fY=;
        b=La4Mc1FCRW89GlfzE9k8pAbOIrivOyW5OvB0hpnJXgXO4COjn0kSsxC45IYWty3kc8
         7GexQokvqMJ1z4oSA4cMfCzva9APBIXkYQs+ZT4xRMmM9TkO6MYZV6G+U0oSaS203qhI
         dsAM4N3UvcvycQ8f8cSAqjDAZnom4mAHcA6uuzK17Rloq2yhB43Z+kUrUl1ZmQiDhq0i
         9ee4vrpwEH3cT7MSyjVBXoQvZ1wvXAc/YqoatEeP7FvUWbXW1/63JCH3B5G+hgoOWGFI
         nhzny7FDFLfKsJ2/Ksy8/0E4jG0yOx1naE8UGaMDpiA2agk4OaXwx6b+YGX2DfmOr1Ye
         9sLQ==
X-Gm-Message-State: AC+VfDyY6LkVVIfXlfQVSm28ZT1RMnMduWg319sxsuRS8SPuYTKF5Qx6
        qEXSsJ2plWClV83n8qpztAOzvlt7CoQUbssJEd0OlOn+Aww=
X-Google-Smtp-Source: ACHHUZ6wOs1MyAyBISkcHXuP2y8G3M4USkY3DciPI9Lvpn/LLoGGlDJMCN6r9Q+SybKXZkagFdTS26pR7xvlF9LAL/A=
X-Received: by 2002:a17:90a:668e:b0:253:9766:749e with SMTP id
 m14-20020a17090a668e00b002539766749emr13214725pjj.16.1684911606182; Wed, 24
 May 2023 00:00:06 -0700 (PDT)
MIME-Version: 1.0
From:   Tribo Dar <3bodar@gmail.com>
Date:   Wed, 24 May 2023 06:59:55 +0000
Message-ID: <CACJVABb8tvgXAowgtHLrC6Uau8Q03VRFu1m7K91SJwjvufqXYw@mail.gmail.com>
Subject: [BUG] Segmentation fault in git v2.41.0.rc1
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running `git submodule update` after commenting out the url setting in both
.gitmodules and the corresponding section for the submodule in .git/config
results in a segmentation fault instead of a suitable error message.

The cause is `sub->url` being NULL here (actual segfault
comes a couple calls further):
https://github.com/git/git/blob/9e49351c3060e1fa6e0d2de64505b7becf157f28/builtin/submodule--helper.c#L2027

Possibly relevant: a similar snippet is being properly protected against
null-pointer dereferencing here:
https://github.com/git/git/blob/9e49351c3060e1fa6e0d2de64505b7becf157f28/builtin/submodule--helper.c#L1243
