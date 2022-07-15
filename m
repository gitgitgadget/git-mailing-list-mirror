Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D08CCA47C
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 12:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbiGOMj3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 08:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbiGOMjX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 08:39:23 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0B885D6E
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 05:39:16 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-10bffc214ffso6080909fac.1
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 05:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=G0ToUH5Emgy7IeB7kjZYC6PyQM5asY/c+TWFlBbFUkU=;
        b=i1q1Kg0361L/Cfr9b5sB5VumGL65rmmq0mH6Fifqr3JUQH+9RLP/TDHH/0nImDb9yX
         eGmxPgWS9gfRVv0aOe7PD8PIaHwP15PsVSPuF/6myXo4Nr3FERLMISJJM97yTe4CetEw
         gWiUo3VM20G5smp4yAysNOJb6rjUzPKO6tkJboEJwnHixsL2JHD1UlfnMTbhb0rErvvU
         3/ayaysZn4koA7eyBAbUoaUz1zyv1Om59xLE6AK1Q0I0NxmPvdrrMbQHKAWGbKbtFA9b
         TPG5jv3seHq5hAi8j0+eMCjMiCpKjokWIQ/Xe+I1TH3gI+8jjVoZfykR0zuyJaoWPRrS
         +Drg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=G0ToUH5Emgy7IeB7kjZYC6PyQM5asY/c+TWFlBbFUkU=;
        b=6sovkC3YAyvnQDO4w5kdp5hOppDTqBye65yBW0uDzhstADNueKzGppGc26yCd7UKpe
         UjShzeQMZkbfUfj6UzF5L8Qa51GfQfvnCViAJTdBCW/6I5JgSHQFXkcmF27KCMr3PLB8
         LZByyhny3mB6TP8+0V/X60+ofko34NXNzYghiOdaKOeixqibgGJqdjYSNdVDncbF73gj
         vrGbnkAMoMug6IrLqiP9DtqtqARKHkZY0/wqvx5vHkm0+sShMB8a3bLDkPC5IEwsJ8Tr
         QqCJd8WRpu8r35McOV419Wc1qR/dXv23NR20qP+7pEa8VubXoAC3gX2c6+oBXj6NHZFb
         CPtQ==
X-Gm-Message-State: AJIora/bA2PuaBtet9D5WPa9+hai86V09JOjDZSfJhhVHUSRU+mDe535
        WhCEc+q+o3bfp2EH8AZHimOaq7/4V3tKzTHt7xcJM+IyozzMDIkB
X-Google-Smtp-Source: AGRyM1siu7PSO2XIvVXQW+v5ag4s19/9sWqHSN/tkGx0bgHNVXH9R3M1Rr+2mBQ3Ikj5G1q+8aDuAnL+pshBU+qNlnw=
X-Received: by 2002:a05:6870:61ca:b0:10c:1358:4eaf with SMTP id
 b10-20020a05687061ca00b0010c13584eafmr10046372oah.111.1657888755841; Fri, 15
 Jul 2022 05:39:15 -0700 (PDT)
MIME-Version: 1.0
From:   Sim Tov <smntov@gmail.com>
Date:   Fri, 15 Jul 2022 15:39:04 +0300
Message-ID: <CA+X_a+ycefqvz0LaO0KK1LuTqgE=iUhooPRXeo3mq-zXkp+nCA@mail.gmail.com>
Subject: git: detect file creator
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I run a book digitizing project and pay people certain rate per 10K
characters for the text files they upload to a git repo. Till now I
was using following command to detect files authored by CertainEditor:

    git log --use-mailmap --no-merges --author="CertainEditor"
--name-only --pretty=format:""

Then I would pipe this output in `wc -m` and get amount of characters
authored by CertainEditor and pay him accordingly. Usually editors do
not touch each other's files and everything worked well. However
recently one editor spotted a typo in somebody else's file and
corrected it. This behavior is actually good and I would like to
encourage it. However, now the command above lists the corrected file
also as his, and so he gets paid for all the characters in the file
while he changed only one of them. This, obviously, is not good.

1. Do you have an idea how can I list all the files **created** (not
authored / committed) by a user, so I can implement a fair characters
counting?

2. Maybe some commit hooks can be used that will check whether the
Author of a new commit is different from the previous one and if true
- override it to the previous Author?

3. Those small changes by a non-creator may be left not paid for (as
this action is not so intensive and may be reciprocal), but if you
have a good idea how I can pay for the "diff" the non-creator provides
- it would be nice! Do you think this "diff" should be deducted from
the creator? And if yes - how?

Thank you!
