From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] gitweb: linkify author/committer names with search
Date: Mon, 12 Oct 2009 16:42:08 -0700
Message-ID: <7vy6ng5gdr.fsf@alter.siamese.dyndns.org>
References: <1255328340-28449-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 01:43:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxUY8-0007dA-OQ
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 01:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756934AbZJLXnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 19:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756810AbZJLXm7
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 19:42:59 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38969 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756814AbZJLXm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 19:42:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7B10775812;
	Mon, 12 Oct 2009 19:42:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Qwrhe/bbEbXVExYwj0MXWHRKpN0=; b=RZ6ISqsmrds9RXbUItd/DVY
	78nrb//jA/Hz3Cogp/9ijjYbbNt9u3kRmV1DeXPJ+MLOv02XXgUb6IL06n0Tu+pF
	qjrdrjtmlCIjRdNCtDQ11V6i7oQAvZ8sFNtHHrULr1UyB0dkCikdorsnsdYAMDe6
	OUFKeGdR3eiNWnoQTGAk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=n6hyd/fWMjG7EgYI+pMdcSzXR2m7cWgQ/iR/ds7RzfAvHccRt
	kGP/FZOUdPHcvAQjt1KdhpeT3DlBa3KAGV/cqIiwuxCTcRb7BEl3+KeB+YQkZYb1
	FuvKiQdfSZ77miaxC5CAL5C/ffAm+kYAw1X67tlrdF/BNROuAZJ70gBJmA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 52B937580F;
	Mon, 12 Oct 2009 19:42:14 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CAC2A7580E; Mon, 12 Oct 2009
 19:42:09 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DE6F1EBE-B788-11DE-AF4F-1000076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130095>

Stephen Boyd <bebarino@gmail.com> writes:

> It's nice to search for an author by merely clicking on their name in
> gitweb. This is usually faster than selecting the name, copying the
> selection, pasting it into the search box, selecting between
> author/committer and then hitting enter.

The intent makes sense to me, although I somehow suspect that with avatar
support the user might be tempted to click on the icon not necessarily on
the name string.

> Signed-off-by: Stephen Boyd <bebarino@gmail.com>
> ---
>
> Cc'ed Jakub as he seems to be resident gitweb expert. 
>
> I thought this might be a nice addition.
>
> The problem is I can't get it to work with UTF-8 characters. I'm not sure
> if it's my system or not, so I'm just posting here to see if others
> experience the same problem and if there's interest.
>
>  gitweb/gitweb.perl |   18 ++++++++++++++----
>  1 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 24b2193..349e734 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1604,7 +1604,10 @@ sub format_author_html {
>  	my $author = chop_and_escape_str($co->{'author_name'}, @_);
>  	return "<$tag class=\"author\">" .
>  	       git_get_avatar($co->{'author_email'}, -pad_after => 1) .
> -	       $author . "</$tag>";
> +	       $cgi->a({-href => href(action=>"search", hash=>$hash,
> +			searchtext=>$co->{'author_name'},
> +			searchtype=>"author"), class=>"list"}, $author) .
> +	       "</$tag>";
>  }
>  
>  # format git diff header line, i.e. "diff --(git|combined|cc) ..."
> @@ -3373,10 +3376,13 @@ sub git_print_authorship {
>  	my $co = shift;
>  	my %opts = @_;
>  	my $tag = $opts{-tag} || 'div';
> +	my $author = $co->{'author_name'};
>  
>  	my %ad = parse_date($co->{'author_epoch'}, $co->{'author_tz'});
>  	print "<$tag class=\"author_date\">" .
> -	      esc_html($co->{'author_name'}) .
> +	      $cgi->a({-href => href(action=>"search", searchtext=>$author,
> +		      searchtype=>"author"), class=>"list"},
> +		      esc_html($author)) .
>  	      " [$ad{'rfc2822'}";
>  	print_local_time(%ad) if ($opts{-localtime});
>  	print "]" . git_get_avatar($co->{'author_email'}, -pad_before => 1)
> @@ -3395,8 +3401,12 @@ sub git_print_authorship_rows {
>  	@people = ('author', 'committer') unless @people;
>  	foreach my $who (@people) {
>  		my %wd = parse_date($co->{"${who}_epoch"}, $co->{"${who}_tz"});
> -		print "<tr><td>$who</td><td>" . esc_html($co->{$who}) . "</td>" .
> -		      "<td rowspan=\"2\">" .
> +		print "<tr><td>$who</td><td>" .
> +		      $cgi->a({-href => href(action=>"search",
> +			       searchtext=>$co->{"${who}_name"},
> +			       searchtype=>$who), class=>"list"},
> +			       esc_html($co->{$who})) .
> +		      "</td><td rowspan=\"2\">" .
>  		      git_get_avatar($co->{"${who}_email"}, -size => 'double') .
>  		      "</td></tr>\n" .
>  		      "<tr>" .
> -- 
> 1.6.5.1.g53fd
