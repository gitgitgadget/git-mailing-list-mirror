From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [ANNOUNCE] GIT 1.6.4-rc2
Date: Sat, 25 Jul 2009 12:22:30 -0700
Message-ID: <20090725192230.GA11510@dcvr.yhbt.net>
References: <7vd47r298e.fsf@alter.siamese.dyndns.org> <20090724093847.GA20338@dcvr.yhbt.net> <7vk51ykm42.fsf@alter.siamese.dyndns.org> <20090725103821.GA13534@dcvr.yhbt.net> <1248529164.4593.8.camel@kea>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mattias Nissler <mattias.nissler@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 25 21:22:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUmpO-0003AQ-Eg
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 21:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148AbZGYTWc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 15:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752124AbZGYTWc
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 15:22:32 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:35794 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751522AbZGYTWb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 15:22:31 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 9AD351F78F;
	Sat, 25 Jul 2009 19:22:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1248529164.4593.8.camel@kea>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124059>

Mattias Nissler <mattias.nissler@gmx.de> wrote:
> On Sat, 2009-07-25 at 03:38 -0700, Eric Wong wrote:
> > Junio C Hamano <gitster@pobox.com> wrote:
> > > Eric Wong <normalperson@yhbt.net> writes:
> > > > Junio C Hamano <gitster@pobox.com> wrote:
> > > >>  * git-svn updates, including a new --authors-prog option to map author
> > > >>    names by invoking an external program, 'git svn reset' to unwind
> > > >>    'git svn fetch', support for more than one branches, etc.
> > > >
> > > > I completely forgot the implications of a change made in commit
> > > > 0b2af457a49e3b00d47d556d5301934d27909db8.  This change probably doesn't
> > > > affect a lot of repos out there, but --minimize-url is no longer the
> > > > default for new imports.
> > 
> > > > Let me know if the above made sense, it's late and I nodded off
> > > > several times while writing this.
> > > 
> > > Your description makes sense, and I suspect that the old default may be
> > > easier to work with.
> > 
> > Yes.  I think the old default makes more sense, so I'll be reverting
> > back to it.  However, I'll make it possible to override from the
> > command-line.
> 
> Maybe we should rather try to detect whether we have read access to the
> repository root and adjust behaviour accordingly? Or at least print a
> warning when cloning restricted multi-branch repos, since this just
> fails silently (doesn't pick up any branches) when you have minimize_url
> enabled.

We actually try that in Git::SVN::Ra::minimize_url:

sub minimize_url {
	my ($self) = @_;
	return $self->{url} if ($self->{url} eq $self->{repos_root});
	my $url = $self->{repos_root};
	my @components = split(m!/!, $self->{svn_path});
	my $c = '';
	do {
		$url .= "/$c" if length $c;
		eval { (ref $self)->new($url)->get_latest_revnum };
	} while ($@ && ($c = shift @components));
	$url;
}

Maybe get_latest_revnum() isn't strong enough of a check for
certain setups and get_log() needs to be used instead?

-- 
Eric Wong
