From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv7 1/9] gitweb: refactor author name insertion
Date: Sat, 27 Jun 2009 16:24:51 +0200
Message-ID: <200906271624.52372.jnareb@gmail.com>
References: <1246104305-15191-1-git-send-email-giuseppe.bilotta@gmail.com> <1246104305-15191-2-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 16:25:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKYqK-0001Ty-PM
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 16:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbZF0OZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2009 10:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751722AbZF0OY7
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 10:24:59 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:58831 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411AbZF0OY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2009 10:24:58 -0400
Received: by fxm18 with SMTP id 18so199468fxm.37
        for <git@vger.kernel.org>; Sat, 27 Jun 2009 07:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=zZXcF7T1lQLPiZtuzRjMXJDQjWOgvNLJ9z8EW6cionc=;
        b=sPDOJSbriQFwPfbdW321nYYPqjpKs7vh/OfQcuVfv5A+TxY+nKY5bk22HFVkbST5dX
         xlNZoLzc7pOvmnEZS9safoUjNTcfdOVBK04D2eFS/rBWcHORYkB/E5A6hPzNdchg4lgU
         poKpA2lzIScP8wRM67+XzVE3/7ti9tLltrl7A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=QNtFOCjgB/Y4RL0T6dlhF0Q2eXkEIfvCEHEW+xsJZIvkg48ykWWedhzr6MVkTjG7Za
         w6++e86mFjqpQUv8rxYLHWnUtNOkQH7tYaf08xY0QABeE9BmAr1XwelsqKawKMKEgVqr
         A30qKkgQULlGICqy8FJGpLaB5ZlV9Xq2ArzpQ=
Received: by 10.103.218.9 with SMTP id v9mr2923404muq.109.1246112700494;
        Sat, 27 Jun 2009 07:25:00 -0700 (PDT)
Received: from ?192.168.1.13? (abwd106.neoplus.adsl.tpnet.pl [83.8.227.106])
        by mx.google.com with ESMTPS id s11sm12058225mue.41.2009.06.27.07.24.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Jun 2009 07:24:59 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1246104305-15191-2-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122365>

On Sat, 27 June 2009, Giuseppe Bilotta wrote:

> Collect all author display code in appropriate functions, making it
> easier to extend these functions on the CGI side.
> 
> We also move some of the presentation code from hard-coded HTML to CSS,
> for easier customization.

Very nicely written, compact yet comprehensive commit message.

It _might_ be worth adding that accidentally commit date got "atnight"
warning too.  I consider that improvement, even though for local commit
(committer == author) it duplicates information.  And it removes
(some of) code duplication.

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

If not for the fact that due to typo you lost localtime info from
'commitdiff' view, I would ACK it.

> ---
>  gitweb/gitweb.css  |    5 ++-
>  gitweb/gitweb.perl |   96 +++++++++++++++++++++++++++++++--------------------
>  2 files changed, 62 insertions(+), 39 deletions(-)

[...]
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 1e7e2d8..9be723c 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1469,6 +1469,16 @@ sub format_subject_html {
>  	}
>  }
>  
> +# format the author name of the given commit with the given tag
> +# the author name is chopped and escaped according to the other
> +# optional parameters (see chop_str).
> +sub format_author_html {
> +	my $tag = shift;
> +	my $co = shift;
> +	my $author = chop_and_escape_str($co->{'author_name'}, @_);
> +	return "<$tag class=\"author\">" . $author . "</$tag>";
> +}

In the future we might want to change it so instead of

  <$tag class="author"><span title="Joe Random Hacker">Joe Random... </span></$tag>

we would use 'title' attribute of $tag element

  <$tag class="author" title="Joe Random Hacker">Joe Random... </$tag>

But I guess this is not worth complicating code required to do this.

> +
>  # format git diff header line, i.e. "diff --(git|combined|cc) ..."
>  sub format_git_diff_header_line {
>  	my $line = shift;
> @@ -3214,21 +3224,53 @@ sub git_print_header_div {
>  	      "\n</div>\n";
>  }
>  
> +# Outputs the author name and date in long form
>  sub git_print_authorship {
>  	my $co = shift;
> +	my %opts = @_;
> +	my $tag = $opts{-tag} || 'div';

BTW. gitweb is a bit inconsistent here.  Sometimes we use $opts{'-tag'}
form, and sometimes $opts{-tag} form like you use here.

(Actually we use '-' prefixing i.e. '-key' not 'key' to make it safe
to write  $opts{-key}  and  -key => 1).

>  
>  	my %ad = parse_date($co->{'author_epoch'}, $co->{'author_tz'});
> -	print "<div class=\"author_date\">" .
> +	print "<$tag class=\"author_date\">" .
>  	      esc_html($co->{'author_name'}) .
>  	      " [$ad{'rfc2822'}";
> -	if ($ad{'hour_local'} < 6) {
> -		printf(" (<span class=\"atnight\">%02d:%02d</span> %s)",
> -		       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
> -	} else {
> -		printf(" (%02d:%02d %s)",
> -		       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
> +	if ($opts{-localtime}) {
> +		if ($ad{'hour_local'} < 6) {
> +			printf(" (<span class=\"atnight\">%02d:%02d</span> %s)",
> +			       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
> +		} else {
> +			printf(" (%02d:%02d %s)",
> +			       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
> +		}
> +	}

By the way, this "atnight" warning is duplicated in subroutine below
git_print_authorship_rows(), but IMHO it is not something very important.
It can be left for later.

> +	print "]</$tag>\n";
> +}
> +
> +# Outputs table rows containing the full author or committer information,
> +# in the format expected for 'commit' view (& similia).
> +# Parameters are a commit hash reference, followed by the list of people
> +# to output information for. If the list is empty it defalts to both
> +# author and committer.
> +sub git_print_authorship_rows {
> +	my $co = shift;
> +	# too bad we can't use @people = @_ || ('author', 'committer')
> +	my @people = @_;
> +	@people = ('author', 'committer') unless @people;
> +	foreach my $who (@people) {
> +		my %ad = parse_date($co->{$who . '_epoch'}, $co->{$who . '_tz'});

Wouldn't

  $co->{"${who}_epoch"}

be simpler than

  $co->{$who . '_epoch'}

Also it is now %wd (%who_date) or just %date rather than 
%ad (%author_date) vs %cd (%committer_date).


Both of those issues are very, very minor.

> +		print "<tr><td>$who</td><td>" . esc_html($co->{$who}) . "</td></tr>\n".
> +		      "<tr>" .
> +		      "<td></td><td> $ad{'rfc2822'}";

> +		if ($ad{'hour_local'} < 6) {
> +			printf(" (<span class=\"atnight\">%02d:%02d</span> %s)",
> +			       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
> +		} else {
> +			printf(" (%02d:%02d %s)",
> +			       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
> +		}

This is a bit of code duplication with git_print_authorship(),
but I don't think it is something seriously to worry about.

> +		print "</td>" .
> +		      "</tr>\n";
>  	}

> -	print "]</div>\n";

Heh.  Strange quirks of diff algorithm... :-)

>  }
>  
>  sub git_print_page_path {
> @@ -4142,11 +4184,9 @@ sub git_shortlog_body {
>  			print "<tr class=\"light\">\n";
>  		}
>  		$alternate ^= 1;
> -		my $author = chop_and_escape_str($co{'author_name'}, 10);
>  		# git_summary() used print "<td><i>$co{'age_string'}</i></td>\n" .
>  		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
> -		      "<td><i>" . $author . "</i></td>\n" .
> -		      "<td>";
> +		      format_author_html('td', \%co, 10) . "<td>";
>  		print format_subject_html($co{'title'}, $co{'title_short'},
>  		                          href(action=>"commit", hash=>$commit), $ref);
>  		print "</td>\n" .

Nice.

> @@ -4193,11 +4233,9 @@ sub git_history_body {
>  			print "<tr class=\"light\">\n";
>  		}
>  		$alternate ^= 1;
> -	# shortlog uses      chop_str($co{'author_name'}, 10)
> -		my $author = chop_and_escape_str($co{'author_name'}, 15, 3);
>  		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
> -		      "<td><i>" . $author . "</i></td>\n" .
> -		      "<td>";
> +	# shortlog:   format_author_html('td', \%co, 10)
> +		      format_author_html('td', \%co, 15, 3) . "<td>";
>  		# originally git_history used chop_str($co{'title'}, 50)
>  		print format_subject_html($co{'title'}, $co{'title_short'},
>  		                          href(action=>"commit", hash=>$commit), $ref);

Nice.  Good, well aligned comment.

> @@ -4350,9 +4388,8 @@ sub git_search_grep_body {
>  			print "<tr class=\"light\">\n";
>  		}
>  		$alternate ^= 1;
> -		my $author = chop_and_escape_str($co{'author_name'}, 15, 5);
>  		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
> -		      "<td><i>" . $author . "</i></td>\n" .
> +		      format_author_html('td', \%co, 15, 5) .
>  		      "<td>" .
>  		      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'}),
>  		               -class => "list subject"},

Nice... although this set of diff chunks made me wonder why we
use "10" for 'shortlog', "15, 3" for 'history, and "15, 5" for 
'search' (grep).

> @@ -5094,9 +5131,9 @@ sub git_log {
>  		      " | " .
>  		      $cgi->a({-href => href(action=>"tree", hash=>$commit, hash_base=>$commit)}, "tree") .
>  		      "<br/>\n" .
> -		      "</div>\n" .
> -		      "<i>" . esc_html($co{'author_name'}) .  " [$ad{'rfc2822'}]</i><br/>\n" .
>  		      "</div>\n";
> +		      git_print_authorship(\%co, -tag => 'span');
> +		      print "<br/>\n</div>\n";
>  
>  		print "<div class=\"log_body\">\n";
>  		git_print_log($co{'comment'}, -final_empty_line=> 1);

This preserves layout.  Good.

I see you choose to correct mentioned issue this way.

> @@ -5115,8 +5152,6 @@ sub git_commit {
>  	$hash ||= $hash_base || "HEAD";
>  	my %co = parse_commit($hash)
>  	    or die_error(404, "Unknown commit object");
> -	my %ad = parse_date($co{'author_epoch'}, $co{'author_tz'});
> -	my %cd = parse_date($co{'committer_epoch'}, $co{'committer_tz'});
>  
>  	my $parent  = $co{'parent'};
>  	my $parents = $co{'parents'}; # listref
> @@ -5183,22 +5218,7 @@ sub git_commit {
>  	}
>  	print "<div class=\"title_text\">\n" .
>  	      "<table class=\"object_header\">\n";
> -	print "<tr><td>author</td><td>" . esc_html($co{'author'}) . "</td></tr>\n".
> -	      "<tr>" .
> -	      "<td></td><td> $ad{'rfc2822'}";
> -	if ($ad{'hour_local'} < 6) {
> -		printf(" (<span class=\"atnight\">%02d:%02d</span> %s)",
> -		       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
> -	} else {
> -		printf(" (%02d:%02d %s)",
> -		       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
> -	}
> -	print "</td>" .
> -	      "</tr>\n";
> -	print "<tr><td>committer</td><td>" . esc_html($co{'committer'}) . "</td></tr>\n";
> -	print "<tr><td></td><td> $cd{'rfc2822'}" .
> -	      sprintf(" (%02d:%02d %s)", $cd{'hour_local'}, $cd{'minute_local'}, $cd{'tz_local'}) .
> -	      "</td></tr>\n";
> +	git_print_authorship_rows(\%co);
>  	print "<tr><td>commit</td><td class=\"sha1\">$co{'id'}</td></tr>\n";
>  	print "<tr>" .
>  	      "<td>tree</td>" .

Nice simplification.  Even without making 'commitdiff' use the same
authorship info layout like 'commit', and 'tag' reusing this subroutine
it might have been worth it.

> @@ -5579,7 +5599,7 @@ sub git_commitdiff {
>  		git_header_html(undef, $expires);
>  		git_print_page_nav('commitdiff','', $hash,$co{'tree'},$hash, $formats_nav);
>  		git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash);
> -		git_print_authorship(\%co);
> +		git_print_authorship(\%co, 'localtime' => 1);
>  		print "<div class=\"page_body\">\n";
>  		if (@{$co{'comment'}} > 1) {
>  			print "<div class=\"log\">\n";

ATTENTION !!!

You should have

  -		git_print_authorship(\%co);
  +		git_print_authorship(\%co, '-localtime' => 1);

here ('-localtime' instead of 'localtime'), otherwise you will loose
localtime information (and "atnight" warning) from 'commitdiff' view.


Thanks again for your diligent work on this patch series!

-- 
Jakub Narebski
Poland
