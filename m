Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92D53208E9
	for <e@80x24.org>; Tue, 17 Jul 2018 20:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbeGQUsG (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 16:48:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:50112 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729728AbeGQUsG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 16:48:06 -0400
Received: (qmail 16667 invoked by uid 109); 17 Jul 2018 20:13:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 17 Jul 2018 20:13:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25332 invoked by uid 111); 17 Jul 2018 20:13:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 17 Jul 2018 16:13:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jul 2018 16:13:49 -0400
Date:   Tue, 17 Jul 2018 16:13:49 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Andrii Dehtiarov <adehtiarov@google.com>
Subject: Re: [PATCH 3/3] gc: do not return error for prior errors in
 daemonized mode
Message-ID: <20180717201348.GD26218@sigill.intra.peff.net>
References: <20180716172717.237373-1-jonathantanmy@google.com>
 <20180717065151.GA177907@aiede.svl.corp.google.com>
 <20180717065740.GD177907@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180717065740.GD177907@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 11:57:40PM -0700, Jonathan Nieder wrote:

> External tools like repo[1], though, do care about the exit status
> from "git gc --auto".  In non-daemonized mode, the exit status is
> straightforward: if there is an error, it is nonzero, but after a
> warning like the above, the status is zero.  The daemonized mode, as a
> side effect of the other properties provided, offers a very strange
> exit code convention:
> 
>  - if no housekeeping was required, the exit status is 0
> 
>  - the first real run, after forking into the background, returns exit
>    status 0 unconditionally.  The parent process has no way to know
>    whether gc will succeed.
> 
>  - if there is any diagnostic output in gc.log, subsequent runs return
>    a nonzero exit status to indicate that gc was not triggered.
> 
> There's nothing for the calling program to act on on the basis of that
> error.  Use status 0 consistently instead, to indicate that we decided
> not to run a gc (just like if no housekeeping was required).  This
> way, repo and similar tools can get the benefit of the same behavior
> as tools like "git fetch" that ignore the exit status from gc --auto.

I think this is a good change.

In theory it might be useful to propagate the original exit code (_not_
"did we see a warning or an error", but the true original exit code. But
as you note, it's not deterministic anyway (we'd miss that exit code on
the first run, or even any simultaneous runs that exit early due to lock
contention). So it's clear that callers can't really do anything robust
based on the exit code of a daemonized "gc --auto".

I still think that "repo" should probably stop respecting the exit code.
But that's no excuse for Git not to have a sensible exit code in the
first place.

The patch itself looks good overall. A few comments (none of which I
think even requires a fix):

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1cc18a828c..5eaa4aaa7d 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1649,7 +1649,8 @@ will be repacked. After this the number of packs should go below
>  gc.autoPackLimit and gc.bigPackThreshold should be respected again.
>  
>  gc.logExpiry::
> -	If the file gc.log exists, then `git gc --auto` won't run
> +	If the file gc.log exists, then `git gc --auto` will print
> +	its content and exit with status zero instead of running
>  	unless that file is more than 'gc.logExpiry' old.  Default is
>  	"1.day".  See `gc.pruneExpire` for more ways to specify its
>  	value.

Yeah, this is definitely worth documenting. I was surprised there's no
discussion of daemonization at all in git-gc(1). I don't think adding it
is a blocker for this series, though.

>  static void gc_before_repack(void)
> @@ -561,7 +576,13 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>  			fprintf(stderr, _("See \"git help gc\" for manual housekeeping.\n"));
>  		}
>  		if (detach_auto) {
> -			report_last_gc_error(); /* dies on error */
> +			int ret = report_last_gc_error();
> +			if (ret < 0)
> +				/* an I/O error occured, already reported */
> +				exit(128);

We have a few exit(128)'s sprinkled throughout the code-base, and I
always wonder if they will one day go stale if we change the code that
die() uses. But it probably doesn't matter, and anyway I don't think
there is a better way to do this currently.

I would have written "return 128" since the other case arm also returns,
but I really cannot think of a reason to prefer one over the other.

> diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
> index c474a94a9f..a222efdbe1 100755
> --- a/t/t6500-gc.sh
> +++ b/t/t6500-gc.sh
> @@ -116,11 +116,11 @@ test_expect_success 'background auto gc does not run if gc.log is present and re
>  	test_config gc.autopacklimit 1 &&
>  	test_config gc.autodetach true &&
>  	echo fleem >.git/gc.log &&
> -	test_must_fail git gc --auto 2>err &&
> -	test_i18ngrep "^fatal:" err &&
> +	git gc --auto 2>err &&
> +	test_i18ngrep "^warning:" err &&
>  	test_config gc.logexpiry 5.days &&
>  	test-tool chmtime =-345600 .git/gc.log &&
> -	test_must_fail git gc --auto &&
> +	git gc --auto &&

Nice. At first I thought this was changing an existing test to cover the
new case (which I usually frown on), but it is just that your patch is
intentionally changing the case covered here. So this is the right thing
to do.

-Peff
