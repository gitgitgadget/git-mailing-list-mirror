From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [git-svn PATCH] Add --no-rebase option to git-svn dcommit
Date: Fri, 4 May 2007 01:04:24 -0700
Message-ID: <20070504080424.GA30555@muzzle>
References: <20070503054749.20115.53805.stgit@yoghurt> <20070504075908.GB17526@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri May 04 10:32:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjtDA-0002qL-NU
	for gcvg-git@gmane.org; Fri, 04 May 2007 10:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932659AbXEDIcR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 4 May 2007 04:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932785AbXEDIcR
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 04:32:17 -0400
Received: from hand.yhbt.net ([66.150.188.102]:37676 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932659AbXEDIcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 04:32:16 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 0B0E77DC0A0;
	Fri,  4 May 2007 01:04:25 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 04 May 2007 01:04:24 -0700
Content-Disposition: inline
In-Reply-To: <20070504075908.GB17526@muzzle>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46145>

Eric Wong <normalperson@yhbt.net> wrote:
> Karl Hasselstr=F6m <kha@treskal.com> wrote:
> > git-svn dcommit exports commits to Subversion, then imports them ba=
ck
> > to git again, and last but not least rebases or resets HEAD to the
> > last of the new commits. I guess this rebasing is convenient when
> > using just git, but when the commits to be exported are managed by
> > StGIT, it's really annoying. So add an option to disable this
> > behavior. And document it, too!
>=20
> Cool, I've been planning to add this myself, too.
>=20
> Acked-by: Eric Wong <normalperson@yhbt.net>
>=20
> > Signed-off-by: Karl Hasselstr=F6m <kha@treskal.com>
> > ---
> >=20
> > Arguably, the switch should be --rebase instead, and default to not
> > rebase. But that would change the existing behavior, and possibly m=
ake
> > dcommit less convenient to use for at least the person who implemen=
ted
> > the existing behavior. Opinions?

Erm, sorry, I skipped over this part.  No. I like rebase being the
default behavior.

> >  Documentation/git-svn.txt |    3 +++
> >  git-svn.perl              |   33 ++++++++++++++++++---------------
> >  2 files changed, 21 insertions(+), 15 deletions(-)
> >=20
> > diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> > index 62d7ef8..fcdeeaa 100644
> > --- a/Documentation/git-svn.txt
> > +++ b/Documentation/git-svn.txt
> > @@ -125,6 +125,9 @@ and have no uncommitted changes.
> >  	alternative to HEAD.
> >  	This is advantageous over 'set-tree' (below) because it produces
> >  	cleaner, more linear history.
> > ++
> > +--no-rebase;;
> > +	After committing, do not rebase or reset.
> >  --
> > =20
> >  'log'::
> > diff --git a/git-svn.perl b/git-svn.perl
> > index 6657e10..3c4f490 100755
> > --- a/git-svn.perl
> > +++ b/git-svn.perl
> > @@ -55,7 +55,7 @@ $sha1_short =3D qr/[a-f\d]{4,40}/;
> >  my ($_stdin, $_help, $_edit,
> >  	$_message, $_file,
> >  	$_template, $_shared,
> > -	$_version, $_fetch_all,
> > +	$_version, $_fetch_all, $_no_rebase,
> >  	$_merge, $_strategy, $_dry_run, $_local,
> >  	$_prefix, $_no_checkout, $_verbose);
> >  $Git::SVN::_follow_parent =3D 1;
> > @@ -114,6 +114,7 @@ my %cmd =3D (
> >  			  'verbose|v' =3D> \$_verbose,
> >  			  'dry-run|n' =3D> \$_dry_run,
> >  			  'fetch-all|all' =3D> \$_fetch_all,
> > +			  'no-rebase' =3D> \$_no_rebase,
> >  			%cmt_opts, %fc_opts } ],
> >  	'set-tree' =3D> [ \&cmd_set_tree,
> >  	                "Set an SVN repository to a git tree-ish",
> > @@ -413,21 +414,23 @@ sub cmd_dcommit {
> >  		return;
> >  	}
> >  	$_fetch_all ? $gs->fetch_all : $gs->fetch;
> > -	# we always want to rebase against the current HEAD, not any
> > -	# head that was passed to us
> > -	my @diff =3D command('diff-tree', 'HEAD', $gs->refname, '--');
> > -	my @finish;
> > -	if (@diff) {
> > -		@finish =3D rebase_cmd();
> > -		print STDERR "W: HEAD and ", $gs->refname, " differ, ",
> > -		             "using @finish:\n", "@diff";
> > -	} else {
> > -		print "No changes between current HEAD and ",
> > -		      $gs->refname, "\nResetting to the latest ",
> > -		      $gs->refname, "\n";
> > -		@finish =3D qw/reset --mixed/;
> > +	unless ($_no_rebase) {
> > +		# we always want to rebase against the current HEAD, not any
> > +		# head that was passed to us
> > +		my @diff =3D command('diff-tree', 'HEAD', $gs->refname, '--');
> > +		my @finish;
> > +		if (@diff) {
> > +			@finish =3D rebase_cmd();
> > +			print STDERR "W: HEAD and ", $gs->refname, " differ, ",
> > +				     "using @finish:\n", "@diff";
> > +		} else {
> > +			print "No changes between current HEAD and ",
> > +			      $gs->refname, "\nResetting to the latest ",
> > +			      $gs->refname, "\n";
> > +			@finish =3D qw/reset --mixed/;
> > +		}
> > +		command_noisy(@finish, $gs->refname);
> >  	}
> > -	command_noisy(@finish, $gs->refname);
> >  }
> > =20
> >  sub cmd_find_rev {

--=20
Eric Wong
