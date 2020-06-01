Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85140C433DF
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 21:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D9D8206E2
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 21:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgFAVrQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 17:47:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:33678 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728360AbgFAVrQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 17:47:16 -0400
Received: (qmail 30859 invoked by uid 109); 1 Jun 2020 21:47:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 01 Jun 2020 21:47:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14290 invoked by uid 111); 1 Jun 2020 21:47:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 01 Jun 2020 17:47:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 1 Jun 2020 17:47:15 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] clone/fetch: anonymize URLs in the reflog
Message-ID: <20200601214715.GB3309882@coredump.intra.peff.net>
References: <pull.797.git.git.1591039202561.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.797.git.git.1591039202561.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 01, 2020 at 07:20:02PM +0000, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Even if we strongly discourage putting credentials into the URLs passed
> via the command-line, there _is_ support for that, and users _do_ do
> that.
> 
> Let's scrub them before writing them to the reflog.

Good idea.

>     This came up in an internal audit, but we do not consider this to be a
>     big deal: the reflog is local and not really shared with anybody.

Agreed.

>  builtin/clone.c            | 10 ++++++----
>  builtin/fetch.c            |  9 +++++++--
>  t/t5541-http-push-smart.sh | 15 +++++++++++++++

The patch itself looks very neatly done.

> @@ -993,11 +993,13 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  
>  	path = get_repo_path(repo_name, &is_bundle);
>  	if (path)
> -		repo = absolute_pathdup(repo_name);
> +		display_repo = repo = absolute_pathdup(repo_name);
>  	else if (!strchr(repo_name, ':'))
>  		die(_("repository '%s' does not exist"), repo_name);
> -	else
> +	else {
>  		repo = repo_name;
> +		display_repo = transport_anonymize_url(repo);
> +	}

Not introduced by your patch, but I had to read this a few times to make
sure we always end up with repo and display_repo set. IMHO it would be
easier to read as:

  if (this) {
     repo = ...;
     display_repo = ...;
  } else if (that) {
     repo = ...;
     display_repo = ...;
  } else {
     die(...);
  }

instead of sticking the die() in the middle.  Maybe just personal
preference, though. :)

> +	# should have been scrubbed down to vanilla URL
> +	git log -g master >reflog &&
> +	grep "$HTTPD_URL" reflog &&
> +	! grep "$HTTPD_URL_USER_PASS" reflog
> +'

And you make sure we retain the username. Nice.

-Peff
