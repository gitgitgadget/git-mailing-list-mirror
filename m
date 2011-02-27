From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: Restructure projects list generation
Date: Sun, 27 Feb 2011 16:03:08 +0100
Message-ID: <201102271603.13902.jnareb@gmail.com>
References: <20110226215230.5333.92839.stgit@localhost.localdomain> <20110227100838.GA24919@elie>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, admin@repo.or.cz,
	John Hawley <warthog9@kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 27 16:03:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pti9m-0006ag-9W
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 16:03:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135Ab1B0PD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 10:03:28 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64256 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440Ab1B0PD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Feb 2011 10:03:27 -0500
Received: by wyg36 with SMTP id 36so2939365wyg.19
        for <git@vger.kernel.org>; Sun, 27 Feb 2011 07:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=2A55xCkWeg7/pZ3BcE9HDYoVAIEJ02U1cRMsdedUR/c=;
        b=H12H4NvUAaajSqaJsxYw8Hy7u2fiIKZwZm592AodgiCLy5vjhF/DsWIzvfgKX8obRU
         4UK3gQsFwQFCNlY/CbEIBj+JNZ5x2pLmOcSIzOIIA44CEWNJGx37aSA5D+ikmVv7p4r1
         yzMGhS1stIhSVpBYIzrJUZCLTe9bteaaIljGg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=VBacY5Nb3Dwd2w84f/7e3M6M1SGDMELqT8fHfub0/oPFx6oYXtD3P1AEqRYTJqkoEu
         tW+Bn4K/DWEVCnZuWbQx40LCl06Ar4ZJxhbko/XV1spcGm6/XpKlv5ouqmIXOhIxkCI6
         2+DNIUOAjls9xuXU/nUQzR5MR1R+5ewLkIx84=
Received: by 10.227.145.193 with SMTP id e1mr4025911wbv.110.1298819005650;
        Sun, 27 Feb 2011 07:03:25 -0800 (PST)
Received: from [192.168.1.13] (abvh253.neoplus.adsl.tpnet.pl [83.8.205.253])
        by mx.google.com with ESMTPS id f27sm2468218wbf.7.2011.02.27.07.03.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 Feb 2011 07:03:23 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20110227100838.GA24919@elie>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168035>

On Sun, 27 Feb 2011, Jonathan Nieder wrote:
> Jakub Narebski wrote:
> 
> > Extract filtering out forks (which is done if 'forks' feature is
> > enabled) into filter_forks_from_projects_list subroutine
> 
> Context (to remind myself): the git_get_projects_list function decides
> which repositories to show on the homepage.

Actually it git_get_projects_list generates list of all exported
repositories, whether they are visible in projects list page (homepage)
or not... at least after this change.

Well... list of directories that look like repositories; it is actually
checked further with git_get_last_activity (running actual git command)
in fill_project_list_info if they are really git repositories.

>                                               git_project_list_body 
> takes care of actually showing them in a table; it displays a "+" sign
> in front of projects with forks and generally the project list it is
> passed omits the forks themselves.

Well, forks are hidden (listed on 'forks' pages linked to by those "+"
signs) only if 'forks' feature is enabled.

> 
> git_get_projects_list needs to be reasonably fast, since it is used
> to validate the "project" parameter in every request.

Only with $strict_export set to true (it defaults to false).

> [...]
> > Both are now run _before_ displaying projects, and not while printing;
> > this allow to know upfront if there were any found projects.  Gitweb
> > now can and do print 'No such projects found' if user searches for
> > phrase which does not correspond to any project (any repository).
> 
> Aren't forks filtered out by git-get-projects-list already?

After this commit they are not, and they should not be.  If forks were
filtered out, then with $strict_export you wouldn't be able to access
pages of repositories which are forks.

> [...]
> > Filtering out forks and marking repository (project) as having forks
> > is now consolidated into one subroutine (special case of handling
> > forks in git_get_projects_list only for $projects_list being file is
> > now removed).
> 
> Ah, no, they aren't.  That's a good change for consistency already.
> 
> > Forks handling is also cleaned up and simplified, which
> > might mean some changes in output.
> 
> (Not having read the code yet) this part is not obvious to me.  Maybe
> an example could help.

Well, the commit message is quite large anyway, so I didn't describe in
detailwhat one can read in patch itself...

But see also comment below about algorithm used.

> [...]
> > The interaction between forks, content tags and searching is now made
> > more explicit: searching whether by tag, or via search form turns off
> > fork filtering (gitweb searches also forks, and will show all
> > results).
> 
> Hm, or maybe this is it.
> 
> > IMVHO the code is
> > cleaner.
> 
> So some general code tidying is intermixed.
> 
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -2646,18 +2646,20 @@ sub git_get_projects_list {
> [...]
> > -		my $dir = $projects_list . ($filter ? "/$filter" : '');
> > +		my $dir = $projects_list;
> >  		# remove the trailing "/"
> >  		$dir =~ s!/+$!!;
> > -		my $pfxlen = length("$dir");
> > -		my $pfxdepth = ($dir =~ tr!/!!);
> > +		my $pfxlen = length("$projects_list");
> > +		my $pfxdepth = ($projects_list =~ tr!/!!);
> [...]
> 
> $dir is the same as before except that trailing slashes are removed,
> and meanwhile the stripped names of directories returned from find()
> will include $filter.  Should be almost a no-op (i.e., a nice
> simplification).

Thanks.

This code could be further simplified if not for the fact that at least
theoretically with $projects_list being directory to scan, $projectroot
can be different from $projects_list.

I'll try to resend fixed version soon.

> > @@ -2672,14 +2674,14 @@ sub git_get_projects_list {
> >  				# only directories can be git repositories
> >  				return unless (-d $_);
> >  				# don't traverse too deep (Find is super slow on os x)
> > +				# $project_maxdepth excludes depth of $projectroot
> >  				if (($File::Find::name =~ tr!/!!) - $pfxdepth > $project_maxdepth) {
> 
> A bugfix.  $project_maxdepth is advertised to be relative to the
> projectroot but it was relative to $projects_list/$filter.

I'm not sure if it was advertised in such detail, but I think consistency
is good to have: we don't go beyond some depth regardless whether $filter
is set or not, i.e. whether we are getting list of projects for homepage
('projects_list' action) or for some 'forks' page.

> [...]
> > @@ -2703,32 +2704,9 @@ sub git_get_projects_list {
> >  			if (!defined $path) {
> >  				next;
> >  			}
> > -			if ($filter ne '') {
> > -				# looking for forks;
> > -				my $pfx = substr($path, 0, length($filter));
> > -				if ($pfx ne $filter) {
> > -					next PROJECT;
> > -				}
> > -				my $sfx = substr($path, length($filter));
> > -				if ($sfx !~ /^\/.*\.git$/) {
> > -					next PROJECT;
> > -				}
> [...]
> > +			# if $filter is rpovided, check if $path begins with $filter
> 
> s/rpovided/provided/ :)

I should have run spellchecker...

> > +			if ($filter && $path !~ m!^\Q$filter\E/!) {
> > +				next;
> 
> Why did the code check for \Q.git\E$ before?  If I'm not missing
> something, I'm happy to see the condition go.

This was about looking for forks, which is now moved out of this
subroutine into filter_forks_from_projects_list subroutine.

> What if $filter is 0?  Silly question, I guess.

Not a problem.  \Q and \E are for quoting metacharacters, i.e. treating
$filter as string (as prefix to be matched) rather than as regexp.

> [...]
> > @@ -2745,6 +2721,67 @@ sub git_get_projects_list {
> >  	return @list;
> >  }
> >  
> > +# this assumes that forks follow immediately forked projects:
> > +# [ ..., 'repo.git', 'repo/fork.git', ...]; if not, set second
> > +# parameter to true value to sort projects by path first.
> > +sub filter_forks_from_projects_list {
> > +	my ($projects, $need_sorting) = @_;
> > +
> > +	@$projects = sort { $a->{'path'} cmp $b->{'path'} } @$projects
> > +		if ($need_sorting);
> 
> What happens in this scenario?
> 
> 	git.git
> 	git.related.project.git
> 	git/platforms.git

Thanks for catching this.

It looks like I have oversimplified the algorithm by requiring that 
forked project directly precedes any of its forks (if they exists).
I'd have to redo this part of patch.

> [...]
> > @@ -4747,23 +4784,36 @@ sub fill_project_list_info {
> >  		if (!defined $pr->{'owner'}) {
> >  			$pr->{'owner'} = git_get_project_owner("$pr->{'path'}") || "";
> >  		}
> > -		if ($check_forks) {
> > -			my $pname = $pr->{'path'};
> > -			if (($pname =~ s/\.git$//) &&
> > -			    ($pname !~ /\/$/) &&
> > -			    (-d "$projectroot/$pname")) {
> > -				$pr->{'forks'} = "-d $projectroot/$pname";
> 
> So currently we treat project.git as having forks when the
> corresponding project/ directory exists, even when the latter is
> empty.  The proposed new rule is that project.git has forks if and
> only if there is at least one project/foo.git repository.  Sensible.

Actually it is marked as having 0 forks, which visually results in "+"
sign which is not a hyperlink to 'forks' view.

Though I am not sure if it is worth it: without mentioned feature code
would be slightly simpler.


Note also that previous code put _string_ into 'forks' field, with
contents "-d <path to project>", instead of 1 as one might expect.

Earlier code contained a few leftover debugging things; I am not sure
if I have removed everything, at least wrt. projects list.

> Hope that helps,

Thanks again for your comments.

-- 
Jakub Narebski
Poland
