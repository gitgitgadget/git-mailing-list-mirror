From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Diffing submodule does not yield complete logs for merge commits
Date: Mon, 4 May 2015 10:05:22 -0500
Message-ID: <CAHd499B=EcgYiTMFt9VYhj45bRkP8h9TBk1B0cr8fYFuXNe_mQ@mail.gmail.com>
References: <CAHd499BqB_ZFKMNxSVCDTFx2Ge=TfCE6gexFn+rfRbS+ybLybA@mail.gmail.com>
	<20150501175757.GA10569@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon May 04 17:05:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpHw0-0004PO-Pj
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 17:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbbEDPFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 11:05:25 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35953 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbbEDPFX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 11:05:23 -0400
Received: by igblo3 with SMTP id lo3so85816757igb.1
        for <git@vger.kernel.org>; Mon, 04 May 2015 08:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=aDGGN9+d7SDVqdqbSCeJuWEYa0df89T40ywDn7tl/dE=;
        b=s+jnayGw2dBHdqGqL2ZJywfxnPfRIDsgSr0yySjig1HUdTYEVPTxy5bhH5EAs0nzNM
         TIaYVtblykRYDqXtEh0bVv8HcnYZP5kV05WEDAk3nH+UZ1YZ8Ali1tUau+cL724F83lW
         k7ieYJ3H03vHa4Rf3oewC9LmPZF9rHWfk2CqLxCKcvy5Rl6XE5Z6wdGS2ENtlhmAsZmH
         rtdQKckbiVXGtMmZIfljvVlbyM/Ah0Bbh77PWXUvkzkWu8FNwphYmy54u8XhoskLJQyR
         pM0byuWXr2edkuxPJJHUMyitk5shCKXitB10MHRf5MOAnAjup1nSkUKBqNfwL908ozaf
         QGzg==
X-Received: by 10.50.43.226 with SMTP id z2mr13429360igl.33.1430751922271;
 Mon, 04 May 2015 08:05:22 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.36.86.148 with HTTP; Mon, 4 May 2015 08:05:22 -0700 (PDT)
In-Reply-To: <20150501175757.GA10569@book.hvoigt.net>
X-Google-Sender-Auth: Dje7Ykd2bTsm8d0AAh4Tv8il5Ac
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268329>

On Fri, May 1, 2015 at 12:57 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> Hi,
>
> On Wed, Apr 29, 2015 at 03:53:11PM -0500, Robert Dailey wrote:
>> I am attempting to diff a submodule modified in my working copy and
>> the only difference is a merge commit. However, I do not get the
>> "full" range of commits introduced by the merge commit when I diff it:
>>
>> $ git diff --submodule=log Core
>> Submodule Core 8b4ec60..def2f3b:
>>   > Merge remote-tracking branch 'origin/master-ah3k'
>>
>> However if I go inside my submodule and run `git log` by hand, I get
>> more information about the TRUE commits introduced:
>>
>> $ git log --oneline 8b4ec60..def2f3b
>> def2f3b Merge remote-tracking branch 'origin/master-ah3k'
>> 015c961 Remove log spam in FontManager
>> 7713ba1 Update third party submodule to latest
>> 10aac78 Merge pull request #9 in FE/core from
>> feature/FE-1348-selecting-continue-on-zero-balance to master-ah3k
>> 287882f FE-1376 Nedd to remain in check detail screen when selecting
>> donation after SBI
>> a5a6bed Do not overwrite the current check# within loop
>> dfb8547 Adding list of checks to CRspChecks before saving
>> 1be280a FE-1354: Guest logged out in specific multiple check scenario
>> de06d5a [FE-1348] Fix PATT exit while checks still open
>>
>> It's almost as if the `git diff --submodule=log` approach is passing
>> in --first-parent to git log, which would exclude commits in the range
>> that I'm seeing when I run git log manually.
>
> That is exactly the case. In prepare_submodule_summary() that option is
> set before doing the revision walk.
>
>> Is this by design? Is there a way to enable the full log history with
>> `git diff` on a submodule?
>
> This stems from the first implementation for showing submodule diffs in
> commit 752c0c24. I guess this was done deliberately to limit the amount
> of output you get for a submodule. At the moment this is hardcoded but I
> think there is nothing wrong with adding another option to include the
> full log.
>
> Cheers Heiko

I will go ahead and work on this feature. Here is what I'd like to see:

1. `git diff --submodule` should have the ability to display full logs
vs current logs (i.e. without --first-parent)
2. `git submodule summary` should have an option to display full logs
or "first-parent" logs.

For #1, do you recommend adding a 3rd setting for `diff.submodule`
config? Something like "full-log" or something? Or an entirely new
config? I noticed that in diff.h, the DIFF_OPT flags already consume
31 bits. If this is a 32-bit flag, there is only 1 bit left. If we go
with a 3rd setting for `diff.submodule` I think this might consume the
last bit.

We could also make `git diff --submodule` default to the "full log"
type, and if users want only first parent logs in submodule summary,
they'd have to execute `git submodule summary` instead.

There are a few options. What do you recommend? Thanks.
