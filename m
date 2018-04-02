Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2056A1F42D
	for <e@80x24.org>; Mon,  2 Apr 2018 06:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754158AbeDBGxj (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 02:53:39 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:28044 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752150AbeDBGxi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 02:53:38 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 40F2xX3qv2z5tlB;
        Mon,  2 Apr 2018 08:53:36 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id B451DDC;
        Mon,  2 Apr 2018 08:53:35 +0200 (CEST)
Subject: Re: Need help debugging issue in git
To:     Robert Dailey <rcdailey.lists@gmail.com>
References: <CAHd499C39sBTJy_AoCJxE2ZS4ECJju2jroY6_0E1MssCBtmC=A@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     Git <git@vger.kernel.org>
Message-ID: <3152c739-5c80-99b3-ac16-31fe348b7657@kdbg.org>
Date:   Mon, 2 Apr 2018 08:53:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAHd499C39sBTJy_AoCJxE2ZS4ECJju2jroY6_0E1MssCBtmC=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.04.2018 um 02:36 schrieb Robert Dailey:
> I'm struggling with a bug that I found introduced in git v2.13.2. The
> bug was not reproducible in v2.13.1. The issue is that using arguments
> like "@{-1}" to aliases causes those curly braces to be removed, so
> once the command is executed after alias processing the argument looks
> like "@-1". This breaks any aliases you have that wrap `git log` and
> such. I originally opened the bug on the Git for Windows project
> (since I use Git mostly on Windows):
> 
> https://github.com/git-for-windows/git/issues/1220
...
> Here is the alias being used for a test:
> 
> [alias]
>      lgtest = !git log --oneline \"$@\"
> 
> And here is the command I invoke for the test:
> 
> $ git lgtest @{-1}
> 
> I should get logs for the previously-checked-out branch.
> 
> When `prepare_shell_cmd()` is called in run-command.c, it gets expanded like so:
> 
> + [0] "sh" const char *
> + [1] "-c" const char *
> + [2] "git log --oneline \"$@\" \"$@\"" const char *
> + [3] "git log --oneline \"$@\"" const char *
> + [4] "@{-1}" const char *
> 
> With my modifications (again, patch inline below) I get this:
> 
> + [0] "sh" const char *
> + [1] "-c" const char *
> + [2] "git log --oneline \"$@\"" const char *
> + [3] "@{-1}" const char *
> 
> The second version looks much better.

But this is wrong. Try this on the command line:

   sh -c 'echo "$@"' a b c

Notice how this prints only 'b c', not 'a b c'. The reason is that the 
argument 'a' is treated like a "script" name, i.e. what you get for 
"$0", and 'b' and 'c' as the actual arguments to the "script".

That is, you must fill in some dummy "script" name at slot [3], and 
run_command chooses to put the alias text there.

> I think the constant nesting of
> commands inside each other that the first version does is somehow
> causing curly braces to be removed. I don't understand enough about
> shell processing to know why it would do this.

Some shells expand the curly braces. They must get lost somewhere by one 
of the two shell invocations that happen on the way.

BTW, you don't happen to have a file named '@-1' in your directory, most 
likely by accident?

-- Hannes
