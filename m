From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] cvsexportcommit: Create config option for CVS dir
Date: Wed, 21 May 2008 22:01:15 +0200
Message-ID: <200805212201.16080.robin.rosenberg.lists@dewire.com>
References: <1210282015-20872-1-git-send-email-tpiepho@freescale.com> <7vprrf1lmd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Trent Piepho <tpiepho@freescale.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 21 22:04:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyuXY-0000Lh-57
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 22:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755334AbYEUUDE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 16:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754367AbYEUUDD
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 16:03:03 -0400
Received: from av8-2-sn3.vrr.skanova.net ([81.228.9.184]:45729 "EHLO
	av8-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754047AbYEUUDB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 16:03:01 -0400
X-Greylist: delayed 1310 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 May 2008 16:03:00 EDT
Received: by av8-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id CC02037F83; Wed, 21 May 2008 22:02:58 +0200 (CEST)
Received: from smtp3-2-sn3.vrr.skanova.net (smtp3-2-sn3.vrr.skanova.net [81.228.9.102])
	by av8-2-sn3.vrr.skanova.net (Postfix) with ESMTP
	id B623E37ECA; Wed, 21 May 2008 22:02:58 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-2-sn3.vrr.skanova.net (Postfix) with ESMTP id 6F67437E50;
	Wed, 21 May 2008 22:02:57 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vprrf1lmd.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82577>

onsdagen den 21 maj 2008 21.51.38 skrev Junio C Hamano:
> Last night I was going through old mail-logs and found this, which I think
> would be nice.  Does anybody see anything wrong with the patch?

No, this looks reallu useful. Ack.

-- robin

> 
> Trent Piepho <tpiepho@freescale.com> writes:
> 
> > For a given project the directory used with the -w option is almost always
> > the same each time.  Let it be specified with 'cvsexportcommit.cvsdir' so
> > it's not necessary to manually add it with -w each time.
> >
> > Signed-off-by: Trent Piepho <tpiepho@freescale.com>
> > ---
> >  Documentation/git-cvsexportcommit.txt |    8 +++++++-
> >  git-cvsexportcommit.perl              |    5 +++++
> >  2 files changed, 12 insertions(+), 1 deletions(-)
> >
> > diff --git a/Documentation/git-cvsexportcommit.txt b/Documentation/git-cvsexportcommit.txt
> > index 9a47b4c..363c36d 100644
> > --- a/Documentation/git-cvsexportcommit.txt
> > +++ b/Documentation/git-cvsexportcommit.txt
> > @@ -65,11 +65,17 @@ OPTIONS
> >  -w::
> >  	Specify the location of the CVS checkout to use for the export. This
> >  	option does not require GIT_DIR to be set before execution if the
> > -	current directory is within a git repository.
> > +	current directory is within a git repository.  The default is the
> > +	value of 'cvsexportcommit.cvsdir'.
> >  
> >  -v::
> >  	Verbose.
> >  
> > +CONFIGURATION
> > +-------------
> > +cvsexportcommit.cvsdir::
> > +	The default location of the CVS checkout to use for the export.
> > +
> >  EXAMPLES
> >  --------
> >  
> > diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
> > index b6036bd..c93bd9c 100755
> > --- a/git-cvsexportcommit.perl
> > +++ b/git-cvsexportcommit.perl
> > @@ -6,6 +6,7 @@ use File::Temp qw(tempdir);
> >  use Data::Dumper;
> >  use File::Basename qw(basename dirname);
> >  use File::Spec;
> > +use Git;
> >  
> >  our ($opt_h, $opt_P, $opt_p, $opt_v, $opt_c, $opt_f, $opt_a, $opt_m, $opt_d, $opt_u, $opt_w);
> >  
> > @@ -15,6 +16,10 @@ $opt_h && usage();
> >  
> >  die "Need at least one commit identifier!" unless @ARGV;
> >  
> > +# Get git-config settings
> > +my $repo = Git->repository();
> > +$opt_w = $repo->config('cvsexportcommit.cvsdir') unless defined $opt_w;
> > +
> >  if ($opt_w) {
> >  	# Remember where GIT_DIR is before changing to CVS checkout
> >  	unless ($ENV{GIT_DIR}) {
> > -- 
> > 1.5.4.1
>
