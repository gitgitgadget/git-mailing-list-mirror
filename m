From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3 (alternate)] gitweb: Mark "atnight" author/committer
 times also for 'localtime'
Date: Fri, 18 Mar 2011 13:48:35 -0700
Message-ID: <7vmxksw3x8.fsf@alter.siamese.dyndns.org>
References: <c8621826e0576e3e31240b0205e7e3d0@localhost>
 <64c70e95e767572e5be732dc7e17815b@localhost>
 <201103181846.04979.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Cernekee <cernekee@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 21:49:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0gbX-0003S7-LX
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 21:49:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757278Ab1CRUst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 16:48:49 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63842 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756932Ab1CRUss (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 16:48:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 231F34FCB;
	Fri, 18 Mar 2011 16:50:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mSDp489M88/xHS2TgtMtGHnVnXk=; b=XW7EP4
	GO/GxCJZUbA8rtcwoYchunXLHEHHX3veyZlWN/vhryrKOSm/BuglLN+qoVoAnxrx
	DYt9lUXv5qTYoj8kjLlGyl5QJbRvuwPHWXy26bTLu9ihlqI4/ih9hzxVje1/LC6J
	DL676amhMrmSmfWuI+KzNHxvahI5/OpV/xTLo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gjdmmB5LUZKx9hRUTHZFpE2WxIuL/i8X
	VwmMnD9Tkn3Io4inyIWLqJwYadkmeHxiYI3qDWAewdQhU1UyjMiqyNjEGgKOyeEJ
	pz3aq02uBq5lqJkASFAUpp09rTpZRZKmCGOSQiVgomRnRELByLcRs/b0okCaS97m
	BszINpTu1/I=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E24684FC7;
	Fri, 18 Mar 2011 16:50:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B9D364FC3; Fri, 18 Mar 2011
 16:50:11 -0400 (EDT)
In-Reply-To: <201103181846.04979.jnareb@gmail.com> (Jakub Narebski's message
 of "Fri, 18 Mar 2011 18:46:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 54622C5C-51A1-11E0-A1A4-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169356>

Jakub Narebski <jnareb@gmail.com> writes:

> Kevin, how about something like this instead?  This preserves _intent_
> for why there is local time beside GMT time when 'localtime' is disabled
> better, I think.
>
> Junio and Kevin, I am not sure if authorship should remain with Kevin,
> or should it revert to me; the solution is quite different.
> About no-change to git_print_authorship: alternate solution would be
> to remove support for -localtime option, like in original patches.

I don't think it is worth anything to keep dead code that anybody
exercises to support -localtime option that nobody asks.

I thought we were getting closer (especially if you consider my suggestion
to the earlier round, but obviously I am biased), but this looks far worse
than your previous clean-up of Kevin's patch.  What is the point of
duplicating the atnight logic her?  Why not kill the useless helper
function "print-local-time", and instead enhance "format-local-time" so
that whatever this added code does is performed there when the caller asks?

Then the caller here would look more or less like:

	print "<tr><td>$who</td>" .
              "... author name, email, avatar ..." .
	      "<td></td><td>" .
              format_timestamp(\%wd, gitweb_check_feature('localtime')) .
	      "</td></tr>\n";

and format_timestamp would be like

	sub format_timestamp {
		my %date = %$_[0];
                my $use_localtime = $_[1];
		my $localtime, $ret, $nite;

		$nite = ($date{'hour_local'} < 6);

		if ($use_localtime) {
			$ret = $date{'rfc2822_local'};
                        if ($nite) {
                        	$ret = sprintf("<span class='atnight'>%s</span>", $ret);
			}
		} else {
			... what the current format_local_time does to set
	                ... including the spanning part
                        $ret = "$date{'rfc2822'} ($localtime)";
		}
		return $ret;
	}

Wouldn't it be much cleaner?  You can then clean up the other call site of
print_local_time in git_print_authorship using the same helper function
(presumably you would always pass 0 to $use_localtime there), no?

>  gitweb/gitweb.perl |   16 ++++++++++++----
>  1 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index cdc2a96..5bda0a8 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -4003,15 +4003,23 @@ sub git_print_authorship_rows {
>  		my %wd = parse_date($co->{"${who}_epoch"}, $co->{"${who}_tz"});
>  		print "<tr><td>$who</td><td>" .
>  		      format_search_author($co->{"${who}_name"}, $who,
> -			       esc_html($co->{"${who}_name"})) . " " .
> +		                           esc_html($co->{"${who}_name"})) . " " .
>  		      format_search_author($co->{"${who}_email"}, $who,
> -			       esc_html("<" . $co->{"${who}_email"} . ">")) .
> +		                           esc_html("<" . $co->{"${who}_email"} . ">")) .
>  		      "</td><td rowspan=\"2\">" .
>  		      git_get_avatar($co->{"${who}_email"}, -size => 'double') .
>  		      "</td></tr>\n" .
>  		      "<tr>" .
> -		      "<td></td><td> $wd{'rfc2822'}";
> -		print_local_time(%wd) if !gitweb_check_feature('localtime');
> +		      "<td></td><td> ";
> +		if (gitweb_check_feature('localtime')) {
> +			if ($wd{'hour_local'} < 6) {
> +				print "<span class=\"atnight\">$wd{'rfc2822'}</span>";
> +			} else {
> +				print $wd{'rfc2822'};
> +			}
> +		} else {
> +			print $wd{'rfc2822'} . format_local_time(%wd);
> +		}
>  		print "</td>" .
>  		      "</tr>\n";
>  	}
