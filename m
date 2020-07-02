Return-Path: <SRS0=gkpi=AN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161C0C433DF
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 07:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2E7B20874
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 07:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=neanderfunk.de header.i=@neanderfunk.de header.b="ah5QT6Z3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgGBHHv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jul 2020 03:07:51 -0400
Received: from mail.nadeshda.org ([51.255.233.210]:51228 "EHLO
        mail.nadeshda.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgGBHHu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jul 2020 03:07:50 -0400
X-Greylist: delayed 77071 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Jul 2020 03:07:49 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2BCEE176A0B;
        Thu,  2 Jul 2020 09:07:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=neanderfunk.de;
        s=default; t=1593673668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/XHNqaEeMrIhz+Q1sYEQkO878vieQFIYWPlNHZ25OGk=;
        b=ah5QT6Z3cAsV4A2RE9RSW4CRvIcb4llxu0S0OzraZ3iNLDJJxo6K/Q183ddHT4pIohJqIr
        KxAmY9/n2rkw8Yl+hYuYdO7CzL0YflW8Y+BCHw6y05Lj+BwTgsW3+CcbRSUVq1gr1Jcfia
        auT7hL0Ve0HK0TS3QK8MolM903knXr5jKC7Wad0bC5O/98pS9zoukruXUcEXT6KwZV/Sov
        yAnP5WONFCWDHjbKvuHuZla1kkvQ3SAQsdSbyA/noT/RR11d2pUFgot6++5acLGBEQotY2
        cqDjjH7MLTDlTIP4AB4jXVpqf0vK+LEhwcq31nuGriDFcNYPnvK151b1DD5wHw==
Subject: Re: Interrupted system call
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, santiago@nyu.edu
References: <14b3d372-f3fe-c06c-dd56-1d9799a12632@yahoo.de>
 <c8061cce-71e4-17bd-a56a-a5fed93804da@neanderfunk.de>
 <20200701162111.GA934052@coredump.intra.peff.net>
From:   "R. Diez" <rdiez@neanderfunk.de>
Message-ID: <11754dcc-3c88-04dd-d009-89da01881e5d@neanderfunk.de>
Date:   Thu, 2 Jul 2020 09:07:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200701162111.GA934052@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


 > [...]
> It would be interesting to know which syscall is
> actually failing. Running the failure case under "strace" would be
> interesting (likewise to see which signal is causing the interruption).
 > [...]


First of all, thanks for your help.

GIT_TRACE alone does not tell me anything useful:

$ GIT_TRACE=true git fsck
07:58:47.229138 git.c:442               trace: built-in: git fsck
error: unable to mmap ./objects/cb/fec04963c1090535d2670b741912e17fd27b27: Interrupted system call
error: cbfec04963c1090535d2670b741912e17fd27b27: object corrupt or missing: ./objects/cb/fec04963c1090535d2670b741912e17fd27b27
Checking object directories: 100% (256/256), done.
Checking objects: 100% (70229/70229), done.
Checking connectivity: 75316, done.
missing commit cbfec04963c1090535d2670b741912e17fd27b27
dangling commit 6835e962b227e957520addbc5c28aedc97b253f3
dangling tree a9d1a1321066d8a8402f1c9e584675146d250952


GIT_TRACE_FSMONITOR does not either:

$ GIT_TRACE_FSMONITOR=true git fsck 

error: unable to mmap ./objects/56/af267465e7cdb7ccebe8242e55c03d4b675684: Interrupted system call
error: 56af267465e7cdb7ccebe8242e55c03d4b675684: object corrupt or missing: ./objects/56/af267465e7cdb7ccebe8242e55c03d4b675684
Checking object directories: 100% (256/256), done.
Checking objects: 100% (70229/70229), done.
Checking connectivity: 75666, done.
missing tree 56af267465e7cdb7ccebe8242e55c03d4b675684

It is the same Git repository, so it looks like every time a different, random file fails.


I managed to make it fail once with:

   strace -f -- git fsck --progress

The signal involved is SIGALRM. I am guessing that Git is setting it up in order to display its progress messages. This is one of the few 
calls to rt_sigaction(SIGALRM):

rt_sigaction(SIGALRM, {sa_handler=0x556c8ac0fe80, sa_mask=[], sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7fbdca7da890}, NULL, 8) = 0


This is the first failure:

openat(AT_FDCWD, "./objects/11/a327f469cc40015d6d873f6eed328e977c4234", O_RDONLY|O_CLOEXEC) = -1 EINTR (Interrupted system call)
--- SIGALRM {si_signo=SIGALRM, si_code=SI_KERNEL} ---
rt_sigreturn({mask=[]})                 = -1 EINTR (Interrupted system call)
openat(AT_FDCWD, "/usr/share/locale/en_US/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/usr/share/locale/en/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/usr/share/locale-langpack/en_US/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/usr/share/locale-langpack/en/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
write(2, "error: unable to mmap ./objects/"..., 99error: unable to mmap ./objects/11/a327f469cc40015d6d873f6eed328e977c4234: Interrupted 
system call
) = 99
write(2, "error: 11a327f469cc40015d6d873f6"..., 128error: 11a327f469cc40015d6d873f6eed328e977c4234: object corrupt or missing: 
./objects/11/a327f469cc40015d6d873f6eed328e977c4234
) = 128


This is the second one:

openat(AT_FDCWD, "./objects/18/5b82729943708795b635899348ecca97aa7804", O_RDONLY|O_CLOEXEC) = -1 EINTR (Interrupted system call)
--- SIGALRM {si_signo=SIGALRM, si_code=SI_KERNEL} ---
rt_sigreturn({mask=[]})                 = -1 EINTR (Interrupted system call)
write(2, "error: unable to mmap ./objects/"..., 99error: unable to mmap ./objects/18/5b82729943708795b635899348ecca97aa7804: Interrupted 
system call
) = 99
write(2, "error: 185b82729943708795b635899"..., 128error: 185b82729943708795b635899348ecca97aa7804: object corrupt or missing: 
./objects/18/5b82729943708795b635899348ecca97aa7804
) = 128

There are a few more failures.

This is the last one. Afterwards, Git exited:

openat(AT_FDCWD, "./objects/f4/56439700761946c57ef467a8a125a80f0304bd", O_RDONLY|O_CLOEXEC) = -1 EINTR (Interrupted system call)
--- SIGALRM {si_signo=SIGALRM, si_code=SI_KERNEL} ---
rt_sigreturn({mask=[]})                 = -1 EINTR (Interrupted system call)
openat(AT_FDCWD, "./objects/pack", O_RDONLY|O_NONBLOCK|O_CLOEXEC|O_DIRECTORY) = 3
fstat(3, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
brk(0x556c934af000)                     = 0x556c934af000
getdents(3, /* 19 entries */, 1048576)  = 1272
getdents(3, /* 0 entries */, 1048576)   = 0
close(3)                                = 0
write(2, "fatal: failed to read object f45"..., 95fatal: failed to read object f456439700761946c57ef467a8a125a80f0304bd: Interrupted system call
) = 95
exit_group(128)                         = ?
+++ exited with 128 +++


I am not an expert in Unix signals, but I'll do my best here.

I do not understand why Git is getting these interruptions due to SIGALRM, because SA_RESTART is in place.

Interestingly, the man page signal(7) does list open() under that flag, but not openat().

The description for open() under SA_RESTART is also interesting:

* open(2), if it can block (e.g., when opening a FIFO; see fifo(7)).

I am not sure that opening a normal disk file may qualify as "can block" with that definition though.

Best regards,
   rdiez
