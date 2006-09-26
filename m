From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Introduce git-mirror, a tool for exactly mirroring another repository.
Date: Tue, 26 Sep 2006 17:57:45 -0400
Message-ID: <20060926215745.GC8177@spearce.org>
References: <20060925044641.GB15757@spearce.org> <7vpsdjtew4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Sep 26 23:58:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSKw9-00037E-G2
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 23:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbWIZV5y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 17:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbWIZV5y
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 17:57:54 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:61392 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932422AbWIZV5x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 17:57:53 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GSKvq-0004Cx-7g; Tue, 26 Sep 2006 17:57:38 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E46D820FB28; Tue, 26 Sep 2006 17:57:45 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vpsdjtew4.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27827>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > Sometimes its handy to be able to efficiently backup or mirror one
> > Git repository to another Git repository by employing the native
> > Git object transfer protocol.  But when mirroring or backing up a
> > repository you really want:
> >
> >   1) Every object in the source to go to the mirror.
> >   2) Every ref in the source to go to the mirror.
> >   3) Any ref removed from the source to be removed from the mirror.
> >   4) Automatically repack and prune the mirror when necessary.
> >
> > and since git-fetch doesn't do 2, 3, and 4 here's a tool that does.
> 
> Just a note.  I usually use git-push the other way for backups,
> and I believe that is how Linus does it, too.

I do the same thing right now but it doesn't get all topic branches
unless I name them on the push line or put them into my remotes
file, and when I delete a topic branch it doesn't remove it from
the remote during the next push...  :-)
 
> > diff --git a/git-mirror.perl b/git-mirror.perl
> > new file mode 100755
> > index 0000000..bff2003
> > --- /dev/null
> > +++ b/git-mirror.perl
> > @@ -0,0 +1,111 @@
> > +#!/usr/bin/env perl
> 
> Please don't.  "#!/usr/bin/env perl" is a disease.

I entirely blame git-svn.perl.  I copied that line from there.
 
> > +# This file is licensed under the GPL v2, or a later version
> > +# at the discretion of Linus.
> 
> Heh ;-).

Yea, I thought you'd get a kick out of that, especially after the
recent discussion. :)

> > +use warnings;
> > +use strict;
> > +use Git;
> > +
> > +sub ls_refs ($$);
> 
> I wonder why people like line-noise prototypes.  Do you ever
> call ls_refs with parameters that benefit from this?  Otherwise
> I prefer not to see them.

Perl is line noise.  I've gotten into the habit of prototyping
most of my functions but clearly this one could be omitted without
any problems.
 
> > +my $remote = shift || 'origin';
> > +my $repo = Git->repository();
> > +
> > +# Verify its OK to execute in this repository.
> > +#
> > +my $mirror_ok = $repo->config('mirror.allowed') || 0;
> > +unless ($mirror_ok =~ /^(?:true|t|yes|y|1)$/i) {
> 
> This _is_ ugly.  Doesn't $repo->config() know how to drive
> underlying "git-repo-config" with specific type argument?

Agreed.  No it doesn't according to Git.pm.  I probably should have
fixed Git.pm first.
 
> > +# Execute the fetch for any refs which differ from our own.
> > +# We don't worry about trying to optimize for rewinds or
> > +# exact branch copies as they are rather uncommon.
> 
> If we need to support only git-native protocols, all of this
> optimization is not needed at all.  It's kind of sad that we
> need to support commit walkers...

Hmm.  I tested this by mirroring a local Git clone ("../git") and
found it was MUCH faster even when only one head was different.
The large number of tags really made it take a lot longer.  And that
was local/local though the native protocols.  I figured it was
worth the few lines of Perl code.
 
> > +if (@to_fetch) {
> > +	git_cmd_try {
> > +		$repo->command_noisy('fetch',
> > +			'--force',
> > +			'--update-head-ok',
> > +			$remote, sort @to_fetch);
> > +	} '%s failed w/ code %d';
> 
> Why sort (no objection, just curious)?

I'm a freak.  I typically don't like things that have a "randomness"
to them.  Since I'm pulling from keys %foo the order I'm getting refs
back in is "unknown" (up to Perl's hash function).  Sorting them
before using them cleans up that randomness.  Although its not
really random here as the hash function is deterministic.

Maybe its because I work with SQL databases all of the time and
you pretty much can't rely on anything coming back in any sort of
order unless you explicitly force it.  So I tend to do the same
with a lot of other systems.

> > +# Repack if we have a large number of loose objects.
> > +#
> > +if (@to_fetch) {
> > +	my $count_output = $repo->command('count-objects');
> > +	my ($cur_loose) = ($count_output =~ /^(\d+) objects/);
> > +	my $max_loose = $repo->config('mirror.maxlooseobjects') || 100;
> > +	if ($cur_loose >= $max_loose) {
> > +		git_cmd_try {
> > +			$repo->command_noisy('repack', '-a', '-d');
> > +			$repo->command_noisy('prune');
> > +		} '%s failed w/ code %d';
> > +	}
> > +}
> 
> If we truly have a large number of objects (in pack and loose),
> you do not want to do "repack -a -d", do you?

Yes.  Because then I want to get your new --unpacked= option
into git-repack.sh.  The -a should then repack all active packs,
omitting the archive packs.  Which are the larger packs that are
costly to repack.

In my opinion mirroring should be a no-brain require activity.
This script is designed for exactly tracking another repository
without any additional intervention from the user.  Carrying a
huge number of loose objects is not ideal, except for maybe the
HTTP commit walker.

-- 
Shawn.
