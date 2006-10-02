From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: make leftmost column of blame less cluttered.
Date: Mon, 2 Oct 2006 12:29:30 -0700 (PDT)
Message-ID: <20061002192930.86293.qmail@web31803.mail.mud.yahoo.com>
References: <7vwt7k4clr.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Oct 02 21:29:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUTTs-0001P5-Ci
	for gcvg-git@gmane.org; Mon, 02 Oct 2006 21:29:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965190AbWJBT3c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Oct 2006 15:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965377AbWJBT3c
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Oct 2006 15:29:32 -0400
Received: from web31803.mail.mud.yahoo.com ([68.142.207.66]:16016 "HELO
	web31803.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965190AbWJBT3b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Oct 2006 15:29:31 -0400
Received: (qmail 86295 invoked by uid 60001); 2 Oct 2006 19:29:30 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=XPIF6CMJN9dPaEczkHiBlVdUP2yxCURiIYh0rIaUqBpsuytB4bTnrPoKKnvlf3b5PDxPICNBWS0EVMjDTByZnrBfvus4nYuo9nNzDaVRh+mi24nrxy2o9+/AnGX270WFiqfAtqvnT8Vl2j6gtyOLHN9f8RO/kg8m9DIdJQ5N+C8=  ;
Received: from [64.215.88.90] by web31803.mail.mud.yahoo.com via HTTP; Mon, 02 Oct 2006 12:29:30 PDT
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
In-Reply-To: <7vwt7k4clr.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28229>

--- Junio C Hamano <junkio@cox.net> wrote:

> Instead of labelling each and every line with clickable commit
> object name, this makes the blame output to show them only on
> the first line of each group of lines from the same revision.
> 
> Also it makes mouse-over to show the minimum authorship and
> authordate information for extra cuteness ;-).
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> ---

ACK.  Please commit.

   Luben

> 
>  * I've been staying away from the party to paint the bikeshed,
>    but I had a bit of time to kill tonight.  Let's see if people
>    might like this...
> 
>  gitweb/gitweb.perl |   67 +++++++++++++++++++++++++++++++++++++++++----------
>  1 files changed, 54 insertions(+), 13 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 44991b1..7e4ec8d 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2429,6 +2429,41 @@ sub git_tag {
>  	git_footer_html();
>  }
>  
> +sub git_blame_flush_chunk {
> +	my ($name, $revdata, $color, $rev, @line) = @_;
> +	my $label = substr($rev, 0, 8);
> +	my $line = scalar(@line);
> +	my $cnt = 0;
> +	my $pop = '';
> +
> +	if ($revdata->{$rev} ne '') {
> +		$pop = ' title="' . esc_html($revdata->{$rev}) . '"';
> +	}
> +
> +	for (@line) {
> +		my ($lineno, $data) = @$_;
> +		$cnt++;
> +		print "<tr class=\"$color\">\n";
> +		if ($cnt == 1) {
> +			print "<td class=\"sha1\"$pop";
> +			if ($line > 1) {
> +				print " rowspan=\"$line\"";
> +			}
> +			print ">";
> +			print $cgi->a({-href => href(action=>"commit",
> +						     hash=>$rev,
> +						     file_name=>$name)},
> +				      $label);
> +			print "</td>\n";
> +		}
> +		print "<td class=\"linenr\">".
> +		    "<a id=\"l$lineno\" href=\"#l$lineno\" class=\"linenr\">" .
> +		    esc_html($lineno) . "</a></td>\n";
> +		print "<td class=\"pre\">" . esc_html($data) . "</td>\n";
> +		print "</tr>\n";
> +	}
> +}
> +
>  sub git_blame2 {
>  	my $fd;
>  	my $ftype;
> @@ -2474,27 +2509,33 @@ sub git_blame2 {
>  <table class="blame">
>  <tr><th>Commit</th><th>Line</th><th>Data</th></tr>
>  HTML
> +	my @chunk = ();
> +	my %revdata = ();
>  	while (<$fd>) {
>  		/^([0-9a-fA-F]{40}).*?(\d+)\)\s{1}(\s*.*)/;
> -		my $full_rev = $1;
> -		my $rev = substr($full_rev, 0, 8);
> -		my $lineno = $2;
> -		my $data = $3;
> -
> +		my ($full_rev, $author, $date, $lineno, $data) =
> +		    /^([0-9a-f]{40}).*?\s\((.*?)\s+([-\d]+ [:\d]+ [-+\d]+)\s+(\d+)\)\s(.*)/;
> +		if (!exists $revdata{$full_rev}) {
> +			$revdata{$full_rev} = "$author, $date";
> +		}
>  		if (!defined $last_rev) {
>  			$last_rev = $full_rev;
>  		} elsif ($last_rev ne $full_rev) {
> +			git_blame_flush_chunk($file_name,
> +					      \%revdata,
> +					      $rev_color[$current_color],
> +					      $last_rev, @chunk);
> +			@chunk = ();
>  			$last_rev = $full_rev;
>  			$current_color = ++$current_color % $num_colors;
>  		}
> -		print "<tr class=\"$rev_color[$current_color]\">\n";
> -		print "<td class=\"sha1\">" .
> -			$cgi->a({-href => href(action=>"commit", hash=>$full_rev, file_name=>$file_name)},
> -			        esc_html($rev)) . "</td>\n";
> -		print "<td class=\"linenr\"><a id=\"l$lineno\" href=\"#l$lineno\" class=\"linenr\">" .
> -		      esc_html($lineno) . "</a></td>\n";
> -		print "<td class=\"pre\">" . esc_html($data) . "</td>\n";
> -		print "</tr>\n";
> +		push @chunk, [$lineno, $data];
> +	}
> +	if (@chunk) {
> +		git_blame_flush_chunk($file_name,
> +				      \%revdata,
> +				      $rev_color[$current_color],
> +				      $last_rev, @chunk);
>  	}
>  	print "</table>\n";
>  	print "</div>";
> -- 
> 1.4.2.1.gc9fffe
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
