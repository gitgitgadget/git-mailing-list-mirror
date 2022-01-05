Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B5AC433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 00:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236814AbiAEAw5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 19:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbiAEAw4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 19:52:56 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487DEC061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 16:52:56 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id h7so40873192lfu.4
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 16:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=E8w593mqed/KQrIUjGDPN+M4L98mZBkHr6PlVfvRoXY=;
        b=T8gwPtUy47myzm1XVMCZhwyIr4ao5u98SVQ5bJ+SEOMphM0o88CAqFh5uLlkKxrTwV
         1GsDNqeQGBtG6+pkcEpRkLUBcnslECm8qfvgLASmGrFCKmuitrc6us/bp1YA8CQiay04
         UuplSRAdmekH+qDlmYFCo5/RfizwnTTmO6C0y7nvKNQdTXAOE+LYst8RAPEyKnK8BXmR
         U28hPTgbKkBU2Ogm+S1nvYm5lHVmWP1zMdM/6yD7E36Tc1YfktOfVdaH5h/R07Ai8FYW
         0P2t9Orvm6ZoUWsHKgAkBUEmRX17F/YMnSVoK9QEQxAy+qKN9LwaLKJjViqCGVWU5Y+v
         l0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=E8w593mqed/KQrIUjGDPN+M4L98mZBkHr6PlVfvRoXY=;
        b=gjiaWiGF8mZN/H1stdPQpVeEqHTieVBrG2Moeei35+X1haynD/xPJc5ve/HdI4zFkz
         v7z506U/nHQ9hzUdfSc4z4yRwLld7flahYklIoKO0MXCXHgFEOSOt5wEADvPahlVb3ay
         mLaNamApleXgIrOLGVZoXVnQVDMtkav+4HKpfVIqwLSq8i/tJ5M4INRPpNcpSJMBjtNN
         Sll9kIVPM1Ik1Fqm0b4p1eXQ9QnzkXt6amr1r7AApLogJQPa8GQ1Yz46faQvt8GghwUX
         Ti1ZBhB8Vqewc6BGjNX/2jbG+DgJuSAKkVPu8NoHCxvo1jbXGD0nJPP+/1P67/dTNjQP
         ij7w==
X-Gm-Message-State: AOAM533HcGmp72jGouVnZimQJkweSt6fQ0zGtLuh/4HdlB2aaJdy1f/U
        9HZk8TLnSAKuyjONgX9VE0Ls2e8B1kuqlbXzt3Q8z2ICzC0=
X-Google-Smtp-Source: ABdhPJxKVPTmY7vn8G4NPjN3FiAu6VMe+rSkOMl29XbieTy51QpFWNPu2F5MsbeNMnq25hOTIB56Pf0Vh+s37CACGkc=
X-Received: by 2002:a05:6512:12c4:: with SMTP id p4mr45993450lfg.282.1641343974240;
 Tue, 04 Jan 2022 16:52:54 -0800 (PST)
MIME-Version: 1.0
From:   Britton Kerin <britton.kerin@gmail.com>
Date:   Tue, 4 Jan 2022 15:52:43 -0900
Message-ID: <CAC4O8c98H=txccR-3JM2L7jiAaf7WmJ1qyg+oiqSgrB5Qc1nUg@mail.gmail.com>
Subject: bug when git stash apply after switching to branch with links were
 regular files
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On git version 2.34.1:

I have a branch where sym links get replaced with copies of the
regular files they point to.  If I make a change to that branch and
git stash it, then git checkout master again, then git stash apply I
get messages like this:

     $ git stash apply
     Adding dirA_thats_now_a_link_again
     Adding dirB_thats_now_a_link_again
     etc.

These messages seem  completely spurious: applying the stash doesn't
result in any actual changes in any of those paths (and the links stay
links).  The only change is to the actual file affected by the stash
(which was a real file in both the branch and master).

Interestingly I was getting this same message a few smallish versions
of git back I believe when I did the checkout back to master.  I
updated to latest stable git and that issue went away.  So it looks
like maybe a fix to get rid of these spurious messages got applied in
one place but not others.

If there's interest in fixing this issue I can go back and isolate it
more carefully on request.

Britton
