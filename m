Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31AC6208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 15:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbdIEPgj (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 11:36:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:57460 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751382AbdIEPgi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 11:36:38 -0400
Received: (qmail 12840 invoked by uid 109); 5 Sep 2017 15:36:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 15:36:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13802 invoked by uid 111); 5 Sep 2017 15:37:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 11:37:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 11:36:36 -0400
Date:   Tue, 5 Sep 2017 11:36:36 -0400
From:   Jeff King <peff@peff.net>
To:     Ross Kabus <rkabus@aerotech.com>
Cc:     git@vger.kernel.org
Subject: Re: [Bug] commit-tree shouldn't append an extra newline to commit
 messages
Message-ID: <20170905153636.tsmlq3wv7ztpc67z@sigill.intra.peff.net>
References: <CAEVs+za9do_wXC12SSRznF9v9oGw3_Grq2EFDVf8nH1CRgM-Qw@mail.gmail.com>
 <20170902083319.lcugfpkkk5lahieb@sigill.intra.peff.net>
 <CAEVs+zbbWQuM-=5d04bkpTu38Mr4PyczskNhni5K1u_nzh-2Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEVs+zbbWQuM-=5d04bkpTu38Mr4PyczskNhni5K1u_nzh-2Qw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 05, 2017 at 11:09:01AM -0400, Ross Kabus wrote:

> On Sat, Sep 2, 2017 at 4:33 AM, Jeff King <peff@peff.net> wrote:
> 
> > But I am confused by your "inconsistent with git commit porcelain"
> > comment. The porcelain git-commit definitely _does_ add a newline if one
> > isn't present (and in fact runs the whole thing through git-stripspace
> > to clean up whitespace oddities).
> 
> Ok I figured out my confusion. The repository I am working with did
> commits with "git commit --cleanup=verbatim" thus do not have a newline.
> This is why I thought there was an inconsistency.

OK, that makes more sense. Though I think even with verbatim, "-m" will
still complete a line (it happens in opt_parse_m):

  $ git commit -q --allow-empty -m foo
  $ git cat-file commit HEAD | xxd
  ...
  00000090: 3034 3030 0a0a 666f 6f0a                 0400..foo.
                                  ^^
				  newline

That makes sense, since the idea of "-m" is to take a one-liner, but you
would not typically provide the newline yourself via the shell.

It looks like "-F" does not do an explicit complete-line (so it would
depend on --cleanup to do it normally, but in verbatim mode would not).
That makes sense to me, as well (in a full file, usually you _would_
have the newline, or choose to omit it intentionally, and we should
respect that). So I'd argue that "git commit -F" is doing a reasonable
thing, and "commit-tree -F" should probably change to match it (because
it's inconsistent, and because if anything the plumbing commit-tree
should err more on the side of not touching its input than the porcelain
commit command).

> > So I don't think "inconsistent with git-commit" is a compelling
> > argument, unless I'm missing something.
> 
> Agreed, but now I guess I would argue that it is inconsistent because
> it lacks a "verbatim" option like git-commit has. I would like to see
> an argument like this for commit-tree but a clean way to add this option
> didn't immediately jump out at me.

I think the default behavior of reading via stdin _is_ the verbatim
option. And you can choose whether or not to pipe it through
git-stripspace to do more cleanup (and in fact, when git-commit was
implemented as a shell script long ago, that's exactly how it was
implemented). But...

> > And definitely it does not when taking the message in via stdin.
> 
> I'm not seeing this, I see commit-tree as adding a new line even via
> stdin (and the code seems to corroborate this), unless I missed something.

I'm not sure why you're seeing that. It seems verbatim to me:

  $ tree=$(git write-tree)
  $ commit=$(printf end | git commit-tree $tree)
  $ git cat-file commit $commit | xxd
  ...
  00000090: 3034 3030 0a0a 656e 64                   0400..end

-Peff
