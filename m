From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH 1/2] git-svn: Fix merge detecting with rewrite-root
Date: Sat, 13 Mar 2010 21:44:43 +1300
Message-ID: <1268469883.7841.40.camel@denix>
References: <1267034942-31581-1-git-send-email-tuomas.suutari@gmail.com>
	 <20100226094317.GA22579@dcvr.yhbt.net>
	 <201003130854.24847.tuomas.suutari@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Tuomas Suutari <tuomas.suutari@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 13 09:44:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqMxu-0004Hh-1g
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 09:44:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932847Ab0CMIos (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Mar 2010 03:44:48 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:55203 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755432Ab0CMIor (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Mar 2010 03:44:47 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 2577F21D120; Sat, 13 Mar 2010 21:44:45 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	FH_DATE_PAST_20XX autolearn=no version=3.2.5
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 361E421D118;
	Sat, 13 Mar 2010 21:44:40 +1300 (NZDT)
In-Reply-To: <201003130854.24847.tuomas.suutari@gmail.com>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142092>

I may have been cargo culting nearby similar code blocks; treat it as
suspicious.

The idea with the rewrite_root support is for SVK and/or svnsync; these
first copy revisions to a local repository, which you then point git-svn
at.  I wrote a long piece on this, on this (quite dated now) guide to
converting from SVK to git: of particular relevance is this section:
http://utsl.gen.nz/talks/git-svn/intro.html#howto-fetch-convert

So.  I predict that if this is not done correctly, then any SVK or
svnsync mirrors, when imported via git-svn, will not correctly detect
standard SVN merge attributes present in the original repository.  This
should be relatively easy to construct a test case for, using a similar
style to the t9110, t9111, t9150 and t9151 tests.  ie, make a script
which constructs a repository in the desired format, and then test that
it imports as it should.

That's a lot of work to go through however for a class of users which
may not even exist.  So, in the meantime it may be more appropriate to
go with the simpler approach which does not try to handle this case
correctly, until someone wants to do the above work.

Does that help?
Sam 


On Sat, 2010-03-13 at 08:54 +0200, Tuomas Suutari wrote:
> Hi Sam,
> 
> Could you please provide your feedback on this?
> 
> Thanks!
> 
> On Fri 2010-02-26 11:43:17 Eric Wong wrote:
> > Tuomas Suutari <tuomas.suutari@gmail.com> wrote:
> > > Detecting of merges from svn:mergeinfo or svk merge tickets failed
> > > with rewrite-root option. This fixes it.
> > >
> > > Signed-off-by: Tuomas Suutari <tuomas.suutari@gmail.com>
> > > ---
> > > Hi again,
> > >
> > > now I found another problem while importing SVN repo with git-svn.
> > >
> > > To speed-up the import, I copied the SVN repo with rsync to localhost
> > > and used file:// URL for the import, but because I want to be able to
> > > track the history with svn+ssh:// later, I used the rewrite-root
> > > option. That seemed to break the merge detecting.
> > >
> > > With this patch the merge detecting works also with rewrite-root
> > > option, but since there are no comments why the $self->rewrite_root
> > > was used in the first place, I have no idea, if this is the right
> > > thing to do.
> > 
> > Hi Tuomas,
> > 
> > I'm not sure why rewrite_root is used here, either.  Ignoring it
> > seems correct but I'll wait for Sam to chime in.
> > 
> > >  git-svn.perl |    4 ++--
> > >  1 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/git-svn.perl b/git-svn.perl
> > > index 265852f..1cbddca 100755
> > > --- a/git-svn.perl
> > > +++ b/git-svn.perl
> > > @@ -2993,7 +2993,7 @@ sub find_extra_svk_parents {
> > >  	for my $ticket ( @tickets ) {
> > >  		my ($uuid, $path, $rev) = split /:/, $ticket;
> > >  		if ( $uuid eq $self->ra_uuid ) {
> > > -			my $url = $self->rewrite_root || $self->{url};
> > > +			my $url = $self->{url};
> > >  			my $repos_root = $url;
> > >  			my $branch_from = $path;
> > >  			$branch_from =~ s{^/}{};
> > > @@ -3201,7 +3201,7 @@ sub find_extra_svn_parents {
> > >  	# are now marked as merge, we can add the tip as a parent.
> > >  	my @merges = split "\n", $mergeinfo;
> > >  	my @merge_tips;
> > > -	my $url = $self->rewrite_root || $self->{url};
> > > +	my $url = $self->{url};
> > >  	my $uuid = $self->ra_uuid;
> > >  	my %ranges;
> > >  	for my $merge ( @merges ) {
> > 
