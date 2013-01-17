From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Allow Git::get_tz_offset to properly handle DST
 boundary times
Date: Thu, 17 Jan 2013 11:09:30 -0800
Message-ID: <7vy5frtymt.fsf@alter.siamese.dyndns.org>
References: <1358291405-10173-1-git-send-email-bdwalton@gmail.com>
 <1358291405-10173-3-git-send-email-bdwalton@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: esr@thyrsus.com, git@vger.kernel.org
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 20:10:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tvuqe-0004Sg-2e
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 20:10:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756027Ab3AQTJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 14:09:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34812 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755834Ab3AQTJh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 14:09:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 91B34AB36;
	Thu, 17 Jan 2013 14:09:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rSiju4i4EOphU30fE4T1dHhxqgk=; b=EHB28S
	vulGz6x0YFj8VtDCVuvkl1uzEXEm720iyAirrmNkRoAXtvYPMGAdObM+vQoWEYtx
	SpD68eNo+/RG1E5Xp5ndGICxn2ai3viU7xqkwNqzjWI4vtFxG6Yg+hB60E//qwqe
	M1eLzz/MMxXkKNTGDDPV8fWGMROTVU6UuhQiA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F1d+4qJhG0w7kR99VGLrWDq+PIaPekyZ
	efXT9T++UOsAuI+LVJK+merYW0cQMGFqVcU5REDIRfOO1aI6xdNAouyJOB4vds90
	ZF0e07KAmbGGTCi/+8fh9xSlbVJJuKucq7oZQner0m5FAl3YI0MFX7SXVZ7K7s3o
	sXefijjOVaE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED84AAB33;
	Thu, 17 Jan 2013 14:09:35 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 15ED1AB2F; Thu, 17 Jan 2013
 14:09:34 -0500 (EST)
In-Reply-To: <1358291405-10173-3-git-send-email-bdwalton@gmail.com> (Ben
 Walton's message of "Tue, 15 Jan 2013 23:10:04 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6E69DCF0-60D9-11E2-981E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213871>

Ben Walton <bdwalton@gmail.com> writes:

> The Git::get_tz_offset is meant to provide a workalike replacement for
> the GNU strftime %z format specifier.  The algorithm used failed to
> properly handle DST boundary cases.
>
> For example, the unix time 1162105199 in CST6CDT saw set_tz_offset
> improperly return -0600 instead of -0500.
>
> TZ=CST6CDT date -d @1162105199 +"%c %z"
> Sun 29 Oct 2006 01:59:59 AM CDT -0500
>
> $ zdump -v /usr/share/zoneinfo/CST6CDT | grep 2006
> /usr/share/zoneinfo/CST6CDT  Sun Apr  2 07:59:59 2006 UTC = Sun Apr  2
> 01:59:59 2006 CST isdst=0 gmtoff=-21600
> /usr/share/zoneinfo/CST6CDT  Sun Apr  2 08:00:00 2006 UTC = Sun Apr  2
> 03:00:00 2006 CDT isdst=1 gmtoff=-18000
> /usr/share/zoneinfo/CST6CDT  Sun Oct 29 06:59:59 2006 UTC = Sun Oct 29
> 01:59:59 2006 CDT isdst=1 gmtoff=-18000
> /usr/share/zoneinfo/CST6CDT  Sun Oct 29 07:00:00 2006 UTC = Sun Oct 29
> 01:00:00 2006 CST isdst=0 gmtoff=-21600
>
> To determine how many hours/minutes away from GMT a particular time
> was, we calculated the gmtime() of the requested time value and then
> used Time::Local's timelocal() function to turn the GMT-based time
> back into a scalar value representing seconds from the epoch.  Because
> GMT has no daylight savings time, timelocal() cannot handle the
> ambiguous times that occur at DST boundaries since there are two
> possible correct results.
>
> To work around the ambiguity at these boundaries, we must take into
> account the pre and post conversion values for is_dst as provided by
> both the original time value and the value that has been run through
> timelocal().  If the is_dst field of the two times disagree then we
> must modify the value returned from timelocal() by an hour in the
> correct direction.

It seems to me that it is a very roundabout way.  It may be correct,
but it is unclear why the magic +/-3600 shift is the right solution
and I suspect even you wouldn't notice if I sent you back your patch
with a slight change to swap $gm += 3600 and $gm -= 3600 lines ;-).

For that timestamp in question, the human-readable representation of
gmtime($t) and localtime($t) look like these two strings:

	my $t = 1162105199;
	print gmtime($t), "\n";    # Sun Oct 29 06:59:59 2006
        print localtime($t), "\n"; # Sun Oct 29 01:59:59 2006

As a human, you can easily see that these two stringified timestamps
look 5 hours apart.  Think how you managed to do so.

If we convert these back to the seconds-since-epoch, as if these
broken-down times were both in a single timezone that does not have
any DST issues, you can get the offset (in seconds) by subtraction,
and that is essentially the same as the way in which your eyes saw
they are 5 hours apart, no?  In other words, why do you need to run
timelocal() at all?

	my $t = 1162105199;
        my $lct = timegm(localtime($t)); 
        # of course, timegm(gmtime($t)) == $t

	my $minutes = int(($lct - $t)/60);
        my $sign "+";
        if ($minutes < 0) {
		$sign = "-";
                $minutes = -$minutes;
	}
        my $hours = int($minutes/60);
        $minutes -= $hours * 60;
        sprintf("%s%02d%02d", $sign, $hours, $minutes);

Confused...

>
> Signed-off-by: Ben Walton <bdwalton@gmail.com>
> ---
>  perl/Git.pm |   20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/perl/Git.pm b/perl/Git.pm
> index 5649bcc..788b9b4 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -528,7 +528,27 @@ If TIME is not supplied, the current local time is used.
>  sub get_tz_offset {
>  	# some systmes don't handle or mishandle %z, so be creative.
>  	my $t = shift || time;
> +	# timelocal() has a problem when it comes to DST ambiguity so
> +	# times that are on a DST boundary cannot be properly converted
> +	# using it.  we will possibly adjust its result depending on whehter
> +	# pre and post conversions agree on DST
>  	my $gm = timelocal(gmtime($t));
> +
> +	# we need to know whether we were originally in DST or not
> +	my $orig_dst = (localtime($t))[8];
> +	# and also whether timelocal thinks we're in DST
> +	my $conv_dst = (localtime($gm))[8];
> +
> +	# re-adjust $gm based on the DST value for the two times we're
> +	# handling.
> +	if ($orig_dst != $conv_dst) {
> +		if ($orig_dst == 1) {
> +			$gm -= 3600;
> +		} else {
> +			$gm += 3600;
> +		}
> +	}
> +
>  	my $sign = qw( + + - )[ $t <=> $gm ];
>  	return sprintf("%s%02d%02d", $sign, (gmtime(abs($t - $gm)))[2,1]);
>  }
