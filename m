Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D09C433FE
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 15:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242807AbiA0PJ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 10:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242796AbiA0PJW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 10:09:22 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90652C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 07:09:22 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id i10so9588159ybt.10
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 07:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=knb5L5Ukp9mYCRneB7fdA0Aq1Fw8cyRnuG3+9MTWHPk=;
        b=f6Hnhj9U6ywE4mCJu8NSa5J4vHq+us33hbGHf/shrPVEbDDpvUUdAOB1MnaAs4qCBC
         DZF0c28xJRXsCdjuIwWjrtKlxKKYG9O/tcAreAOoKtnQJxk0SbINVnjKiJ//y+EftS/b
         2lmipkWmKdXjKfbUVJtXYyzy+dSpqujwQCPktNYE99LpYcSFqZWOFRbxCFIs2ArfRJsa
         HoRHf1jmN1PifMtBcMKNA8Uy3UKGSV6EqYLTNlRh9I6s3d9cy2pwxv8Won4Tt0W25Cv4
         m2DY7LCVWmxvTXgSzE5sXrAFuCQ1ZZOw2Z2zXGfxjYmh7aEX/vGv5FmCpcJsKjgq+jcU
         R3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=knb5L5Ukp9mYCRneB7fdA0Aq1Fw8cyRnuG3+9MTWHPk=;
        b=eRyXH/JRYo2hm1iSBR0GzDCezJ8kOimmQfI9mqX9JM2CrsvOnnzgTvCc+hPTwuU0Vx
         XvoVKJ9tc3LknXBCDho8bko7mMDWgSi5jqIz41L+Doqmzq+JgimyUKVmBD5WfDbHD+TX
         cD3lo9bbBkfyUBF03aqWXJDB09YX12tlBfzWBN5Zp9VsOTnZJhSBcS8/YW4uXTbcF3WQ
         cHVRRvGGKLYNvNWBFuxIB5hiOL0+UUh6mCtNhkfC1yJ/Dmn4guUCOKeMj3VoxBRtxkQI
         UUPj+wFqlE1WFvLjBlR7Pv7gwLkMoyRk1RzlxYSfWfFofBZWpz7VvWUGFvaiQeLViVLj
         5hjw==
X-Gm-Message-State: AOAM530jRk4rBcjq6K9t2OA8WIN70q6gtcTQdQSgbmSIM20Twrccmpd9
        5v9+ePxyNSobFJ/1BByovnhWrK+nZTXJ6nJfqtva7JpeVkY=
X-Google-Smtp-Source: ABdhPJxYWvXACy8UOgrysmZRLZ/+PaukNi4+Fl3+d9z6cxbkhIPdaXKtiFdCLdOy1sGpqgZ9/Yq8WBXiVmcpqTFVTH0=
X-Received: by 2002:a25:6d05:: with SMTP id i5mr6010244ybc.179.1643296161391;
 Thu, 27 Jan 2022 07:09:21 -0800 (PST)
MIME-Version: 1.0
From:   clime <clime7@gmail.com>
Date:   Thu, 27 Jan 2022 16:09:10 +0100
Message-ID: <CAGqZTUuLNoZR7L9r1unR75S4Gte83DGSV2QUnGG2PqQOPBigAg@mail.gmail.com>
Subject: spurious git stash create failures
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I am using `git stash create` from a python script and occasionally it
fails with return code 1 without seemingly any reason (i.e. without
printing anything to stderr).

After discussing this in the git irc channel, I have added strace to
the call (GIT_TRACE=2 env var didn't provide any info except: "trace:
built-in: git stash create" and then fail).

I also wrapped the call in for loop to retry if it fails ;( and today,
on a clean work-tree, it failed once and then immediately succeeded on
next loop iteration a few tens of ms later. Here are strace parts that
went differently in each try:

(I reproduced this on git 2.30 and 2.31 on two different systems, i
don't use any GUI or IDE, just the script that calls git stash
create).

...
newfstatat(AT_FDCWD, "merge_runs.py", {st_mode=S_IFREG|0775,
st_size=1164, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(AT_FDCWD, "paper_reproducer", {st_mode=S_IFREG|0775,
st_size=81651, ...}, AT_SYMLINK_NOFOLLOW) = 0   ### till now the same
in successful run
readlink(".git/index", 0x55c61b001a30, 32) = -1 EINVAL (Invalid
argument)   ### this block until ENDBLOCK is only present in the
failed run
getcwd("/home/clime/vizorbot", 129) = 21
openat(AT_FDCWD, "/home/clime/vizorbot/.git/index.lock",
O_RDWR|O_CREAT|O_EXCL|O_CLOEXEC, 0666) = 3
rt_sigaction(SIGINT, {sa_handler=0x55c6198df5a0, sa_mask=[INT],
sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7f9d3d534320},
{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGHUP, {sa_handler=0x55c6198df5a0, sa_mask=[HUP],
sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7f9d3d534320},
{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGTERM, {sa_handler=0x55c6198df5a0, sa_mask=[TERM],
sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7f9d3d534320},
{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGQUIT, {sa_handler=0x55c6198df5a0, sa_mask=[QUIT],
sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7f9d3d534320},
{sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGPIPE, {sa_handler=0x55c6198df5a0, sa_mask=[PIPE],
sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7f9d3d534320},
{sa_handler=SIG_DFL, sa_mask=[PIPE], sa_flags=SA_RESTORER|SA_RESTART,
sa_restorer=0x7f9d3d534320}, 8) = 0
getpid() = 7126
newfstatat(AT_FDCWD, "paper_reproducer", {st_mode=S_IFREG|0775,
st_size=81651, ...}, AT_SYMLINK_NOFOLLOW) = 0
openat(AT_FDCWD, "paper_reproducer", O_RDONLY|O_CLOEXEC) = 4
openat(AT_FDCWD, "/etc/gitattributes", O_RDONLY) = -1 ENOENT (No such
file or directory)
openat(AT_FDCWD, "/home/clime/.config/git/attributes", O_RDONLY) = -1
ENOENT (No such file or directory)
openat(AT_FDCWD, ".gitattributes", O_RDONLY) = -1 ENOENT (No such file
or directory)
openat(AT_FDCWD, ".git/info/attributes", O_RDONLY) = -1 ENOENT (No
such file or directory)
mmap(NULL, 81651, PROT_READ, MAP_PRIVATE, 4, 0) = 0x7f9d2fe30000
munmap(0x7f9d2fe30000, 81651) = 0
close(4) = 0
newfstatat(AT_FDCWD, "param_sets", {st_mode=S_IFDIR|0775,
st_size=4096, ...}, AT_SYMLINK_NOFOLLOW) = 0   ### ENDBLOCK
newfstatat(AT_FDCWD, "param_sets/params0", {st_mode=S_IFDIR|0775,
st_size=4096, ...}, AT_SYMLINK_NOFOLLOW) = 0

... now this part in the end is also only in failed run:

lseek(3, 0, SEEK_CUR) = 0
lseek(3, 0, SEEK_CUR) = 0
write(3, "DIRC\0\0\0\2\0\0\0016a\354'@%\253\301\36a\354'@%\253\301\36\0\0\375\0"...,
48938) = 48938
close(3) = 0
newfstatat(AT_FDCWD, "/home/clime/vizorbot/.git/index.lock",
{st_mode=S_IFREG|0664, st_size=48938, ...}, 0) = 0
rename("/home/clime/vizorbot/.git/index.lock",
"/home/clime/vizorbot/.git/index") = 0
access(".git/hooks/post-index-change", X_OK) = -1 ENOENT (No such file
or directory)
newfstatat(AT_FDCWD, ".git/HEAD", {st_mode=S_IFREG|0664, st_size=23,
...}, AT_SYMLINK_NOFOLLOW) = 0
openat(AT_FDCWD, ".git/HEAD", O_RDONLY) = 3
read(3, "ref: refs/heads/master\n", 256) = 23
read(3, "", 233) = 0
close(3) = 0
newfstatat(AT_FDCWD, ".git/refs/heads/master", {st_mode=S_IFREG|0664,
st_size=41, ...}, AT_SYMLINK_NOFOLLOW) = 0
openat(AT_FDCWD, ".git/refs/heads/master", O_RDONLY) = 3
read(3, "71bbd69706edf1746ce971e495f841a5"..., 256) = 41
read(3, "", 215) = 0
close(3) = 0
newfstatat(AT_FDCWD, ".git/refs/HEAD", 0x7ffc90cf1990,
AT_SYMLINK_NOFOLLOW) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, ".git/packed-refs", {st_mode=S_IFREG|0664,
st_size=373, ...}, 0) = 0
newfstatat(AT_FDCWD, ".git/refs/tags/HEAD", 0x7ffc90cf1990,
AT_SYMLINK_NOFOLLOW) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, ".git/packed-refs", {st_mode=S_IFREG|0664,
st_size=373, ...}, 0) = 0
newfstatat(AT_FDCWD, ".git/refs/heads/HEAD", 0x7ffc90cf1990,
AT_SYMLINK_NOFOLLOW) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, ".git/packed-refs", {st_mode=S_IFREG|0664,
st_size=373, ...}, 0) = 0
newfstatat(AT_FDCWD, ".git/refs/remotes/HEAD", 0x7ffc90cf1990,
AT_SYMLINK_NOFOLLOW) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, ".git/packed-refs", {st_mode=S_IFREG|0664,
st_size=373, ...}, 0) = 0
newfstatat(AT_FDCWD, ".git/refs/remotes/HEAD/HEAD", 0x7ffc90cf1990,
AT_SYMLINK_NOFOLLOW) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, ".git/packed-refs", {st_mode=S_IFREG|0664,
st_size=373, ...}, 0) = 0
newfstatat(AT_FDCWD, ".git/HEAD", {st_mode=S_IFREG|0664, st_size=23,
...}, AT_SYMLINK_NOFOLLOW) = 0
openat(AT_FDCWD, ".git/HEAD", O_RDONLY) = 3
read(3, "ref: refs/heads/master\n", 256) = 23
read(3, "", 233) = 0
close(3) = 0
newfstatat(AT_FDCWD, ".git/refs/heads/master", {st_mode=S_IFREG|0664,
st_size=41, ...}, AT_SYMLINK_NOFOLLOW) = 0
openat(AT_FDCWD, ".git/refs/heads/master", O_RDONLY) = 3
read(3, "71bbd69706edf1746ce971e495f841a5"..., 256) = 41
read(3, "", 215) = 0
close(3) = 0
newfstatat(AT_FDCWD, ".git/refs/HEAD", 0x7ffc90cf1990,
AT_SYMLINK_NOFOLLOW) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, ".git/packed-refs", {st_mode=S_IFREG|0664,
st_size=373, ...}, 0) = 0
newfstatat(AT_FDCWD, ".git/refs/tags/HEAD", 0x7ffc90cf1990,
AT_SYMLINK_NOFOLLOW) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, ".git/packed-refs", {st_mode=S_IFREG|0664,
st_size=373, ...}, 0) = 0
newfstatat(AT_FDCWD, ".git/refs/heads/HEAD", 0x7ffc90cf1990,
AT_SYMLINK_NOFOLLOW) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, ".git/packed-refs", {st_mode=S_IFREG|0664,
st_size=373, ...}, 0) = 0
newfstatat(AT_FDCWD, ".git/refs/remotes/HEAD", 0x7ffc90cf1990,
AT_SYMLINK_NOFOLLOW) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, ".git/packed-refs", {st_mode=S_IFREG|0664,
st_size=373, ...}, 0) = 0
newfstatat(AT_FDCWD, ".git/refs/remotes/HEAD/HEAD", 0x7ffc90cf1990,
AT_SYMLINK_NOFOLLOW) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, ".git/packed-refs", {st_mode=S_IFREG|0664,
st_size=373, ...}, 0) = 0
newfstatat(AT_FDCWD, ".git/HEAD", {st_mode=S_IFREG|0664, st_size=23,
...}, AT_SYMLINK_NOFOLLOW) = 0
openat(AT_FDCWD, ".git/HEAD", O_RDONLY) = 3
read(3, "ref: refs/heads/master\n", 256) = 23
read(3, "", 233) = 0
close(3) = 0
newfstatat(AT_FDCWD, ".git/refs/heads/master", {st_mode=S_IFREG|0664,
st_size=41, ...}, AT_SYMLINK_NOFOLLOW) = 0
openat(AT_FDCWD, ".git/refs/heads/master", O_RDONLY) = 3
read(3, "71bbd69706edf1746ce971e495f841a5"..., 256) = 41
read(3, "", 215) = 0
close(3) = 0
newfstatat(AT_FDCWD, ".git/refs/HEAD", 0x7ffc90cf0db0,
AT_SYMLINK_NOFOLLOW) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, ".git/packed-refs", {st_mode=S_IFREG|0664,
st_size=373, ...}, 0) = 0
newfstatat(AT_FDCWD, ".git/refs/tags/HEAD", 0x7ffc90cf0db0,
AT_SYMLINK_NOFOLLOW) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, ".git/packed-refs", {st_mode=S_IFREG|0664,
st_size=373, ...}, 0) = 0
newfstatat(AT_FDCWD, ".git/refs/heads/HEAD", 0x7ffc90cf0db0,
AT_SYMLINK_NOFOLLOW) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, ".git/packed-refs", {st_mode=S_IFREG|0664,
st_size=373, ...}, 0) = 0
newfstatat(AT_FDCWD, ".git/refs/remotes/HEAD", 0x7ffc90cf0db0,
AT_SYMLINK_NOFOLLOW) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, ".git/packed-refs", {st_mode=S_IFREG|0664,
st_size=373, ...}, 0) = 0
newfstatat(AT_FDCWD, ".git/refs/remotes/HEAD/HEAD", 0x7ffc90cf0db0,
AT_SYMLINK_NOFOLLOW) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, ".git/packed-refs", {st_mode=S_IFREG|0664,
st_size=373, ...}, 0) = 0
getpid() = 7126
exit_group(1) = ?
+++ exited with 1 +++

Best regards
clime
