Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F339B1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 04:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfKOEJL (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 23:09:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:48022 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726755AbfKOEJK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 23:09:10 -0500
Received: (qmail 25404 invoked by uid 109); 15 Nov 2019 04:09:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Nov 2019 04:09:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10082 invoked by uid 111); 15 Nov 2019 04:12:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Nov 2019 23:12:46 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 14 Nov 2019 23:09:09 -0500
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 00/27] t: general test cleanup + `set -o pipefail`
Message-ID: <20191115040909.GA21654@sigill.intra.peff.net>
References: <cover.1573779465.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1573779465.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 14, 2019 at 05:00:29PM -0800, Denton Liu wrote:

> Patches 1-20 perform some general test cleanup to modernise the style.
> They should be relatively uncontroversial and can be merged earlier (or
> as a separate series) if desired. The reason these tests were identified
> for cleanup was because they failed under `set -o pipefail`.
> 
> Patches 21-27 should be considered RFC. In an attempt to catch git
> commands failing in the upstream of a pipe, we enable `set -o pipefail`
> on Bash. This may result in some funny-looking shell script constructs
> (e.g. needing to wrap `grep` since it may "fail") but overall, I think it
> is an improvement since we catch failure in more cases.

Using pipefail can have unexpected consequences for other commands if
they rely on SIGPIPE/EPIPE to signal the left-hand side of the pipe.
E.g., this:

  $ set -o pipefail
  $ yes | head >/dev/null
  $ echo $?

will consistently yield 141, since "yes" will always die to SIGPIPE
after "head" stops reading from it.

But much worse, this can be racy. Take something like this (which is a
real snippet in our test suite):

  git status -s -b | head -1

The "head" process will quit after reading one line. What's the exit
code of "git status"? It's either "0", if it managed to write everything
into the pipe buffer before the simultaneously-running "head" closed the
pipe. Or it's 141, if it didn't and got SIGPIPE.

You could argue that "git status" should not be on the left-hand side of
a pipe, but the same holds for any command on the left-hand side. E.g.,
grepping in our test scripts yields some bits like:

  t/t7003-filter-branch.sh:       echo "$faux_gpg_tag" | sed -e s/XXXXXX/$sha1/ | head -n 6 > expect &&
  t/t9400-git-cvsserver-server.sh:   test "$(echo $(grep -v ^D cvswork/CVS/Entries|cut -d/ -f2,3,5 | head -n 1))" = "empty/1.1/" &&

And it's not just "head" that doesn't read all of its input. Another
common one is "grep -q", which can quit as soon as it sees a match.

So I have a feeling that pipefail is going to create more headaches than
it solves.

-Peff
