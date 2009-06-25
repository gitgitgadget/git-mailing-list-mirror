From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv6 1/8] gitweb: refactor author name insertion
Date: Fri, 26 Jun 2009 00:55:10 +0200
Message-ID: <200906260055.11347.jnareb@gmail.com>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com> <1245926587-25074-2-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 00:55:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJxqh-00062S-PM
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 00:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755423AbZFYWzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 18:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754978AbZFYWzM
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 18:55:12 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:30757 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754544AbZFYWzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 18:55:09 -0400
Received: by fg-out-1718.google.com with SMTP id e12so664748fga.17
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 15:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=eDBizQam8YYIZ24D5MvlgJegJ7IoZ0UGNn53ThczXLQ=;
        b=O7oB3MqPhXqUqFfIYku8pPHqtuloUFZGy075ZhXPk0xIPxIPvFTCPbxXv4mjxeJZ44
         IA3g6NYlwFjrXPtIWX5QlZK00vZuXZ8q4ga9Lzs1ZByAAGV2uYThYJEDhc+cARLCq7dK
         ggiZ+SRZZGrVvCVNkH2CLrVSa96eirQxa74dI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=h5JLwcjvq4d0uaQqwPNyHsEkFB/Rh6J5Alcc2nhaiTBws2eL7YSgDjX/KzhqyILDbV
         rS/L0u59qBlk8mBMY6JYAoSghO7HouN1tYVf9y84ptqcVW7Rh4OqBqaeJX7mMpYaY/9p
         +9eqPgeZaljOHrHFXOCiy6Z2e0I715nv5lef8=
Received: by 10.86.36.4 with SMTP id j4mr3121224fgj.63.1245970511324;
        Thu, 25 Jun 2009 15:55:11 -0700 (PDT)
Received: from ?192.168.1.13? (abwu167.neoplus.adsl.tpnet.pl [83.8.244.167])
        by mx.google.com with ESMTPS id l19sm5515550fgb.16.2009.06.25.15.55.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Jun 2009 15:55:10 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1245926587-25074-2-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122256>

On Thu, 25 June 2009, Giuseppe Bilotta wrote:

> Collect all author display code in appropriate functions, making it
> easiser to extend them on the CGI side, and rely on CSS rather than
> hard-coded HTML formatting for easier customization.

Typo: s/easiser/easier/ 

This paragraph could have been written better, perhaps by dividing it
in two sentences: one talking about collecting/factoring common code,
one talking about moving from presentational HTML (<i>, <b> tags) to
styling using CSS and class attribute.

Do I understand it correctly that this was meant as pure refactoring,
i.e. that none of gitweb output should have changed?  Because you made
a mistake, and 'log' view is broken (and it doesn't look like it did
before).  See comments below for cause and (simple) solution.

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---

What are the changes as compared to previous (or just earlier) version?

>  gitweb/gitweb.css  |    5 ++-
>  gitweb/gitweb.perl |   80 +++++++++++++++++++++++++++++++---------------------
>  2 files changed, 52 insertions(+), 33 deletions(-)
> 
> diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
> index a01eac8..68b22ff 100644
> --- a/gitweb/gitweb.css
> +++ b/gitweb/gitweb.css
> @@ -132,11 +132,14 @@ div.list_head {
>  	font-style: italic;
>  }
>  
> +.author_date, .author {
> +	font-style: italic;
> +}
> +
>  div.author_date {
>  	padding: 8px;
>  	border: solid #d9d8d1;
>  	border-width: 0px 0px 1px 0px;
> -	font-style: italic;
>  }

Nice.

>  
>  a.list {
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 1e7e2d8..9b60418 100755
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
> +	return "<$tag class=\"author\">" . $author . "</$tag>\n";
> +}

Good... although I wonder if we should not get rid of chop_and_escape_str
altogether, and for example add title attribute (if needed due to having
to do shortening) directly to $tag, and not to inner <span> element.

Should "\n" be in returned string? Just asking.

> +
>  # format git diff header line, i.e. "diff --(git|combined|cc) ..."
>  sub format_git_diff_header_line {
>  	my $line = shift;
> @@ -3214,13 +3224,36 @@ sub git_print_header_div {
>  	      "\n</div>\n";
>  }
>  
> +# Outputs the author name and date in long form
>  sub git_print_authorship {
>  	my $co = shift;
> +	my %params = @_;
> +	my $tag = $params{'tag'} || 'div';

Nice using of hash to have named optional params.

Usually though we use %opts and not %params for the name of this
hash, and we use CGI-like keys prefixed by '-', for example
'-z' in parse_ls_tree_line(), '-nbsp' in esc_html, '-nohtml' in 
quot_cec(),  '-remove_title', '-remove_signoff' and '-final_empty_line'
in git_print_log().  git_commitdiff() uses %params, but it doesn't
have non-optional parameters (still, I guess we should use %opts
for consistency), and it uses '-format' and '-single' as names.

href() subroutine uses %params... but those are not extra named
optional parameters to subroutine; they are CGI query parameters.


NOTE: Default tag (as used in git_log) should be not generic block 
element tag: 'div', but rather generic inline element: 'span'.  The
presentational HTML element '<i>' which we are replacing is inline
(layout) element.

It is because it is '<div>' (and probably because some "random" CSS
rules in gitweb.css match it) it breaks layout or 'log' view.  There
two horizontal lines: one for <div> element, and one for unnecessary
now <br> element.  As div.author_date it has extra 8px padding, from
which the top padding is visible as extra unnecessary vertical space.

>  
>  	my %ad = parse_date($co->{'author_epoch'}, $co->{'author_tz'});
> -	print "<div class=\"author_date\">" .
> +	print "<$tag class=\"author_date\">" .
>  	      esc_html($co->{'author_name'}) .
>  	      " [$ad{'rfc2822'}";
> +	if ($params{'localtime'}) {
> +		if ($ad{'hour_local'} < 6) {
> +			printf(" (<span class=\"atnight\">%02d:%02d</span> %s)",
> +			       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
> +		} else {
> +			printf(" (%02d:%02d %s)",
> +			       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
> +		}
> +	}
> +	print "]</$tag>\n";
> +}

Gaah, git has chosen to show this diff a bit strangely...

> +
> +# Outputs table rows containign the full author and commiter information.

Typo: s/containign/containing/

You could say that it uses format used to show author and comitter fields
(headers) in 'commit' view.

> +sub git_print_full_authorship {
> +	my $co = shift;
> +	my %ad = parse_date($co->{'author_epoch'}, $co->{'author_tz'});
> +	my %cd = parse_date($co->{'committer_epoch'}, $co->{'committer_tz'});
> +	print "<tr><td>author</td><td>" . esc_html($co->{'author'}) . "</td></tr>\n".
> +	      "<tr>" .
> +	      "<td></td><td> $ad{'rfc2822'}";
>  	if ($ad{'hour_local'} < 6) {
>  		printf(" (<span class=\"atnight\">%02d:%02d</span> %s)",
>  		       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
> @@ -3228,7 +3261,12 @@ sub git_print_authorship {
>  		printf(" (%02d:%02d %s)",
>  		       $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
>  	}
> -	print "]</div>\n";
> +	print "</td>" .
> +	      "</tr>\n";
> +	print "<tr><td>committer</td><td>" . esc_html($co->{'committer'}) . "</td></tr>\n";
> +	print "<tr><td></td><td> $cd{'rfc2822'}" .
> +	      sprintf(" (%02d:%02d %s)", $cd{'hour_local'}, $cd{'minute_local'}, $cd{'tz_local'}) .
> +	      "</td></tr>\n";
>  }

By the way, what about author / tagger info used in 'tag' view?
Wouldn't it be better to factor out generating table rows for single
author / committer / tagger header (field) info?

>  
>  sub git_print_page_path {
> @@ -4142,11 +4180,9 @@ sub git_shortlog_body {
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

Nice refactoring and simplification.

> @@ -4193,11 +4229,9 @@ sub git_history_body {
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

Nice refactoring and simplification.
Good comment.

> @@ -4350,9 +4384,8 @@ sub git_search_grep_body {
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

Nice refactoring and simplification.

> @@ -5094,9 +5127,9 @@ sub git_log {
>  		      " | " .
>  		      $cgi->a({-href => href(action=>"tree", hash=>$commit, hash_base=>$commit)}, "tree") .
>  		      "<br/>\n" .
> -		      "</div>\n" .
> -		      "<i>" . esc_html($co{'author_name'}) .  " [$ad{'rfc2822'}]</i><br/>\n" .
>  		      "</div>\n";
> +		      git_print_authorship(\%co);
> +		      print "<br/>\n</div>\n";
>  
>  		print "<div class=\"log_body\">\n";
>  		git_print_log($co{'comment'}, -final_empty_line=> 1);

Here you replace inline <i> element with <div> _block_ element, 
destroying layout.  Replacing default of 'div' by default of
inline <span> element restores old layout.

> @@ -5115,8 +5148,6 @@ sub git_commit {
>  	$hash ||= $hash_base || "HEAD";
>  	my %co = parse_commit($hash)
>  	    or die_error(404, "Unknown commit object");
> -	my %ad = parse_date($co{'author_epoch'}, $co{'author_tz'});
> -	my %cd = parse_date($co{'committer_epoch'}, $co{'committer_tz'});
>  
>  	my $parent  = $co{'parent'};
>  	my $parents = $co{'parents'}; # listref
> @@ -5183,22 +5214,7 @@ sub git_commit {
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
> +	git_print_full_authorship(\%co);
>  	print "<tr><td>commit</td><td class=\"sha1\">$co{'id'}</td></tr>\n";
>  	print "<tr>" .
>  	      "<td>tree</td>" .

I'd rather use here (as mentioned in comment about git_print_full_authorship
subroutine) something like the following:

+	git_print_authorship_header(\%co, 'author');
+	git_print_authorship_header(\%co, 'committer');

Or something like that.  But this might be a matter of taste.

> @@ -5579,7 +5595,7 @@ sub git_commitdiff {
>  		git_header_html(undef, $expires);
>  		git_print_page_nav('commitdiff','', $hash,$co{'tree'},$hash, $formats_nav);
>  		git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash);
> -		git_print_authorship(\%co);
> +		git_print_authorship(\%co, 'localtime' => 1);
>  		print "<div class=\"page_body\">\n";
>  		if (@{$co{'comment'}} > 1) {
>  			print "<div class=\"log\">\n";

Nice.  Although... 'localtime' / '-localtime'?  Perhaps '-show_localtime'?
But that is just nitpicking (naming is hard), and I am not sure if 
proposed name is any better.

> -- 
> 1.6.3.rc1.192.gdbfcb
> 
> 

Thank you for diligent work on this patch series!

-- 
Jakub Narebski
Poland
