Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4893207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 18:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934123AbcI2Sjp (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 14:39:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:50054 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755690AbcI2Sjn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 14:39:43 -0400
Received: (qmail 12200 invoked by uid 109); 29 Sep 2016 18:39:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 18:39:42 +0000
Received: (qmail 3614 invoked by uid 111); 29 Sep 2016 18:39:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 14:39:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Sep 2016 14:39:40 -0400
Date:   Thu, 29 Sep 2016 14:39:40 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com
Subject: Re: [PATCH v5 1/4] git: make super-prefix option
Message-ID: <20160929183940.vgac7by74gmglaf2@sigill.intra.peff.net>
References: <1474930003-83750-1-git-send-email-bmwill@google.com>
 <1475099443-145608-1-git-send-email-bmwill@google.com>
 <1475099443-145608-2-git-send-email-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1475099443-145608-2-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 28, 2016 at 02:50:40PM -0700, Brandon Williams wrote:

> Add a super-prefix environment variable 'GIT_INTERNAL_SUPER_PREFIX'
> which can be used to specify a path from above a repository down to its
> root.  The immediate use of this option is by commands which have a
> --recurse-submodule option in order to give context to submodules about
> how they were invoked.  This option is currently only allowed for
> builtins which support a super-prefix.

What about non-builtins?

E.g., what should

  git --super-prefix=foo bar

do? Should the externals and scripts check the presence of
GIT_INTERNAL_SUPER_PREFIX and barf if it is set? Most scripts would
probably notice eventually when calling some other builtin that doesn't
support SUPER_PREFIX, but it seems hacky to count on that.

There's also the question of 3rd-party programs. If we want to be
conservative, I think you'd want to just always bail in
execv_dashed_external() if --super-prefix is in use. That doesn't give
an option for scripts to say "hey, I support this", but we can perhaps
worry about loosening later.

-Peff
