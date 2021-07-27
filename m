Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C48C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 00:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC3CC60F02
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 00:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbhG0AOt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 20:14:49 -0400
Received: from smtprelay02.ispgateway.de ([80.67.31.36]:9930 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhG0AOr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 20:14:47 -0400
Received: from [84.163.73.49] (helo=[192.168.2.202])
        by smtprelay02.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1m8BLr-00067x-T9; Tue, 27 Jul 2021 02:53:43 +0200
Subject: Re: Files modified, even after: git reset --hard
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Git List <git@vger.kernel.org>
References: <dd4aca2c-9ca2-e489-d78f-9d2a5580f1a5@mfriebe.de>
 <4e9b54b4-8e40-7fd3-ae65-d33390f3af43@mfriebe.de>
 <04f3b300-3ccf-c91b-6406-6a998b473a24@mfriebe.de>
 <bfc257c7-bf74-06be-ac62-9a6d27f565c9@mfriebe.de>
 <CAPx1GvcHiaGsuOybOijRYpmivO0dLvUFacAeOrM4DfY-uuXB2Q@mail.gmail.com>
 <070f7f5e-0e6c-2edc-1403-9265c810df17@mfriebe.de>
 <CAPx1GvdM7CzsbT1SWW9+OPcG9FL7WXQ7YD6aM7P0krujp_OrkQ@mail.gmail.com>
 <67f35be7-3317-6486-cdb6-62eb691eaf10@mfriebe.de>
 <CAPx1Gvey1uSr58Uf7VpC0c6J+R0tUP=VUP_dGmv_yVO-CwmvXg@mail.gmail.com>
From:   Martin <git@mfriebe.de>
Message-ID: <3cfcbbd4-0b26-dedf-f5f2-85caebcb75da@mfriebe.de>
Date:   Tue, 27 Jul 2021 02:55:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAPx1Gvey1uSr58Uf7VpC0c6J+R0tUP=VUP_dGmv_yVO-CwmvXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/07/2021 00:03, Chris Torek wrote:
> On Mon, Jul 26, 2021 at 12:57 PM Martin <git@mfriebe.de> wrote:
>> Is it possible that those cheats also look at the "replaced" (rather
>> than the "replacement") commit(s)?
> 
> [1]: https://git-scm.com/docs/racy-git/en
> [2]: https://web.archive.org/web/20101214222704/http://msdn.microsoft.com/en-us/library/14h5k7ff(v=vs.80).aspx
> 

Thanks for the info. I still think there is something wrong.
So I made a simple testcase

https://github.com/User4martin/testrep.git
git fetch origin 'refs/replace/*:refs/replace/*'


All tested on linux. (Though git version 2.25.1)

git init test

FILE .gitattributes
foo -text

FILE foo
AAAAA

git add .gitattributes foo
git commit -m A

modify foo (real content modify)
add / commit -m B
modify foo (real content modify)
add / commit -m C

switch -d <A>
modify foo to be the same as commited to "C"
add / commit -m A2

git show
- get the old and new hash for the blob containing foo
git replace old new

Now commit A has the same content in foo as commit C
(we are currently at the detached commit A2)

git switch <C>
git status  // all fine

git switch <A>
git status
=> foo is modified
git diff
=> no diff


So I would say, it is not autorclf, or line endings in this case.

I do not know, if the above can be caused by "raciness".
But it appears to only(?) happens if a replace is in place.

So at this point my guess would be, that when the switch is done, at 
some point something looks at the original blob, even though it is meant 
to look at the replacement.











