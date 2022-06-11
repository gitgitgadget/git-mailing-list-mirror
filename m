Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95F3C433EF
	for <git@archiver.kernel.org>; Sat, 11 Jun 2022 08:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiFKIVm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Jun 2022 04:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiFKIVh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Jun 2022 04:21:37 -0400
X-Greylist: delayed 2297 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 11 Jun 2022 01:21:36 PDT
Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133D812AB8
        for <git@vger.kernel.org>; Sat, 11 Jun 2022 01:21:35 -0700 (PDT)
Received: from bsmtp3.bon.at (unknown [192.168.181.107])
        by bsmtp5.bon.at (Postfix) with ESMTPS id 4LKqZF1sDmz5tpN
        for <git@vger.kernel.org>; Sat, 11 Jun 2022 09:43:17 +0200 (CEST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4LKqZ94gZLz5tl9;
        Sat, 11 Jun 2022 09:43:12 +0200 (CEST)
Message-ID: <442e3166-4f18-3ee0-e3bc-d24687471d5c@kdbg.org>
Date:   Sat, 11 Jun 2022 09:43:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: git filter bug
Content-Language: en-US
To:     "Udoff, Marc" <Marc.Udoff@deshaw.com>
Cc:     "Shupak, Vitaly" <Vitaly.Shupak@deshaw.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <101027c97a9b40ce97192b1cee203b07@deshaw.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <101027c97a9b40ce97192b1cee203b07@deshaw.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.06.22 um 00:19 schrieb Udoff, Marc:
> Hi,
> 
> I believe there is a bug in git status that happens when a file
> changes but the filtered version of the file does not. Correctly,
> git diff does not show anything as different and git commit believes
> there is nothing to commit.
> 
> Reproducer:
> $ git init
> $ touch bar
> $ git add bar
> $ git commit -am 'Bar'
> [main (root-commit) dd12b3e] Bar
> 1 file changed, 0 insertions(+), 0 deletions(-)
> create mode 100644 bar
> $ echo -en '\n[filter "noat"]\n     clean = grep -v "@"\n' >> .git/config
> $ cat .git/config 
> [core]
>         repositoryformatversion = 0
>         filemode = true
>         bare = false
>         logallrefupdates = true
> 
> [filter "noat"]
>      clean = grep -v "@"
> $ echo -en 'abc\n@def\nghi\n' > bar 
> $ cat bar 
> abc
> @def
> ghi
> $ echo "* filter=noat" > .gitattributes
> $ git commit -am 'No at bar'
> [main e81ee3b] No at bar
> 2 files changed, 3 insertions(+)
> create mode 100644 .gitattributes
> $ git show HEAD:bar
> abc
> ghi
> $ echo "@another line" >> bar # Add another @ which will be filtered. touch doesn't cause this bug
> $ git status --porcelain
> M bar

git status does not compute differences; it only looks at the stat
information, and that is by design for performance reasons. So, IMO,
this is working as designed and not a bug.

-- Hannes
