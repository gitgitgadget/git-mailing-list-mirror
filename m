Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1639C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 07:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbiKHH1p (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 02:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiKHH1n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 02:27:43 -0500
Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D702C656
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 23:27:42 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4N606y6tjpz5tlB;
        Tue,  8 Nov 2022 08:27:38 +0100 (CET)
Message-ID: <628833cf-3537-bf8a-0a1a-9ade1bec39a1@kdbg.org>
Date:   Tue, 8 Nov 2022 08:27:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: Potential bug in --color-words output
To:     Simeon Krastnikov <skrastnikov@gmail.com>
References: <e2164b04-98de-6f19-6c33-6979c1a328ff@gmail.com>
Content-Language: en-US
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
In-Reply-To: <e2164b04-98de-6f19-6c33-6979c1a328ff@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.10.22 um 23:08 schrieb Simeon Krastnikov:
> Hello,
> 
> Given an initial file with the contents "not to be", which I then change
> to "to be", the output of 'git diff --color-words', is
> 
>   notto be
> 
> with the first three letters colored red. To me this seems incorrect as
> it implies, or at least misleadingly suggests, that there was no space
> between "not" and "to" in the original file. (Even though in that case
> the output is actually "nottoto be" with the "notto" in red and "to" in
> green.)
> 
> If instead I start with a file with contents "to be", which I then
> change to "not to be", then the output is as expected:
> 
>   not to be
> 
> (First three letters colored green.)
> 
> Am I correct in seeing this as a bug? If so, any tips on what parts of
> diff.c to look at when starting a patch?

Well, not really. When you have a file with

   Line one.
   Line two.

then change it to

   Line ONE.
   Line TWO.

then --color-words currently prints it as

   Line one.ONE.
   Line two.TWO.

because it does not print the whitespace after[*] a sequence of deleted
words. But if it were printed, we would see

   Line one.
   ONE.
   Line two.
   TWO.

That is considered inferior; hence, it isn't printed.

The current algorithm produces sensible output in the vast majority of
cases while also being fairly straight-forward. To make it work "better"
(for some definition of that word) in the borderline cases, the
algorithm would have to be made considerably more sophisticated.

[*] It might be whitespace before a sequence of words, but that does not
change the gist of the argument.

-- Hannes

