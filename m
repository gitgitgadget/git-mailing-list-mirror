Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 304511F4F8
	for <e@80x24.org>; Sat,  1 Oct 2016 09:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751161AbcJAJMu (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Oct 2016 05:12:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:50797 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750934AbcJAJMs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Oct 2016 05:12:48 -0400
Received: (qmail 17266 invoked by uid 109); 1 Oct 2016 09:12:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 01 Oct 2016 09:12:47 +0000
Received: (qmail 16945 invoked by uid 111); 1 Oct 2016 09:13:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 01 Oct 2016 05:13:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Oct 2016 05:12:45 -0400
Date:   Sat, 1 Oct 2016 05:12:45 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     David Turner <dturner@twosigma.com>
Subject: Re: [PATCH 4/6] receive-pack: quarantine objects until pre-receive
 accepts
Message-ID: <20161001091245.jkju5rlytbcb2r52@sigill.intra.peff.net>
References: <20160930193533.ynbepaago6oycg5t@sigill.intra.peff.net>
 <20160930193630.vwq6n5hjbthrz6fj@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160930193630.vwq6n5hjbthrz6fj@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 30, 2016 at 03:36:30PM -0400, Jeff King wrote:

> @@ -1639,6 +1666,18 @@ static const char *unpack(int err_fd, struct shallow_info *si)
>  		argv_array_push(&child.args, alt_shallow_file);
>  	}
>  
> +	tmp_objdir = tmp_objdir_create();
> +	if (!tmp_objdir)
> +		return "unable to create temporary object directory";
> +	child.env = tmp_objdir_env(tmp_objdir);

One thing to note here: this new code kicks in all the time. My
reasoning was that there's basically no time you _wouldn't_ want it to,
and certainly that was the case for us when I wrote it. But I tried to
think of user-visible changes. Here's what I came up with:

  - we currently leave the tmp_pack_* for a failed push sitting around
    (e.g., if the client hangs up halfway through, or index-pack rejects
    the pack for some reason). But with this series, it would always be
    cleaned up. That's a very good thing if you're running a git hosting
    site. It might make things harder if you're debugging.

    I don't think it's a good reason not to enable this by default, but
    it _could_ be a reason to have a config switch to turn it off
    temporarily (or just leave the "incoming-*" directory in place).

  - the environment that pre-receive pack runs in has access to objects
    that the rest of the repository doesn't. So if you were to do
    something silly in your pre-receive like:

      # reject the push, but log a copy of the objects
      git update-ref refs/rejected/$(date +%s) $new_sha1
      exit 1

    Then your ref-update would succeed (you have $new_sha1), but the
    objects would be deleted immediately afterwards. I find this a
    somewhat questionable pattern, and I have no idea if anybody else
    has thought of it. But it _does_ work today, and not with this
    series.

I don't think it would be too hard to put a config conditional around
this tmp_objdir_create(). And then all of the tmp_objdir_env() calls
would just return NULL, and effectively become noops.

-Peff
