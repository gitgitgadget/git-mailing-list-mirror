Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34AE1203C5
	for <e@80x24.org>; Thu, 21 Jul 2016 21:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754557AbcGUVhp (ORCPT <rfc822;e@80x24.org>);
	Thu, 21 Jul 2016 17:37:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:48300 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754525AbcGUVhn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2016 17:37:43 -0400
Received: (qmail 29458 invoked by uid 102); 21 Jul 2016 21:37:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 Jul 2016 17:37:43 -0400
Received: (qmail 579 invoked by uid 107); 21 Jul 2016 21:38:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 Jul 2016 17:38:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Jul 2016 17:37:40 -0400
Date:	Thu, 21 Jul 2016 17:37:40 -0400
From:	Jeff King <peff@peff.net>
To:	larsxschneider@gmail.com
Cc:	git@vger.kernel.org
Subject: Re: [PATCH v1] convert: add test to demonstrate clean invocations
Message-ID: <20160721213740.GB4604@sigill.intra.peff.net>
References: <1469134747-26785-1-git-send-email-larsxschneider@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1469134747-26785-1-git-send-email-larsxschneider@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 21, 2016 at 10:59:07PM +0200, larsxschneider@gmail.com wrote:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> If three files processed by a filter are added and committed to a
> repository then I expect three clean invocations per Git operation.
> Apparently Git invokes the clean process 12 times.
> 
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> 
> It's pretty late here and I hope do not miss something obvious... but
> can anyone explain to me why the clean operation is executed 12 times
> for 3 files?

Hmm. If I run this under gdb and backtrace when we hit apply_filter(), I
see:

> +		rm -f run.count &&
> +		git add . &&
> +		test_line_count = 3 run.count

This "git add" does invoke apply_filter() 3 times, which I'd expect.

> +		rm -f run.count &&
> +		git commit . -m "test commit" &&
> +		test_line_count = 3 run.count

This invokes apply_filter() six times. So something funny is going on
already (I do get 12 dots, so checking apply_filter() seems to only
cover half the invocations).

Three of them are for re-adding the three files to the index again,
since "git commit ." is asking us to do so. I'm surprised, though; I
would have thought we could avoid doing so just based on the stat
information. Maybe it's a racy-index thing because the files' mtimes are
likely to be the same as the index?

Indeed, if I stick a "sleep 1" between modifying the files and calling
"git add", then the "git commit" invocation drops to only 6 invocations
of the filter. So that explains half of it (though I'm still confused
why index refreshing requires 6 and not 3; I guess it may be because
"git commit ." works in a separate index, and we first refresh that
index, and then refresh the "real" index again afterwards, when we could
theoretically just copy the entries).

The next three are to show the final diffstat after the commit
completes. It looks like the "should we reuse the worktree file?"
optimization in diff_populate_filespec() does not take into account
whether we will have to convert the contents, and it probably should.
The point is that sometimes mmap-ing the file contents is more efficient
than zlib inflating the object from disk. But if we have to exec an
extra process and read the whole object contents into a strbuf, that is
probably not a win.

Adding a "return 0" at the top of reuse_worktree_file() drops our 6 to
3 (but obviously it should actually check the attributes).

So of the 12 invocations:

  - 3 must be for refreshing the index again, because the way the test
    is written causes us to err on the side of caution when the mtimes
    are the same (and also means that even if your test is fixed to
    pass, it would racily fail when the system is under load)

  - 3 are for the double-refresh when "git commit ---only" is used (and
    "git commit ." implies "--only". Seems like there is room for
    optimization there.

  - 3 are for the tree-diff reusing the worktree files. This should be
    dropped.

  - The other 3, I'm not sure.

-Peff
