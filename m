Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B38C433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 17:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382402AbhLCRpr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 12:45:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:43176 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239496AbhLCRpp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 12:45:45 -0500
Received: (qmail 24874 invoked by uid 109); 3 Dec 2021 17:42:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Dec 2021 17:42:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3093 invoked by uid 111); 3 Dec 2021 17:42:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Dec 2021 12:42:20 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 3 Dec 2021 12:42:20 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: t7900 failures when $HOME is symlinked
Message-ID: <YapW/CfjFiPvsVbj@coredump.intra.peff.net>
References: <4cf14040-c8e1-0f75-0ec4-fd8cf6bed0a5@gmail.com>
 <xmqq1r2tty13.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1r2tty13.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 03, 2021 at 09:10:16AM -0800, Junio C Hamano wrote:

>  * TRASH_DIRECTORY is originally set to "trash directory." with a
>    suffix to make it unique across test scripts, but it immediately
>    gets turned into an absolute path by doing this:
> 
>         test -n "$root" && TRASH_DIRECTORY="$root/$TRASH_DIRECTORY"
>         case "$TRASH_DIRECTORY" in
>         /*) ;; # absolute path is good
>          *) TRASH_DIRECTORY="$TEST_OUTPUT_DIRECTORY/$TRASH_DIRECTORY" ;;
>         esac
> 
>    I notice that a root that is not absolute is silently lost during
>    this process.
> 
>    TEST_OUTPUT_DIRECTORY is set to TEST_DIRECTORY that comes from
>    $(pwd) we saw earlier, or TEST_OUTPUT_DIRECTORY_OVERRIDE, which
>    is also set to $(pwd) elsewhere, so the case statement does make
>    it absolute in the end.  It just loses --root=* without complaint
>    which is what I found iffy.

I don't think it's lost. It becomes part of $TRASH_DIRECTORY in the
first line, so the final line which prepends $TEST_OUTPUT_DIRECTORY
makes it relative to that. E.g.:

  $ cd t
  $ ./t0000-basic.sh --root=foo --debug
  [...]
  $ ls foo
  trash directory.t0000-basic/

I don't recall planning that in particular (there is not much point in
using it unless you are pointing outside the repo, though I guess you
could use ../../../foo or similar). But I think it has always worked
that way, since f423ef5f2b (tests: allow user to specify trash directory
location, 2009-08-09). It was perhaps a little easier to see back then
when the intermediate "$test" variable was not the final one.

-Peff
