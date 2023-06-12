Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B245C7EE2E
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 03:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbjFLDW0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jun 2023 23:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbjFLDWC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2023 23:22:02 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85BBE70
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 20:21:07 -0700 (PDT)
Received: (qmail 22154 invoked by uid 109); 12 Jun 2023 03:21:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 Jun 2023 03:21:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11640 invoked by uid 111); 12 Jun 2023 03:21:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 11 Jun 2023 23:21:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 11 Jun 2023 23:21:06 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 04/11] branch: fix a leak in dwim_and_setup_tracking
Message-ID: <20230612032106.GD306352@coredump.intra.peff.net>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
 <a6fec1ab-4006-2896-a2d9-dc0d8fa1c132@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6fec1ab-4006-2896-a2d9-dc0d8fa1c132@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 11, 2023 at 08:49:43PM +0200, Rubén Justo wrote:

> In e89f151db1 (branch: move --set-upstream-to behavior to
> dwim_and_setup_tracking(), 2022-01-28) the string returned by
> dwim_branch_start() was not freed, resulting in a memory leak.

Yep, looks good. One small comment:

> diff --git a/branch.c b/branch.c
> index ba3914adf5..a7333a4c32 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -638,9 +638,10 @@ void dwim_and_setup_tracking(struct repository *r, const char *new_ref,
>  			     const char *orig_ref, enum branch_track track,
>  			     int quiet)
>  {
> -	char *real_orig_ref;
> +	char *real_orig_ref = NULL;
>  	dwim_branch_start(r, orig_ref, track, &real_orig_ref, NULL);
>  	setup_tracking(new_ref, real_orig_ref, track, quiet);
> +	free(real_orig_ref);
>  }

Adding the NULL-initialization signals that we expect that real_orig_ref
might sometimes _not_ be filled in by dwim_branch_start(). But I think
it always will be; and if it weren't, that would make passing it to
setup_tracking() rather suspicious.

So I don't think the NULL initialization is wrong, and certainly it is
more defensive. But I find it a little misleading.

-Peff
