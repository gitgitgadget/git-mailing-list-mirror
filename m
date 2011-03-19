From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/2] gitweb: introduce localtime feature
Date: Sat, 19 Mar 2011 10:56:27 -0700
Message-ID: <7v39mjro38.fsf@alter.siamese.dyndns.org>
References: <ab54ba2199cc7487e383a31e3aa65885@localhost>
 <dab08d0ff27b0f571a17ed4f1ab0f39b@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 18:56:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q10OV-0003jy-Ip
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 18:56:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757035Ab1CSR4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 13:56:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60650 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756828Ab1CSR4j (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 13:56:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 594BD3DFC;
	Sat, 19 Mar 2011 13:58:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cBHA8m6kpHbt62sSTg6BG2g4uZc=; b=CNt48+
	fauewk3zc3m0liBzRcKk3MPhWpleK6b9OEkLSXe6Eaek6G2buLapCI3FvvSl9qJG
	1KAOwePsWBrZWx40PYGjH4Wy0o/MP9fZjdnMo3FrtxeWeiJbjl4yL/VaCPOiW+Z3
	J+wK/LbsmhNgrfBHWdjXvaha3ZxijLW/NjGfg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VOm8GduGST8gSEO/WGIbUwDAAs0buVBz
	WywsECZg+35oZAHvhJUK0hK9aDf25iq1nrv/Tzh1/W8FaLGsgkbkr6fGDOMPsPqp
	sPwkJ55MQRnabBo6EBN8omLVfRYyriafwc0vkbcdaTiLL7x/Zutl0azXP/Mpt07d
	M+1lFVQdiq0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 296173DFB;
	Sat, 19 Mar 2011 13:58:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D1D2C3DFA; Sat, 19 Mar 2011
 13:58:05 -0400 (EDT)
In-Reply-To: <dab08d0ff27b0f571a17ed4f1ab0f39b@localhost> (Kevin Cernekee's
 message of "Fri, 18 Mar 2011 22:39:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 739114BA-5252-11E0-90D0-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169451>

Kevin Cernekee <cernekee@gmail.com> writes:

> -sub format_local_time {
> -	my $localtime = '';
> -	my %date = @_;
> -	if ($date{'hour_local'} < 6) {
> -		$localtime .= sprintf(" (<span class=\"atnight\">%02d:%02d</span> %s)",
> -			$date{'hour_local'}, $date{'minute_local'}, $date{'tz_local'});

Looks like we used to only paint HH:MM part but... 

> +# Returns an RFC 2822 timestamp string, which may contain HTML.
> +# If $use_localtime is 0, don't do anything special.
> +# If $use_localtime is 1, add an alternate HH:MM timestamp in parentheses at
> +# the end.  If $feature{'localtime'} is enabled this looks like:
> +#   Thu, 17 Mar 2011 18:28:57 -0700 (01:28 +0000)
> +# Otherwise, it looks like:
> +#   Fri, 18 Mar 2011 01:28:57 +0000 (18:28 -0700)
> +# If $use_localtime is 1, this will also apply the "atnight" style to
> +# local times between 00:00 and 05:59.
> +sub timestamp_html {
> +	my %date = %{$_[0]};
> +	my $use_localtime = $_[1];
> +	my $timestamp;
> +	my $alt_time;
> +
> +	if (gitweb_check_feature('localtime')) {
> +		$timestamp = $date{'rfc2822_local'};
> +		if ($use_localtime && $date{'hour_local'} < 6) {
> +			$timestamp = "<span class=\"atnight\">" .
> +			             $timestamp .
> +			             "</span>";
> +		}
> +		$alt_time = sprintf(" (%02d:%02d %s)",
> +		                    $date{'hour'}, $date{'minute'}, "+0000");
>  	} else {
> -		$localtime .= sprintf(" (%02d:%02d %s)",
> -			$date{'hour_local'}, $date{'minute_local'}, $date{'tz_local'});
> +		$timestamp = $date{'rfc2822'};
> +		$alt_time = sprintf(" (%02d:%02d %s)",
> +				    $date{'hour_local'},
> +				    $date{'minute_local'},
> +				    $date{'tz_local'});
> +		if ($use_localtime && $date{'hour_local'} < 6) {
> +			$alt_time = "<span class=\"atnight\">" .
> +			            $alt_time .
> +			            "</span>";
> +		}

... we now paint the whole line, which I personally think is a friendly
move for color challenged people (me included---a larger span of text
painted in different colors tends to help you still notice it better using
value/brightness difference, even if your hue perception is weaker than
other people). But it is a change from the old behaviour and might be
worth stating in the log message.

> -	return $localtime;
> +	if ($use_localtime) {
> +		$timestamp .= $alt_time;
> +	}

You kept -localtime nobody uses? If you dig the history, you would notice
that it is merely a remnant of f88bafa (gitweb: uniform author info for
commit and commitdiff, 2009-06-30) that forgot to remove the feature while
removing the last callsite, and I don't think anybody even was against
such a change.

I'd suggest to remove $alt_time codepath from this function. Nobody will
notice.

>  # Outputs the author name and date in long form
> @@ -3956,10 +3999,9 @@ sub git_print_authorship {
>  	my %ad = format_date($co->{'author_epoch'}, $co->{'author_tz'});
>  	print "<$tag class=\"author_date\">" .
>  	      format_search_author($author, "author", esc_html($author)) .
> -	      " [$ad{'rfc2822'}";
> -	print_local_time(%ad) if ($opts{-localtime});
> -	print "]" . git_get_avatar($co->{'author_email'}, -pad_before => 1)
> -		  . "</$tag>\n";
> +	      " [" . timestamp_html(\%ad, 0) . "] ".
> ...
>  # Outputs table rows containing the full author or committer information,
> @@ -3983,9 +4025,9 @@ sub git_print_authorship_rows {
> -		print "</td>" .
> +		      "<td></td><td> " .
> +		      timestamp_html(\%wd, 1) .
> +		      "</td>" .

While I don't agree with Jakub about the presense / absence of "[]" around
it (that is not a part of "timestamp", but is how the caller wants to
prepare the space to plug a timestamp string in), I do agree that the
second parameter "use-localtime" looks funny, not because it is an unnamed
parameter (which I personally think is fine) but because it isn't about
the localness of the displayed time anymore.  Your 'localtime' feature
alone controls in which timezone the timestamp is shown, and this only
controls the use of 'atnight' highlighting. The parameter needs to be
renamed, and perhaps you may clarify it further by making it a keyword
argument as Jakub suggests.

Other than that, I think this round is very nicely done.

This is a complete tangent, but I wonder if it makes sense to keep the
output from print_authorship plain (no atnight markings) while painting
the output from print_authorship_rows.

I would understand it if the design _were_ to paint late-nite commits
differently when we list multiple commits in a row (e.g. summary view) to
make them easier to stand out (for amusement purposes), and not to paint
the timestamp when we show only one commit to avoid distraction.  But that
doesn't seem to be the case.
