Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C74C433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 14:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245085AbiCYO1o (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 10:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiCYO1n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 10:27:43 -0400
X-Greylist: delayed 526 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Mar 2022 07:26:08 PDT
Received: from lb1.peda.net (lb1.peda.net [130.234.6.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31273BD7DD
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 07:26:07 -0700 (PDT)
Received: from [84.251.221.37] (dsl-jklbng12-54fbdd-37.dhcp.inet.fi [84.251.221.37])
        by lb1.peda.net (Postfix) with ESMTPSA id B6F62600A14;
        Fri, 25 Mar 2022 16:17:18 +0200 (EET)
Message-ID: <7ce7bd47-7ac2-ad57-118a-67e547cffab0@peda.net>
Date:   Fri, 25 Mar 2022 16:17:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
To:     git@vger.kernel.org
Content-Language: en-US
From:   Mikko Rantalainen <mikko.rantalainen@peda.net>
Subject: Runtime performance of git-prompt.sh with verbose upstream summary
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

I have configured my bash prompt to automatically have git summary in my
prompt like this in ~/.bashrc

if [ "$color_prompt" = yes ]; then
    source /usr/lib/git-core/git-sh-prompt
    GIT_PS1_SHOWDIRTYSTATE=0
    GIT_PS1_SHOWSTASHSTATE=0
    GIT_PS1_SHOWUNTRACKEDFILES=0
    GIT_PS1_SHOWUPSTREAM=verbose

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1
" (%s)")\$ '
else
...

Whenever I `cd` any directory which is part of a git checkout, my prompt
shows me summary of commits in the current working directory vs
respective upstream. This is exactly what I want but I noticed that if I
have a big project with an old branch checked out, the computation to
figure out the total amount of commits gets so expensive that doing it
for every shell prompt gets too slow to be usable. So the behavior is
correct but too slow in practice.

A specific example I can publicly share was one checkout where my local
"master" branch of linux kernel was at
72bc15d0018ebfbc9c389539d636e2e9a9002b3b and origin/master was at
d4899e5542c15062cc55cac0ca99025bb64edc61. Computing the amount of
changes took multiple seconds and the shell prompt hangs for the whole
time, obviously.

Looking at the actual code, it appears that the git-sh-prompt runs

    git rev-list --left-right "$upstream"...HEAD

at line

https://github.com/git/git/blob/5c0cbdb107c5e1c1474618535fda438f25d260ca/contrib/completion/git-prompt.sh#L187

to actually compute the summary. How about changing that to

    timeout 1 git rev-list --left-right "$upstream"...HEAD

instead? (Or maybe even smaller timeout?)

That would avoid blocking the shell prompt for longer than 1 second even
if this computation would take a lot of time. And in case timeout is
exceeded, the verbose upstream information will be just missing and the
prompt will work just fine otherwise. Or maybe the verbose upstream
summary could be replaced with "??" in case timeout was exceeded?

An even better implementation could have very short timeout for
computing the prompt (e.g. 100 ms) and if the timeout is exceeded, the
computing would be executed once in the background and cached somewhere
to be displayed on the prompt automatically. If that cache were put into
a file, it's modification time could be checked against .git/HEAD to
figure out if the HEAD has been changed since the cache was last computed.

The prompt could even show something like

   user@example.com:~/src/linux (master $ u+1475??)$

if the verbose detail "u+5123" was displayed from stale cache so that
the prompt would still show the last known value but the extra question
marks indicate that the value may not be correct.

-- 
Mikko
