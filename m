From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: [RFC/PATCH] gitweb: Paginate project list
Date: Sat, 10 May 2008 11:28:28 -0700
Message-ID: <1210444108.11526.139.camel@localhost.localdomain>
References: <200805011220.58871.jnareb@gmail.com>
	 <200805031103.14960.jnareb@gmail.com> <200805091523.24591.jnareb@gmail.com>
	 <200805101128.59313.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 10 20:29:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JutpH-0007pu-8u
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 20:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753342AbYEJS2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 14:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753293AbYEJS2x
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 14:28:53 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:33966 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753186AbYEJS2w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 14:28:52 -0400
Received: from [172.19.0.93] ([76.21.83.184])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id m4AISd4T008626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 10 May 2008 11:28:39 -0700
In-Reply-To: <200805101128.59313.jnareb@gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-3.fc8) 
X-Virus-Scanned: ClamAV 0.88.7/7082/Fri May  9 20:33:49 2008 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.1.12 (shards.monkeyblade.net [198.137.202.13]); Sat, 10 May 2008 11:28:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81690>

$page_size should be moved to a configuration directive, with a possible
default of 100, and there should be an option to turn it off completely
(I.E. kernel.org will likely have it turned off).

It might also be advantageous to generate the entire list and stash that
somewhere, (session on the host side?) and run the pagination out of
that.  Would even allow the user to choose how many items they wish to
see from a drop down maybe?

- John

On Sat, 2008-05-10 at 11:28 +0200, Jakub Narebski wrote:
> Divide projects list and project search results into pages of
> $page_size (currently 100) elements.  Pagination links look
> like shown below:
> 
>   first prev 1 2 3 *4* 5 6 next last
> 
> where *4* denotes current page, is in bold, and isn't a link.
> This would need to be improved for extremely large number of projects
> (repositories), where number of projects divided by page size is very
> large.
> 
> Currently pagination interacts with sorting in a bit strange way.
> When clicking on "sort by" link when on some later page the result is
> not this page sorted, by given page of sorted output.  Perhaps "sort
> by" links should always show first page...
> 
> git_project_list_body() subroutine takes care to fill field (key) we
> sort by for all projects, sort by given ordering, and fill the rest of
> project info only for projects shown.
> 
> NOTE: currently code is not optimal, as it contains a few unnecessary
> array copying, or array fragment copying.
> 
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> This patch depends on earlier "gitweb: Project search", but conceptually
> they are independent; probably fill_project_list_info() improvement to
> do partial filling should be in seaparet commit...
> 
>  gitweb/gitweb.perl |   57 ++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 files changed, 51 insertions(+), 6 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 7e1a9b4..716f7ad 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3709,10 +3709,10 @@ sub print_sort_th_num {
>  sub git_project_list_body {
>  	my ($projlist, $order, $from, $to, $extra, $no_header) = @_;
>  
> +	$order ||= $default_projects_order;
>  	my ($check_forks) = gitweb_check_feature('forks');
> -	my @projects = fill_project_list_info($projlist, $check_forks);
> +	my @projects = fill_project_list_info($projlist, $check_forks, $order);
>  
> -	$order ||= $default_projects_order;
>  	$from = 0 unless defined $from;
>  	$to = $#projects if (!defined $to || $#projects < $to);
>  
> @@ -3733,9 +3733,10 @@ sub git_project_list_body {
>  		print "<th></th>\n" . # for links
>  		      "</tr>\n";
>  	}
> +	@projects = @projects[$from..$to];
> +	@projects = fill_project_list_info(\@projects, $check_forks);
>  	my $alternate = 1;
> -	for (my $i = $from; $i <= $to; $i++) {
> -		my $pr = $projects[$i];
> +	foreach my $pr (@projects) {
>  		if ($alternate) {
>  			print "<tr class=\"dark\">\n";
>  		} else {
> @@ -4066,6 +4067,46 @@ sub git_project_list {
>  		die_error(undef, "No projects found");
>  	}
>  
> +	my $page_size = 100;
> +	# +1 for incomplete page (not having $page_size items)
> +	my $npages = int(@list / $page_size)+((@list % $page_size) > 0);
> +	# pages are numbered 0..$npages-1
> +	$page = 0 if (!defined $page || $page < 0);
> +	$page = $npages-1 if ($page >= $npages);
> +	my $paging_nav;
> +
> +	if ($npages > 1) {
> +		my @paging = ();
> +		push @paging, $cgi->a({-href => href(-replay=>1, page=>0)},
> +		                      "first");
> +		if ($page > 0) {
> +			push @paging, $cgi->a({-href => href(-replay=>1, page=>$page-1),
> +			                       -accesskey => "p", -title => "Alt-p"},
> +			                      "prev");
> +		} else {
> +			push @paging, "prev";
> +		}
> +		for (my $pg = 0; $pg < $npages; $pg++) {
> +			# links to individual pages are numbered 1..$npages
> +			if ($page == $pg) {
> +				push @paging, '<b>'.($pg+1).'</b>';
> +			} else {
> +				push @paging, $cgi->a({-href => href(-replay=>1, page=>$pg)},
> +				                      $pg+1);
> +			}
> +		}
> +		if ($page < $npages-1) {
> +			push @paging, $cgi->a({-href => href(-replay=>1, page=>$page+1),
> +			                       -accesskey => "n", -title => "Alt-n"},
> +			                      "next");
> +		} else {
> +			push @paging, "next";
> +		}
> +		push @paging, $cgi->a({-href => href(-replay=>1, page=>$npages-1)},
> +		                      "last");
> +		$paging_nav = join(' &sdot; ', @paging);
> +	}
> +
>  	git_header_html();
>  	if (-f $home_text) {
>  		print "<div class=\"index_include\">\n";
> @@ -4081,10 +4122,14 @@ sub git_project_list {
>  		if (defined $searchtype) {
>  			filter_project_list(\@list, $searchtype, $search_regexp)
>  				unless ($searchtype eq 'list_all');
> -			git_project_list_body(\@list, $order);
> +			git_project_list_body(\@list, $order,
> +			                      $page*$page_size, ($page+1)*$page_size - 1,
> +			                      $paging_nav);
>  		}
>  	} else {
> -		git_project_list_body(\@list, $order);
> +		git_project_list_body(\@list, $order,
> +		                      $page*$page_size, ($page+1)*$page_size - 1,
> +		                      $paging_nav);
>  	}
>  	git_footer_html();
>  }
