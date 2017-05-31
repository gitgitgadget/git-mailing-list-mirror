Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3320A1FD09
	for <e@80x24.org>; Wed, 31 May 2017 22:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751053AbdEaWLy (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 18:11:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:60991 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751004AbdEaWLy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 18:11:54 -0400
Received: (qmail 19438 invoked by uid 109); 31 May 2017 22:11:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 May 2017 22:11:51 +0000
Received: (qmail 11046 invoked by uid 111); 31 May 2017 22:12:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 May 2017 18:12:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 May 2017 18:11:51 -0400
Date:   Wed, 31 May 2017 18:11:51 -0400
From:   Jeff King <peff@peff.net>
To:     Kevin Willford <kcwillford@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH 2/2] rebase: turn on progress option by default for
 format-patch
Message-ID: <20170531221151.pxdikxgxy37g7zub@sigill.intra.peff.net>
References: <20170531150427.7820-1-kewillf@microsoft.com>
 <20170531150427.7820-3-kewillf@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170531150427.7820-3-kewillf@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 31, 2017 at 08:04:27AM -0700, Kevin Willford wrote:

> This change passes the progress option of format-patch by
> default and passes the -q --quiet option through to the
> format-patch call so that it is respected as well.

That makes sense. Is it a bug that we aren't propagating "-q" already?

I think the answer is "no", because that option only claims to silence
the printing of the filenames that format-patch writes. But since we're
using --stdout, it wouldn't write those anyway.

Come to think of it, I'm not sure that "-q" silencing "--progress" in
your patch 1 actually makes sense. If you do:

  git format-patch -o out/

you don't need progress, because we're already writing the filenames to
stdout. So it's only if you did:

  git format-patch -o out/ -q

that you'd actually want progress. But "-q" would override any
--progress option!  So I actually think we may be better off keeping the
two as distinct features (especially if we follow the "no progress
unless --progress is given" rule I mentioned in the earlier message).

> diff --git a/git-rebase--am.sh b/git-rebase--am.sh
> index 375239341f..ab2be30abf 100644
> --- a/git-rebase--am.sh
> +++ b/git-rebase--am.sh
> @@ -51,8 +51,9 @@ then
>  else
>  	rm -f "$GIT_DIR/rebased-patches"
>  
> -	git format-patch -k --stdout --full-index --cherry-pick --right-only \
> -		--src-prefix=a/ --dst-prefix=b/ --no-renames --no-cover-letter \
> +	git format-patch $git_format_patch_opt -k --stdout --full-index \
> +		--cherry-pick --right-only --src-prefix=a/ --dst-prefix=b/ \
> +		--no-renames --no-cover-letter --progress \
>  		"$revisions" ${restrict_revision+^$restrict_revision} \
>  		>"$GIT_DIR/rebased-patches"

Here we pass --progress unconditionally, which tells format-patch to
output progress information. Shouldn't we be checking whether stderr is
a tty before making that decision? And that we're not in --quiet mode?

That explains why you want to pass "-q" in the other hunk; to
countermand the explicit --progress here. But if we separate the two as
I mentioned above, you'd want logic more like:

  if test -t 2 && test "$GIT_QUIET" != "t"
	git_format_patch_opt="$git_format_patch_opt --progress"
  fi

-Peff
