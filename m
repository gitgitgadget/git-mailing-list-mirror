Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7159DC4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 09:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 533CF6054F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 09:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239706AbhHYJ4p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 05:56:45 -0400
Received: from forward108j.mail.yandex.net ([5.45.198.253]:46248 "EHLO
        forward108j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239735AbhHYJ4n (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Aug 2021 05:56:43 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Aug 2021 05:56:43 EDT
Received: from myt3-cee5d581c61e.qloud-c.yandex.net (myt3-cee5d581c61e.qloud-c.yandex.net [IPv6:2a02:6b8:c00:321e:0:640:cee5:d581])
        by forward108j.mail.yandex.net (Yandex) with ESMTP id 77AA93F22D03
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 12:49:11 +0300 (MSK)
Received: from myt3-5a0d70690205.qloud-c.yandex.net (myt3-5a0d70690205.qloud-c.yandex.net [2a02:6b8:c12:4f2b:0:640:5a0d:7069])
        by myt3-cee5d581c61e.qloud-c.yandex.net (mxback/Yandex) with ESMTP id RWARSS0AQK-nBHaCqoh;
        Wed, 25 Aug 2021 12:49:11 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1629884951;
        bh=a3pLnNgWbjtXL6sugUFafaT4EE9AjGDNLlGqHrA3RZI=;
        h=Date:To:From:Subject:Message-ID;
        b=rR8gn5BUgYOUzs+xhI2q7otV88YpwR0U9geu2RNXsR1uIBmID+aVzRa1V5hkhCy3y
         7ebXLjW2f/Q6tWIRy9kovJx+a/clOC1jMyGgO7eYcXXAEWFozEL2IUm8Cd/djJNc9H
         fuPDZts/an44AgMeBdZ8QGTnzPhsMHD4An8gV0xQ=
Authentication-Results: myt3-cee5d581c61e.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt3-5a0d70690205.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id JysJx66B9Q-nB3KEa60;
        Wed, 25 Aug 2021 12:49:11 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Message-ID: <7d29b582ef44785015e631251da8499b197ff4bc.camel@yandex.ru>
Subject: [BUG] git-rebase unnecessarily change mtime of files
From:   Konstantin Kharlamov <hi-angel@yandex.ru>
To:     git@vger.kernel.org
Date:   Wed, 25 Aug 2021 12:49:10 +0300
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Suppose your branch has *one* commit that modified file `myfile`. When you
interactively-rebase to that commit, mtime of that file will change even if
though you did not change the file (i.e. commit you are on has changed the file,
but since you're *at* this commit, not before this, there shouldn't have been
any change to the file).

This might be bad for performance; however what concerns me personally the most
is that my editor keeps asking me "file was changed on the disk, are you sure
you wanna modify the file?", which is confusing and annoying.

I am also not completely sure, but it might be a regression, because I don't
seem to remember having that before.

# Steps to reproduce

 λ mkdir foo
 λ cd foo
 λ git init
hint: Using 'master' as the name for the initial branch. This default branch
name
hint: is subject to change. To configure the initial branch name to use in all
hint: of your new repositories, which will suppress this warning, call:
hint:
hint:   git config --global init.defaultBranch <name>
hint:
hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and
hint: 'development'. The just-created branch can be renamed via this command:
hint:
hint:   git branch -m <name>
Initialized empty Git repository in /tmp/foo/.git/
 λ echo hello1 > file1 && git add file1 && git commit -m "1st commit"
[master (root-commit) f1cc312] 1st commit
 1 file changed, 1 insertion(+)
 create mode 100644 file1
 λ echo hello2 > file2 && git add file2 && git commit -m "2nd commit"
[master 8bed9e1] 2nd commit
 1 file changed, 1 insertion(+)
 create mode 100644 file2
 λ echo hello3 > file3 && git add file3 && git commit -m "3rd commit"
[master e6d5aab] 3rd commit
 1 file changed, 1 insertion(+)
 create mode 100644 file3
 λ stat -c %y file2
2021-08-25 12:37:19.008378563 +0300
 λ rebase-at e HEAD~2     # that is `git rebase -i HEAD~2`, then [e]dit the
commit
Stopped at 8bed9e1...  2nd commit
You can amend the commit now, with

  git commit --amend

Once you are satisfied with your changes, run

  git rebase --continue
 λ stat -c %y file2
2021-08-25 12:37:37.375537063 +0300


## Expected

The mtime of the file did not change

## Actual

The mtime of the file changed by 18 seconds

# Additional information

[System Info]
git version:
git version 2.33.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.13.5-zen1-1-zen #1 ZEN SMP PREEMPT Sun, 25 Jul 2021 18:03:00
+0000 x86_64
compiler info: gnuc: 11.1
libc info: glibc: 2.33
$SHELL (typically, interactive shell): /usr/bin/zsh


