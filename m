Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09352C7EE2E
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 03:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjFLD7x (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jun 2023 23:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjFLD7u (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2023 23:59:50 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22F7F3
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 20:59:49 -0700 (PDT)
Received: (qmail 24491 invoked by uid 109); 12 Jun 2023 03:59:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 Jun 2023 03:59:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11808 invoked by uid 111); 12 Jun 2023 03:59:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 11 Jun 2023 23:59:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 11 Jun 2023 23:59:48 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 09/11] branch: fix a leak in setup_tracking
Message-ID: <20230612035948.GI306352@coredump.intra.peff.net>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
 <471dcc04-d60c-b745-15f0-05fe4e93ff11@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <471dcc04-d60c-b745-15f0-05fe4e93ff11@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 11, 2023 at 08:50:36PM +0200, Rubén Justo wrote:

> The commit d3115660b4 (branch: add flags and config to inherit tracking,
> 2021-12-20) replaced in "struct tracking", the member "char *src" by a
> new "struct string_list *srcs".
> 
> This caused a modification in find_tracked_branch().  The string
> returned by remote_find_tracking(), previously assigned to "src", is now
> added to the string_list "srcs".
> 
> That string_list is initialized with STRING_LIST_INIT_DUP, which means
> that what is added is not the given string, but a duplicate.  Therefore,
> the string returned by remote_find_tracking() is leaked.

Your fix makes sense. I had to stare at the existing code for a long
time to make sure the _other_ side of the switch wasn't leaking, but it
works by falling through "case 2" into "default", which frees
tracking->spec.src.  So this should plug the leak completely.

-Peff
