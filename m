Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87EAC433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 03:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiKCDPK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 23:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiKCDPH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 23:15:07 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5BBFDC
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 20:15:06 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id d3so708486ljl.1
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 20:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+ZxH6QeZLdXRhyq+0Rrhf5wLmnXasf6CusD1wxYYPMA=;
        b=JnpExVHc7er5MPrSGzAlMNqKmuv4ve5ceaQKeTEGCW+RZIiN/QFgsDTKYZn/F5VKhw
         7YB9izbNNZmlfwhBaaO5weH2a+YvtTEgxMtIt5vYJfr4mJaTdFx5XoC5vsciMZ8bl2R/
         QSbdnYjsObxVrOjX3B8xl1MrENYv05p19t6oy6p1GD8YSAzE9LOJhwR7m4PPeeHF0BAj
         3dKaU+faegWIVoQjalH6TROzBIo7hK9hl8+y+hKD9UzaCSkY4R4wkPnkyxqluMTuOi8S
         qqjJDfuTXevCGXKzzg0iDiEg5djgLneb4ogF6/n0cw+1vISK0+FY41vPZW9xd5SpFyt9
         ZUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ZxH6QeZLdXRhyq+0Rrhf5wLmnXasf6CusD1wxYYPMA=;
        b=RZXe5Xi0pxYs1mzO/2ou/1IOymoGVQSRltTSxJC1QGzKYO9eRoVjKto+SryWzq1GwO
         U+HmX/jwnusjvlVn1cOvssae+erxuDODqjpha2NIwk4N87BgQQWoBelX3Yo5zQxGV+uw
         dWiu9vLUfHNaMpmbAx3wRtnLhQH8aaOvrIFu2pdkU6ZgdWoEPMbSe2xgF8W7o4Rydjol
         +qUp8Se+3qKxU5NH+OfSvf3ueCa69tKYhudbfpMUPRHcGplTGPcTlXnolmFBxCJM/xvj
         j4tZcnJqrxdOvM5mggWeMCKAdQdV+3mqe9z0ClBW3aY98WDSQB7tN+LWbpcgNRXAViTC
         wPMw==
X-Gm-Message-State: ACrzQf3tMfc1B2B+YL5p/VcTwhfR7qktTltuasrFZ9BUqwbSzyT49UuY
        soivLrW9W8+HM+Pu5PS1fhI1Y9L9EUlgmJ7/mpEBLniuuAyhFg==
X-Google-Smtp-Source: AMsMyM7FMCLDb3UuOJquzAISoU+WWd72f8CTUUaj6nJNvO8RODCX73k1HDA0N7Q6EcwyRI29byizCzOwBTFRGlYtxZ8=
X-Received: by 2002:a2e:544c:0:b0:277:5872:85b0 with SMTP id
 y12-20020a2e544c000000b00277587285b0mr7247063ljd.162.1667445303853; Wed, 02
 Nov 2022 20:15:03 -0700 (PDT)
MIME-Version: 1.0
From:   Evan Benn <evanbenn@google.com>
Date:   Thu, 3 Nov 2022 14:14:37 +1100
Message-ID: <CAKz_xw2X+eapmASqG7V=RXehh7=LN24m+MJPn-wx80oZAZHBnQ@mail.gmail.com>
Subject: bug: git format prints no final newline
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This command omits the final newline:

git log --format=format:"%H"

check with: `| tail | cat -A`

This command doesn't, but there is an extra newline between each line of course:

git log --format=format:"%H%n"

This seems to be intentional in the code, a newline is printed before
each line except the first:

https://github.com/git/git/blob/master/log-tree.c#L664

It seems more correct to print a newline after every line, but the
code is very hairy so I am keen to get any feedback before attempting
that.

Thanks
