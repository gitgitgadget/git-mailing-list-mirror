Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68704C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 22:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AEA461246
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 22:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243059AbhI1Wjj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 18:39:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:57186 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238632AbhI1Wji (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 18:39:38 -0400
Received: (qmail 11684 invoked by uid 109); 28 Sep 2021 22:37:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Sep 2021 22:37:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5373 invoked by uid 111); 28 Sep 2021 22:37:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Sep 2021 18:37:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Sep 2021 18:37:58 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 3/7] ll-merge: add API for capturing warnings in a strbuf
 instead of stderr
Message-ID: <YVOZRhWttzF18Xql@coredump.intra.peff.net>
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
 <2bf5efb5169b71ee7c1da006a74aa67794f1399d.1630376800.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2bf5efb5169b71ee7c1da006a74aa67794f1399d.1630376800.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 02:26:36AM +0000, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
> 
> Whenever ll-merge encounters a binary file, it prints a warning to
> stderr.  However, for the --remerge-diff option we want to add, we need
> to capture all conflict messages and show them in a diff instead of
> dumping them straight to stdout or stderr.  Add some new API that will
> allow us to capture this output and display it in our preferred method.

This is a reasonable strategy for error-handling in general (though some
more thoughts below).

> @@ -71,8 +75,11 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
>  	} else {
>  		switch (opts->variant) {
>  		default:
> -			warning("Cannot merge binary files: %s (%s vs. %s)",
> -				path, name1, name2);
> +			if (warnings) {
> +				strbuf_addstr(warnings, "Warning: ");
> +				strbuf_addf(warnings, msg, path, name1, name2);
> +			} else
> +				warning(msg, path, name1, name2);

The usual warn_builtin() has a lowercase "warning: " prefix, but your
strbuf variant uses uppercase.

> @@ -98,6 +105,7 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
>  
>  static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
>  			mmbuffer_t *result,
> +			struct strbuf *warnings,
>  			const char *path,
>  			mmfile_t *orig, const char *orig_name,
>  			mmfile_t *src1, const char *name1,

There's a lot of plumbing this variable through. This is probably too
gross, but another option would be to call set_warn_routine() to
override it temporarily. It's gross because it affects everything, not
just this call stack (and I also think we'd need to beef up the warn
routine code to handle some of the rough edges).

I do wonder if the ll_merge() code should avoid calling warning() in the
first place. It is after all, meant to be "low-level". We already return
an error code from the function. I wonder if returning a more detailed
code instead, like:

  enum LL_MERGE_RESULT {
	LL_MERGE_OK = 0,
	LL_MERGE_CONFLICT,
	LL_MERGE_BINARY_CONFLICT,
  };

would let the caller do the sensible thing.

-Peff
