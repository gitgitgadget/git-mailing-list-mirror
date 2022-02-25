Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E490FC433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 08:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238514AbiBYIdW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 03:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236278AbiBYIdV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 03:33:21 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95438187BA7
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 00:32:49 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id t25so2113215uaa.3
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 00:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=fMtvewpPfvhbXY4GgjIkGtnii/AgJ8TRI0WsbwhM7Jo=;
        b=NxElw+gmjTfm8MLh6rhm/swgKpap1puNaDA4ZD/1Llrov2bvmvjOU7Iz2AMsSXrVIR
         /zez62bPzCE+9LEpy79B02xST4wPWtJ0v2EolRGyp/CfDFHXynL5yGb0dqrLFhhGBRj8
         zqED4R3A1oD4Dxzon8kA+PQWXamyQTpbVTwvzQhsgzjhXJIunjD6CHs7Uyqen05dsIxY
         3LPEfbxKCZesMG6gi9aGCSwkjBgoMMRFNF753jPzfB86LIadamIFktuWcZnuQGNr95iB
         cO/rBVv94j6wrX73DjJ8Obvtv69zdndOi0Zzf3xUJGJbEyxmSYbjAd2NjpZpWe3LuLQt
         Yx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=fMtvewpPfvhbXY4GgjIkGtnii/AgJ8TRI0WsbwhM7Jo=;
        b=tdtCdsUchi+tgnMWJzQcVQwoNVsWtWYCvOJavvND59IpGV9F0prc66q9e5HIF7KMEI
         /OCHHYwo0UTROYZ3NiVW11WQuKVRnOUwqRfaWT+wP4ucp0FWcaz1AifdTXamkHbiJhaJ
         Urtu1YoauJHiH7TyWO1gWC5pxe+sD6qa8ZKTJi7a0WkzAvds11h4rEDs/IQMA1Zxt3rG
         bQf812cdkHwaoMhNxMJjSQmIH0vPE+nauATXcEhyCVhmS0h5jp4dwU0EQjX5dt5nirar
         CJWevej8qvQDVaOMGUPf41TfLrePLu2s4EJSfi8DL25Tllzl38m2HOUpJux/WlxHC2CX
         9W/w==
X-Gm-Message-State: AOAM530YKYxtkiLuOKO2WqAon6oxKBggFtH0pem5kIwAh5yfPBz/gSv4
        56TbR8S8hVFnPNSfD24U/aGPKcc42G4JQkuhUjLQV+62TTI=
X-Google-Smtp-Source: ABdhPJxvmcTOU4bbu3/g1uSpIHijwn4iDiCR0yd+4pnYjIeIDB0paxzS2cq8dQTtFa8pgSB+f2cSREvYjarRTDqm8Hg=
X-Received: by 2002:ab0:6346:0:b0:342:458a:eff9 with SMTP id
 f6-20020ab06346000000b00342458aeff9mr2904903uap.50.1645777968446; Fri, 25 Feb
 2022 00:32:48 -0800 (PST)
MIME-Version: 1.0
From:   Kang-Che Sung <explorer09@gmail.com>
Date:   Fri, 25 Feb 2022 16:32:37 +0800
Message-ID: <CADDzAfNTuuAWn1ynswTayRqgNNcPn3ou=v6c+z_tRsu5uoqJZA@mail.gmail.com>
Subject: "Git worktree list" on paths with newlines
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git developers,

I'm not sure if this is a good place to ask a question about the Git worktree
feature.

I'm writing a shell script that parses the "git worktree list --porcelain"
format, and I've run into trouble on determining the end of the worktree path.

Consider a repository with a "test1" branch, and I create a worktree through a
command like this:

$ git worktree add "$(printf 'directory\nHEAD\nbranch\n\nxyz')" test1

Git does allow me to create a worktree with newlines in its name (in a Unix
file system, of course). After that, "git worktree list --porcelain" would show
a somewhat tricked output, and it would break my parsing script.

(What my script does is find out what worktrees check out branches of a
specific pattern, and remove the worktrees found )

I wish "git worktree list --porcelain" would show directory names with some
quoting or escaping so that tricky names can be handled easily for any program
that reads the porcelain output. But I didn't see any command line option that
enables quoting or escaping of file names.

Does anyone have an idea on what I could do?
