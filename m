From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] [RFC] Introduce Git.pm
Date: Thu, 22 Jun 2006 21:37:48 +0200
Message-ID: <20060622193748.GD21864@pasky.or.cz>
References: <20060622003546.17760.23089.stgit@machine.or.cz> <20060622023104.GB27871@hand.yhbt.net> <20060622003546.17760.23089.stgit@machine.or.cz> <7v64iuxard.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 21:37:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtUzx-0003aN-UO
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 21:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWFVThu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 15:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751896AbWFVThu
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 15:37:50 -0400
Received: from w241.dkm.cz ([62.24.88.241]:62594 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751536AbWFVThu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 15:37:50 -0400
Received: (qmail 31226 invoked by uid 2001); 22 Jun 2006 21:37:48 +0200
To: Junio C Hamano <junkio@cox.net>, Eric Wong <normalperson@yhbt.net>
Content-Disposition: inline
In-Reply-To: <20060622023104.GB27871@hand.yhbt.net> <7v64iuxard.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22360>

Dear diary, on Thu, Jun 22, 2006 at 03:03:02AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > Currently Git.pm just wraps up exec()s of Git commands, but even that
> > is not trivial to get right and various Git perl scripts do it in
> > various inconsistent ways. And things will get much more interesting
> > when we get to XS-izing libgit.
> 
> We would probably need some moderate to major surgery before
> doing that depending on which parts.  Worrisome are object layer
> that holds onto parsed objects and keeps flag bits from the
> previous runs, and lockfile that are cleaned up via atexit() --
> there may be others.

Yes, I'm aware of that. Still, some parts should be quite easy...

Dear diary, on Thu, Jun 22, 2006 at 04:31:05AM CEST, I got a letter
where Eric Wong <normalperson@yhbt.net> said that...
> XS-ising libgit would be awesome with all the git-hash-object calls in
> git-svn (and other importers, too, I imagine).

...so I couldn't resist that and did add hash_object() xs-ized
function. Looks pretty sweet:

$ time perl -w -I/home/xpasky/lib/perl5/site_perl/5.8.8 -MGit -le 'print Git::generic_oneline("hash-object", "Makefile") for (1..1000)' >/dev/null

real    0m4.800s
user    0m2.072s
sys     0m2.560s

$ time perl -w -I/home/xpasky/lib/perl5/site_perl/5.8.8 -MGit -le 'print Git::hash_object("Makefile") for (1..1000)' >/dev/null

real    0m0.179s
user    0m0.144s
sys     0m0.032s


Dear diary, on Thu, Jun 22, 2006 at 03:03:02AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> > @@ -618,6 +622,7 @@ GIT-CFLAGS: .FORCE-GIT-CFLAGS
> >  	@FLAGS='$(TRACK_CFLAGS)'; \
> >  	    if test x"$$FLAGS" != x"`cat GIT-CFLAGS 2>/dev/null`" ; then \
> >  		echo 1>&2 "    * new build flags or prefix"; \
> > +		echo 1>&2 "    * $$FLAGS != `cat GIT-CFLAGS 2>/dev/null`"; \
> >  		echo "$$FLAGS" >GIT-CFLAGS; \
> >              fi
> >  
> 
> Offtopic; do people mind if we drop $GIT_VERSION from
> TRACK_CFLAGS?  Every time I switch branches or make a new commit
> it ends up rebuilding everything needlessly.

Please, please, _do_! :-)

I'm sorry about this hunk, I added it to just figure out why the heck it
keeps rebuilding everything from scratch and forgot to drop it.

> >  sub current_branch {
> > -	my ($bra) = qx{git-symbolic-ref HEAD};
> > +	my ($bra) = $repo->generic_oneline('symbolic-ref', 'HEAD');
> >  	chomp($bra);
> >  	$bra =~ s|^refs/heads/||;
> >  	if ($bra ne 'master') {
> 
> Your *_oneline chomps so chomp($bra) is not needed anymore, I think.

Ah, thanks.

> > +require Exporter;
> 
> Not "use"?

The idiom is to require, I guess; we don't need to import anything.
I don't think it matters and I'm not entirely sure about all the
implications of the difference between the two, so if you wish,
I can change it.

> > +# Methods which can be called as standalone functions as well:
> > +@EXPORT_OK = qw(generic generic_oneval generic_vocal);
> 
> I am not sure generic_xxx is a good name.  Perhaps command_xxx?

Technically, other methods can be commands, too. ;-) But yet, it sounds
better. I've changed it.

> Also as you say in the comment, "vocal" sounds a bit funny.
> I wonder if we can use wantarray to detect the case where the
> caller wants _no_ value, and do the "not piping" optimization in
> that case.

I think that would be rather confusing since generic_vocal does not make
the output go away but makes it go to stdout, while if you just throw
away return value of generic(), you expect it to go nowhere.

At least I will change 'vocal' to 'noisy' so that it does not sound
so weird.


Dear diary, on Thu, Jun 22, 2006 at 04:31:05AM CEST, I got a letter
where Eric Wong <normalperson@yhbt.net> said that...
> Petr Baudis <pasky@suse.cz> wrote:
> > +	my $pid = open(my $fh, "-|");
> > +	if ($pid < 0) {
> > +		die "generic($cmd, @args) open: $!";
> 
> In Perl, fork returns undef instead of $pid < 0 on failure.

Thanks!

> Doing join(' ',@args) will also make the error message more readable, too :)

@args should get automagically interpolated by having the members
separated by $" (space by default).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
