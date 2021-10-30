Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2BBC433EF
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 10:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C4FC60F23
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 10:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbhJ3KmU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 06:42:20 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:45396 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231685AbhJ3KmU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 06:42:20 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 8F15E1F953;
        Sat, 30 Oct 2021 10:39:50 +0000 (UTC)
Date:   Sat, 30 Oct 2021 10:39:50 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Neeraj Singh <nksingh85@gmail.com>
Subject: Re: [PATCH] allow disabling fsync everywhere
Message-ID: <20211030103950.M489266@dcvr>
References: <20211028002102.19384-1-e@80x24.org>
 <211029.86v91g3vv3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211029.86v91g3vv3.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Thu, Oct 28 2021, Eric Wong wrote:
> 
> > "core.fsync" and the "GIT_FSYNC" environment variable now exist
> > for disabling fsync() even on packfiles and other critical data.
> 
> First off, I think this would be useful to add, even as a non-test
> thing.

<snip>

Agreed, I've LD_PRELOAD-ed libeatmydata via ~/.bashrc at times :>

OTOH, I understand Junio and brian's positions on dealing with
misinformed users losing data.  I'm also lazy when it comes to
docs and support, so I'm leaning towards keeping this exclusively
for those who read source code.

I also know it's easy to add a sysctl knob for disabling fsync
et. al. in the kernel; but it's not something I want to deal
with supporting and documenting, either.

> > Running "make test -j8 NO_SVN_TESTS=1" on a noisy 8-core system
> > on an HDD, adding "GIT_FSYNC=0" to the invocation brings my test
> > runtime from ~4 minutes down to ~3 minutes.
> 
> On a related topic: Have you tried having it use an empty template
> directory? I have some unsubmitted patches for that, and if you retain
> all trash dirs you'll find that we have IIRC 100-200MB of just
> accumulated *.sample etc. hooks, out of ~1GB total for the tests.

Not, not yet.  I also expect using reflinks on some Linux FSes
will help users save space in real-world use
(ioctl(dst_fd, FICLONE, src_fd)).

> Per the recent threads about fsync semantics this should really be
> worded to be more scary, i.e. it's not guaranteed that your data is
> on-disk at all. So subsequent git operations might see repo corruption,
> if we're being POSIX-pedantic.

Yeah, I wasn't sure how strongly to word it.  Now it's
undocumented; I suppose we can use your wording if we decide
it's worth documenting.

> > --- a/git-cvsserver.perl
> > +++ b/git-cvsserver.perl
> > @@ -3607,6 +3607,25 @@ package GITCVS::updater;
> >  use strict;
> >  use warnings;
> >  use DBI;
> > +our $_use_fsync;
> 
> s/our/my/?

Erm, yes.  Though it doesn't matter for a standalone script;
probably not worth a reroll..

> I wonder most of all if we really need these perl changes, does it
> really matter for the overall performance that you want, or was it just
> to get all fsync() uses out of the test suite?

Yes to both, or at least an attempt to...  A single fsync() can
end up being equivalent to syncfs().

Fully-disabling fsync in SVN doesn't seem possible, though.
There's a few svnadmin switches (--no-flush-to-disk +
--bdb-txn-nosync) but AFAIK they aren't 100% solutions.
Fortuntanately, NO_SVN_TESTS=1 exists.

> This is a more general comment, but so much of scaffolding like that in
> the *.perl scripts could go away if we taught git.c some "not quite a
> builtin, but it's ours" mode, and had say code for git-send-email,
> git-svn etc. to just set the various data they need in the environment
> before we invoke them. Then this would just be say:
> 
>     our $use_fsync = $ENV{GIT_FOR_CVSSERVER_FSYNC};

That's potentially a lot of environment variables, though.
Maybe just:  eval($ENV{GIT_CFG_CVSSERVER}) if $ENV{GIT_CFG_PID} == $$;
The PID check should be sufficient to avoid mismatches and
malicious code injection.

> > [...]
> >  	my $sync;
> >  	# both of these options make our .rev_db file very, very important
> >  	# and we can't afford to lose it because rebuild() won't work
> > -	if ($self->use_svm_props || $self->no_metadata) {
> > +	if (($self->use_svm_props || $self->no_metadata) && use_fsync()) {
> >  		require File::Copy;
> >  		$sync = 1;
> >  		File::Copy::copy($db, $db_lock) or die "rev_map_set(@_): ",
> 
> This doesn't just impact $io->sync, but also $io->flush, which is a
> different thing. PerlIO flushing to the OS != fsync().

Right, close($fh) (right below[1]) also takes care of PerlIO
flushing.  ->flush was only there for fsync.

[1] https://yhbt.net/lore/git/7b333ea62e/s/?b=perl/Git/SVN.pm#n2334

> This patch direction looks good to me, aside from the above we should
> really update any other fsync() docs we have, maybe with a
> cross-reference in core.fsyncObjectFiles?

Alright, though I'm happy with it being undocumented, for now.

> I'm not sure offhand what the state of the other fsync patches that
> Neeraj Singh has been submitting is, but let's make sure that whatever
> docs/config knobs etc. we have all play nicely together, and are
> somewhat future-proof if possible.

It looks like it some changes will be necessary to keep tests fast
after that lands.
