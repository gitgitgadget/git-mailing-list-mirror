Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4B5C33C9E
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 21:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E75224656
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 21:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgANVZu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:25:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:36580 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727102AbgANVZu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 16:25:50 -0500
Received: (qmail 10271 invoked by uid 109); 14 Jan 2020 21:25:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Jan 2020 21:25:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25461 invoked by uid 111); 14 Jan 2020 21:32:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Jan 2020 16:32:04 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Jan 2020 16:25:48 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 8/8] sparse-checkout: write escaped patterns in cone mode
Message-ID: <20200114212548.GD3949560@coredump.intra.peff.net>
References: <pull.513.git.1579029962.gitgitgadget@gmail.com>
 <79b6e9a565fde766954d7cda84a835b9015af6cb.1579029963.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <79b6e9a565fde766954d7cda84a835b9015af6cb.1579029963.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 14, 2020 at 07:26:02PM +0000, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> If a user somehow creates a directory with an asterisk (*) or backslash
> (\), then the "git sparse-checkout set" command will struggle to provide
> the correct pattern in the sparse-checkout file. When not in cone mode,
> the provided pattern is written directly into the sparse-checkout file.
> However, in cone mode we expect a list of paths to directories and then
> we convert those into patterns.
> 
> Even more specifically, the goal is to always allow the following from
> the root of a repo:
> 
>   git ls-tree --name-only -d HEAD | git sparse-checkout set --stdin
> 
> The ls-tree command provides directory names with an unescaped asterisk.
> It also quotes the directories that contain an escaped backslash. We
> must remove these quotes, then keep the escaped backslashes.

Do we need to document these rules somewhere? Naively I'd expect
"--stdin" to take in literal pathnames. But of course it can't represent
a path with a newline. So perhaps it makes sense to take quoted names by
default, and allow literal NUL-separated input with "-z" if anybody
wants it.

-Peff
