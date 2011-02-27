From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: Restructure projects list generation
Date: Sun, 27 Feb 2011 04:08:38 -0600
Message-ID: <20110227100838.GA24919@elie>
References: <20110226215230.5333.92839.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, admin@repo.or.cz,
	John Hawley <warthog9@kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 27 11:08:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtdYd-0003Pd-Aa
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 11:08:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964Ab1B0KIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 05:08:50 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:33274 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937Ab1B0KIt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Feb 2011 05:08:49 -0500
Received: by vxi39 with SMTP id 39so2452579vxi.19
        for <git@vger.kernel.org>; Sun, 27 Feb 2011 02:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=KyrZnlbFh0Rkeq+hYYWBant7FceNiggHay0PlbcIfRA=;
        b=JWgz1jA/+PkTqZ8E48mDmaAQcoqUNKwBMiKk5kbSBGhZcphlbuOnY0rNqHcr10WW6B
         Z5WbQvHJjeS61ouOrZwyy2JdTy9jpo8qLQN9mApFawpT7IICu1uWZs+2NbCovQ4mD7rZ
         nz2mojiUz3Di+0EyIOhsn5Om51B0VTei7VtRg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=lpEOF6ftRgLTlGIEz6cwzeFLrVX1Oic0zqzJuU7J5UEPyT05t4CUZ6NtowfRy2lK4K
         Bpp2RDs2kZ8JlykRgxBXEbkype66tbLRlHfYS0NqPoTn1BUmUNxURsB58hOFXwU5mI/h
         vnKEByp/eJUeGHrKgpSBPex4f60tYljn0icow=
Received: by 10.52.89.140 with SMTP id bo12mr3900847vdb.142.1298801328257;
        Sun, 27 Feb 2011 02:08:48 -0800 (PST)
Received: from elie (adsl-76-206-235-173.dsl.chcgil.sbcglobal.net [76.206.235.173])
        by mx.google.com with ESMTPS id e20sm1828010vbz.8.2011.02.27.02.08.45
        (version=SSLv3 cipher=OTHER);
        Sun, 27 Feb 2011 02:08:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110226215230.5333.92839.stgit@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168019>

Hi,

Jakub Narebski wrote:

> Extract filtering out forks (which is done if 'forks' feature is
> enabled) into filter_forks_from_projects_list subroutine

Context (to remind myself): the git_get_projects_list function decides
which repositories to show on the homepage.  git_project_list_body
takes care of actually showing them in a table; it displays a "+" sign
in front of projects with forks and generally the project list it is
passed omits the forks themselves.

git_get_projects_list needs to be reasonably fast, since it is used
to validate the "project" parameter in every request.

[...]
> Both are now run _before_ displaying projects, and not while printing;
> this allow to know upfront if there were any found projects.  Gitweb
> now can and do print 'No such projects found' if user searches for
> phrase which does not correspond to any project (any repository).

Aren't forks filtered out by git-get-projects-list already?

[...]
> Filtering out forks and marking repository (project) as having forks
> is now consolidated into one subroutine (special case of handling
> forks in git_get_projects_list only for $projects_list being file is
> now removed).

Ah, no, they aren't.  That's a good change for consistency already.

> Forks handling is also cleaned up and simplified, which
> might mean some changes in output.

(Not having read the code yet) this part is not obvious to me.  Maybe
an example could help.

[...]
> The interaction between forks, content tags and searching is now made
> more explicit: searching whether by tag, or via search form turns off
> fork filtering (gitweb searches also forks, and will show all
> results).

Hm, or maybe this is it.

> IMVHO the code is
> cleaner.

So some general code tidying is intermixed.

> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2646,18 +2646,20 @@ sub git_get_projects_list {
[...]
> -		my $dir = $projects_list . ($filter ? "/$filter" : '');
> +		my $dir = $projects_list;
>  		# remove the trailing "/"
>  		$dir =~ s!/+$!!;
> -		my $pfxlen = length("$dir");
> -		my $pfxdepth = ($dir =~ tr!/!!);
> +		my $pfxlen = length("$projects_list");
> +		my $pfxdepth = ($projects_list =~ tr!/!!);
[...]

$dir is the same as before except that trailing slashes are removed,
and meanwhile the stripped names of directories returned from find()
will include $filter.  Should be almost a no-op (i.e., a nice
simplification).

> @@ -2672,14 +2674,14 @@ sub git_get_projects_list {
>  				# only directories can be git repositories
>  				return unless (-d $_);
>  				# don't traverse too deep (Find is super slow on os x)
> +				# $project_maxdepth excludes depth of $projectroot
>  				if (($File::Find::name =~ tr!/!!) - $pfxdepth > $project_maxdepth) {

A bugfix.  $project_maxdepth is advertised to be relative to the
projectroot but it was relative to $projects_list/$filter.

[...]
> @@ -2703,32 +2704,9 @@ sub git_get_projects_list {
>  			if (!defined $path) {
>  				next;
>  			}
> -			if ($filter ne '') {
> -				# looking for forks;
> -				my $pfx = substr($path, 0, length($filter));
> -				if ($pfx ne $filter) {
> -					next PROJECT;
> -				}
> -				my $sfx = substr($path, length($filter));
> -				if ($sfx !~ /^\/.*\.git$/) {
> -					next PROJECT;
> -				}
[...]
> +			# if $filter is rpovided, check if $path begins with $filter

s/rpovided/provided/ :)

> +			if ($filter && $path !~ m!^\Q$filter\E/!) {
> +				next;

Why did the code check for \Q.git\E$ before?  If I'm not missing
something, I'm happy to see the condition go.

What if $filter is 0?  Silly question, I guess.

[...]
> @@ -2745,6 +2721,67 @@ sub git_get_projects_list {
>  	return @list;
>  }
>  
> +# this assumes that forks follow immediately forked projects:
> +# [ ..., 'repo.git', 'repo/fork.git', ...]; if not, set second
> +# parameter to true value to sort projects by path first.
> +sub filter_forks_from_projects_list {
> +	my ($projects, $need_sorting) = @_;
> +
> +	@$projects = sort { $a->{'path'} cmp $b->{'path'} } @$projects
> +		if ($need_sorting);

What happens in this scenario?

	git.git
	git.related.project.git
	git/platforms.git

[...]
> @@ -4747,23 +4784,36 @@ sub fill_project_list_info {
>  		if (!defined $pr->{'owner'}) {
>  			$pr->{'owner'} = git_get_project_owner("$pr->{'path'}") || "";
>  		}
> -		if ($check_forks) {
> -			my $pname = $pr->{'path'};
> -			if (($pname =~ s/\.git$//) &&
> -			    ($pname !~ /\/$/) &&
> -			    (-d "$projectroot/$pname")) {
> -				$pr->{'forks'} = "-d $projectroot/$pname";

So currently we treat project.git as having forks when the
corresponding project/ directory exists, even when the latter is
empty.  The proposed new rule is that project.git has forks if and
only if there is at least one project/foo.git repository.  Sensible.

Thanks for a pleasant read.

Hope that helps,
Jonathan
