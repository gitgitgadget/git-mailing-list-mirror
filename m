From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: make leftmost column of blame less cluttered.
Date: Tue, 3 Oct 2006 12:08:46 -0700 (PDT)
Message-ID: <20061003190846.81481.qmail@web31813.mail.mud.yahoo.com>
References: <7vmz8dsvwm.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 03 21:09:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUpdL-00078I-Gn
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 21:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030331AbWJCTIs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 15:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030336AbWJCTIs
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 15:08:48 -0400
Received: from web31813.mail.mud.yahoo.com ([68.142.207.76]:12918 "HELO
	web31813.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030331AbWJCTIq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 15:08:46 -0400
Received: (qmail 81483 invoked by uid 60001); 3 Oct 2006 19:08:46 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=FD7KRdL+fOp6vvdKTmlFFQXMlaRiL6Y+mp6RR0t9skfnVF8Kusa8VceAGrdSLcfK68UjiW6CErh4bGOfA2jFZCOR6pfzaZoYzckSus5qq0PRex5LdvRpbDv2+N5yhhs1R11b30KBU6lWN80Fy1zz7dPXaPUKxiaTsuriPwfnOas=  ;
Received: from [64.215.88.90] by web31813.mail.mud.yahoo.com via HTTP; Tue, 03 Oct 2006 12:08:46 PDT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmz8dsvwm.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28289>

--- Junio C Hamano <junkio@cox.net> wrote:
> Perhaps like this.  This has hardcoded chunk-cap of 20 lines,
> which means we never buffer more than 40 lines and never emit
> more than 20 lines at a time.  The reason we do not immediately
> flush after getting 20 lines is if we have a block of 21 lines
> we would end up giving 20 line chunk and 1 line chunk and then a
> chunk for the different revision (orphaned line).  In such a
> case we are better off giving two evenly divided chunks and that
> is why we buffer up to twice the chunk-cap size.
> 
> If people are interested we probably would want to make 20
> configurable.  Maybe not.  I personally suspect it does not
> matter much.

I think this would get us into too much "special cases".  The colored
chunks of commits were added with the intention of "single commit",
so I think we should be ok, to have a single row at the top for
the initial commit when the file had not been changed since.

Initial commits are normally "well known commits", so I think it should
be ok to not have to print every 20 or so lines as this breaks the 
color-block-per-commit intention.

   Luben


> 
> -- >8 --
> [PATCH] gitweb: make leftmost column of blame less cluttered.
> 
> Instead of labelling each and every line with clickable commit
> object name, this makes the blame output to show them only on
> the first line of each group of lines from the same revision.
> 
> Also it makes mouse-over to show the minimum authorship and
> authordate information for extra cuteness ;-).
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> ---
>  gitweb/gitweb.perl |   99 +++++++++++++++++++++++++++++++++++++++++++++-------
>  1 files changed, 86 insertions(+), 13 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> old mode 100755
> new mode 100644
> index 3e9d4a0..55d1b2c
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2430,9 +2430,64 @@ sub git_tag {
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
> +# We can have up to N*2 lines.  If it is more than N lines, split it
> +# into two to avoid orphans.
> +sub git_blame_flush_chunk_1 {
> +	my ($chunk_cap, $name, $revdata, $color, $rev, @chunk) = @_;
> +	if ($chunk_cap < @chunk) {
> +		my @first = splice(@chunk, 0, @chunk/2);
> +		git_blame_flush_chunk($name,
> +				      $revdata,
> +				      $color,
> +				      $rev,
> +				      @first);
> +	}
> +	git_blame_flush_chunk($name,
> +			      $revdata,
> +			      $color,
> +			      $rev,
> +			      @chunk);
> +}
> +
>  sub git_blame2 {
>  	my $fd;
>  	my $ftype;
> +	my $chunk_cap = 20;
>  
>  	my ($have_blame) = gitweb_check_feature('blame');
>  	if (!$have_blame) {
> @@ -2475,27 +2530,45 @@ sub git_blame2 {
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
> +			git_blame_flush_chunk_1($chunk_cap,
> +						$file_name,
> +						\%revdata,
> +						$rev_color[$current_color],
> +						$last_rev, @chunk);
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
> +		elsif ($chunk_cap * 2 < @chunk) {
> +			# We have more than N*2 lines from the same
> +			# revision.  Flush N lines and leave N lines
> +			# in @chunk to avoid orphaned lines.
> +			my @first = splice(@chunk, 0, $chunk_cap);
> +			git_blame_flush_chunk($file_name,
> +					      \%revdata,
> +					      $rev_color[$current_color],
> +					      $last_rev, @first);
> +		}
> +		push @chunk, [$lineno, $data];
> +	}
> +	if (@chunk) {
> +		git_blame_flush_chunk_1($chunk_cap,
> +					$file_name,
> +					\%revdata,
> +					$rev_color[$current_color],
> +					$last_rev, @chunk);
>  	}
>  	print "</table>\n";
>  	print "</div>";
> -- 
> 1.4.2.3.gbe06
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
