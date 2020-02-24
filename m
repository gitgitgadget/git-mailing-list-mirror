Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E30C35679
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 07:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF2120714
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 07:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgBXHMI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 02:12:08 -0500
Received: from dd26228.kasserver.com ([85.13.145.71]:60698 "EHLO
        dd26228.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgBXHMI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 02:12:08 -0500
X-Greylist: delayed 555 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Feb 2020 02:12:06 EST
Received: from [192.168.28.100] (aftr-62-216-206-39.dynamic.mnet-online.de [62.216.206.39])
        by dd26228.kasserver.com (Postfix) with ESMTPSA id 5D871EE
        for <git@vger.kernel.org>; Mon, 24 Feb 2020 08:02:50 +0100 (CET)
To:     git@vger.kernel.org
From:   Stefan <git.kernel.org_20@green-sparklet.de>
Subject: Bug: 'git ls-files' doesn't work on submodule in post-commit hook
Message-ID: <ede4b653-35bf-d163-c27d-d23602dbd726@green-sparklet.de>
Date:   Mon, 24 Feb 2020 08:03:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey there,

I think I found a bug in git: I want to use 'git ls-files' onto a git submodule, called in a post-commit hook of main repository, which doesn’t work.
The same call in a post-checkout hook works perfectly.

Example setup to try it out, use a empty (temporary) folder:
--- snipp ---
mkdir git-submodulerepo
cd git-submodulerepo
git init
git config user.email "you@example.com"
git config user.name "Your Name"
echo "nothing" > submodule_file.txt
git add submodule_file.txt
git commit submodule_file.txt -m "Add my file"
cd ..
 
mkdir git-repo
cd git-repo
git init
git config user.email "you@example.com"
git config user.name "Your Name"
echo "nothing" > rubbish.txt
git add rubbish.txt
git commit rubbish.txt -m "Add my rubbish"
 
git submodule add ../git-submodulerepo
 
printf '#!/bin/bash\ncd git-submodulerepo\necho Git says my files are:\ngit ls-files\necho ---------------\necho Filesystem says my files are:\nls -w1\necho ---------------\n' > .git/hooks/post-commit
chmod +x .git/hooks/post-commit
cp .git/hooks/post-commit .git/hooks/post-checkout
chmod +x .git/hooks/post-checkout
--- snapp ---


So 'git ls-files' call in post-checkout hook works:
$ git checkout HEAD
A       .gitmodules
A       git-submodulerepo
Git says my files are:
submodule_file.txt
---------------
Filesystem says my files are:
submodule_file.txt
---------------
 
A 'git ls-files' in post-commit doesn’t work:
$  echo nothing >> rubbish.txt && git commit rubbish.txt -m "Add just rubbish"
Git says my files are:
---------------
Filesystem says my files are:
submodule_file.txt
---------------
[master e05efb1] just rubbish
1 file changed, 1 insertion(+)
 

This was tested using git version 2.25.0.windows.1
With git version 2.21.0 (cygwin) git ls-files outputs "fatal: .git/index: index file open failed: Not a directory"

I didn’t test other hooks.

Calling "git ls-files" in hook for your main repository (and not a submodule) works for both cases.
I checked for basic things (I'm in submodule directory in both hooks), so I guess this is a bug in git.

Any questions?
Thanks in advance!

Stefan
