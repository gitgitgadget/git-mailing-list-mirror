From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH 1/5] gitweb: Cleanup input validation and error messages
Date: Fri, 4 Aug 2006 16:54:50 -0700 (PDT)
Message-ID: <20060804235450.33762.qmail@web31804.mail.mud.yahoo.com>
References: <200608050038.20534.jnareb@gmail.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sat Aug 05 01:54:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G99VH-00015I-9b
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 01:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161586AbWHDXyw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 19:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161589AbWHDXyw
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 19:54:52 -0400
Received: from web31804.mail.mud.yahoo.com ([68.142.207.67]:26299 "HELO
	web31804.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161586AbWHDXyv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 19:54:51 -0400
Received: (qmail 33764 invoked by uid 60001); 4 Aug 2006 23:54:50 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=gwu/Bfl/5Oc6qPHrvUjZoskfEwjpscEwRC16+TVGpvF1UL8lJIY99Rt4fVpWComX6hl9t02nHgYBQrc0Tbl5yo4ohu8zfPi/PuKM5R/+iBCbAb+7jvxspFt3m7AwWKqgsY4OgOh0uXEYzdsxrNxCCplKj4lm5AMw+oQsLJ0fFOA=  ;
Received: from [64.215.88.90] by web31804.mail.mud.yahoo.com via HTTP; Fri, 04 Aug 2006 16:54:50 PDT
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
In-Reply-To: <200608050038.20534.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24864>

--- Jakub Narebski <jnareb@gmail.com> wrote:
> Clean up input validation, including removing $rss_link variable and
> making error messages more explicit.  Expand and uniquify other error
> messages.
> 
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> This probably conflicts "[PATCH 4/4] gitweb: No periods for error messages".
> It uses periods for error messages which does not end in with some 
> value of some variable.

Can you fix your patch then?
Error messages in general do not end with a period.

    Luben

> 
>  gitweb/gitweb.perl |   88 ++++++++++++++++++++++++----------------------------
>  1 files changed, 40 insertions(+), 48 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 58eb5b1..dfc2d09 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -71,13 +71,15 @@ if (! -d $git_temp) {
>  	mkdir($git_temp, 0700) || die_error("Couldn't mkdir $git_temp");
>  }
>  
> +
> +# ======================================================================
>  # input validation and dispatch
>  our $action = $cgi->param('a');
>  if (defined $action) {
>  	if ($action =~ m/[^0-9a-zA-Z\.\-_]/) {
> -		undef $action;
> -		die_error(undef, "Invalid action parameter.");
> +		die_error(undef, "Invalid action parameter $action");
>  	}
> +	# action which does not check rest of parameters
>  	if ($action eq "opml") {
>  		git_opml();
>  		exit;
> @@ -85,22 +87,17 @@ if (defined $action) {
>  }
>  
>  our $project = ($cgi->param('p') || $ENV{'PATH_INFO'});
> -if (defined $project) {
> -	$project =~ s|^/||; $project =~ s|/$||;
> -	$project = validate_input($project);
> -	if (!defined($project)) {
> -		die_error(undef, "Invalid project parameter.");
> +$project =~ s|^/||; $project =~ s|/$||;
> +if (defined $project || $project) {
> +	if (!validate_input($project)) {
> +		die_error(undef, "Invalid project parameter $project");
>  	}
>  	if (!(-d "$projectroot/$project")) {
> -		undef $project;
> -		die_error(undef, "No such directory.");
> +		die_error(undef, "No such directory $project");
>  	}
>  	if (!(-e "$projectroot/$project/HEAD")) {
> -		undef $project;
> -		die_error(undef, "No such project.");
> +		die_error(undef, "No such project $project");
>  	}
> -	$rss_link = "<link rel=\"alternate\" title=\"" . esc_param($project) . " log\" href=\"" .
> -	            "$my_uri?" . esc_param("p=$project;a=rss") . "\" type=\"application/rss+xml\"/>";
>  	$ENV{'GIT_DIR'} = "$projectroot/$project";
>  } else {
>  	git_project_list();
> @@ -109,49 +106,43 @@ if (defined $project) {
>  
>  our $file_name = $cgi->param('f');
>  if (defined $file_name) {
> -	$file_name = validate_input($file_name);
> -	if (!defined($file_name)) {
> -		die_error(undef, "Invalid file parameter.");
> +	if (!validate_input($file_name)) {
> +		die_error(undef, "Invalid file parameter $file_name");
>  	}
>  }
>  
>  our $hash = $cgi->param('h');
>  if (defined $hash) {
> -	$hash = validate_input($hash);
> -	if (!defined($hash)) {
> -		die_error(undef, "Invalid hash parameter.");
> +	if (!validate_input($hash)) {
> +		die_error(undef, "Invalid hash parameter $hash");
>  	}
>  }
>  
>  our $hash_parent = $cgi->param('hp');
>  if (defined $hash_parent) {
> -	$hash_parent = validate_input($hash_parent);
> -	if (!defined($hash_parent)) {
> -		die_error(undef, "Invalid hash parent parameter.");
> +	if (!validate_input($hash_parent)) {
> +		die_error(undef, "Invalid hash parent parameter $hash_parent");
>  	}
>  }
>  
>  our $hash_base = $cgi->param('hb');
>  if (defined $hash_base) {
> -	$hash_base = validate_input($hash_base);
> -	if (!defined($hash_base)) {
> -		die_error(undef, "Invalid hash base parameter.");
> +	if (!validate_input($hash_base)) {
> +		die_error(undef, "Invalid hash base parameter $hash_base");
>  	}
>  }
>  
>  our $page = $cgi->param('pg');
>  if (defined $page) {
>  	if ($page =~ m/[^0-9]$/) {
> -		undef $page;
> -		die_error(undef, "Invalid page parameter.");
> +		die_error(undef, "Invalid page parameter $page");
>  	}
>  }
>  
>  our $searchtext = $cgi->param('s');
>  if (defined $searchtext) {
>  	if ($searchtext =~ m/[^a-zA-Z0-9_\.\/\-\+\:\@ ]/) {
> -		undef $searchtext;
> -		die_error(undef, "Invalid search parameter.");
> +		die_error(undef, "Invalid search parameter $searchtext");
>  	}
>  	$searchtext = quotemeta $searchtext;
>  }
> @@ -180,8 +171,7 @@ my %actions = (
>  
>  $action = 'summary' if (!defined($action));
>  if (!defined($actions{$action})) {
> -	undef $action;
> -	die_error(undef, "Unknown action.");
> +	die_error(undef, "Unknown action $action");
>  }
>  $actions{$action}->();
>  exit;
> @@ -871,11 +861,13 @@ sub git_header_html {
>  <meta name="robots" content="index, nofollow"/>
>  <title>$title</title>
>  <link rel="stylesheet" type="text/css" href="$stylesheet"/>
> -$rss_link
> -</head>
> -<body>
>  EOF
> -	print "<div class=\"page_header\">\n" .
> +	print "<link rel=\"alternate\" title=\"" . esc_param($project) . " log\" href=\"" .
> +	      "$my_uri?" . esc_param("p=$project;a=rss") . "\" type=\"application/rss+xml\"/>\n" .
> +	      "</head>\n";
> +
> +	print "<body>\n" .
> +	      "<div class=\"page_header\">\n" .
>  	      "<a href=\"http://www.kernel.org/pub/software/scm/git/docs/\" title=\"git
> documentation\">" .
>  	      "<img src=\"$logo\" width=\"72\" height=\"27\" alt=\"git\" style=\"float:right;
> border-width:0px;\"/>" .
>  	      "</a>\n";
> @@ -1471,18 +1463,18 @@ sub git_blame2 {
>  	my $fd;
>  	my $ftype;
>  	die_error(undef, "Permission denied.") if (!git_get_project_config_bool ('blame'));
> -	die_error('404 Not Found', "File name not defined") if (!$file_name);
> +	die_error('404 Not Found', "File name not defined.") if (!$file_name);
>  	$hash_base ||= git_read_head($project);
> -	die_error(undef, "Reading commit failed") unless ($hash_base);
> +	die_error(undef, "Couldn't find base commit.") unless ($hash_base);
>  	my %co = git_read_commit($hash_base)
> -		or die_error(undef, "Reading commit failed");
> +		or die_error(undef, "Reading commit failed.");
>  	if (!defined $hash) {
>  		$hash = git_get_hash_by_path($hash_base, $file_name, "blob")
> -			or die_error(undef, "Error looking up file");
> +			or die_error(undef, "Error looking up file $file_name");
>  	}
>  	$ftype = git_get_type($hash);
>  	if ($ftype !~ "blob") {
> -		die_error("400 Bad Request", "object is not a blob");
> +		die_error("400 Bad Request", "Object is not a blob.");
>  	}
>  	open ($fd, "-|", $GIT, "blame", '-l', $file_name, $hash_base)
>  		or die_error(undef, "Open git-blame failed.");
> @@ -1529,14 +1521,14 @@ sub git_blame2 {
>  sub git_blame {
>  	my $fd;
>  	die_error('403 Permission denied', "Permission denied.") if (!git_get_project_config_bool
> ('blame'));
> -	die_error('404 Not Found', "What file will it be, master?") if (!$file_name);
> +	die_error('404 Not Found', "File name not defined.") if (!$file_name);
>  	$hash_base ||= git_read_head($project);
> -	die_error(undef, "Reading commit failed.") unless ($hash_base);
> +	die_error(undef, "Couldn't find base commit.") unless ($hash_base);
>  	my %co = git_read_commit($hash_base)
>  		or die_error(undef, "Reading commit failed.");
>  	if (!defined $hash) {
>  		$hash = git_get_hash_by_path($hash_base, $file_name, "blob")
> -			or die_error(undef, "Error lookup file.");
> +			or die_error(undef, "Error lookup file $file_name");
>  	}
>  	open ($fd, "-|", $GIT, "annotate", '-l', '-t', '-r', $file_name, $hash_base)
>  		or die_error(undef, "Open git-annotate failed.");
> @@ -1649,7 +1641,7 @@ sub git_blob_plain {
>  		if (defined $file_name) {
>  			my $base = $hash_base || git_read_head($project);
>  			$hash = git_get_hash_by_path($base, $file_name, "blob")
> -				or die_error(undef, "Error lookup file.");
> +				or die_error(undef, "Error lookup file $file_name");
>  		} else {
>  			die_error(undef, "No file name defined.");
>  		}
> @@ -1682,7 +1674,7 @@ sub git_blob {
>  		if (defined $file_name) {
>  			my $base = $hash_base || git_read_head($project);
>  			$hash = git_get_hash_by_path($base, $file_name, "blob")
> -				or die_error(undef, "Error lookup file.");
> +				or die_error(undef, "Error lookup file $file_name");
>  		} else {
>  			die_error(undef, "No file name defined.");
>  		}
> @@ -2122,7 +2114,7 @@ sub git_commitdiff {
>  	open my $fd, "-|", $GIT, "diff-tree", '-r', $hash_parent, $hash
>  		or die_error(undef, "Open git-diff-tree failed.");
>  	my @difftree = map { chomp; $_ } <$fd>;
> -	close $fd or die_error(undef, "Reading diff-tree failed.");
> +	close $fd or die_error(undef, "Reading git-diff-tree failed.");
>  
>  	# non-textual hash id's can be cached
>  	my $expires;
> @@ -2202,7 +2194,7 @@ sub git_commitdiff_plain {
>  	open my $fd, "-|", $GIT, "diff-tree", '-r', $hash_parent, $hash
>  		or die_error(undef, "Open git-diff-tree failed.");
>  	my @difftree = map { chomp; $_ } <$fd>;
> -	close $fd or die_error(undef, "Reading diff-tree failed.");
> +	close $fd or die_error(undef, "Reading git-diff-tree failed.");
>  
>  	# try to figure out the next tag after this commit
>  	my $tagname;
> @@ -2493,7 +2485,7 @@ sub git_rss {
>  	open my $fd, "-|", $GIT, "rev-list", "--max-count=150", git_read_head($project)
>  		or die_error(undef, "Open git-rev-list failed.");
>  	my @revlist = map { chomp; $_ } <$fd>;
> -	close $fd or die_error(undef, "Reading rev-list failed.");
> +	close $fd or die_error(undef, "Reading git-rev-list failed.");
>  	print $cgi->header(-type => 'text/xml', -charset => 'utf-8');
>  	print "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n".
>  	      "<rss version=\"2.0\" xmlns:content=\"http://purl.org/rss/1.0/modules/content/\">\n";
> -- 
> 1.4.1.1
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
