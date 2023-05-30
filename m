Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FEDC77B7A
	for <git@archiver.kernel.org>; Tue, 30 May 2023 09:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjE3Jo0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 May 2023 05:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjE3JoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2023 05:44:25 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8E1C7
        for <git@vger.kernel.org>; Tue, 30 May 2023 02:44:23 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 5C06523F29;
        Tue, 30 May 2023 05:44:21 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1q3vtt-UZm-00; Tue, 30 May 2023 11:44:21 +0200
Date:   Tue, 30 May 2023 11:44:21 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Paul Jolly <paul@myitcv.io>
Cc:     git@vger.kernel.org
Subject: Re: Automatically re-running commands during an interactive rebase
 or post commit
Message-ID: <ZHXFdRnrwzNCA227@ugly>
References: <CACoUkn7TmZ=trtDKcQm0SG5qCqK=-+YxrDV-7xYnLH_XK7K7og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACoUkn7TmZ=trtDKcQm0SG5qCqK=-+YxrDV-7xYnLH_XK7K7og@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 29, 2023 at 02:38:40PM +0100, Paul Jolly wrote:
>As part of my project, I have a code generation script that sha256
>hashes a number of files to another file. This produces a
>deterministic "has this part of the project changed" indicator via the
>code generated file's content, that I then use in various cache
>invalidation steps.
>
>This means, however, that I need to re-run that code generation script
>as part of each commit in order to ensure that the code generated hash
>file is current (I have a step in CI that detects if it is not, which
>re-runs the code generation script to then see if the commit is
>"clean").
>
i would recommend taking a step back and considering whether you're 
actually trying to fix the right problem.

why are you checking in an auto-generated file, esp. given that it can 
be generated very quickly as you report?

usually, this should be done by the build system.

if the used build tool really is too dumb to integrate it into the build 
system, you might have luck with a post-checkout hook.

you can also obtain existing hashes directly from git, with ls-tree, 
though this would again require some kind of integration with the build 
or checkout process.

if you can't get around checking in the hash, i can think of hacking it 
using rebase --exec. basically, before each pick you'd create a commit 
that reverts the hash change (by checking out that path from the parent 
of the last commit that touched it, found automatically with git log), 
and after the pick you'd squash away the revert (using `reset HEAD~2 && 
commit -C @{1}` or something to that effect). very ugly, very fragile.

regards,
ossi
