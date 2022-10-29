Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17012C38A02
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 05:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiJ2Fqx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Oct 2022 01:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJ2Fqv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2022 01:46:51 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C852D7C1BA
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 22:46:50 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bs21so9047827wrb.4
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 22:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jR96TZxJFdM2dxCFprbTymvtTJ8qe8gHV0PC18yBf+4=;
        b=UmD4317K/yb2goFqg7fs52Xu/X2fsD186tZciDz3riC/E28mw1U2gORDO6aSB7VW/0
         OFVvYXoXrJfXsH4Q6EPox2cVKlRP+RiOOinCoTlNQCxRS1YXPKgFxhjuPl5EykhDeNCd
         009ciXbX59gX4hQZopoVYF2kW+VWH1q2ih+VM2s0Q+XG1O6eUpteRXOIReA4stFV8yss
         6tN1ovF10SufiJN5g8z3PlwGnK53+9BwhbNY2FrPrljq4AHVjc2zf8wQNntJ7I6YlZzN
         JWf+Ov9exdlTpHj2mCdP9Yv052kWDy5PJxAmC5eJpghuVkmN3bVFE/PsmVDx7NYlDdiy
         yIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jR96TZxJFdM2dxCFprbTymvtTJ8qe8gHV0PC18yBf+4=;
        b=w9GjGLW67QfDPuyuZwLhTFFDAtJcSyYIHTKcJEA0C+rj2X29Rj47Ioxcdan9XSYfJT
         /jUrmiyzIirJvvhAL41bnNqkMMbYsvi8BqNkP3MqCKbAtBa8vV+OAGazHshsmAug+LRK
         M6LXGrqgfM4CWpZ1TWUtuVSmDKDZp52V+BPQqUN648wIfcyFuwvSgm9lFs0mL+bGYw4D
         4TgNKPLZG2iRzc3t/9JF9yDipS4fsOb3UepAPKNAWnq7lqG/If7JLZ1CJp6vXA8dDwh7
         a4lVuOZZ4ZgT12ZdjLuvRTi/3zNGAPMBBrbIylbhQe08shP0NAhcMKsAcslTkSC+MFUi
         06hg==
X-Gm-Message-State: ACrzQf1X57qppVh5doRum9l7IZxNRX5WOI5zVcWf0dvXQoHognLuiLI7
        LLAfSrpuEAGZLDaddnIR1IQ/E1K51nJvN6xH3MhRUsrN9WHdOg==
X-Google-Smtp-Source: AMsMyM4bm0NucBCxX9r7REgVYcXI+ij3caMaQAdSrT0T9/C6CrQLez/4CkyHosKmhrxWIor34h0Zk+w12S8f8JoYE7Q=
X-Received: by 2002:adf:9787:0:b0:236:8639:9e12 with SMTP id
 s7-20020adf9787000000b0023686399e12mr1379123wrb.265.1667022408747; Fri, 28
 Oct 2022 22:46:48 -0700 (PDT)
MIME-Version: 1.0
From:   Martin von Zweigbergk <martinvonz@google.com>
Date:   Fri, 28 Oct 2022 22:46:37 -0700
Message-ID: <CAESOdVBpsbJ0obD=qDjHBJg-wwWUL5sQ-7X_h13Vw39Q9QUzHA@mail.gmail.com>
Subject: Bug in `git branch --delete main` when on other orphan branch
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I did this:
git init test
cd test
echo a > file
git add file
git commit -m a
git checkout --orphan other
git branch --delete main

The last command fails with:
fatal: Couldn't look up commit object for HEAD

That's a bug, right? I can of course work around it with `rm
.git/refs/heads/main`.
