Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D23720248
	for <e@80x24.org>; Thu, 28 Mar 2019 00:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfC1Atk (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 20:49:40 -0400
Received: from mail-it1-f180.google.com ([209.85.166.180]:35111 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfC1Atk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 20:49:40 -0400
Received: by mail-it1-f180.google.com with SMTP id w15so3371451itc.0
        for <git@vger.kernel.org>; Wed, 27 Mar 2019 17:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=6+m/AfSrQMn6pAC0WxMUVShbSagBo8w6vu6A2OyqZ7Q=;
        b=RzW3OxT93k5TX4Bl69TBGSaIAqUc0VBqIM8ty7Uq7kgvFWmktgpN9qM6Zl71aw4WUB
         R/0ELsdXJ9KMzCb5IaVWBkiXPGvrVs5ZB3D/SYJcpstZR1dWhsqWX+2RceGj/hsul1oP
         nt7n1aNHsvdUFaZqenPN7dgHD4iFLnz1tRCheMCh+HZBc9tET3uQT39EzT719+Jk4hBl
         cNygR3SCWi/+tYHj9PiBfZ2i+qXBGTRBWHaX1oVUiRlIGXuf/axgIVAwv6LUMRyK6JLF
         gSKQKq7V4QWgwiAG14DUri1As7hGtMfaRIWT5g1aK0U1O/g7fHlVRwL/1CHerGe8+Snu
         IrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6+m/AfSrQMn6pAC0WxMUVShbSagBo8w6vu6A2OyqZ7Q=;
        b=pyP7o55wPqPviwmPMsE+WTkVG1k6WSxnyKW3gwOpp7m/fgWSHV/SmSDVaPGqe1zIgf
         lmrz7sfxpV15jv8pxdVzZQOXcKMV6nNK8lXDPX1g1kCxJIGWTmLKubb2ckK5CObJdtBJ
         TgVbpzT3n8vcbWHlLEg6QrESXJ04OlsIcDL/xECbL3cglZ7wXGYMGaUmlsge0DuKCNeS
         vnghb9Mlu0DhzyB5Q0KI7gKyJqzuKYYWiV2qmkKru+MYWcaug3C7sWh3NO/3gAUJCCKW
         1HN+Sv6Zdwwfcez1PBhzOUPigz02N4M73a/Nd08eb9vRZJRbNdE+DTGzRYT093U1Ey1A
         W0ew==
X-Gm-Message-State: APjAAAV5NIrJCBUXoZMpmhaZJ7ogLB5/rh2hQIkjvbdBtRyk1u14UCAW
        LdswY+sVXkLfCU1y40p5i8YEP1IL/GbYAm5jbeKwSOSHLKg=
X-Google-Smtp-Source: APXvYqy2FccMbUxO4AxNBp0oJaDhzp9r6B83xnbYw6yXIRpnP1v/RUCovFf3JblchUdslUfB30e+9AQbfEWExyXOntM=
X-Received: by 2002:a24:50d5:: with SMTP id m204mr6290597itb.103.1553734178536;
 Wed, 27 Mar 2019 17:49:38 -0700 (PDT)
MIME-Version: 1.0
From:   Bryan Turner <bturner@atlassian.com>
Date:   Wed, 27 Mar 2019 17:49:27 -0700
Message-ID: <CAGyf7-F8cmzOuhi6zeJJ13iwGh_ie-uTiJYUzBwssvH+kCY+yA@mail.gmail.com>
Subject: Puzzling Git backtrace
To:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm trying to assist a Bitbucket Server customer who is seeing some
"git-upload-pack" processes "hang" on their server.

While investigating, we had them connect gdb to their processes (which
are 2.10.0 built from source using a simple unzip-and-run-make
approach) and get the backtraces for them. The output that they're
seeing makes no sense to me, though, so I'm throwing this out to the
list just to see if anyone has any idea how the processes could end up
like this.

One "family" of "hung" processes looks like this in ps:

32432  7811 atlbitb+ Mar22 /bin/git upload-pack /path/to/repository
32433 32432 atlbitb+ Mar22 git-upload-pack /path/to/repository

Looks normal enough. The backtrace for process 32432 also looks like I'd expect:

#0  0x00007fa39842fc9c in __libc_waitpid (pid=pid@entry=32433,
stat_loc=stat_loc@entry=0x7fffb42a4e4c, options=options@entry=0) at
../sysdeps/unix/sysv/linux/waitpid.c:31
#1  0x00000000005098f2 in wait_or_whine (pid=32433, argv0=0xd6e0c0
"git-upload-pack", in_signal=in_signal@entry=0) at run-command.c:229
#2  0x000000000050a949 in finish_command
(cmd=cmd@entry=0x7fffb42a4ea0) at run-command.c:537
#3  0x000000000050a9c1 in run_command (cmd=cmd@entry=0x7fffb42a4ea0)
at run-command.c:558
#4  0x000000000050aa5e in run_command_v_opt_cd_env
(argv=argv@entry=0x7fffb42a5140, opt=opt@entry=40, dir=dir@entry=0x0,
env=env@entry=0x0) at run-command.c:578
#5  0x000000000050aa79 in run_command_v_opt
(argv=argv@entry=0x7fffb42a5140, opt=opt@entry=40) at
run-command.c:563
#6  0x0000000000405ad0 in execv_dashed_external (argv=0x7fffb42a5140)
at git.c:569
#7  run_argv (argv=0x7fffb42a4f10, argcp=0x7fffb42a4f1c) at git.c:596
#8  cmd_main (argc=2, argc@entry=3, argv=0x7fffb42a5140,
argv@entry=0x7fffb42a5138) at git.c:665
#9  0x0000000000404d9d in main (argc=3, argv=0x7fffb42a5138) at common-main.c:40

It's in "wait_or_whine" for "git-upload-pack".

When they attached to 32433 and printed its backtrace, though, things
go a little sideways:

(gdb) attach 32433
Attaching to program: /usr/bin/git, process 32433
Reading symbols from /lib64/ld-linux-x86-64.so.2...Reading symbols
from /usr/lib/debug/usr/lib64/ld-2.17.so.debug...done.
done.
Loaded symbols for /lib64/ld-linux-x86-64.so.2
0x00007f79d1aca240 in ?? ()
(gdb) bt
#0  0x00007f79d1aca240 in ?? ()
#1  0x000000000045179e in mktree_line (allow_missing=4,
nul_term_line=0, len=<optimized out>, buf=<optimized out>) at
builtin/mktree.c:103
#2  cmd_mktree (ac=<optimized out>, av=<optimized out>,
prefix=<optimized out>) at builtin/mktree.c:173
#3  0x0000000000000000 in ?? ()

So ps shows "git-upload-pack", and the parent process shows it's
waiting for "git-upload-pack", but gdb shows it's attaching to "git",
not "git-upload-pack", and the stack trace on the child shows it's
running "git mktree". I've searched through the source code and I
don't see any path through upload-pack.c that could result in it
essentially exec'ing "git mktree" over the top of itself, or even
spawning a "git mktree" of its own.

Has anyone seen anything like this before? Any thoughts on how what
should be a "git-upload-pack" could possibly end up being a "git
mktree" instead?

Best regards,
Bryan
