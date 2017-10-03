Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 373102036B
	for <e@80x24.org>; Tue,  3 Oct 2017 13:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751514AbdJCNhQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 09:37:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:59032 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751204AbdJCNhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 09:37:16 -0400
Received: (qmail 28914 invoked by uid 109); 3 Oct 2017 13:37:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 13:37:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7753 invoked by uid 111); 3 Oct 2017 13:37:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 09:37:15 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Oct 2017 09:37:13 -0400
Date:   Tue, 3 Oct 2017 09:37:13 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Toni Uebernickel <tuebernickel@gmail.com>, git@vger.kernel.org,
        Tsvi Mostovicz <ttmost@gmail.com>
Subject: Re: Updated to v2.14.2 on macOS; git add --patch broken
Message-ID: <20171003133713.ccxv6clrmuuhhc3u@sigill.intra.peff.net>
References: <xmqqpoa5kp0c.fsf@gitster.mtv.corp.google.com>
 <xmqqinfxklw7.fsf@gitster.mtv.corp.google.com>
 <20171003061515.72l35fpvcf63vsf6@sigill.intra.peff.net>
 <xmqqinfwiu5n.fsf@gitster.mtv.corp.google.com>
 <20171003071622.el6zqibfyrjc2mra@sigill.intra.peff.net>
 <xmqqefqkiq8v.fsf@gitster.mtv.corp.google.com>
 <20171003084506.lwmnrym4oyf66icz@sigill.intra.peff.net>
 <xmqq4lrgip7u.fsf@gitster.mtv.corp.google.com>
 <20171003091049.jb46pyi3obtwkzsa@sigill.intra.peff.net>
 <xmqqpoa4h5y7.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpoa4h5y7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 03, 2017 at 07:38:24PM +0900, Junio C Hamano wrote:

> That's an argument to say color.ui=always is not a useful thing to
> use and Git is wrong to offer such a nonsense option.  I agree with
> both of them.
> 
> But it is a different matter that plumbing commands are now doing
> the "color" thing without being asked.  Reading the configuration
> that is meant for human interaction adds insult to injury.  I think
> the earlier "everybody is colored by default" that forgot to make
> sure the change does not affect plumbing was the main culprit, and
> we were merely lucky that thanks to the auto-detection of "auto" we
> did not break scripts.

Yes, I agree that the "everybody is colored by default" is the root of
the problem. And in that sense all of this discussion is band-aid fixes
on that.

At the same time, I have a suspicion that "even plumbing is color=auto
by default" may actually be _helping_ in many scripts. Because they to
use the plumbing to show output to the user, respecting the user's
normal color preferences. That's just a hunch, though.

I also think trying to revert that "default" patch (4c7f1819) may be a
pretty big pain at this point.

  Side note: Sorry, I noticed while writing this that I got my commit
  references mixed up earlier between 4c7f1819 (which turned the default
  to auto even for plumbing) and 136c8c8b, my recent change to parse
  color.ui in more places. When I said the problem was exacerbated/made
  worse by 4c7f1819, I really meant 136c8c8b. Hopefully that didn't
  confuse the discussion too much.

> Having said all that, unless we revert the entire series (and
> possibly other things that happened after the series was merged on
> 'master' that assumes that now default_config would read the
> color.ui thing), we won't be able to get back to the state before
> the "add -p" regression, it seems.  As -rc freeze period for the
> next cycle is approaching fast, I wanted to make sure that we have a
> plan to address the regression (which does not have to solve what
> the reverted commit tried to solve).  If you think we can get a
> workable code in 2.14.x and 'master' that essentially castrates
> "always" and makes it the same as "auto" in several days tops, then
> I'd prefer such a solution, as honoring "color.ui=always" does not
> feel all that important.

Here's what I came up with on the "color.ui=always is nonsense that we
should not offer" front. The number of patches may be a little daunting,
but most of them are just removing cases of "git -c color.ui=always"
from the tests.

  [01/12]: test-terminal: set TERM=vt100
  [02/12]: t4015: prefer --color to -c color.diff=always
  [03/12]: t4015: use --color with --color-moved
  [04/12]: t3701: use test-terminal to collect color output
  [05/12]: t7508: use test_terminal for color output
  [06/12]: t7502: use diff.noprefix for --verbose test
  [07/12]: t6006: drop "always" color config tests
  [08/12]: t3203: drop "always" color test
  [09/12]: t7301: use test_terminal to check color
  [10/12]: t3205: use --color instead of color.branch=always
  [11/12]: provide --color option for all ref-filter users
  [12/12]: color: make "always" the same as "auto" in config

 Documentation/config.txt           | 35 ++++++++++++-------------
 Documentation/git-for-each-ref.txt |  5 ++++
 Documentation/git-tag.txt          |  5 ++++
 builtin/for-each-ref.c             |  1 +
 builtin/tag.c                      |  1 +
 color.c                            |  2 +-
 t/t3203-branch-output.sh           |  8 +-----
 t/t3205-branch-color.sh            |  5 ++--
 t/t3701-add-interactive.sh         | 18 +++++++++----
 t/t4015-diff-whitespace.sh         | 53 +++++++++++++++++++-------------------
 t/t4202-log.sh                     |  2 +-
 t/t6006-rev-list-format.sh         | 23 +++++------------
 t/t6300-for-each-ref.sh            |  7 +++--
 t/t7004-tag.sh                     |  6 ++---
 t/t7006-pager.sh                   |  6 ++---
 t/t7301-clean-interactive.sh       |  5 ++--
 t/t7502-commit.sh                  |  4 +--
 t/t7508-status.sh                  | 41 +++++++++++++++--------------
 t/test-terminal.perl               |  1 +
 19 files changed, 115 insertions(+), 113 deletions(-)

-Peff
