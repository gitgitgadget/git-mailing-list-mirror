Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9001AC433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 17:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6444361872
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 17:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbhKRRHi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 12:07:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:34002 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233847AbhKRRHh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 12:07:37 -0500
Received: (qmail 30477 invoked by uid 109); 18 Nov 2021 17:04:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 Nov 2021 17:04:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31521 invoked by uid 111); 18 Nov 2021 17:04:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 Nov 2021 12:04:36 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 18 Nov 2021 12:04:36 -0500
From:   Jeff King <peff@peff.net>
To:     Danial Alihosseini <danial.alihosseini@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Subject: Re: git 2.34.0: Behavior of `**` in gitignore is different from
 previous versions.
Message-ID: <YZaHpJKeyDEY8qKW@coredump.intra.peff.net>
References: <CACLOEFZz7bunO2S5-ec1K10B9AJU4-m50j3j9c=12R6d1D+-dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACLOEFZz7bunO2S5-ec1K10B9AJU4-m50j3j9c=12R6d1D+-dg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 18, 2021 at 08:11:04PM +0330, Danial Alihosseini wrote:

> What did you do before the bug happened? (Steps to reproduce your issue)
> Consider the following project structure
> - data
>   - data1
>     - file1
>     - file1.txt
>   - data2
>     - file2
>     - file2.txt
> - .gitignore
> 
> 
> `.gitignore` is as follows:
> ```
> data/**
> !data/**/
> !data/**/*.txt
> ```
> What did you expect to happen? (Expected behavior)
> 
> I expect all files in `data` folder to be ignored except `.txt` files.
> 
> What happened instead? (Actual behavior)
> 
> `file1` and `file2` are not ignored.
> Here is the `check-ignore` output:
> ```
> $ git check-ignore -v data/data1/file1
> .gitignore:2:!/data/**/ data/data1/file1
> ```

Thanks for an easy reproduction. It looks like this changed in
f6526728f9 (dir: select directories correctly, 2021-09-24). Author cc'd.

The key thing seems to be that the second line of your .gitignore should
match only directories (because of the trailing slash), but no longer
does.

-Peff
