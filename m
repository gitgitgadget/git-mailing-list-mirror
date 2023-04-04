Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA0CC7618D
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 05:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbjDDFiI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 01:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbjDDFiH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 01:38:07 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480B11FCD
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 22:38:04 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id iw3so30261636plb.6
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 22:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=t-engineering.se; s=google; t=1680586683;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6hf78krS+suKp2rx2uH9j6ppbREzUVFXNMyaJOrB0Oc=;
        b=JmfqznuL4Bmelr2bdxBlWdO4tiiCU5ZWNX6SGfMskliAkiV+YqO8vNZDGd0+fz4Sck
         DpPO2ps7L/W4Hk6craEuYRfUQY4kR+p9HxmRCqM9Ii8XaldreJnyNDX4bNGkqhWT2ycn
         dcEqLxmO8NnPiXogWmNEH9mWzznpXu5bg/db8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680586683;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6hf78krS+suKp2rx2uH9j6ppbREzUVFXNMyaJOrB0Oc=;
        b=krsjeh4V4v81a3pUa5Msi4igZJFH9HyYfpsBf7+YxkvE9Ff4sPdQXzNttRBDyTUq07
         1Wkm3mT6F5GHRRXhBjH3NyLSQNJLiIvH5sfsOGV1m+9+hj4IN3ROwZNyiavdKKFA9Brb
         EWfdcLgWSR9IFGFmWy+k6404FsAf7DXtSxGBYLKldm6AwygHeM96vD6xc6tPQ3q2Aezt
         kTOFpQ6184qFn3hzSh/yNdpXseb1UD5TWAa3kc49SBmwA2UJmk92Mk+iymosKlLylIkw
         Y/3e1Fg2RzCJDKi4rWvq1tG5XfnCRTCbz7jfwk0u9vbppJ4IDh8eHKM3uOtXezdaMWxQ
         aXJw==
X-Gm-Message-State: AAQBX9c+0/tQDMnqp+o5a3TZ1f4MWiagBdhtdw2wgtfyiPKXIl0le4JA
        HGrwWLk+tnIAVvBmQS29cUs/LYI771LKWLspykKN4y0IyCTvjftK7UY=
X-Google-Smtp-Source: AKy350bRyfjS1ft66uLXH5ckqSSaN/Kp5XXc8X0knubHPbM69oNtuBZhPLR0hBsf/DsYuMX0RV3Wgc6YnBQLr4wtoyM=
X-Received: by 2002:a17:902:7448:b0:1a2:74df:b384 with SMTP id
 e8-20020a170902744800b001a274dfb384mr537448plt.12.1680586683374; Mon, 03 Apr
 2023 22:38:03 -0700 (PDT)
MIME-Version: 1.0
From:   Mattias Holmqvist <mattias.holmqvist@t-engineering.se>
Date:   Tue, 4 Apr 2023 07:37:51 +0200
Message-ID: <CAPMLkzd=VGGqZ0trMMVXUsjGwbjFN-nz3tGQUG-O0Xc84Zc+hw@mail.gmail.com>
Subject: --shallow-exclude commit list is offsetted one commit
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)
git clone -b A --shallow-exclude=B


What did you expect to happen? (Expected behavior)
My remote repo looks like this:

  A B   # two branches, A and B
1 |     # commit in A
2 |\    # merge from B to A
3   |   # commit in B
4 |     # commit in A
5 |\    # merge from B to A
6   |   # commit in B

A and B are branches. 1 is a commit in A, 2 is a merge from B to A etc.

I would have expected the following repo as a result

  A
1 |
2 |
4 |
5 |

I would also have expected a shallow file with the following commits in .git:
3
6

What happened instead? (Actual behavior)

When I run the command I get a repo like this:

  A
1 |

I also get a shallow file in .git with the following commit list
2
5

What's different between what you expected and what actually happened?
The commit list in the shallow file is offsetted one commit.
he consequence of that is that not only B is excluded but also
everything in A that depends on B

Anything else you want to add:
The result is the same if I use the git fetch --shallow-exclude

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.40.0.windows.1
cpu: x86_64
built from commit: 1d90ca2906dd4b7ddaf0669a13c173ec579d794a
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 22621
compiler info: gnuc: 12.2
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>


[Enabled Hooks]
not run from a git repository - no hooks to show
