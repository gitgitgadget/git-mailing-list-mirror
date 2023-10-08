Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862B1E95A67
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 20:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjJHUfQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 16:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjJHUfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 16:35:16 -0400
X-Greylist: delayed 457 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 08 Oct 2023 13:35:13 PDT
Received: from mail.d-paulus.de (elara.d-paulus.de [IPv6:2a03:4000:21:11c::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F21AC
        for <git@vger.kernel.org>; Sun,  8 Oct 2023 13:35:13 -0700 (PDT)
Received: from d-paulus.de (unknown [IPv6:2a02:168:7af0:1::9f9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
        (No client certificate requested)
        by mail.d-paulus.de (Postfix) with ESMTPSA id E94557E62CC
        for <git@vger.kernel.org>; Sun,  8 Oct 2023 22:27:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dominik-paulus.ch;
        s=mail; t=1696796852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=K9eNypRGdZRxYWWRLLwubd6WZ/cyAASDROvjHnyip/Y=;
        b=aPvCquefNeXZ3ClLLGqkNe+y8zkt8TipVgFsfE8Q2hDt/fkoVPvjt82V1b/N3dS3m54Qwh
        83iR57NcZkGPe6zPVK7S+YBOpDLJPMo6DBuH1DHqCD5L6WzarkqFJJb40/KFbp886fIzln
        lZiINDbx0J7+IgpZVWae57tRzowChjk=
Date:   Sun, 8 Oct 2023 22:27:30 +0200
From:   Dominik Paulus <git-bugreport@dominik-paulus.ch>
To:     git@vger.kernel.org
Subject: Bug: 'git diff' crashes on corrupted repository
Message-ID: <wawqkhikp5ga4b6talc4zug7mgzwdf36yyc5jqontk6v3zcryy@ds5iqwuj2omw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened?
I have a git repository which is stored in a 'Seafile' shared folder[0]. As I
noticed, 'Seafile' seems to not correctly sync hidden files/dotfiles, so after
modifying the git repository on one host, the ".git" directory in the Seafile
replica on the other host is inconsistent: Specifically, it seems to be
missing a subset of the files in '.git/objects'.
'git fsck' complains about various missing blobs, dangling commits, dangling
trees, broken links, and notably also "error: HEAD: invalid sha1 pointer
[...]".

On this - obviously corrupted - repository, most git commands report "fatal:
bad object HEAD". In contrast, 'git diff' crashes:

$ git status
fatal: bad object HEAD
$ git log
fatal: bad object HEAD
$ git diff
Segmentation fault (core dumped)
$

This is the stacktrace for this crash (gdb output):

-----
Starting program: /usr/bin/git diff
Downloading separate debug info for system-supplied DSO at 0x7ffff7fc8000
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/usr/lib/libthread_db.so.1".
[Detaching after fork from child process 16789]

Program received signal SIGSEGV, Segmentation fault.
0x00005555556ff6ac in diff_add_if_missing (r=0x555555966ac0 <the_repo>, to_fetch=0x7fffffffce10, filespec=0x555555975)
    at /usr/src/debug/git/git-2.42.0/diff.c:6895
6895		if (filespec && filespec->oid_valid &&
(gdb) bt
#0  0x00005555556ff6ac in diff_add_if_missing (r=0x555555966ac0 <the_repo>, to_fetch=0x7fffffffce10, filespec=0x555555975)
    at /usr/src/debug/git/git-2.42.0/diff.c:6895
#1  0x00005555556ff7aa in diff_queued_diff_prefetch (repository=0x555555966ac0 <the_repo>)
    at /usr/src/debug/git/git-2.42.0/diff.c:6911
#2  0x00005555556f5e74 in diff_populate_filespec (r=0x555555966ac0 <the_repo>, s=0x555555977660, options=0x7fffffffcfe0)
    at /usr/src/debug/git/git-2.42.0/diff.c:4184
#3  0x00005555556fee70 in diff_filespec_check_stat_unmatch (r=0x555555966ac0 <the_repo>, p=p@entry=0x5555559755e0)
    at /usr/src/debug/git/git-2.42.0/diff.c:6839
#4  0x0000555555709560 in diffcore_skip_stat_unmatch (diffopt=0x7fffffffdb20) at /usr/src/debug/git/git-2.42.0/diff.c:6857
#5  diffcore_std (options=<optimized out>) at /usr/src/debug/git/git-2.42.0/diff.c:6946
#6  0x00005555556ee59c in run_diff_files (revs=<optimized out>, option=<optimized out>)
    at /usr/src/debug/git/git-2.42.0/diff-lib.c:272
#7  0x00005555555ba95b in builtin_diff_files (argv=<optimized out>, argc=<optimized out>, revs=<optimized out>)
    at builtin/diff.c:293
#8  cmd_diff (argc=1, argv=0x7fffffffe7a0, prefix=<optimized out>) at builtin/diff.c:586
#9  0x00005555555767f4 in run_builtin (argv=0x7fffffffe7a0, argc=1, p=0x555555938db0 <commands.lto_priv+816>)
    at /usr/src/debug/git/git-2.42.0/git.c:469
#10 handle_builtin (argc=1, argv=0x7fffffffe7a0) at /usr/src/debug/git/git-2.42.0/git.c:723
#11 0x0000555555576dab in run_argv (argcp=0x7fffffffe4ec, argv=0x7fffffffe510) at /usr/src/debug/git/git-2.42.0/git.c:787
#12 0x00005555555727e3 in cmd_main (argv=<optimized out>, argc=<optimized out>) at /usr/src/debug/git/git-2.42.0/git.c:922
#13 main (argc=<optimized out>, argv=<optimized out>) at /usr/src/debug/git/git-2.42.0/common-main.c:62
(gdb) print filespec->oid_valid
Cannot access memory at address 0x555555975
(gdb)
-----


What did you expect to happen?
'git diff' should not crash/perform invalid memory accesses on a corrupted repository.


[System Info]
git version:
git version 2.42.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.5.5-arch1-1 #1 SMP PREEMPT_DYNAMIC Sat, 23 Sep 2023 22:55:13 +0000 x86_64
compiler info: gnuc: 13.2
libc info: glibc: 2.38
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]



[0] I'm aware that this is a bad idea in the first place and a red flag about
the underlying workflow :).
