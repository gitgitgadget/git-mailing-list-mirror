Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 384BA1FA21
	for <e@80x24.org>; Wed, 11 Oct 2017 18:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752502AbdJKSgn (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 14:36:43 -0400
Received: from ikke.info ([178.21.113.177]:43924 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752045AbdJKSgm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 14:36:42 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id F01FF44039C; Wed, 11 Oct 2017 20:36:40 +0200 (CEST)
Date:   Wed, 11 Oct 2017 20:36:40 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Rafael =?iso-8859-1?Q?Ascens=E3o?= <rafa.almas@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] column: show auto columns when pager is active
Message-ID: <20171011183640.GC16800@alpha.vpn.ikke.info>
References: <20171009214543.12986-1-me@ikke.info>
 <20171011172310.2932-1-me@ikke.info>
 <CAN0heSqbD8TJu+_d11gj2eftG3gR+n0j621q_uSnuLQc9t_pbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSqbD8TJu+_d11gj2eftG3gR+n0j621q_uSnuLQc9t_pbQ@mail.gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 11, 2017 at 08:12:35PM +0200, Martin Ågren wrote:
> On 11 October 2017 at 19:23, Kevin Daudt <me@ikke.info> wrote:
> > finalize_colopts in column.c only checks whether the output is a TTY to
> > determine if columns should be enabled with columns set to auto. Also check
> > if the pager is active.
> 
> Maybe you could say something about the difficulties of writing a test
> for `git column` proper. Something like this perhaps:
> 
>   Adding a test for git column is possible but requires some care to
>   work around a race on stdin. See commit 18d8c2693 (test_terminal:
>   redirect child process' stdin to a pty, 2015-08-04). Test git tag
>   instead, since that does not involve stdin, and since that was the
>   original motivation for this patch.

Right, makes sense.
> 
> > Helped-by: Rafael Ascensão <rafa.almas@gmail.com>
> > Signed-off-by: Kevin Daudt <me@ikke.info>
> > ---
> >  column.c         |  3 ++-
> >  t/t7006-pager.sh | 14 ++++++++++++++
> >  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> Does the documentation on `column.ui` need to be updated? It talks about
> "if the output is to the terminal". That's similar to the documentation
> on the various `color.*`, so we should be fine, and arguably it's even
> better not to say anything since that makes it consistent.
> 
> > diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
> > index f0f1abd1c..44c2ca5d3 100755
> > --- a/t/t7006-pager.sh
> > +++ b/t/t7006-pager.sh
> > @@ -570,4 +570,18 @@ test_expect_success 'command with underscores does not complain' '
> >         test_cmp expect actual
> >  '
> >
> > +test_expect_success TTY 'git tag with auto-columns ' '
> > +       test_commit one &&
> > +       test_commit two &&
> > +       test_commit three &&
> > +       test_commit four &&
> > +       test_commit five &&
> > +       cat >expected <<\EOF &&
> > +initial  one      two      three    four     five
> > +EOF
> > +       test_terminal env PAGER="cat >actual.tag" COLUMNS=80 \
> > +               git -p -c column.ui=auto tag --sort=authordate &&
> > +       test_cmp expected actual.tag
> > +'
> > +
> >  test_done
> 
> Since `git tag` pages when it's listing, you don't need the `-p`. But
> it's not like it hurts to have it. Yeah, I know, you needed it with `git
> column`. :-)

Right, it was a bit of a left-over since I assumed the PAGER='cat >paginated.out'
from the beginning of the test was in place and I wasn't getting any
output, but it turned out PAGER wasn't set.

> I wonder if it's useful to set COLUMNS a bit lower so that this has to
> split across more than one line (but not six), i.e., to do something
> non-trivial. I suppose that might lower the chances of some weird
> breakage slipping through.

Yeah, I was doubting about that, but wouldn't this amount to testing
whether git column is working properly, instead of just testing whether
it's being done at all?

> This test uses "actual.tag" while most (all?) others in this file use
> "actual". Maybe you worry about checking the "wrong" file, e.g., in case
> the pager doesn't kick in. You could do `rm -f actual` before the
> `test_terminal`-invocation to protect against that.

Yeah, I actually ran into that, but rm-ing it is better, I agree.

> These were just the thoughts that occurred to me, not sure if any of
> them is particularly significant. Thanks for cleaning up after me.
> 

np. Just as I posted earlier, I think you did not actually cause the bug
(because this has never worked), it just made it visible to more users.

Kevin
