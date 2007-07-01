From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: cache max revision in rev_db databases
Date: Sat, 30 Jun 2007 22:31:56 -0700
Message-ID: <20070701053114.GA1787@muzzle>
References: <7vfy48940k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 01 07:32:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4s2c-0000O5-CS
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 07:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756017AbXGAFcG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 01:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755918AbXGAFcF
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 01:32:05 -0400
Received: from hand.yhbt.net ([66.150.188.102]:42924 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756017AbXGAFb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 01:31:58 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 5427C2DC032;
	Sat, 30 Jun 2007 22:31:56 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 30 Jun 2007 22:31:56 -0700
Content-Disposition: inline
In-Reply-To: <7vfy48940k.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51275>

Junio C Hamano <gitster@pobox.com> wrote:
> Sam Vilain <sam.vilain@catalyst.net.nz> writes:
> 
> > Cache the maximum revision for each rev_db URL rather than looking it
> > up each time.  This saves a lot of time when rebuilding indexes on a
> > freshly cloned repository.
> >
> > Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
> 
> I think both the previous one from Sam that makes it use git-log
> instead of git-rev-list and this one looks sane.  Ack/Nack is
> appreciated.

Now that 80583c0ef61cc966c7eee79cf3623a83197e19b8 is in, both patches
are:

Acked-by: Eric Wong <normalperson@yhbt.net>

> > ---
> >  git-svn.perl |    4 ++++
> >  1 files changed, 4 insertions(+), 0 deletions(-)
> >
> > diff --git a/git-svn.perl b/git-svn.perl
> > index 556cd7d..a8b6669 100755
> > --- a/git-svn.perl
> > +++ b/git-svn.perl
> > @@ -801,6 +801,7 @@ sub working_head_info {
> >  	my ($head, $refs) = @_;
> >  	my ($fh, $ctx) = command_output_pipe('log', $head);
> >  	my $hash;
> > +	my %max;
> >  	while (<$fh>) {
> >  		if ( m{^commit ($::sha1)$} ) {
> >  			unshift @$refs, $hash if $hash and $refs;
> > @@ -810,11 +811,14 @@ sub working_head_info {
> >  		next unless s{^\s*(git-svn-id:)}{$1};
> >  		my ($url, $rev, $uuid) = extract_metadata($_);
> >  		if (defined $url && defined $rev) {
> > +			next if $max{$url} and $max{$url} < $rev;
> >  			if (my $gs = Git::SVN->find_by_url($url)) {
> >  				my $c = $gs->rev_db_get($rev);
> >  				if ($c && $c eq $hash) {
> >  					close $fh; # break the pipe
> >  					return ($url, $rev, $uuid, $gs);
> > +				} else {
> > +					$max{$url} ||= $gs->rev_db_max;
> >  				}
> >  			}
> >  		}
> > -- 
> > 1.5.2.1.1131.g3b90
> 

-- 
Eric Wong
