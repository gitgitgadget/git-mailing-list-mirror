From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH 3/3] gitweb: A bit of code cleanup in git_blame()
Date: Tue, 9 Dec 2008 22:24:49 -0800 (PST)
Message-ID: <910359.52983.qm@web31807.mail.mud.yahoo.com>
References: <20081209224814.28106.83387.stgit@localhost.localdomain>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 07:26:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAIWO-0005Ac-V3
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 07:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbYLJGYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 01:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbYLJGYv
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 01:24:51 -0500
Received: from web31807.mail.mud.yahoo.com ([68.142.207.70]:35956 "HELO
	web31807.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751013AbYLJGYv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Dec 2008 01:24:51 -0500
Received: (qmail 53225 invoked by uid 60001); 10 Dec 2008 06:24:49 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:X-Mailer:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type;
  b=Kt8IdKWVKBEE68hCPP0ZTWJD1v3myTgkGcXtTBAHhaHSybjGGViUUTIBvRk+foEtiZ/hipmCyR70eIZYGifoDBo5qXsVrBeZe4wfKZWn44T+1oW0ZxkYCXH8w1s5P5CnVemeMxlmIH4lLMIx4TueMUkVkk4c8iN89PuJD6Bdc5A=  ;
Received: from [71.132.209.19] by web31807.mail.mud.yahoo.com via HTTP; Tue, 09 Dec 2008 22:24:49 PST
X-Mailer: YahooMailWebService/0.7.260.1
In-Reply-To: <20081209224814.28106.83387.stgit@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102668>


--- On Tue, 12/9/08, Jakub Narebski <jnareb@gmail.com> wrote:
> From: Jakub Narebski <jnareb@gmail.com>
> Subject: [PATCH 3/3] gitweb: A bit of code cleanup in git_blame()
> To: git@vger.kernel.org
> Cc: "Luben Tuikov" <ltuikov@yahoo.com>, "Jakub Narebski" <jnareb@gmail.com>
> Date: Tuesday, December 9, 2008, 2:48 PM
> Among others: 
>  * move variable declaration closer to the place it is set
> and used,
>    if possible,
>  * uniquify and simplify coding style a bit, which includes
> removing
>    unnecessary '()'.
>  * check type only if $hash was defined, as otherwise from
> the way
>    git_get_hash_by_path() is called (and works), we know
> that it is
>    a blob,
>  * use modern calling convention for git-blame,
>  * remove unused variable,
>  * don't use implicit variables ($_),
>  * add some comments
> 
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
Acked-by: Luben Tuikov <ltuikov@yahoo.com>

Looks good.

> ---
> Not stricly necessary... but the code looked not very nice
> 
>  gitweb/gitweb.perl |   65
> ++++++++++++++++++++++++++++++----------------------
>  1 files changed, 37 insertions(+), 28 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 916396a..68aa3f8 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -4575,28 +4575,32 @@ sub git_tag {
>  }
>  
>  sub git_blame {
> -	my $fd;
> -	my $ftype;
> -
> +	# permissions
>  	gitweb_check_feature('blame')
> -	    or die_error(403, "Blame view not
> allowed");
> +		or die_error(403, "Blame view not allowed");
>  
> +	# error checking
>  	die_error(400, "No file name given") unless
> $file_name;
>  	$hash_base ||= git_get_head_hash($project);
> -	die_error(404, "Couldn't find base commit")
> unless ($hash_base);
> +	die_error(404, "Couldn't find base commit")
> unless $hash_base;
>  	my %co = parse_commit($hash_base)
>  		or die_error(404, "Commit not found");
>  	if (!defined $hash) {
>  		$hash = git_get_hash_by_path($hash_base, $file_name,
> "blob")
>  			or die_error(404, "Error looking up file");
> +	} else {
> +		my $ftype = git_get_type($hash);
> +		if ($ftype !~ "blob") {
> +			die_error(400, "Object is not a blob");
> +		}
>  	}
> -	$ftype = git_get_type($hash);
> -	if ($ftype !~ "blob") {
> -		die_error(400, "Object is not a blob");
> -	}
> -	open ($fd, "-|", git_cmd(), "blame",
> '-p', '--',
> -	      $file_name, $hash_base)
> +
> +	# run git-blame --porcelain
> +	open my $fd, "-|", git_cmd(),
> "blame", '-p',
> +		$hash_base, '--', $file_name
>  		or die_error(500, "Open git-blame failed");
> +
> +	# page header
>  	git_header_html();
>  	my $formats_nav =
>  		$cgi->a({-href =>
> href(action=>"blob", -replay=>1)},
> @@ -4610,40 +4614,43 @@ sub git_blame {
>  	git_print_page_nav('','',
> $hash_base,$co{'tree'},$hash_base, $formats_nav);
>  	git_print_header_div('commit',
> esc_html($co{'title'}), $hash_base);
>  	git_print_page_path($file_name, $ftype, $hash_base);
> -	my @rev_color = (qw(light2 dark2));
> +
> +	# page body
> +	my @rev_color = qw(light2 dark2);
>  	my $num_colors = scalar(@rev_color);
>  	my $current_color = 0;
> -	my $last_rev;
> +	my %metainfo = ();
> +
>  	print <<HTML;
>  <div class="page_body">
>  <table class="blame">
> 
> <tr><th>Commit</th><th>Line</th><th>Data</th></tr>
>  HTML
> -	my %metainfo = ();
> -	while (1) {
> -		$_ = <$fd>;
> -		last unless defined $_;
> + LINE:
> +	while (my $line = <$fd>) {
> +		chomp $line;
> +		# the header: <SHA-1> <src lineno> <dst
> lineno> [<lines in group>]
> +		# no <lines in group> for subsequent lines in
> group of lines
>  		my ($full_rev, $orig_lineno, $lineno, $group_size) =
> -		    /^([0-9a-f]{40}) (\d+) (\d+)(?:
> (\d+))?$/;
> +		   ($line =~ /^([0-9a-f]{40}) (\d+) (\d+)(?:
> (\d+))?$/);
>  		if (!exists $metainfo{$full_rev}) {
>  			$metainfo{$full_rev} = {};
>  		}
>  		my $meta = $metainfo{$full_rev};
> -		while (<$fd>) {
> -			last if (s/^\t//);
> -			if (/^(\S+) (.*)$/) {
> +		while (my $data = <$fd>) {
> +			chomp $data;
> +			last if ($data =~ s/^\t//); # contents of line
> +			if ($data =~ /^(\S+) (.*)$/) {
>  				$meta->{$1} = $2;
>  			}
>  		}
> -		my $data = $_;
> -		chomp $data;
> -		my $rev = substr($full_rev, 0, 8);
> +		my $short_rev = substr($full_rev, 0, 8);
>  		my $author = $meta->{'author'};
> -		my %date = parse_date($meta->{'author-time'},
> -		                      $meta->{'author-tz'});
> +		my %date =
> +			parse_date($meta->{'author-time'},
> $meta->{'author-tz'});
>  		my $date = $date{'iso-tz'};
>  		if ($group_size) {
> -			$current_color = ++$current_color % $num_colors;
> +			$current_color = ($current_color + 1) % $num_colors;
>  		}
>  		print "<tr id=\"l$lineno\"
> class=\"$rev_color[$current_color]\">\n";
>  		if ($group_size) {
> @@ -4654,7 +4661,7 @@ HTML
>  			print $cgi->a({-href =>
> href(action=>"commit",
>  			                             hash=>$full_rev,
>  			                            
> file_name=>$file_name)},
> -			              esc_html($rev));
> +			              esc_html($short_rev));
>  			print "</td>\n";
>  		}
>  		my $parent_commit;
> @@ -4683,6 +4690,8 @@ HTML
>  	print "</div>";
>  	close $fd
>  		or print "Reading blob failed\n";
> +
> +	# page footer
>  	git_footer_html();
>  }
