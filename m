From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: teach to create and operate on bare
	repositories
Date: Thu, 23 Apr 2009 11:21:10 -0700
Message-ID: <20090423182110.GA17467@dcvr.yhbt.net>
References: <lGoUDENjg0Z+sDE9v/txzTLyfk8@7qgLKkvX/1U6eu9avhKQpU/1pEI> <20090421180101.GA16642@dcvr.yhbt.net> <qxrtBtZrSZuDTP4eMtsCu+KmGTY@urRFFPz6LpPjhjTBiIOEhMtLGGg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Thu Apr 23 20:22:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx3ZP-0005YE-OQ
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 20:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756409AbZDWSVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 14:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755529AbZDWSVM
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 14:21:12 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:48747 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755323AbZDWSVL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 14:21:11 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16A5F1F602;
	Thu, 23 Apr 2009 18:21:11 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <qxrtBtZrSZuDTP4eMtsCu+KmGTY@urRFFPz6LpPjhjTBiIOEhMtLGGg>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117357>

Eygene Ryabinkin <rea-git@codelabs.ru> wrote:
> Eric, good day.
> 
> Tue, Apr 21, 2009 at 11:01:01AM -0700, Eric Wong wrote:
> > This definitely seems useful.  I'd like a basic test to ensure it
> > continues working in the future.
> 
> No problems, answers inline ;))
> 
> > >  sub cmd_set_tree {
> > >  	my (@commits) = @_;
> > > +
> > > +	get_bareness();
> > > +	if ($_bare) {
> > > +		fatal("'set-tree' isn't supported for bare repositories.");
> > > +	}
> > > +
> > 
> > This repetition with get_bareness() and then checking for $_bare all
> > over the place bothers me a bit.  I'd rather just have something like
> > this:
> > 
> > 	fatal_if_bare('set-tree');
> > 
> > Or even:
> > 
> > 	fatal_if_bare($cmd);
> 
> Done.
> 
> > > +# Initialize bareness flag for an existing repository
> > > +sub get_bareness {
> > > +	return unless -d $ENV{GIT_DIR};
> > > +	my $result = Git::config_bool('core.bare');
> > > +	$result = 0 unless defined($result);
> > > +	$_bare = $result;
> > > +}
> > 
> > Perhaps this function can go into Git.pm since core.bare affects all
> > of git, not just git-svn.  I'd also like to just use something like
> > 
> > 	if (Git::config_bare()) { ... }
> > 
> > ...rather than having to check/initialize a variable every time.
> > 
> > Of course, we can have config caching for platforms that really need
> > it done via Sam's Git::Config module when it gets merged.
> 
> Hmm, for my needs the bare "Git::config_bool('core.bare')" is sufficient,
> so I implanted it everywhere.
> 
> > >  sub extract_metadata {
> > >  	my $id = shift or return (undef, undef, undef);
> > >  	my ($url, $rev, $uuid) = ($id =~ /^\s*git-svn-id:\s+(.*)\@(\d+)
> > > @@ -1527,6 +1588,51 @@ sub parse_revision_argument {
> > >  	die "revision argument: $::_revision not understood by git-svn\n";
> > >  }
> > >  
> > > +#
> > > +# While we are fetching to bare repositories, we should update branch
> > > +# heads manually, because it is not possible to do merges within bare
> > > +# repositories.
> > > +#
> > > +# Arguments:
> > > +# - name of remote branch, for example 'refs/remotes/git-svn';
> > > +# - name of the corresponding local head, for example 'refs/heads/master'.
> > > +#
> > > +sub fast_forward_bare_fetch {
> > > +	return unless defined($_bare);
> > > +	return unless defined($_[0]);
> > > +	return unless defined($_[1]);
> > 
> > Checking for arguments here seems unnecessarily defensive.
> 
> I used to this style, but OK, it was eliminated.
> 
> > 
> > > +	my $remote = $_[0];
> > > +	my $localhead = $_[1];
> > 
> > The general git-svn style is this:
> > 
> > 	my ($remote, $localhead) = @_;
> 
> Fixed.
> 
> > > +	# Update (fast-forward) heads for bare repository.
> > > +	if (defined($_bare)) {
> > > +		foreach my $gs (@gs) {
> > > +			my $remote = 'refs/remotes/' . $gs->{ref_id};
> > > +			my $localhead = 'refs/heads/master';
> > > +			if (open(FH, "<", "HEAD")) {
> > > +				chomp(my $head = <FH>);
> > > +				close FH;
> > > +				if ($head =~ /^ref: (.*)$/) {
> > > +					$localhead = $1;
> > > +				}
> > > +			}
> > 
> > "git rev-parse --symbolic-full-name HEAD" should work better
> > than parsing HEAD ourselves.
> 
> Used it.  The resulting patch is attached.
> 
> I have one question: as you can see from the above hunk, I am using HEAD
> as the tip of all local branches to be fast-forwarded.  It works with
> only one upstream branch, but what if there will be multiple
> (disconnected) remotes we are tracking?  I had seen the words that it it
> possible (in the git-svn man page), but hadn't managed to create such
> repository and figure out how can I deduce the name of the local head
> for the remote one.  Could you, please, enlighten me?

For bare repositories, I would just update all the remotes/*
to heads/* or tags/*.  Perhaps:

	foreach my $gs (@gs) {
		my $remote = 'refs/remotes/' . $gs->{ref_id};
		my $pfx = $gs->{ref_id} =~ m{^tags/} ? 'tags' : 'heads';
		my $localhead = "refs/$pfx/$gs->{ref_id}";
		fast_forward_bare_fetch($remote, $localhead);
	}

I'm not sure what should be done with HEAD, it's been brought up for
discussion once again...

clone/init currently picks the latest modified branch/trunk/tag because:

a) it's the easiest

b) some repositories I tracked did all the work in branches
   so trunk almost always out-of-date.

Also, can you make sure any patches you send actually passes the test
suite (or fix the test suite so it passes)?

Thanks.

-- 
Eric Wong
