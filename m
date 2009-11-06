From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: [PATCH] gitweb: Refactor project list routines
Date: Fri, 06 Nov 2009 10:56:02 -0800
Message-ID: <4AF47142.4010609@eaglescrag.net>
References: <1257520246-6548-1-git-send-email-pasky@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Nov 06 20:56:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6Uug-0002kJ-Fv
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 20:56:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759759AbZKFTzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 14:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759732AbZKFTzo
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 14:55:44 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:59205 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759625AbZKFTzn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 14:55:43 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id nA6Iu2i4029708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 6 Nov 2009 10:56:02 -0800
User-Agent: Thunderbird 2.0.0.23 (X11/20090825)
In-Reply-To: <1257520246-6548-1-git-send-email-pasky@suse.cz>
X-Enigmail-Version: 0.95.6
X-Virus-Scanned: ClamAV 0.88.7/9996/Thu Nov  5 22:03:42 2009 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.1.1 (shards.monkeyblade.net [198.137.202.13]); Fri, 06 Nov 2009 10:56:03 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132324>

Petr,

After digging into some of the ctags stuff recently looking at it, I 
have some serious concerns over making it a more primary interface 
inside of Gitweb.

1) The mechanism to assign ctags and it's associated documentation is 
cryptic at best.  It took me reverse engineering the code to figure out 
how to add tags to a repository, and even then there are very simple 
means of trivially breaking them (Like put 0 inside of a ctag file, the 
divide by zero errors are kinda concerning for instance).

2) If the repository is cloned the ctag information is not retained, 
which means there is no real way for the original developer to manage or 
move this information between different hosting sites, I.E. repo.or.cz 
and kernel.org (though I'll admit I have it turned off)

So if your going to eliminate the project listing, with the general 
intention of using the tag cloud as more of a primary search mechanism, 
including the search box, I think there's some serious work that needs 
to be put into the ctags system because in it's current state, for the 
likes of kernel.org, it's unusable, unstable and not something I would 
recommend to anyone to run in production.  I like the idea, I just have 
concerns over it's current implementation.

- John 'Warthog9' Hawley

Petr Baudis wrote:
> This is a preparatory patch for separation of project list and frontpage
> actions; it factors out most logic of git_project_list():
> 
> 	* git_project_list_all() as a git_project_list_body() wrapper for
> 	  complete project listing
> 	* git_project_search_form() for printing the project search form
> 
> Also, git_project_list_ctags() is now separated out of
> git_project_list_body(), showing tag cloud for given project list.
> 
> Signed-off-by: Petr Baudis <pasky@suse.cz>
> 
> ---
>  gitweb/gitweb.perl |   69 +++++++++++++++++++++++++++++++---------------------
>  1 files changed, 41 insertions(+), 28 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index e4cbfc3..e82ca45 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -4201,10 +4201,9 @@ sub git_patchset_body {
>  # project in the list, removing invalid projects from returned list
>  # NOTE: modifies $projlist, but does not remove entries from it
>  sub fill_project_list_info {
> -	my ($projlist, $check_forks) = @_;
> +	my ($projlist, $check_forks, $show_ctags) = @_;
>  	my @projects;
>  
> -	my $show_ctags = gitweb_check_feature('ctags');
>   PROJECT:
>  	foreach my $pr (@$projlist) {
>  		my (@activity) = git_get_last_activity($pr->{'path'});
> @@ -4254,12 +4253,26 @@ sub print_sort_th {
>  	}
>  }
>  
> +sub git_project_list_ctags {
> +	my ($projects) = @_;
> +
> +	my %ctags;
> +	foreach my $p (@$projects) {
> +		foreach my $ct (keys %{$p->{'ctags'}}) {
> +			$ctags{$ct} += $p->{'ctags'}->{$ct};
> +		}
> +	}
> +	my $cloud = git_populate_project_tagcloud(\%ctags);
> +	print git_show_project_tagcloud($cloud, 64);
> +}
> +
>  sub git_project_list_body {
>  	# actually uses global variable $project
>  	my ($projlist, $order, $from, $to, $extra, $no_header) = @_;
>  
>  	my $check_forks = gitweb_check_feature('forks');
> -	my @projects = fill_project_list_info($projlist, $check_forks);
> +	my $show_ctags = gitweb_check_feature('ctags');
> +	my @projects = fill_project_list_info($projlist, $check_forks, $show_ctags);
>  
>  	$order ||= $default_projects_order;
>  	$from = 0 unless defined $from;
> @@ -4278,16 +4291,8 @@ sub git_project_list_body {
>  		@projects = sort {$a->{$oi->{'key'}} <=> $b->{$oi->{'key'}}} @projects;
>  	}
>  
> -	my $show_ctags = gitweb_check_feature('ctags');
>  	if ($show_ctags) {
> -		my %ctags;
> -		foreach my $p (@projects) {
> -			foreach my $ct (keys %{$p->{'ctags'}}) {
> -				$ctags{$ct} += $p->{'ctags'}->{$ct};
> -			}
> -		}
> -		my $cloud = git_populate_project_tagcloud(\%ctags);
> -		print git_show_project_tagcloud($cloud, 64);
> +		git_project_list_ctags(\@projects);
>  	}
>  
>  	print "<table class=\"project_list\">\n";
> @@ -4361,6 +4366,28 @@ sub git_project_list_body {
>  	print "</table>\n";
>  }
>  
> +sub git_project_search_form {
> +	print $cgi->startform(-method => "get") .
> +	      "<p class=\"projsearch\">Search:\n" .
> +	      $cgi->textfield(-name => "s", -value => $searchtext) . "\n" .
> +	      "</p>" .
> +	      $cgi->end_form() . "\n";
> +}
> +
> +sub git_project_list_all {
> +	my $order = $input_params{'order'};
> +	if (defined $order && $order !~ m/none|project|descr|owner|age/) {
> +		die_error(400, "Unknown order parameter");
> +	}
> +
> +	my @list = git_get_projects_list();
> +	if (!@list) {
> +		die_error(404, "No projects found");
> +	}
> +
> +	git_project_list_body(\@list, $order);
> +}
> +
>  sub git_shortlog_body {
>  	# uses global variable $project
>  	my ($commitlist, $from, $to, $refs, $extra) = @_;
> @@ -4630,28 +4657,14 @@ sub git_search_grep_body {
>  ## actions
>  
>  sub git_project_list {
> -	my $order = $input_params{'order'};
> -	if (defined $order && $order !~ m/none|project|descr|owner|age/) {
> -		die_error(400, "Unknown order parameter");
> -	}
> -
> -	my @list = git_get_projects_list();
> -	if (!@list) {
> -		die_error(404, "No projects found");
> -	}
> -
>  	git_header_html();
>  	if (-f $home_text) {
>  		print "<div class=\"index_include\">\n";
>  		insert_file($home_text);
>  		print "</div>\n";
>  	}
> -	print $cgi->startform(-method => "get") .
> -	      "<p class=\"projsearch\">Search:\n" .
> -	      $cgi->textfield(-name => "s", -value => $searchtext) . "\n" .
> -	      "</p>" .
> -	      $cgi->end_form() . "\n";
> -	git_project_list_body(\@list, $order);
> +	git_project_search_form();
> +	git_project_list_all();
>  	git_footer_html();
>  }
>  
