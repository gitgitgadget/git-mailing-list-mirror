Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B884D208CD
	for <e@80x24.org>; Sun, 20 Aug 2017 08:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752706AbdHTIUv (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 04:20:51 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:56283 "EHLO bsmtp8.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751264AbdHTIUv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 04:20:51 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp8.bon.at (Postfix) with ESMTPSA id 3xZqX06r7Qz5tlC;
        Sun, 20 Aug 2017 10:20:48 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id C9B2B1AFC;
        Sun, 20 Aug 2017 10:20:47 +0200 (CEST)
Subject: Re: Git *accepts* a branch name, it can't identity in the future?
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        git@vger.kernel.org
Newsgroups: gmane.comp.version-control.git
References: <1503215489.5824.4.camel@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <829ac9ed-857d-84bf-2374-6a36b1d0aff1@kdbg.org>
Date:   Sun, 20 Aug 2017 10:20:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1503215489.5824.4.camel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.08.2017 um 09:51 schrieb Kaartic Sivaraam:
> I made a small assumption in the script which turned out to be false. I
> thought the unicode prefixes I used corresponded to only two bytes.
> This lead to the issue. The unicode character '✓' corresponds to three
> characters and as a result instead of removing it, my script replaced
> it with the unknown character '�'. So, the branch named '✓doc-fix'
> became 'done/�doc-fix'. Here's the issue. I couldn't use
> 
>      $ git branch -m done/�doc-fix done/dic-fix
> 
> to rename the branch. Nor could I refer to it in anyway. Git simply
> says,
> 
>      error: pathspec 'done/�doc-fix' did not match any file(s) known to git.
> 
> It's not a big issue as I haven't lost anything out of it. The branches
> have been merged into 'master'.
> 
> I just wanted to know why git accepted a branch name which it can't
> identify later?
> 
> If it had rejected that name in the first place it would have been
> better. In case you would like to know how I got that weird name,
> here's a way to get that
> 
>      $ echo '✓doc-fix' | cut -c3-100
> 

See, these two are different:

$ echo '✓doc-fix' | cut -c3-100 | od -t x1
0000000 93 64 6f 63 2d 66 69 78 0a
0000011
$ echo '�doc-fix' | od -t x1
0000000 64 6f bd 64 6f 63 2d 66 69 78 0a
0000013

It is not Git's fault that your terminal converts an invalid UTF-8 
sequence (that your script produces) to �. Nor is it when you paste that 
character onto the command line, that it is passed as a (correct) UTF-8 
character.

Perhaps this helps (untested):

$ git branch -m done/$(printf '\x93')doc-fix done/dic-fix

In Git's database, branch names are just sequences of bytes. It is 
outside the scope to verify that all input is encoded correctly.

-- Hannes
