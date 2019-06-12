Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C78D1F609
	for <e@80x24.org>; Wed, 12 Jun 2019 19:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbfFLTSV (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 15:18:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:53226 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727496AbfFLTSV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 15:18:21 -0400
Received: (qmail 25465 invoked by uid 109); 12 Jun 2019 19:18:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 12 Jun 2019 19:18:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13345 invoked by uid 111); 12 Jun 2019 19:19:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 12 Jun 2019 15:19:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Jun 2019 15:18:19 -0400
Date:   Wed, 12 Jun 2019 15:18:19 -0400
From:   Jeff King <peff@peff.net>
To:     Josh Steadmon <steadmon@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, git@jeffhostetler.com
Subject: Re: [RFC PATCH 3/3] trace2: add a schema validator for trace2 events
Message-ID: <20190612191818.GB14949@sigill.intra.peff.net>
References: <cover.1560295286.git.steadmon@google.com>
 <7475c6220895d96cdc7d25d6edea70e2f978526b.1560295286.git.steadmon@google.com>
 <87v9xb7x0q.fsf@evledraar.gmail.com>
 <20190612162341.GA42943@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190612162341.GA42943@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 12, 2019 at 09:23:41AM -0700, Josh Steadmon wrote:

> The problem with the existing validators is that they expect each file to be a
> complete JSON entity, whereas the trace output is one object per line. You can
> of course loop over the lines in a shell script, but in my testing this approach
> took multiple hours on the full test suite trace output, vs. 15 minutes for the
> implementation in this patch.

It seems like it should be easy to turn a sequence of entities into a
single entity, with something like:

  echo '['
  sed 's/$/,/' <one-per-line
  echo ']'

You could even turn a sequence of files into a single entity (which
might be even faster to validate, since it would be one invocation for
the entire test suite) with something like:

  echo '{'
  for fn in $FILES; do
	echo "\"$fn\": "
	cat $fn
	echo ","
  done
  echo '}'

though I suspect the resulting error messages might not be as good.

Obviously neither of those is particularly robust if the individual JSON
is not well-formed. But then, if we are mostly interested in testing
whether it's well-formed and expect it to be in the normal case, that
might be a good optimization.

I also wouldn't be surprised if "jq" could do this in a more robust way.

-Peff
