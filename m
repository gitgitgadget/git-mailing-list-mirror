Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EB2C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 07:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09EC661151
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 07:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhJ2H7J (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 03:59:09 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:38450 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232258AbhJ2H7I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 03:59:08 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 449F51F953;
        Fri, 29 Oct 2021 07:56:40 +0000 (UTC)
Date:   Fri, 29 Oct 2021 07:56:40 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] tests: disable fsync everywhere
Message-ID: <20211029075640.M183252@dcvr>
References: <20211028002102.19384-1-e@80x24.org>
 <YXq1g4Zwfq8gJEoC@coredump.intra.peff.net>
 <20211028182824.GA1307@dcvr>
 <xmqqilxhq774.fsf@gitster.g>
 <20211029001552.GA29647@dcvr>
 <xmqqr1c4mmsf.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1c4mmsf.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> > +# n.b. consider using Git.pm
> > +sub use_fsync {
> > +    if (!defined($_use_fsync)) {
> > +        my $x = $ENV{GIT_TEST_FSYNC};
> > +        if (defined $x) {
> 
> I would have expected to see "exists $ENV{GIT_TEST_FSYNC}", but I
> guess there is no way to place in %ENV anyway, so it would be OK.

Was that meant to say: "no way to place `undef' in %ENV anyway"?

If so, `undef' can actually be in Perl's %ENV, though it appears
to get coerced into "" (empty string) when spawning processes.

> > +            local $ENV{GIT_CONFIG};
> > +            delete $ENV{GIT_CONFIG};
> 
> OK, "git -c test.fsync=no cvsserver" would added something to
> GIT_CONFIG that would affect test.fsync, but wouldn't the usual
> last-one-wins rule be sufficient to check the value of $x using the
> next construction, no matter what is in GIT_CONFIG?  I do not think
> it would hurt to delete $ENV{GIT_CONFIG}, but I am not sure how it
> is necessary.

Leaving GIT_CONFIG set was actually causing "git config" to
exit(1) since git-cvsserver sets GIT_CONFIG and the GIT_CONFIG
file doesn't have a test.fsync setting.  This is the current
behavior, I think it's a weird quirk, but intended behavior of
git-config.

# this assumes you don't have foo.bar set in your ~/.gitconfig :>
$ GIT_CONFIG=$HOME/.gitconfig git -c foo.bar=0 config --type=bool foo.bar
$ echo $?
1

> > +            my $v = ::safe_pipe_capture('git', '-c', "test.fsync=$x",
> > +                                        qw(config --type=bool test.fsync));
> 
> THis is an interesting idiom.

Heh, I just thought of it before sending my original.  I was
going to use a regexp originally (in git-svn, too), but didn't
want to get into corner cases such as hex and +/- prefixes).

> > +            $_use_fsync = defined($v) ? ($v eq "true\n") : 1;
> > +        }
> > +    }
> > +    $_use_fsync;
> > +}
> 
> 
> > +# TODO: move this to Git.pm?
> > +sub use_fsync {
> 
> Possibly, but in a slightly more general form, taking the name of
> the environment variable that holds a boolean value as an argument,
> or something?

Yeah.  It would've been more useful if git-cvsserver used Git.pm;
but I didn't want to introduce Git.pm into git-cvsserver in case
somebody relies on git-cvsserver being standalone.
