Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4788CC433F5
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 04:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 100DE61212
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 04:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhKEEUu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 00:20:50 -0400
Received: from devianza.investici.org ([198.167.222.108]:37981 "EHLO
        devianza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhKEEUu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 00:20:50 -0400
X-Greylist: delayed 449 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Nov 2021 00:20:49 EDT
Received: from mx2.investici.org (unknown [127.0.0.1])
        by devianza.investici.org (Postfix) with ESMTP id 4Hln9X36KTz6vHZ
        for <git@vger.kernel.org>; Fri,  5 Nov 2021 04:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onenetbeyond.org;
        s=stigmate; t=1636085440;
        bh=Kgm6pi9LD5OyKqEe1gsh2Nj7/WuNkuU6Dmp7URDjsmY=;
        h=Date:To:From:Subject:From;
        b=jekweFLorxa+UMYzw/xQolS3SQpmlD/CQB0ENab1YGIR/JhwVGg2CrwbIZAjutGuL
         xzAd9angFRU2OGwnXf/HLeZGvoQQxkF2YO3OdUiI0e/ZSu0gVhn46yGOlfe7qPuFSn
         q47mrSJE8ySlxPPiC9mXhYnjKIJSx2mCbHI//0oI=
Received: from [198.167.222.108] (mx2.investici.org [198.167.222.108]) (Authenticated sender: kumar@onenetbeyond.org) by localhost (Postfix) with ESMTPSA id 4Hln9W6CySz6vHV
        for <git@vger.kernel.org>; Fri,  5 Nov 2021 04:10:39 +0000 (UTC)
Message-ID: <c3932b3c-323a-39d6-26a7-ba0c3d17378b@onenetbeyond.org>
Date:   Fri, 5 Nov 2021 04:10:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101 Firefox/91.0
Content-Language: en-US
To:     git@vger.kernel.org
From:   Vipul Kumar <kumar+git@onenetbeyond.org>
Subject: List all commits of a specified file in oldest to newest order
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I want to list all commits (including renames) of a specified file in 
oldest to newest order. But when I run "git log --follow --reverse -- 
<path/to/the/file>" command, I'm getting a single commit, which points 
to the "rename of the file". This behavior is weird to me because I 
expected to get list of all commit in oldest to newest order, whereas 
"git log --follow -- <path/to/the/file>" command works as expected.

### Steps to reproduce

$ git init test
$ cd test
$ echo "Hello from foo." > a.txt
$ git add a.txt
$ git commit -m 'Initial commit'
$ git mv a.txt b.txt
$ git commit -m 'Rename a.txt to b.txt'
$ git log --follow -- b.txt
commit 55e3e6857755fe815449e787a90fe82feb174817
Author: Redacted <Redacted>
Date:   Fri Nov 5 06:56:58 2021 +0530

     Rename a.txt to b.txt

commit f40baf5e777b2618e02805d16c950687d98356fe
Author: Redacted <Redacted>
Date:   Fri Nov 5 06:53:35 2021 +0530

     Initial commit
$ git log --follow --reverse -- b.txt
commit 55e3e6857755fe815449e787a90fe82feb174817
Author: Redacted <Redacted>
Date:   Fri Nov 5 06:56:58 2021 +0530

     Rename a.txt to b.txt


### Expected output

As far as I understand, using "--reverse" option along with "git log" 
command reverse the chronological order of the commits. So expected 
output of "git log --follow --reverse" command should be in oldest to 
newest commits order that's reverse the chronological order of "git log 
--follow" command's output.

$ git log --follow --reverse -- b.txt
commit f40baf5e777b2618e02805d16c950687d98356fe
Author: Redacted <Redacted>
Date:   Fri Nov 5 06:53:35 2021 +0530

     Initial commit

commit 55e3e6857755fe815449e787a90fe82feb174817
Author: Redacted <Redacted>
Date:   Fri Nov 5 06:56:58 2021 +0530

     Rename a.txt to b.txt


### Actual output

But when I use "--reverse" along with "--follow" option, I'm getting a 
single commit which points to the rename of the file.

$ git log --follow --reverse -- b.txt
commit 55e3e6857755fe815449e787a90fe82feb174817
Author: Redacted <Redacted>
Date:   Fri Nov 5 06:56:58 2021 +0530

     Rename a.txt to b.txt


### Additional

$ git --version
git version 2.33.0

First I thought "--follow --reverse" showing to me the newest commit. 
But later, I found out that, it always shows a single commit which 
points to the rename of the file.

$ echo "Hello from bar." >> b.txt
$ git add b.txt
$ git commit -m 'Update b.txt'
$ git log --follow --reverse -- b.txt
commit 55e3e6857755fe815449e787a90fe82feb174817
Author: Redacted <Redacted>
Date:   Fri Nov 5 06:56:58 2021 +0530

     Rename a.txt to b.txt



Cheers,
Vipul
