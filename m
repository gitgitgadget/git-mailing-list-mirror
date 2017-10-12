Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 024C220372
	for <e@80x24.org>; Thu, 12 Oct 2017 15:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751963AbdJLPIu (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 11:08:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:51022 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751356AbdJLPIr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 11:08:47 -0400
Received: (qmail 19505 invoked by uid 109); 12 Oct 2017 15:08:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Oct 2017 15:08:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16353 invoked by uid 111); 12 Oct 2017 15:08:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Oct 2017 11:08:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Oct 2017 11:08:45 -0400
Date:   Thu, 12 Oct 2017 11:08:45 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] color: discourage use of ui.color=always
Message-ID: <20171012150844.jhdbnckabkbdzi4d@sigill.intra.peff.net>
References: <xmqqr2uao2vy.fsf@gitster.mtv.corp.google.com>
 <20171012021007.7441-1-gitster@pobox.com>
 <20171012021007.7441-3-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171012021007.7441-3-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 12, 2017 at 11:10:07AM +0900, Junio C Hamano wrote:

> Warn when we read such a configuration from a file, and nudge the
> users to spell them 'auto' instead.

Hmm. On the one hand, it is nice to make people aware that their config
isn't doing what they might think.

On the other hand, if "always" is no longer a problem for anybody, do we
need to force users to take the step to eradicate it? I dunno. Were we
planning to eventually remove it?

> @@ -320,6 +322,11 @@ int git_config_colorbool(const char *var, const char *value)
>  			 * Otherwise, we're looking at on-disk config;
>  			 * downgrade to auto.
>  			 */
> +			if (!warn_once) {
> +				warn_once++;
> +				warning("setting '%s' to '%s' is no longer valid; "
> +					"set it to 'auto' instead", var, value);
> +			}

This warn_once is sadly not enough to give non-annoying output to
scripts that call many git commands. E.g.:

  $ git config color.ui always
  $ git add -p
  warning: setting 'color.ui' to 'always' is no longer valid; set it to 'auto' instead
  warning: setting 'color.ui' to 'always' is no longer valid; set it to 'auto' instead
  warning: setting 'color.ui' to 'always' is no longer valid; set it to 'auto' instead
  warning: setting 'color.ui' to 'always' is no longer valid; set it to 'auto' instead
  warning: setting 'color.ui' to 'always' is no longer valid; set it to 'auto' instead
  warning: setting 'color.ui' to 'always' is no longer valid; set it to 'auto' instead
  warning: setting 'color.ui' to 'always' is no longer valid; set it to 'auto' instead
  warning: setting 'color.ui' to 'always' is no longer valid; set it to 'auto' instead
  warning: setting 'color.ui' to 'always' is no longer valid; set it to 'auto' instead
  warning: setting 'color.ui' to 'always' is no longer valid; set it to 'auto' instead
  diff --git a/file b/file
  [...]

-Peff
