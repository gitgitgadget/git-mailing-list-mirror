Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1C5C1F405
	for <e@80x24.org>; Tue, 18 Dec 2018 17:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbeLRRyU (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 12:54:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:45172 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726446AbeLRRyU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 12:54:20 -0500
Received: (qmail 2820 invoked by uid 109); 18 Dec 2018 17:54:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 18 Dec 2018 17:54:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15163 invoked by uid 111); 18 Dec 2018 17:53:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 18 Dec 2018 12:53:52 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Dec 2018 12:54:18 -0500
Date:   Tue, 18 Dec 2018 12:54:18 -0500
From:   Jeff King <peff@peff.net>
To:     Erin Dahlgren <eedahlgren@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Simplify handling of setup_git_directory_gently()
 failure cases.
Message-ID: <20181218175418.GB31070@sigill.intra.peff.net>
References: <1544722211-13370-1-git-send-email-eedahlgren@gmail.com>
 <1544922308-740-1-git-send-email-eedahlgren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1544922308-740-1-git-send-email-eedahlgren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 15, 2018 at 05:05:08PM -0800, Erin Dahlgren wrote:

> setup_git_directory_gently() expects two types of failures to
> discover a git directory (e.g. .git/):
> [...]

When I read your subject line, I'll admit to having a funny feeling in
the pit of my stomach. This setup code has historically been full of
subtle corner cases, and I expected a very tricky review.

However, your explanation was so well-written that it was a pleasure to
read. :)

> Before this change are two misleading additional behaviors:
> 
>   - GIT_DIR_HIT_CEILING: setup_nongit() changes to the cwd for no
> 	apparent reason. We never had the chance to change directories
> 	up to this point so chdir(current cwd) is pointless.

That makes sense. I think this is a holdover from when we used to walk
backwards via chdir(), prior to ce9b8aab5d (setup_git_directory_1():
avoid changing global state, 2017-03-13). Back then, we needed to
restore the state at this point, but now we don't.

>   - GIT_DIR_HIT_MOUNT_POINT: strbuf_release() frees the buffer
> 	of a static struct strbuf (cwd). This is unnecessary because the
> 	struct is static so its buffer is always reachable. This is also
> 	misleading because nowhere else in the function is this buffer
> 	released.

Makes sense.

I do have one question, though:

>  	case GIT_DIR_HIT_CEILING:
> -		prefix = setup_nongit(cwd.buf, nongit_ok);
> -		break;
> +		if (!nongit_ok)
> +			die(_("not a git repository (or any of the parent directories): %s"),
>a +					DEFAULT_GIT_DIR_ENVIRONMENT);
> +		*nongit_ok = 1;
> +		strbuf_release(&dir);
> +		return NULL;

This case used to break out of the switch, and now returns early.

So we do not execute the later code which clears GIT_PREFIX_ENVIRONMENT,
and zeroes the fields in startup_info. Those probably don't matter in
most cases, but I wonder if there are some obscure ones where it might.

Might it make sense to make GIT_DIR_HIT_MOUNT_POINT more like
GIT_DIR_HIT_CEILING currently is, rather than the other way around?
I.e., something like:

  case GIT_DIR_HIT_CEILING:
	if (!nongit_ok)
		die(...);
	*nongit_ok = 1;
	prefix = NULL;
	break;
  case GIT_DIR_HIT_MOUNT_POINT:
	if (!nongit_ok)
		die(...);
	*nongit_ok = 1;
	prefix = NULL;
	break;

?

-Peff
