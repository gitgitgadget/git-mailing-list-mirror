Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 472DE1F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 15:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfDVP13 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 11:27:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:36810 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726943AbfDVP12 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 11:27:28 -0400
Received: (qmail 31290 invoked by uid 109); 22 Apr 2019 15:27:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 22 Apr 2019 15:27:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32329 invoked by uid 111); 22 Apr 2019 15:28:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 22 Apr 2019 11:28:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Apr 2019 11:27:26 -0400
Date:   Mon, 22 Apr 2019 11:27:26 -0400
From:   Jeff King <peff@peff.net>
To:     santiago@nyu.edu
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
Subject: Re: [RFC PATCH] builtin:tag:verify_tag: allow gpg output + pretty
Message-ID: <20190422152726.GB1633@sigill.intra.peff.net>
References: <20190412201432.11328-1-santiago@nyu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190412201432.11328-1-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 12, 2019 at 04:14:32PM -0400, santiago@nyu.edu wrote:

> From: Santiago Torres <santiago@nyu.edu>
> 
> On the git tag -v code, there is a guard to suppress gpg output if a
> pretty format is provided. The rationale for this is that the gpg output
> *and* the pretty formats together may conflict with each other. However,
> both outputs are directed to different output streams and, as such,
> they can safely coexist. Drop the guard clause and use
> GPG_VERIFY_VERBOSE regardless of the pretty format

I think this makes sense. My first worry was whether this would be
surprising to any callers, but as you note, they go to different
streams.

However, I don't think this patch is quite right, as it causes us to
dump the whole tag contents to stdout, as well. E.g.:

  [before]
  $ git tag -v --format='foo %(tag)' v2.21.0
  foo v2.21.0

  [after]
  $ git tag -v --format='foo %(tag)' v2.21.0
  object 8104ec994ea3849a968b4667d072fedd1e688642
  type commit
  tag v2.21.0
  tagger Junio C Hamano <gitster@pobox.com> 1551023739 -0800
  
  Git 2.21
  gpg: Signature made Sun Feb 24 10:55:39 2019 EST
  gpg:                using RSA key E1F036B1FEE7221FC778ECEFB0B5E88696AFE6CB
  gpg: Good signature from "Junio C Hamano <gitster@pobox.com>" [full]
  gpg:                 aka "Junio C Hamano <jch@google.com>" [full]
  gpg:                 aka "Junio C Hamano <junio@pobox.com>" [full]
  foo v2.21.0

I think "git verify-tag" would need similar treatment, too:

  $ git verify-tag v2.21.0
  gpg: Signature made Sun Feb 24 10:55:39 2019 EST
  gpg:                using RSA key E1F036B1FEE7221FC778ECEFB0B5E88696AFE6CB
  gpg: Good signature from "Junio C Hamano <gitster@pobox.com>" [full]
  gpg:                 aka "Junio C Hamano <jch@google.com>" [full]
  gpg:                 aka "Junio C Hamano <junio@pobox.com>" [full]

  $ git verify-tag --format='foo %(tag)' v2.21.0
  foo v2.21.0

In some ways I'm less concerned about verify-tag, though, because the
point is that it should be scriptable. And scraping gpg's stderr is not
ideal there. We should be parsing --status-fd ourselves and making the
result available via format specifier, similar to the way "log
--format=%G?" works.

So I think ultimately that's the direction we want to go, but I think
in the meantime restoring the gpg output to stderr especially for the
porcelain "git tag -v" makes sense for human eyes.

-Peff
