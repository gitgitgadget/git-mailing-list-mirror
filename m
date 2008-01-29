From: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
Subject: Re: [PATCH] Added sub get_owner_file which checks if there's a
	file with project owner name
Date: Tue, 29 Jan 2008 12:25:50 -0200
Message-ID: <20080129142550.GA25312@c3sl.ufpr.br>
References: <1201577766-11601-1-git-send-email-ribas@c3sl.ufpr.br> <m3lk6898kg.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 15:27:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJrQI-0003Db-Rx
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 15:26:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763330AbYA2OZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 09:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758870AbYA2OZy
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 09:25:54 -0500
Received: from mx.c3sl.ufpr.br ([200.17.202.3]:51287 "EHLO
	urquell.c3sl.ufpr.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753967AbYA2OZw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 09:25:52 -0500
Received: from localhost (unknown [201.21.136.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ribas)
	by urquell.c3sl.ufpr.br (Postfix) with ESMTP id 7D375700003E1;
	Tue, 29 Jan 2008 12:25:50 -0200 (BRST)
Content-Disposition: inline
In-Reply-To: <m3lk6898kg.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71978>

On Tue, Jan 29, 2008 at 03:26:31AM -0800, Jakub Narebski wrote:
> Bruno Ribas <ribas@c3sl.ufpr.br> writes:
> 
> > This file ($projectroot/$project/owner) is good to have when we don't want to
> > maintain a project  list AND when we share same SSH account for all projects,
> > using ssh_acl for example.
> >
> > Signed-off-by: Bruno Ribas <ribas@c3sl.ufpr.br>
> 
> This explanation is a bit too complicated; it explains farther
> reasons, instead of immediate ones: you don't want to maintain project
> list file, and all repository directories have to have the same owner
> (for example when the same SSH account is shared for all projects,
> using ssh_acl to control access instead).

I'm sorry about this complicated explanation.

> 
> Besides with new faster config reader we probably would want to allow
> to use config file to set owner, instead of adding yet another file to
> the repo area; see commit 0e121a2cd42d28bc4034feedf8a13c5a91f85bd3
>   "gitweb: Use config file for repository description and URLs"
> This would have the advantage that you could use system config
> (/etc/gitconfig) to set fallback owner instead of relying on
> filesystem.  I'm not sure what should be the preference, though:
> gitweb.owner, then $GIT_DIR/owner, or vice versa?  I guess that
> reading $GIT_DIR/owner should take preference, as it is needed also
> for projects list page, where ordinary we didn't read individual
> repositories configuration.

Reading $GIT_DIR/owner would be the preference, Maybe it can generate project
list page faster when machine have high IO waits (WA).

Having gitweb.owner is good too, but as you said I don't need to read
individual repositories configuration.

Having another file at the repo area is not a problem (my say). Sometimes
having files appears to be more organized than having everything in one file
(my say again).

I even made another patch about cloneURL, instead of looking for inside files
and stuff, i made gitweb.conf a variable that says:
- If i have a prefix path for HTTP,SSH,GIT[protocol]
Then if this variable is set gitweb only mounts... like
HTTPPREFIX="http://git.c3sl.ufpr.br/pub/scm"
and gitweb sets it to $HTTPREFIX/$project

I made this because I don't want to set each project it's clone URL, so this 
makes thing easier! What do you think?



> 
> I guess that it is meant to be post 1.5.4, isn't it?
> 
> > ---
> >  gitweb/gitweb.perl |   14 ++++++++++++++
> >  1 files changed, 14 insertions(+), 0 deletions(-)
> > 
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index 6256641..fac5f78 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -1754,6 +1754,15 @@ sub git_get_project_list_from_file {
> >  	}
> >  }
> >  
> > +sub get_owner_file {
> > +    my $owner_file = shift;
> 
> Here you use spaces instead of tabs in indent.
> 
> > +
> > +	open my $fd, "$owner_file" or return undef;
> 
> 	open my $fd, $owner_file or return undef;
> 
> would be simpler.
> 
> > +	my $owner = <$fd>;
> > +	close $fd;
> > +	return to_utf8($owner);
> > +}
> 
> I wonder if we should just bite the bullet and replace all such by
> generic subroutine called e.g. read_singleline_file, or something like
> that.  Or perhaps not, if we want to read alternatively from config,
> with different config variable key names and different preferences of
> file/config priority...
> 
> > +
> >  sub git_get_project_owner {
> >  	my $project = shift;
> >  	my $owner;
> > @@ -1767,6 +1776,11 @@ sub git_get_project_owner {
> >  	if (exists $gitweb_project_owner->{$project}) {
> >  		$owner = $gitweb_project_owner->{$project};
> >  	}
> > +
> > +    if ( -f "$projectroot/$project/owner" ) {
> > +        $owner = get_owner_file("$projectroot/$project/owner");
> > +    }
> > +
> 
> Here you use spaces. I think that you can lose spaces around condition
> in the above 'if'.
> 
> >  	if (!defined $owner) {
> >  		$owner = get_file_owner("$projectroot/$project");
> >  	}
> > -- 
> > 1.5.3.8
> 
> I hope that doesn't mean that this patch is based on v1.5.3.8
> gitweb...
> 
> -- 
> Jakub Narebski
> Poland
> ShadeHawk on #git

-- 
Bruno Ribas - ribas@c3sl.ufpr.br
http://web.inf.ufpr.br/ribas
C3SL: http://www.c3sl.ufpr.br 
