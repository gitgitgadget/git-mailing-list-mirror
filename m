Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D4AC4338F
	for <git@archiver.kernel.org>; Sun,  8 Aug 2021 22:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5AEF60E76
	for <git@archiver.kernel.org>; Sun,  8 Aug 2021 22:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbhHHWWB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Aug 2021 18:22:01 -0400
Received: from mail.ispras.ru ([83.149.199.84]:45332 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230509AbhHHWWA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Aug 2021 18:22:00 -0400
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 48DB140D3BFF
        for <git@vger.kernel.org>; Sun,  8 Aug 2021 22:21:38 +0000 (UTC)
MIME-Version: 1.0
Date:   Mon, 09 Aug 2021 01:21:38 +0300
From:   Alexey Izbyshev <izbyshev@ispras.ru>
To:     git@vger.kernel.org
Subject: [BUG] git checkout --recurse-submodules on initialized but not cloned
 submodule fails badly
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <85faefc0b1e23ee942b11087089ccc4f@ispras.ru>
X-Sender: izbyshev@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On a fresh clone of a repo with submodules, running `git checkout 
--recurse-submodules` after `git submodule init` but without `git 
submodule update` fails (as expected), but leaves the working tree in a 
bad state:

git init repo
git -C repo commit --allow-empty -m "initial"
git -C repo submodule add "$PWD"/repo
git -C repo commit -m "add sm"
git clone repo repo-clone
git -C repo-clone submodule init repo
git -C repo-clone checkout --recurse-submodules repo
fatal: not a git repository: ../.git/modules/repo
fatal: could not reset submodule index

(Tested on git 2.17.1 and v2.33.0-rc1)

`git checkout` creates a gitlink in the submodule directory even though 
its target is not a valid git dir (it contains only `config`). In the 
resulting state, many git commands (like `status` and even `submodule 
deinit`) fail, so while trying to checkout a submodule before `submodule 
update` isn't supposed to work, I think it still shouldn't leave the 
repo in such a state.

It seems that related issues have already been reported, though those 
that I've found[1,2,3] describe more complex scenarios, while mine is 
very basic.

Hope it helps,
Alexey

[1] 
https://public-inbox.org/git/20200501005432.h62dnpkx7feb7rto@glandium.org/
[2] 
https://public-inbox.org/git/dab7128d-5ea7-5d7c-1ae1-1d71be316326@gmail.com/
[3] 
https://public-inbox.org/git/CABVQXt5E-R22G62W-tQieA7XiZKZiOA8Hp2xewYhwwOS8wFh0Q@mail.gmail.com/

