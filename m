Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8BDC433DF
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 16:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA7BE221F1
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 16:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730794AbgJHQNq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 12:13:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:53914 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729164AbgJHQNq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 12:13:46 -0400
Received: (qmail 29608 invoked by uid 109); 8 Oct 2020 16:13:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Oct 2020 16:13:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25194 invoked by uid 111); 8 Oct 2020 16:13:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Oct 2020 12:13:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Oct 2020 12:13:45 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] contrib/git-resurrect.sh: use hash-agnostic OID
 pattern
Message-ID: <20201008161345.GD2823778@coredump.intra.peff.net>
References: <cover.1602139448.git.liu.denton@gmail.com>
 <6fad1fc7fdad98c3dda1ec334a10a6a9e311fef8.1602139448.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6fad1fc7fdad98c3dda1ec334a10a6a9e311fef8.1602139448.git.liu.denton@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 07, 2020 at 11:44:40PM -0700, Denton Liu wrote:

> diff --git a/contrib/git-resurrect.sh b/contrib/git-resurrect.sh
> index 57a77c03f9..d843df3afd 100755
> --- a/contrib/git-resurrect.sh
> +++ b/contrib/git-resurrect.sh
> @@ -37,19 +37,18 @@ search_reflog_merges () {
>  	)
>  }
>  
> -_x40="[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]"
> -_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
> +oid_pattern=$(git hash-object --stdin </dev/null | sed -e 's/./[0-9a-f]/g')

This looks correct, although...

>  search_merges () {
>  	git rev-list --all --grep="Merge branch '$1'" \
>  		--pretty=tformat:"%P %s" |
> -	sed -ne "/^$_x40 \($_x40\) Merge .*/ {s//\1/p;$early_exit}"
> +	sed -ne "/^$oid_pattern \($oid_pattern\) Merge .*/ {s//\1/p;$early_exit}"
>  }
>  
>  search_merge_targets () {
>  	git rev-list --all --grep="Merge branch '[^']*' into $branch\$" \
>  		--pretty=tformat:"%H %s" --all |
> -	sed -ne "/^\($_x40\) Merge .*/ {s//\1/p;$early_exit} "
> +	sed -ne "/^\($oid_pattern\) Merge .*/ {s//\1/p;$early_exit} "
>  }

in both cases we are matching output we asked for, so we really matching
[0-9a-f]\+ would be correct and sufficient. That's a little simpler. I
don't feel too strongly either way, though.

  Side note: It's a shame that there is no way to convince rev-list not
  to print the "commit ..." header, which is really what we're avoiding
  here. We probably should have suppressed it with user-formats when
  they were introduced, but it's too late to make that change. I wonder
  if it would be worth adding a command-line option, though. I've often
  had to hack around this when parsing rev-list output (and sometimes
  even resort to using git-log if it's a one-off).

-Peff
