From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: Support for snapshot
Date: Fri, 18 Aug 2006 12:51:48 -0700 (PDT)
Message-ID: <20060818195148.66411.qmail@web31807.mail.mud.yahoo.com>
References: <44E54AC6.9010600@gmail.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Aug 18 21:52:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEANm-0006jg-KH
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 21:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWHRTvu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 15:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWHRTvu
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 15:51:50 -0400
Received: from web31807.mail.mud.yahoo.com ([68.142.207.70]:26454 "HELO
	web31807.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932261AbWHRTvt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 15:51:49 -0400
Received: (qmail 66413 invoked by uid 60001); 18 Aug 2006 19:51:48 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=j8jzc+kZZC3BW+h+a3hW2QSdeMnUQA9LXuXHBeKLsCupQmnDFo/mj+cjNaPkAgZwGBQJysyXjowWFewsv+fpoCmjUTxQo4jDkPvs+ouDdj1+zyDinRWXZLbrbMHpjXh6WZCO5aIZCDscDUHx5owGJs0jTxqEOg6DQbMoA8BdsUU=  ;
Received: from [64.215.88.90] by web31807.mail.mud.yahoo.com via HTTP; Fri, 18 Aug 2006 12:51:48 PDT
To: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>, git@vger.kernel.org
In-Reply-To: <44E54AC6.9010600@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25691>

--- "Aneesh Kumar K.V" <aneesh.kumar@gmail.com> wrote:
> This adds snapshort support in gitweb. To enable one need to
> set gitweb.snapshot = true in the config file.

Could you use bzip2?  It generates smaller files (better compression),
which is a good thing when downloading over a network.

   Luben

> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
> ---
>  gitweb/gitweb.perl |   41 +++++++++++++++++++++++++++++++++++++----
>  1 files changed, 37 insertions(+), 4 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 04282fa..d6f96a3 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -15,6 +15,7 @@ use CGI::Carp qw(fatalsToBrowser);
>  use Encode;
>  use Fcntl ':mode';
>  use File::Find qw();
> +use File::Basename qw(basename);
>  binmode STDOUT, ':utf8';
>  
>  our $cgi = new CGI;
> @@ -175,6 +176,7 @@ my %actions = (
>  	"tag" => \&git_tag,
>  	"tags" => \&git_tags,
>  	"tree" => \&git_tree,
> +	"snapshot" => \&git_snapshot,
>  );
>  
>  $action = 'summary' if (!defined($action));
> @@ -1320,6 +1322,7 @@ sub git_difftree_body {
>  sub git_shortlog_body {
>  	# uses global variable $project
>  	my ($revlist, $from, $to, $refs, $extra) = @_;
> +	my $have_snapshot = git_get_project_config_bool('snapshot');
>  	$from = 0 unless defined $from;
>  	$to = $#{$revlist} if (!defined $to || $#{$revlist} < $to);
>  
> @@ -1344,8 +1347,11 @@ sub git_shortlog_body {
>  		print "</td>\n" .
>  		      "<td class=\"link\">" .
>  		      $cgi->a({-href => href(action=>"commit", hash=>$commit)}, "commit") . " | " .
> -		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff") .
> -		      "</td>\n" .
> +		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff");
> +		if ($have_snapshot) {
> +			print " | " .  $cgi->a({-href => href(action=>"snapshot", hash=>$commit)}, "snapshot");
> +		}
> +		print "</td>\n" .
>  		      "</tr>\n";
>  	}
>  	if (defined $extra) {
> @@ -2112,6 +2118,29 @@ sub git_tree {
>  	git_footer_html();
>  }
>  
> +sub git_snapshot {
> +
> +	if (!defined $hash) {
> +		$hash = git_get_head_hash($project);
> +	}
> +
> +	my $filename = basename($project) . "-$hash.tar.gz";
> +
> +	print $cgi->header(-type => 'application/x-tar',
> +			-content-encoding => 'x-gzip',
> +			'-content-disposition' => "inline; filename=\"$filename\"",
> +			-status => '200 OK');
> +
> +	open my $fd, "-|", "$GIT tar-tree $hash \'$project\' | gzip" or
> +				die_error(undef, "Execute git-tar-tree failed.");
> +	binmode STDOUT, ':raw';
> +	print <$fd>;
> +	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
> +	close $fd;
> +
> +
> +}
> +
>  sub git_log {
>  	my $head = git_get_head_hash($project);
>  	if (!defined $hash) {
> @@ -2206,6 +2235,7 @@ sub git_commit {
>  	}
>  	my $refs = git_get_references();
>  	my $ref = format_ref_marker($refs, $co{'id'});
> +	my $have_snapshot = git_get_project_config_bool('snapshot');
>  	my $formats_nav = '';
>  	if (defined $file_name && defined $co{'parent'}) {
>  		my $parent = $co{'parent'};
> @@ -2241,8 +2271,11 @@ sub git_commit {
>  	      "<td class=\"sha1\">" .
>  	      $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'}, hash_base=>$hash), class =>
> "list"}, $co{'tree'}) .
>  	      "</td>" .
> -	      "<td class=\"link\">" . $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'},
> hash_base=>$hash)}, "tree") .
> -	      "</td>" .
> +	      "<td class=\"link\">" . $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'},
> hash_base=>$hash)}, "tree");
> +	if ($have_snapshot) {
> +		print " | " .  $cgi->a({-href => href(action=>"snapshot", hash=>$hash)}, "snapshot");
> +	}
> +	print "</td>" .
>  	      "</tr>\n";
>  	my $parents = $co{'parents'};
>  	foreach my $par (@$parents) {
> -- 
> 1.4.2.rc1.g83e1-dirty
> 
> 
