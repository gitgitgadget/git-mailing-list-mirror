Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15E5C433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 05:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5A2660FC0
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 05:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbhJ2F7x (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 01:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbhJ2F7w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 01:59:52 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5881C061570
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 22:57:24 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id g17so8124338qtk.8
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 22:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=Gp/TU2psbR2l6ym2nKhp8qaAwtU7zxvAoDdAry4C6NA=;
        b=LnQKymW0XN2t9AQbLI6vDwtIMNVQKhAg8QJkqmqodu+5318zFDQ4hSWkZBIKvr5pBg
         Bg/m4yCGbmPU8fDTPZDkcHjleX0J7fYAaBOOm8StsO0QnYSTlnxIM1FqG9YI1mkSwaOl
         xyLjU1h9QxJOoJUwAzf7klazlRAL8KdlWGkSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Gp/TU2psbR2l6ym2nKhp8qaAwtU7zxvAoDdAry4C6NA=;
        b=Xwa0iGq+PuuEoIj9MiOc4qx12jsxEsuFIOs4lIu1EeSvL75981yBu4D3dhuwihhBal
         9GcMXhNOcGPBRDFqnyF16OCoUtDK+8EMxa2Cs7wnmC39bG3s7LKM6UiRRMqCu/9nC5e7
         qtFbP9vWhYr74MCosrEYwJt93c2OZ0bav9foXxV4k8b5fLtVHowoI0OPOq0AB7FgpnCg
         ehNerwtU9i09M5H8KHMBMYTbW8z25hfCOl4AyExc+Tlk8VZm2ktotAEph+VWtnXLA8ht
         GN0w2QTmum3mL6K8469EnqufvfMNW7nTnZvpH8DGSb1gK8TdSZ1YmY4yjUwUyMKfuNxR
         Vtsg==
X-Gm-Message-State: AOAM5326DTGKPXDzRRm2Vy/NpDOrAkHUze7bbZ/RHLxB69Garni6iTXW
        i3m3KUK2DbfioSRPiOd+qA5UrBwuq7Jvlf19ERvD/BzVqwc=
X-Google-Smtp-Source: ABdhPJxzXs//8CvUxZ/oFRfwZHP8pEewmxe8rBu1LWyUPRODNkQMIblCiTEIBFPjtahSiA/k3tmHNSx7z2acD5AUt8g=
X-Received: by 2002:a05:622a:180b:: with SMTP id t11mr9495049qtc.25.1635487042823;
 Thu, 28 Oct 2021 22:57:22 -0700 (PDT)
MIME-Version: 1.0
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 29 Oct 2021 05:57:11 +0000
Message-ID: <CACPK8Xcm-ivTkPVpF3XwaniUeyM_RJVLY9wSvBKbr-7rUYgdmQ@mail.gmail.com>
Subject: bug: invalid sha1 pointer in cache-tree
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I've filled out git-bugreport after discussing this issue with a git
developer. I'm not sure if it's user error, disk corruption, or a bug
in git. Any insight would be appreciated!

What did you do before the bug happened? (Steps to reproduce your issue)

I was attempting to merge a tag into the current branch. Before I did so, I
reset'd away a commit I didn't want:

$ git reset HEAD~1 --hard
error: Could not read 7c03aa457205afa2def273129653bea6225c5a0a
HEAD is now at 387b8b425339 spi: fsi: Print status on error

I fetched the tag I was after:

$ git fetch  stable
From https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux
   ed99bf0e81b5..2760370b1649  linux-4.14.y         -> stable/linux-4.14.y
   e34184f53363..ff079d726eb6  linux-4.19.y         -> stable/linux-4.19.y
   1392fe82d7fb..c67099a5bc53  linux-4.4.y          -> stable/linux-4.4.y
   9e8a7b701479..aa13f01432a2  linux-4.9.y          -> stable/linux-4.9.y
   5aa003b38148..3a9842b42e42  linux-5.10.y         -> stable/linux-5.10.y
   924356b31dcb..fe024e004fa3  linux-5.14.y         -> stable/linux-5.14.y
   faaca480fd5c..4f508aa9dd3b  linux-5.4.y          -> stable/linux-5.4.y
   080735f6de74..dddcb86bb323  linux-rolling-lts    -> stable/linux-rolling-lts
   66035107bbad..cc0dfcda549b  linux-rolling-stable ->
stable/linux-rolling-stable
   5d6ab0bb408f..3906fe9bb7f1  master               -> stable/master
 * [new tag]                   v4.14.251            -> v4.14.251
 * [new tag]                   v4.14.252            -> v4.14.252
 * [new tag]                   v4.19.211            -> v4.19.211
 * [new tag]                   v4.19.212            -> v4.19.212
 * [new tag]                   v4.19.213            -> v4.19.213
 * [new tag]                   v4.4.289             -> v4.4.289
 * [new tag]                   v4.9.287             -> v4.9.287
 * [new tag]                   v5.10.73             -> v5.10.73
 * [new tag]                   v5.10.74             -> v5.10.74
 * [new tag]                   v5.10.75             -> v5.10.75
 * [new tag]                   v5.14.12             -> v5.14.12
 * [new tag]                   v5.14.13             -> v5.14.13
 * [new tag]                   v5.14.14             -> v5.14.14
 * [new tag]                   v5.15-rc5            -> v5.15-rc5
 * [new tag]                   v5.15-rc6            -> v5.15-rc6
 * [new tag]                   v5.15-rc7            -> v5.15-rc7
 * [new tag]                   v5.4.153             -> v5.4.153
 * [new tag]                   v5.4.154             -> v5.4.154
 * [new tag]                   v5.4.155             -> v5.4.155

This is the merge. I hadn't touched any of these files (I don't work on
arch/xtensa at all), so this was unexpected:

$ git merge v5.14.14
error: Your local changes to the following files would be overwritten by merge:
  arch/xtensa/include/uapi/asm/Kbuild
arch/xtensa/include/uapi/asm/auxvec.h
arch/xtensa/include/uapi/asm/byteorder.h
arch/xtensa/include/uapi/asm/ioctls.h
arch/xtensa/include/uapi/asm/ipcbuf.h
arch/xtensa/include/uapi/asm/mman.h
arch/xtensa/include/uapi/asm/msgbuf.h
arch/xtensa/include/uapi/asm/param.h
arch/xtensa/include/uapi/asm/poll.h
arch/xtensa/include/uapi/asm/posix_types.h
arch/xtensa/include/uapi/asm/ptrace.h
arch/xtensa/include/uapi/asm/sembuf.h
arch/xtensa/include/uapi/asm/setup.h
arch/xtensa/include/uapi/asm/shmbuf.h
arch/xtensa/include/uapi/asm/sigcontext.h
arch/xtensa/include/uapi/asm/signal.h
arch/xtensa/include/uapi/asm/sockios.h
arch/xtensa/include/uapi/asm/stat.h
arch/xtensa/include/uapi/asm/swab.h
arch/xtensa/include/uapi/asm/termbits.h
arch/xtensa/include/uapi/asm/types.h
arch/xtensa/include/uapi/asm/unistd.h arch/xtensa/kernel/.gitignore
arch/xtensa/kernel/Makefile arch/xtensa/kernel/align.S
arch/xtensa/kernel/asm-offsets.c arch/xtensa/kernel/coprocessor.S
arch/xtensa/kernel/entry.S arch/xtensa/kernel/head.S
arch/xtensa/kernel/hw_breakpoint.c arch/xtensa/kernel/irq.c
arch/xtensa/kernel/jump_label.c arch/xtensa/kernel/mcount.S
arch/xtensa/kernel/module.c arch/xtensa/kernel/mxhead.S
arch/xtensa/kernel/pci-dma.c arch/xtensa/kernel/pci.c
arch/xtensa/kernel/perf_event.c arch/xtensa/kernel/platform.c
arch/xtensa/kernel/process.c arch/xtensa/kernel/ptrace.c
arch/xtensa/kernel/s32c1i_selftest.c arch/xtensa/kernel/setup.c
arch/xtensa/kernel/signal.c arch/xtensa/kernel/smp.c
arch/xtensa/kernel/stacktrace.c arch/xtensa/kernel/syscall.c
arch/xtensa/kernel/syscalls/Makefile
arch/xtensa/kernel/syscalls/syscall.tbl arch/xtensa/kernel/time.c
arch/xtensa/kernel/traps.c arch/xtensa/kernel/vectors.S
arch/xtensa/kernel/vmlinux.lds.S arch/xtensa/kernel/xtensa_ksyms.c
arch/xtensa/lib/Makefile arch/xtensa/lib/checksum.S
arch/xtensa/lib/memcopy.S arch/xtensa/lib/memset.S
arch/xtensa/lib/pci-auto.c arch/xtensa/lib/strncpy_user.S
arch/xtensa/lib/strnlen_user.S arch/xtensa/lib/usercopy.S
arch/xtensa/mm/Makefile arch/xtensa/mm/cache.c arch/xtensa/mm/fault.c
arch/xtensa/mm/highmem.c arch/xtensa/mm/init.c
arch/xtensa/mm/ioremap.c arch/xtensa/mm/kasan_init.c
arch/xtensa/mm/misc.S arch/xtensa/mm/mmu.c arch/xtensa/mm/tlb.c
arch/xtensa/platforms/iss/Makefile arch/xtensa/platforms/iss/console.c
arch/xtensa/platforms/iss/include/platform/serial.h
arch/xtensa/platforms/iss/include/platform/simcall-gdbio.h
arch/xtensa/platforms/iss/include/platform/simcall-iss.h
arch/xtensa/platforms/iss/include/platform/simcall.h
arch/xtensa/platforms/iss/network.c arch/xtensa/platforms/iss/setup.c
arch/xtensa/platforms/iss/simdisk.c
arch/xtensa/platforms/xt2000/Makefile
arch/xtensa/platforms/xt2000/include/platform/hardware.h
arch/xtensa/platforms/xt2000/include/platform/serial.h
arch/xtensa/platforms/xt2000/setup.c
arch/xtensa/platforms/xtfpga/Makefile
arch/xtensa/platforms/xtfpga/include/platform/hardware.h
arch/xtensa/platforms/xtfpga/include/platform/lcd.h
arch/xtensa/platforms/xtfpga/include/platform/serial.h
arch/xtensa/platforms/xtfpga/lcd.c
arch/xtensa/platforms/xtfpga/setup.c
arch/xtensa/variants/csp/include/variant/core.h
arch/xtensa/variants/csp/include/variant/tie-asm.h
arch/xtensa/variants/csp/include/variant/tie.h
arch/xtensa/variants/dc232b/include/variant/core.h
arch/xtensa/variants/dc232b/include/variant/tie-asm.h
arch/xtensa/variants/dc232b/include/variant/tie.h
arch/xtensa/variants/dc233c/include/variant/core.h
arch/xtensa/variants/dc233c/include/variant/tie-asm.h
arch/xtensa/variants/dc233c/include/variant/tie.h
arch/xtensa/variants/de212/include/variant/core.h
arch/xtensa/variants/de212/include/variant/tie-asm.h
arch/xtensa/variants/de212/include/variant/tie.h
arch/xtensa/variants/fsf/include/variant/core.h
arch/xtensa/variants/fsf/include/variant/tie-asm.h
arch/xtensa/variants/fsf/include/variant/tie.h
arch/xtensa/variants/test_kc705_be/include/variant/core.h
arch/xtensa/variants/test_kc705_be/include/variant/tie-asm.h
arch/xtensa/variants/test_kc705_b
$ git status
On branch dev-5.14
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
    new file:   arch/xtensa/include/uapi/asm/Kbuild
    new file:   arch/xtensa/include/uapi/asm/auxvec.h
    new file:   arch/xtensa/include/uapi/asm/byteorder.h
    new file:   arch/xtensa/include/uapi/asm/ioctls.h
    new file:   arch/xtensa/include/uapi/asm/ipcbuf.h
    new file:   arch/xtensa/include/uapi/asm/mman.h
    new file:   arch/xtensa/include/uapi/asm/msgbuf.h
    new file:   arch/xtensa/include/uapi/asm/param.h
    new file:   arch/xtensa/include/uapi/asm/poll.h
    new file:   arch/xtensa/include/uapi/asm/posix_types.h
    new file:   arch/xtensa/include/uapi/asm/ptrace.h
    new file:   arch/xtensa/include/uapi/asm/sembuf.h
    new file:   arch/xtensa/include/uapi/asm/setup.h
    new file:   arch/xtensa/include/uapi/asm/shmbuf.h
    new file:   arch/xtensa/include/uapi/asm/sigcontext.h
    new file:   arch/xtensa/include/uapi/asm/signal.h
    new file:   arch/xtensa/include/uapi/asm/sockios.h
    new file:   arch/xtensa/include/uapi/asm/stat.h
    new file:   arch/xtensa/include/uapi/asm/swab.h
    new file:   arch/xtensa/include/uapi/asm/termbits.h
    new file:   arch/xtensa/include/uapi/asm/types.h
    new file:   arch/xtensa/include/uapi/asm/unistd.h
    new file:   arch/xtensa/kernel/.gitignore
    new file:   arch/xtensa/kernel/Makefile
    new file:   arch/xtensa/kernel/align.S
    new file:   arch/xtensa/kernel/asm-offsets.c
    new file:   arch/xtensa/kernel/coprocessor.S
    new file:   arch/xtensa/kernel/entry.S
    new file:   arch/xtensa/kernel/head.S
    new file:   arch/xtensa/kernel/hw_breakpoint.c
    new file:   arch/xtensa/kernel/irq.c
    new file:   arch/xtensa/kernel/jump_label.c
    new file:   arch/xtensa/kernel/mcount.S
    new file:   arch/xtensa/kernel/module.c
    new file:   arch/xtensa/kernel/mxhead.S
    new file:   arch/xtensa/kernel/pci-dma.c
    new file:   arch/xtensa/kernel/pci.c
    new file:   arch/xtensa/kernel/perf_event.c
    new file:   arch/xtensa/kernel/platform.c
    new file:   arch/xtensa/kernel/process.c
    new file:   arch/xtensa/kernel/ptrace.c
    new file:   arch/xtensa/kernel/s32c1i_selftest.c
    new file:   arch/xtensa/kernel/setup.c
    new file:   arch/xtensa/kernel/signal.c
    new file:   arch/xtensa/kernel/smp.c
    new file:   arch/xtensa/kernel/stacktrace.c
    new file:   arch/xtensa/kernel/syscall.c
    new file:   arch/xtensa/kernel/syscalls/Makefile
    new file:   arch/xtensa/kernel/syscalls/syscall.tbl
    new file:   arch/xtensa/kernel/time.c
    new file:   arch/xtensa/kernel/traps.c
    new file:   arch/xtensa/kernel/vectors.S
    new file:   arch/xtensa/kernel/vmlinux.lds.S
    new file:   arch/xtensa/kernel/xtensa_ksyms.c
    new file:   arch/xtensa/lib/Makefile
    new file:   arch/xtensa/lib/checksum.S
    new file:   arch/xtensa/lib/memcopy.S
    new file:   arch/xtensa/lib/memset.S
    new file:   arch/xtensa/lib/pci-auto.c
    new file:   arch/xtensa/lib/strncpy_user.S
    new file:   arch/xtensa/lib/strnlen_user.S
    new file:   arch/xtensa/lib/usercopy.S
    new file:   arch/xtensa/mm/Makefile
    new file:   arch/xtensa/mm/cache.c
    new file:   arch/xtensa/mm/fault.c
    new file:   arch/xtensa/mm/highmem.c
    new file:   arch/xtensa/mm/init.c
    new file:   arch/xtensa/mm/ioremap.c
    new file:   arch/xtensa/mm/kasan_init.c
    new file:   arch/xtensa/mm/misc.S
    new file:   arch/xtensa/mm/mmu.c
    new file:   arch/xtensa/mm/tlb.c
    new file:   arch/xtensa/platforms/iss/Makefile
    new file:   arch/xtensa/platforms/iss/console.c
    new file:   arch/xtensa/platforms/iss/include/platform/serial.h
    new file:   arch/xtensa/platforms/iss/include/platform/simcall-gdbio.h
    new file:   arch/xtensa/platforms/iss/include/platform/simcall-iss.h
    new file:   arch/xtensa/platforms/iss/include/platform/simcall.h
    new file:   arch/xtensa/platforms/iss/network.c
    new file:   arch/xtensa/platforms/iss/setup.c
    new file:   arch/xtensa/platforms/iss/simdisk.c
    new file:   arch/xtensa/platforms/xt2000/Makefile
    new file:   arch/xtensa/platforms/xt2000/include/platform/hardware.h
    new file:   arch/xtensa/platforms/xt2000/include/platform/serial.h
    new file:   arch/xtensa/platforms/xt2000/setup.c
    new file:   arch/xtensa/platforms/xtfpga/Makefile
    new file:   arch/xtensa/platforms/xtfpga/include/platform/hardware.h
    new file:   arch/xtensa/platforms/xtfpga/include/platform/lcd.h
    new file:   arch/xtensa/platforms/xtfpga/include/platform/serial.h
    new file:   arch/xtensa/platforms/xtfpga/lcd.c
    new file:   arch/xtensa/platforms/xtfpga/setup.c
    new file:   arch/xtensa/variants/csp/include/variant/core.h
    new file:   arch/xtensa/variants/csp/include/variant/tie-asm.h
    new file:   arch/xtensa/variants/csp/include/variant/tie.h
    new file:   arch/xtensa/variants/dc232b/include/variant/core.h
    new file:   arch/xtensa/variants/dc232b/include/variant/tie-asm.h
    new file:   arch/xtensa/variants/dc232b/include/variant/tie.h
    new file:   arch/xtensa/variants/dc233c/include/variant/core.h
    new file:   arch/xtensa/variants/dc233c/include/variant/tie-asm.h
    new file:   arch/xtensa/variants/dc233c/include/variant/tie.h
    new file:   arch/xtensa/variants/de212/include/variant/core.h
    new file:   arch/xtensa/variants/de212/include/variant/tie-asm.h
    new file:   arch/xtensa/variants/de212/include/variant/tie.h
    new file:   arch/xtensa/variants/fsf/include/variant/core.h
    new file:   arch/xtensa/variants/fsf/include/variant/tie-asm.h
    new file:   arch/xtensa/variants/fsf/include/variant/tie.h
    new file:   arch/xtensa/variants/test_kc705_be/include/variant/core.h
    new file:   arch/xtensa/variants/test_kc705_be/include/variant/tie-asm.h
    new file:   arch/xtensa/variants/test_kc705_be/include/variant/tie.h
    new file:   arch/xtensa/variants/test_kc705_hifi/include/variant/core.h
    new file:   arch/xtensa/variants/test_kc705_hifi/include/variant/tie-asm.h
    new file:   arch/xtensa/variants/test_kc705_hifi/include/variant/tie.h
    new file:   arch/xtensa/variants/test_mmuhifi_c3/include/variant/core.h
    new file:   arch/xtensa/variants/test_mmuhifi_c3/include/variant/tie-asm.h
    new file:   arch/xtensa/variants/test_mmuhifi_c3/include/variant/tie.h

I cleaned up the working tree (rm -rf arch/xtensa && git reset --hard)
and re-attempted the merge:

$ git merge v5.14.14
fatal: unable to read tree 7c03aa457205afa2def273129653bea6225c5a0a

This is the error I now see when I re-attempt the merge.

What did you expect to happen? (Expected behavior)

The tag to be merged.

What happened instead? (Actual behavior)

The merge failed:

$ git merge v5.14.14
fatal: unable to read tree 7c03aa457205afa2def273129653bea6225c5a0a

What's different between what you expected and what actually happened?

I expected the merge to complete successfully.

Anything else you want to add:

I have tree git trees involved:

linus, a clone of torvald's tree
stable, a bare clone of the stable tree. it was cloned with a
--reference to linus
openbmc, a clone of a kernel tree that has a --reference to both
stable and linus.

I did a fsck and saw this:

error: 7c03aa457205afa2def273129653bea6225c5a0a: invalid sha1 pointer
in cache-tree
broken link from    tree 385b33c97554b2ab43b7dea822b34e10e9d7ce66 (:)
              to    tree 7c03aa457205afa2def273129653bea6225c5a0a (:configs/)


I have since tried re-fetching all three repositories in turn, and
this had no change:

git fetch-pack --all https://github.com/openbmc/linux
git fetch-pack --all
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch-pack --all
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git

I also tried removing and re-cloning the stable tree (an the assumption that
this is where the objects that make up the problematic v5.14.14 tag should come
from), but this did not help. I have however changed the output of git fsck:

$ git merge v5.14.14
fatal: unable to read tree 385b33c97554b2ab43b7dea822b34e10e9d7ce66

$ git fsck
...
error: 385b33c97554b2ab43b7dea822b34e10e9d7ce66: invalid sha1 pointer
in cache-tree
broken link from    tree 61a337aed7681b506b935b507a422fc5983ba4f3 (:)
              to    tree 385b33c97554b2ab43b7dea822b34e10e9d7ce66 (:powerpc/)


Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.33.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.14.0-2-amd64 #1 SMP Debian 5.14.9-2 (2021-10-03) x86_64
compiler info: gnuc: 10.2
libc info: glibc: 2.33
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]

Cheers,

Joel
