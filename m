Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E55B2013A
	for <e@80x24.org>; Fri, 17 Feb 2017 08:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754811AbdBQIW5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 03:22:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:56966 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754542AbdBQIW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 03:22:56 -0500
Received: (qmail 4875 invoked by uid 109); 17 Feb 2017 08:22:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 08:22:55 +0000
Received: (qmail 31959 invoked by uid 111); 17 Feb 2017 08:22:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 03:22:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Feb 2017 03:22:54 -0500
Date:   Fri, 17 Feb 2017 03:22:54 -0500
From:   Jeff King <peff@peff.net>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] update-ref: pass reflog message argument to
 delete_refs
Message-ID: <20170217082253.kxjezkxfqkfxjhzr@sigill.intra.peff.net>
References: <20170126211205.5gz3zsrptop7n34n@sigill.intra.peff.net>
 <20170217035800.13214-1-kyle@kyleam.com>
 <20170217035800.13214-3-kyle@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170217035800.13214-3-kyle@kyleam.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2017 at 10:57:59PM -0500, Kyle Meyer wrote:

> Now that delete_refs() accepts a reflog message, pass the
> user-provided message to delete_refs() rather than silently dropping
> it.  The doesn't matter for the deleted ref's log because the log is
> deleted along with the ref, but this entry will show up in HEAD's
> reflog when deleting a checked out branch.

Sounds good.

> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index a41f9adf1..f642acc22 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -435,7 +435,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
>  		 */
>  		return delete_ref(refname,
>  				  (oldval && !is_null_sha1(oldsha1)) ? oldsha1 : NULL,
> -				  flags, NULL);
> +				  flags, msg);

This looks obviously correct.

> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index b0ffc0b57..65918d984 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -85,6 +85,15 @@ test_expect_success "delete $m (by HEAD)" '
>  '
>  rm -f .git/$m
>  
> +test_expect_success "deleting current branch adds message to HEAD's log" '
> +	git update-ref $m $A &&
> +	git symbolic-ref HEAD $m &&
> +	git update-ref -mdelmsg -d $m &&
> +	! test -f .git/$m &&
> +	grep "delmsg$" .git/logs/HEAD >/dev/null
> +'
> +rm -f .git/$m

I think covering this with a test is good.

I don't know if it's also worth testing that deleting via HEAD also
writes the reflog. I.e.,:

  git update-ref -m delete-by-head -d HEAD

Some of the style here is a bit out-dated, but I think you are just
matching the surrounding tests.  So that's OK by me (though a patch to
modernize the whole thing would be welcome, too).

For reference, the two things I notice are:

  - we prefer test_path_is_missing to "! test -f" these days.

  - we don't redirect the output of grep (it's handled already in
    non-verbose mode, and in verbose mode we try to be...verbose).

-Peff
