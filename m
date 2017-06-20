Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4528620282
	for <e@80x24.org>; Tue, 20 Jun 2017 15:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751865AbdFTPzB (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 11:55:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:46410 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751763AbdFTPzB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 11:55:01 -0400
Received: (qmail 29507 invoked by uid 109); 20 Jun 2017 15:55:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 20 Jun 2017 15:55:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14137 invoked by uid 111); 20 Jun 2017 15:55:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 20 Jun 2017 11:55:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Jun 2017 11:54:59 -0400
Date:   Tue, 20 Jun 2017 11:54:59 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH] die routine: change recursion limit from 1 to 1024
Message-ID: <20170620155459.a6e7pypxx6vpdbvs@sigill.intra.peff.net>
References: <20170619220036.22656-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170619220036.22656-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 19, 2017 at 10:00:36PM +0000, Ævar Arnfjörð Bjarmason wrote:

> Change the recursion limit for the default die routine from a *very*
> low 1 to 1024. This ensures that infinite recursions are broken, but
> doesn't lose error messages.
> 
> The intent of the existing code, as explained in commit
> cd163d4b4e ("usage.c: detect recursion in die routines and bail out
> immediately", 2012-11-14), is to break infinite recursion in cases
> where the die routine itself dies.

I agree that was the original intent, but I think it also does something
else. Anytime die() recurses, even a single level, we're going to cover
up the original failure with the one that happened inside die(), which
is almost certainly the less interesting of the two.

E.g., if I

  die_errno("unable to open %s", filename);

and then the die handler calls malloc() and fails, you'd much rather see
that first message than "out of memory".

To be fair, "die handler is recursing" is _also_ not helpful, but at
least it's clear that this is a bug (and IMHO it should be marked with
BUG()). Saying "out of memory" tells you about the second error, but it
doesn't tell you that we've masked the first error. So it may lead to
more confusion in the long run.

I wonder if we can get the best of both, though. Can we make the logic
more like:

  if (!dying) {
	/* ok, normal */
	return 0;
  } else if (dying < 1024) {
	/* only show the warning once */
	if (dying == 1)
		warning("I heard you liked errors, so I put a die() in your die()");
	return 0; /* don't bail yet */
  } else {
	BUG("recursion detected in die handler");
  }

> Now, git-grep could make use of the pluggable error facility added in
> commit c19a490e37 ("usage: allow pluggable die-recursion checks",
> 2013-04-16).

Yeah, I think this is a bug in git-grep and should be fixed, independent
of this commit. You should be able to use as a template the callbacks
added by the child of c19a490e37:

  1ece66bc9 (run-command: use thread-aware die_is_recursing routine,
  2013-04-16)

-Peff
