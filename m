Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89F4C433EF
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 21:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241044AbiBGVe2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 16:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbiBGVe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 16:34:26 -0500
X-Greylist: delayed 421 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 13:34:25 PST
Received: from dcvr.yhbt.net (dcvr.yhbt.net [64.71.152.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AA7C061355
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 13:34:25 -0800 (PST)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 73CFD1F852;
        Mon,  7 Feb 2022 21:27:24 +0000 (UTC)
Date:   Mon, 7 Feb 2022 21:27:24 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <stolee@gmail.com>, meta@public-inbox.org
Subject: Re: Using public-inbox+lei+Emacs+mu+mu4e (was: Large delays in
 mailing list delivery?)
Message-ID: <20220207212724.GA9233@dcvr>
References: <CABPp-BF_xsOpQ6GSaWs9u9JcnPQT_OXP-gCsAuxPtMj-X1tgOg@mail.gmail.com>
 <211203.86sfv9qwdm.gmgdl@evledraar.gmail.com>
 <20211203202427.o575sgrx4auqkmjp@meerkat.local>
 <211206.867dchr9nt.gmgdl@evledraar.gmail.com>
 <20211206163626.GA4714@dcvr>
 <220202.86leyt8uly.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220202.86leyt8uly.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Mon, Dec 06 2021, Eric Wong wrote:
> > Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> >> On Fri, Dec 03 2021, Konstantin Ryabitsev wrote:
> >> 
> >> > On Fri, Dec 03, 2021 at 09:02:48PM +0100, Ævar Arnfjörð Bjarmason wrote:
> >> >> When I've experienced delays (sometimes of half a day or more) both
> >> >> https://public-inbox.org/git/ and https://lore.kernel.org/git/ have been
> >> >> updated.
> >> >
> >> > Btw, you can source lore.kernel.org straight into your gmail inbox. :)
> >> >
> >> >     https://people.kernel.org/monsieuricon/lore-lei-part-1-getting-started
> >> >     https://people.kernel.org/monsieuricon/lore-lei-part-2-now-with-imap
> >> >
> >> > Or, you can read it via nntp://nntp.lore.kernel.org/.
> >> 
> >> [CC'd meta@public-inbox.org, probably best to move this thread over
> >> there sooner than later, but CC'ing git@ still in case this is
> >> interesting to others]
> >> 
> >> I poked a bit at setting this up but couldn't find from building
> >> public-inbox.org & trying to page through the docs how I'd get from an
> >> existing public-inbox.org/git/ checkout to a local Maildir.
> >
> > Existing, public-inboxes can be set as "externals" and managed
> > via {add,forget,ls}-external sub-commands:
> >
> > 	# for locally-cloned inboxes:
> > 	public-inbox-index /path/to/existing/inbox
> > 	lei add-external /path/to/existing/inbox
> >
> > 	# relies on curl, memoizes data downloaded for each search:
> > 	lei add-external https://yhbt.net/lore/git
> >
> > Local externals will be included by every "lei q" invocation;
> > HTTP(S) ones require "lei q --remote"
> >
> > If you only want to use an external as a one-off without adding
> > it, the -I/--include and -O/--only flags are useful:
> >
> >   lei q -O https://yhbt.net/lore/git -o /tmp/results SEARCH_TERMS
> >
> >> If you could share some recipe or a pointer to the right docs for that
> >> that would be much appreciated. Thanks!
> >
> > lei-overview(7) manpage documents some things, at least:
> > https://public-inbox.org/lei-overview.html  Patches welcome :>
> >
> > IMHO lei still kinda sucks, and I probably won't have time to
> > work on it for a bit :<
> 
> Thanks. I finally got around to setting this up.
> 
> The above instructions didn't quite work for me, but here's what I did
> (in the form of a script lifted from a screen(1) config I've
> got). Indented with un-indented comments. The "stuff" is screen's way of
> "run this command" (or well, input these characters):
> 
> I had a ~/g/git-ml clone already, but this makes one:
>     
>     stuff "cd ~/g/git-ml || git clone https://public-inbox.org/git ~/g/git-ml^M"

Wait, lack of --mirror or --bare for git-clone on any
public-inbox is a big mistake in terms of inode+disk use

> The initial index:
> 
>     ## This will create a .git/publici-inbox in ~/g/git-ml. Takes a while
>     ## the first time.
>     stuff "time public-inbox-index -v \$PWD^M"
> 
> I fiddled with this for a bit because it refused to work, turns out it
> was missing the .git at the end, i.e. it expected a bare repo[1]:
> 
>     ## When we add the lei external it *must* have the ".git" part,
>     ## because it'll try to find the "public-inbox" folder at wherever we
>     ## point it.
>     stuff "test -d ~/.config/lei || lei add-external ~/g/git-ml/.git^M"

Yeah, public-inbox has never supported non-bare usage.

> A bit of a UX wart not to be able to specify no --limit, or maybe I'm
> missing a way:
> 
>     ## The one-off massive import of the Git ML. TODO: No way to specify
>     ## an infinite limit? Not --no-limit or --limit=0.
>     stuff "test -d ~/Maildir/lei-q-git-ml || time lei q --limit=999999999 -v -o ~/Maildir/lei-q-git-ml l:git.vger.kernel.org^M"

Oops.  --no-limit or --limit=0 or --limit=-1 support will be
added at some point...

> The initial indexing:
> 
>     ## After the one-off import this will take forever *the first time*
>     ## (or around 20m), but subsequent invocations will be fast:
>     stuff "time lei up ~/Maildir/lei-q-git-ml^M"
> 
> Runs an ad-hoc script to keep it up-to-date, which is quoted below:
> 
>     ## Run it in a loop
>     stuff "public-inbox-lei-pull-index^M"
> 
> That script (which I whipped up just now. Is there a better/more
> standard way? to keep a public-inbox+lei pair up-to-date with
> sleep/backoff etc?

Not yet, unfortunately.  I would like to have some sort of
long-polling support (similar to IDLE in IMAP) because I hate
sleep/backoff.  But I don't think I'm physically nor mentally
capable of doing that or much of anything, anymore.

> 	#!/bin/sh
> 	set -xe
> 	
> 	repo=~/g/git-ml
> 	while true
> 	do
> 		oid=$(git -C $repo rev-parse HEAD)
> 		git -C $repo pull
> 		noid=$(git -C $repo rev-parse HEAD)
> 		if test "$oid" = "$noid"
> 		then
> 			echo Nothing to update
> 			sleep 60
> 			continue
> 		fi
> 		(
> 			cd $repo &&
> 			public-inbox-index -v "$PWD"
> 		)
> 		lei up ~/Maildir/lei-q-git-ml
> 		sleep 1
> 	done
> 
> I use Emacs+mu4e for my E-Mail. And since I index ~/Maildir having these
> files dropped in there will be added to its index. Then I just changed
> my saved search to also look through that maildir (I guess the entire
> first condition could be dropped, but whatever):
> 
>     "(maildir:/personal-gmail/* OR maildir:/lei-q-git-ml/*) AND list:git.vger.kernel.org OR recip:git@vger.kernel.org OR recip:git-packagers@googlegroups.com"
> 
> Because "mu" is generally good about de-duplicating stuff I've now got
> an inbox with mixed messages I can sync from GMail (including my "Sent"
> folder), and I get up-to-the-minute ML traffic now (it's bee 10hrs-4day
> delayed for 3-4 months at least).
> 
> So new messages are generally from the "lei" directory, but when I send
> one it'll be dropped in the personal-gmail.
> 
> I still need to check if it's doing the wrong thing with e.g. "read"
> flags if I read a mail synced via lei that later arrives in GMail. But I
> mostly don't use "read" statuses anyway...

lei can export flags from its internal DBs to IMAP via "lei export-kw"
see lei-mail-sync-overview(7) for some details, but usability is still
rough...

> 1.  Maybe this "I only tested if it complied" patch would make sense to catch that?
> 
> diff --git a/lib/PublicInbox/LeiXSearch.pm b/lib/PublicInbox/LeiXSearch.pm
> index 2958d3f9..be49621f 100644
> --- a/lib/PublicInbox/LeiXSearch.pm
> +++ b/lib/PublicInbox/LeiXSearch.pm
> @@ -613,7 +613,7 @@ sub add_uri {
>  	}
>  }
>  
> -sub prepare_external {
> +sub _prepare_external {
>  	my ($self, $loc, $boost) = @_; # n.b. already ordered by boost
>  	if (ref $loc) { # already a URI, or PublicInbox::Inbox-like object
>  		return add_uri($self, $loc) if $loc->can('scheme');
> @@ -638,6 +638,14 @@ sub prepare_external {
>  	push @{$self->{locals}}, $loc;
>  }
>  
> +sub prepare_external {
> +	my ($self, $loc, $boost) = @_;
> +	my $ret = _prepare_external($self, $loc, $boost);
> +	warn "W: we got nothing from $loc, did you mean $loc/.git?"
> +		if !$ret && -e "$loc/.git";
> +	return $ret;
> +}

Probably add a note saying non-bare repos are a terrible idea,
anyways, especially for v1 public-inboxes like public-inbox.org/git
