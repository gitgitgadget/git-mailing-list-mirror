Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1A0C2BA2B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 16:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E882078E
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 16:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgDJQ4p (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 12:56:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:39790 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726177AbgDJQ4p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 12:56:45 -0400
Received: (qmail 5118 invoked by uid 109); 10 Apr 2020 16:56:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 10 Apr 2020 16:56:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 468 invoked by uid 111); 10 Apr 2020 17:07:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Apr 2020 13:07:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Apr 2020 12:56:44 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] merge: use skip_prefix to parse config key
Message-ID: <20200410165644.GA79836@coredump.intra.peff.net>
References: <20200410151032.23198-1-martin.agren@gmail.com>
 <20200410155827.GA71011@coredump.intra.peff.net>
 <xmqqo8rzjnnb.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo8rzjnnb.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 10, 2020 at 09:44:56AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > In general, parsing subsections accurately involves looking from both
> > the start and the end of the string, pulling out the section and key and
> > leaving the rest in the middle. But I think we can get away with this
> > left-to-right parsing because we're only interested in matching a
> > _specific_ subsection name, and a specific key. So there are no cases it
> > will handle incorrectly.
> 
> In other words, if k were "branch.A.B.mergeoptions", it can only be
> the 'branch.*.mergeoptions' variable attached to branch "A.B", but
> when checking for branch=="A", the first two skip_prefix() would
> pass and the only thing that protects us from misparsing is that
> "B.mergeoptions" is not what we are looking for.

Yes, exactly.

> > The more general form would be:
> [...]
> Yes, but even with such a helper, i.e.
> [...]
> what Martin wrote, especially if it is reflowed to match the above, i.e.
> [...]
> I find it just as, if not more, easy to read.

Yeah, sorry if I was unclear; I think the left-to-right is perfectly
fine for this case.

> Where the parse_config_key() helper shines, I think, is when we do
> not have the middle level to compare against, and in that case, we
> must work only from the given key, scanning from both ends for dot.

Agreed.

Another option for known-value cases like this is to do it outside of
the callback handler, like:

  char *key = xstrfmt("branch.%s.mergeoptions");
  const char *value;
  if (!git_config_get_string_const(key, &value))
     ...
  free(key);

The allocation is a bit awkward, though we could hide that with a clever
helper.

Shifting from "iterate over and store config keys" to "look up config
keys on demand" is a much bigger change, though. I would only do it if
it made the rest of the code flow easier.

-Peff
