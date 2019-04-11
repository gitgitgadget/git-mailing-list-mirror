Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8167B20248
	for <e@80x24.org>; Thu, 11 Apr 2019 12:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfDKM5G (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 08:57:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:54770 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726014AbfDKM5G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 08:57:06 -0400
Received: (qmail 6645 invoked by uid 109); 11 Apr 2019 12:57:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 11 Apr 2019 12:57:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27202 invoked by uid 111); 11 Apr 2019 12:57:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 11 Apr 2019 08:57:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Apr 2019 08:57:04 -0400
Date:   Thu, 11 Apr 2019 08:57:04 -0400
From:   Jeff King <peff@peff.net>
To:     NoName Req <nonamereq29@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug(feature?) on git-diff-files
Message-ID: <20190411125703.GA26995@sigill.intra.peff.net>
References: <CABgj7us=Rk3EUvd2EVVqsYKDUGS7VfAX09SpW04fB26cgntw5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABgj7us=Rk3EUvd2EVVqsYKDUGS7VfAX09SpW04fB26cgntw5g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 11, 2019 at 03:47:58PM +0300, NoName Req wrote:

> Summary
>    `git -C (folder path) diff-files --name-only` output is not correct
> 
> Steps to Reproduce
> 1. Apply change to a clean git repository. Go to another folder (not
> within this repository) and apply the command
>    `git -C repo-path diff-files --name-only`
> The above command lists dirty files in that repository.
> 2. Now undo your changes on the repository
> 3. Issue the same command. It still lists the file.
> 
> More Information
> 
> `git -C repo-path diff`  command doesn't seem to have this problem.

Try running `git update-index --refresh` before running `diff-files`.

Unlike git-diff, git-diff-files is plumbing that is meant to be called
from scripts. So it is up to the script writer to decide when the index
should be refreshed from the actual filesystem (which makes sense, e.g.,
if you're going to do it once at the start of the script and then make a
bunch of separate diff-related calls).

Until that happens, diff-files will see only that the entry is
stat-dirty, and report it as a potential change.

-Peff
