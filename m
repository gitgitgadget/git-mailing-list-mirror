Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EC3C433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 10:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5D1061165
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 10:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbhIPKXn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 06:23:43 -0400
Received: from mx1.emlix.com ([136.243.223.33]:35668 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233913AbhIPKXg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 06:23:36 -0400
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Sep 2021 06:23:36 EDT
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 20F61601B0;
        Thu, 16 Sep 2021 12:12:51 +0200 (CEST)
Message-ID: <85a103f6-8b3c-2f21-cc0f-04f517c0c9a1@emlix.com>
Date:   Thu, 16 Sep 2021 12:12:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: data loss when doing ls-remote and piped to command
Content-Language: en-US
To:     Rolf Eike Beer <eb@emlix.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <6786526.72e2EbofS7@devpool47> <xmqqwnnhwvnd.fsf@gitster.g>
 <2279155.Qy0YqsFniq@devpool47>
From:   Tobias Ulmer <tu@emlix.com>
In-Reply-To: <2279155.Qy0YqsFniq@devpool47>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/09/2021 08:38, Rolf Eike Beer wrote:
...
> The redirection seems to be an important part of it. I now did:
> 
> git ... 2>&1 | sha256sum

I've tried to reproduce this since yesterday, but couldn't until now:

2>&1 made all the difference, took less than a minute.

Different repo, different machine, but also running Tumbleweed 
5.14.1-1-default, git 2.33.0

while [ "`git --git-dir=$PWD/in/linux/.git ls-remote origin 2>&1 | tee 
failed.out | sha1sum`" = "7fa299e589bacdc908395730beff542b0fc684eb  -" 
]; do echo -n .; done
..........

failed.out has multiple lines like this:

--8<--
4e77f7f1261f65cff06918bc5e66d02a418fc842        refs/tags/v3.10.18^{}
f7b8df0cc81cf82a4ac6834225bddbe46a340455a4a5d52f29d08d923ce8d232b0b497da674dd2c 
refs/tags/v3.18
b2776bf7149bddd1f4161f14f79520f17fc1d71d        refs/tags/v3.18^{}
--8<--


Running the same on Archlinux (5.13.13-arch1-1, 2.33.0) doesn't show the 
problem.
This may well turn out not to be git, but a kernel issue.

@Eike: I think at this point you should try to downgrade and see whether 
that makes any difference
