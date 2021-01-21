Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06341C433E0
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 21:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C793F22BEF
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 21:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbhAUVFk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 16:05:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:34518 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727530AbhAUVDa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 16:03:30 -0500
Received: (qmail 6869 invoked by uid 109); 21 Jan 2021 21:02:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Jan 2021 21:02:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5973 invoked by uid 111); 21 Jan 2021 21:02:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Jan 2021 16:02:43 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 21 Jan 2021 16:02:42 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v4 3/3] clone: respect remote unborn HEAD
Message-ID: <YAnr8lBESOO+ACL/@coredump.intra.peff.net>
References: <20201211210508.2337494-1-jonathantanmy@google.com>
 <cover.1608673963.git.jonathantanmy@google.com>
 <e770fc46eb3b600d8475d69964badaf2c63a7364.1608673963.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e770fc46eb3b600d8475d69964badaf2c63a7364.1608673963.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 22, 2020 at 01:54:20PM -0800, Jonathan Tan wrote:

> @@ -1323,10 +1325,20 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  		remote_head = NULL;
>  		option_no_checkout = 1;
>  		if (!option_bare) {
> -			const char *branch = git_default_branch_name();
> -			char *ref = xstrfmt("refs/heads/%s", branch);
> +			const char *branch;
> +			char *ref;
> +
> +			if (unborn_head_target &&
> +			    skip_prefix(unborn_head_target, "refs/heads/", &branch)) {
> +				ref = unborn_head_target;
> +				unborn_head_target = NULL;
> +			} else {
> +				branch = git_default_branch_name();
> +				ref = xstrfmt("refs/heads/%s", branch);
> +			}
>  
>  			install_branch_config(0, branch, remote_name, ref);
> +			create_symref("HEAD", ref, "");
>  			free(ref);
>  		}

In the old code, we never called create_symref() at all. It makes sense
that we'd do it now when unborn_head_target is not NULL. But what about
in the "else" clause there? Now we're adding an extra create_symref()
call. Who was setting up the HEAD symref before, and are we now doing it
twice?

If we have a valid unborn head, then we alias it to "ref" and we set the
original to NULL. And it gets cleaned up here via free(ref). Makes
sense. It confused me for a moment with this hunk...

> @@ -1373,6 +1385,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	strbuf_release(&key);
>  	junk_mode = JUNK_LEAVE_ALL;
>  
> +	free(unborn_head_target);

...since this line will almost always be free(NULL) as a result (either
there was no unborn head, or we consumed the string already). But it is
covering the case that somebody gave us an unborn_head_target but it
didn't start with refs/heads/. So it's useful to have.

-Peff
