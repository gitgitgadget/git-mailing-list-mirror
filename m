Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62051C433EF
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 07:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382239AbiD3HTz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 03:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbiD3HTy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 03:19:54 -0400
Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0B0A621C
        for <git@vger.kernel.org>; Sat, 30 Apr 2022 00:16:31 -0700 (PDT)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4Kr0yg5Mgsz5tlB;
        Sat, 30 Apr 2022 09:16:27 +0200 (CEST)
Message-ID: <1c11f705-596f-9e51-8017-2b59cac5f19d@kdbg.org>
Date:   Sat, 30 Apr 2022 09:16:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Getting an odd diff
Content-Language: en-US
To:     Jack Adrian Zappa <adrianh.bsc@gmail.com>
References: <CAKepmahKwpe_YVrVrS0L3hMAu44W8VgbmvHY2LRpbrC6CQ0AKQ@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     git-mailing-list <git@vger.kernel.org>
In-Reply-To: <CAKepmahKwpe_YVrVrS0L3hMAu44W8VgbmvHY2LRpbrC6CQ0AKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.04.22 um 14:33 schrieb Jack Adrian Zappa:
> So, I have a regex to select words so that I can focus on the actual
> changes.  But then I noticed that it did something weird.  It grouped
> some parenthesis with another word.  I generated a minimal example for
> that line and it was reproducible.
> 
> Before:
> var result = ((res.State == ResultState.Succeeded) &&
> string.IsNullOrEmpty(res.ErrorCode) )? (byte)0 : (byte)1;
> 
> After:
> var result = res.State == ResultState.Succeeded ? (byte)0 : (byte)1;
> 
> Diff:
> $ git diff2 --no-index b a
> warning: LF will be replaced by CRLF in b.
> The file will have its original line endings in your working directory
> warning: LF will be replaced by CRLF in a.
> The file will have its original line endings in your working directory
> diff --git a/b b/a
> index 4e3604a8e..619d21e4e 100644
> --- a/b
> +++ b/a
> @@ -1 +1 @@
> var result = [-((res-]{+res+}.State == ResultState.Succeeded[-) &&
> string.IsNullOrEmpty(res.ErrorCode) )-] ? (byte)0 : (byte)1;
> 
> I tried to make a smaller example and it didn't cause the issue.
> 
> Before:
> var abc = ((xyz.Stuff == other_stuff) && stuff.yay(question) ? yes : no;
> 
> After:
> var abc = xyz.Stuff == other_stuff ? yes : no;
> 
> Diff:
> $ git diff2 --no-index b a
> warning: LF will be replaced by CRLF in b.
> The file will have its original line endings in your working directory
> warning: LF will be replaced by CRLF in a.
> The file will have its original line endings in your working directory
> diff --git a/b b/a
> index df18ca34e..1024d6b68 100644
> --- a/b
> +++ b/a
> @@ -1 +1 @@
> var abc =[-((-] xyz.Stuff == other_stuff[-) && stuff.yay(question)-] ? yes : no;
> 
> So, my question is, what's going on here?
> 
> The alias is as follows:
>      diff2 = diff --color=always --ignore-space-change
> '--word-diff-regex=((\\r\\n?|\\n\\r?)[\\t
> ]*)?([a-zA-Z_][a-zA-Z_0-9]*|0([xX]([0-9][a-fA-F])+|[0-7]+|[bB][01]+)|[1-9][0-9]*(\\.[0-9]+)?([eE][0-9]+|[pP][0-9a-fA-F])?|\\S)(\\r\\n?|\\n\\r?)?'
> -p

I am a bit reluctant to diagnose what exactly is happening here because
your word regex is outside the design space. It is definitely not a good
idea to declare whitespace and even line breaks as part of a word. And
in fact, when you remove the trailing (\\r\\n?|\\n\\r?)?, you get a more
sensible word diff:

var result =[-((-] resx.State == ResultState.Succeeded[-) &&-]
[-string.IsNullOrEmpty(res.ErrorCode) )-] ? (byte)0 : (byte)1;

But if I were you, I would remove all subexpressions that match any form
of whitespace.

-- Hannes
