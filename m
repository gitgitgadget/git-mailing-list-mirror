Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 731BA2036D
	for <e@80x24.org>; Sun, 26 Nov 2017 07:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752051AbdKZHTs (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 02:19:48 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:35543 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751930AbdKZHTr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 02:19:47 -0500
Received: by mail-qt0-f182.google.com with SMTP id n32so35649202qtb.2
        for <git@vger.kernel.org>; Sat, 25 Nov 2017 23:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=iHdgFVmMS/Q7gQRnNxf0E4jXeBU3QlOWEd0CRy1wn7Q=;
        b=OPiriw3ibJlcrTXu4bUdCGLOoahgDhRNk3zTtoIAPXsFLnRNTiaPDzN2mkEjQI+WQv
         PMSpbqRQcOWAB7QAbuOZMGiQOoqy0YpfiwYV4ZPnugsfE2f1Z/WTFpRutNzgoJZgqIvV
         gIcLDX5lKXX3bN5S6YCd8Co869JZvOEmA9trjm41PSPrl7/SBW1KAQwtJ75ZcEd8SeVl
         2Vt4XIHyXUuef/E0D393C1d3u8rSHbUi7BgAH7w4s+APIUcG6A7hRto9hI6swanbU3g7
         PxWb+H5WnCPO8a3FTqM6cewvGAwSY/t+OfcgrvH9DP0PbR56kKQ65eE66UXsMkT36hvu
         /7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=iHdgFVmMS/Q7gQRnNxf0E4jXeBU3QlOWEd0CRy1wn7Q=;
        b=Vgcsd4/wvWcC6TwDQgM65cYk08pcyKuVLM6PSCMoP1XR4Y4O0ntzXJJPxx9FlYKT8m
         OpMgZBNqQV09CcOQSg4sdjVBi7y8CY3Iq4KYQ67xIfiLzD7+W0Ssb0KMbf4RieEtJ2Q+
         MiXPEkhYu1lrrFXImm0Ww8TRAiWloms2ysqhXTHoI9W/2Ponjdxt2RL1HQG4S4nSoG0+
         LCKxVSC6J5aOwqlK+G7eZUGNpuy8UemTKJh8kxKdYl5Kpsw5DpU+k60GxXW/FPiS8RkI
         eaXh25N3zWUJur/kv5TRbL7QTGj47geSY/TF2RKpuMEJvEAR3nt+aB7+x6G0Nv8soZLB
         o+eQ==
X-Gm-Message-State: AJaThX5Y7akw+t9z8e+NvbY4PVm7mOvHPwo6ThqDRxXvDcgIQorcEvxK
        3s5HeObi+2hIcZMoWF9Gskf2aswP5IFqZ1cOwqJn+ZeC
X-Google-Smtp-Source: AGs4zMa6auq9KBRW22iMMEf5W3H2q0iPLbVvecgYTZ1ERmTCxBXtGURwlSkcmBY4Dwe35vOKUFbm/MWnO1m1wKFdiZY=
X-Received: by 10.200.27.76 with SMTP id p12mr33841273qtk.310.1511680786350;
 Sat, 25 Nov 2017 23:19:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.209.220 with HTTP; Sat, 25 Nov 2017 23:19:25 -0800 (PST)
From:   Michael Sloan <mgsloan@gmail.com>
Date:   Sat, 25 Nov 2017 23:19:25 -0800
Message-ID: <CAEDDsWdXQ1+UukvbfRoTPzY3Y9sOaxQ7nh+qL_Mcuy3=XKKh7w@mail.gmail.com>
Subject: Problem with environment of hook execution when git is run with
 --work-tree / --git-dir
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

I noticed a potential bug with the invocation of a pre-commit hook
when running git with --work-tree and --git-dir.  In particular, I was
investigating how hooks can still run git commands properly even when
the work-tree or git-dir is overridden via CLI args.  I put the
following in "/home/mgsloan/.dotfiles-git/hooks/pre-commit":

    #!/bin/sh
    env

after this, running "git --work-tree=/home/mgsloan
--git-dir=/home/mgsloan/.dotfiles-git commit" has output with a bunch
of variables, here are the important ones:

    GIT_WORK_TREE=.
    GIT_DIR=.dotfiles-git/
    PWD=/home/mgsloan

So what's the problem with this choice of environment variables?
Well, the problem is that if PWD is changed during the execution of
the script, then GIT_WORK_TREE and GIT_DIR will no longer work
properly. For example, if the pre-commit hook is

    #!/bin/sh
    cd some-dir
    git status

This will fail with

    Not a git repository: '.dotfiles-git'

There is another detail here, which is that when --git-dir /
--work-tree is not specified, the no GIT_WORK_TREE / GIT_DIR
environment variable is set.  This means that in this case, changing
PWD in the hook will work fine as long as the search for .git will
find the right one.  Note that this also means that changing PWD in a
script can change which git repo the command is being run on, for
example, when the hook is interacting with a submodule.

A half-fix to this would be to have the GIT_WORK_TREE and GIT_DIR set
when running hooks use absolute paths.  However, this would not have
the same behavior as when git is used without --git-dir / --work-tree.
As described in the paragraph above, if PWD is relied upon to instead
target a different git repo, then things break.

Not sure what the total fix for this would be.   I think the
information that needs to be conveyed to the hook's git invocations is
that "the work-tree /home/mgsloan should be associated with the
git-dir /home/mgsloan/.dotfiles-git".  Could have an env var like

    GIT_DIR_MAPPINGS="/home/mgsloan!/home/mgsloan/.dotfiles-git"

The idea is that this would be a list of mappings from GIT_WORK_TREE
to GIT_DIR.  If this variable is set, then it will be followed when
git is searching parents of PWD for ".git" directories.  I chose "!"
rather arbitrarily here.  "->" would look nicer, but people might
forget to escape it when programmatically setting this var.

What do y'all think of this idea?

Some of you might be wondering what I'm doing with my work tree being
my home directory.  It is the approach suggested here -
https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
- for versioning your configuration files directly.

Apologies if this has already been discussed, I could not find a good
way to search the mailinglist archives.

Thanks!
-Michael
