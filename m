Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53DD51F462
	for <e@80x24.org>; Fri, 14 Jun 2019 15:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbfFNPIA (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 11:08:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:55198 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725780AbfFNPIA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 11:08:00 -0400
Received: (qmail 16835 invoked by uid 109); 14 Jun 2019 15:08:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Jun 2019 15:08:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27675 invoked by uid 111); 14 Jun 2019 15:08:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 14 Jun 2019 11:08:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Jun 2019 11:07:58 -0400
Date:   Fri, 14 Jun 2019 11:07:58 -0400
From:   Jeff King <peff@peff.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     git@vger.kernel.org, masahiroy@kernel.org
Subject: Re: 'git interpret-trailers' is tripped by comment characters other
 than '#'
Message-ID: <20190614150758.GA22984@sigill.intra.peff.net>
References: <CAK7LNAR=KhTZRFFXTbcZwe-+65fGnVB7NbmVbQ7ymbmChDuhAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK7LNAR=KhTZRFFXTbcZwe-+65fGnVB7NbmVbQ7ymbmChDuhAg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 14, 2019 at 08:35:04PM +0900, Masahiro Yamada wrote:

> Perhaps, 'git interpret-trailers' should be changed
> to recognize core.commentChar ?

It looks like the trailer code does respect it, but the
interpret-trailers program never loads the config. Does the patch below
make your problem go away?

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 8ae40dec47..f101d092b8 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -10,6 +10,7 @@
 #include "parse-options.h"
 #include "string-list.h"
 #include "trailer.h"
+#include "config.h"
 
 static const char * const git_interpret_trailers_usage[] = {
 	N_("git interpret-trailers [--in-place] [--trim-empty] [(--trailer <token>[(=|:)<value>])...] [<file>...]"),
@@ -112,6 +113,8 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	git_config(git_default_config, NULL);
+
 	argc = parse_options(argc, argv, prefix, options,
 			     git_interpret_trailers_usage, 0);
 

I do wonder if the trailer code is correct to always respect it, though.
For example, in "git log" output we'd expect to see commit messages from
people with all sorts of config. I suppose the point is that their
comment characters wouldn't make it into the commit object at all, so
the right answer there is probably not to look for comment characters at
all.

-Peff
