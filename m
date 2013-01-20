From: Ben Walton <bdwalton@gmail.com>
Subject: Re: [PATCH 2/3] Allow Git::get_tz_offset to properly handle DST
 boundary times
Date: Sun, 20 Jan 2013 20:06:13 +0000
Message-ID: <CAP30j14Og7YLaZj0dbpAhUHFfuy0Y=bEn_3EqGzxR5PRA7vQXA@mail.gmail.com>
References: <1358291405-10173-1-git-send-email-bdwalton@gmail.com>
	<1358291405-10173-3-git-send-email-bdwalton@gmail.com>
	<7vy5frtymt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Eric Raymond <esr@thyrsus.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 21:09:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx1DH-00062I-5l
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 21:09:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447Ab3ATUGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 15:06:16 -0500
Received: from mail-la0-f42.google.com ([209.85.215.42]:63372 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404Ab3ATUGP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 15:06:15 -0500
Received: by mail-la0-f42.google.com with SMTP id fe20so5481013lab.15
        for <git@vger.kernel.org>; Sun, 20 Jan 2013 12:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=U0e+DWw3hw+bMJM3dP9P3pU1IQOlE6KUFMNMV6DOOJo=;
        b=PQWS3GL0elMbOon0GZ8BTSk4E5Wu9NYpvxxu62SoB6otmgMwvNrudkfFiBwm5HZb92
         dm1fOR2seEy+XrEmQrQcFUOgfDCzq2TBfqBZm+IzHA45SzaedpMuFl7Mb7JPMr/4BFm3
         eAo3JjJq+KYpJSrwMlpKMhzLMuRws0+aF0zvGZ3uMnh/VfhgVWYPzt+wHohXM+M+RlqZ
         FqGnEBndWj8o/9/w5ZfhnidrecIlWpUTr98NJB0EO76FdeZ54F/hDb5ZwQfIKWiYHJIh
         LUuPrmkHDtP+oJMzSWTRwmo4rOBlJ/o4+X9staggF0ohe9hQrN6/x1DiIhdC03NVTvGE
         aKcw==
X-Received: by 10.112.13.162 with SMTP id i2mr6402596lbc.76.1358712373421;
 Sun, 20 Jan 2013 12:06:13 -0800 (PST)
Received: by 10.114.29.129 with HTTP; Sun, 20 Jan 2013 12:06:13 -0800 (PST)
In-Reply-To: <7vy5frtymt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214042>

On Thu, Jan 17, 2013 at 7:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ben Walton <bdwalton@gmail.com> writes:
>
>> The Git::get_tz_offset is meant to provide a workalike replacement for
>> the GNU strftime %z format specifier.  The algorithm used failed to
>> properly handle DST boundary cases.
>>
>> For example, the unix time 1162105199 in CST6CDT saw set_tz_offset
>> improperly return -0600 instead of -0500.
>>
>> TZ=CST6CDT date -d @1162105199 +"%c %z"
>> Sun 29 Oct 2006 01:59:59 AM CDT -0500
>>
>> $ zdump -v /usr/share/zoneinfo/CST6CDT | grep 2006
>> /usr/share/zoneinfo/CST6CDT  Sun Apr  2 07:59:59 2006 UTC = Sun Apr  2
>> 01:59:59 2006 CST isdst=0 gmtoff=-21600
>> /usr/share/zoneinfo/CST6CDT  Sun Apr  2 08:00:00 2006 UTC = Sun Apr  2
>> 03:00:00 2006 CDT isdst=1 gmtoff=-18000
>> /usr/share/zoneinfo/CST6CDT  Sun Oct 29 06:59:59 2006 UTC = Sun Oct 29
>> 01:59:59 2006 CDT isdst=1 gmtoff=-18000
>> /usr/share/zoneinfo/CST6CDT  Sun Oct 29 07:00:00 2006 UTC = Sun Oct 29
>> 01:00:00 2006 CST isdst=0 gmtoff=-21600
>>
>> To determine how many hours/minutes away from GMT a particular time
>> was, we calculated the gmtime() of the requested time value and then
>> used Time::Local's timelocal() function to turn the GMT-based time
>> back into a scalar value representing seconds from the epoch.  Because
>> GMT has no daylight savings time, timelocal() cannot handle the
>> ambiguous times that occur at DST boundaries since there are two
>> possible correct results.
>>
>> To work around the ambiguity at these boundaries, we must take into
>> account the pre and post conversion values for is_dst as provided by
>> both the original time value and the value that has been run through
>> timelocal().  If the is_dst field of the two times disagree then we
>> must modify the value returned from timelocal() by an hour in the
>> correct direction.
>
> It seems to me that it is a very roundabout way.  It may be correct,
> but it is unclear why the magic +/-3600 shift is the right solution
> and I suspect even you wouldn't notice if I sent you back your patch
> with a slight change to swap $gm += 3600 and $gm -= 3600 lines ;-).
>
> For that timestamp in question, the human-readable representation of
> gmtime($t) and localtime($t) look like these two strings:
>
>         my $t = 1162105199;
>         print gmtime($t), "\n";    # Sun Oct 29 06:59:59 2006
>         print localtime($t), "\n"; # Sun Oct 29 01:59:59 2006
>
> As a human, you can easily see that these two stringified timestamps
> look 5 hours apart.  Think how you managed to do so.
>
> If we convert these back to the seconds-since-epoch, as if these
> broken-down times were both in a single timezone that does not have
> any DST issues, you can get the offset (in seconds) by subtraction,
> and that is essentially the same as the way in which your eyes saw
> they are 5 hours apart, no?  In other words, why do you need to run
> timelocal() at all?
>
>         my $t = 1162105199;
>         my $lct = timegm(localtime($t));
>         # of course, timegm(gmtime($t)) == $t
>
>         my $minutes = int(($lct - $t)/60);
>         my $sign "+";
>         if ($minutes < 0) {
>                 $sign = "-";
>                 $minutes = -$minutes;
>         }
>         my $hours = int($minutes/60);
>         $minutes -= $hours * 60;
>         sprintf("%s%02d%02d", $sign, $hours, $minutes);
>
> Confused...
>
>>
>> Signed-off-by: Ben Walton <bdwalton@gmail.com>
>> ---
>>  perl/Git.pm |   20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/perl/Git.pm b/perl/Git.pm
>> index 5649bcc..788b9b4 100644
>> --- a/perl/Git.pm
>> +++ b/perl/Git.pm
>> @@ -528,7 +528,27 @@ If TIME is not supplied, the current local time is used.
>>  sub get_tz_offset {
>>       # some systmes don't handle or mishandle %z, so be creative.
>>       my $t = shift || time;
>> +     # timelocal() has a problem when it comes to DST ambiguity so
>> +     # times that are on a DST boundary cannot be properly converted
>> +     # using it.  we will possibly adjust its result depending on whehter
>> +     # pre and post conversions agree on DST
>>       my $gm = timelocal(gmtime($t));
>> +
>> +     # we need to know whether we were originally in DST or not
>> +     my $orig_dst = (localtime($t))[8];
>> +     # and also whether timelocal thinks we're in DST
>> +     my $conv_dst = (localtime($gm))[8];
>> +
>> +     # re-adjust $gm based on the DST value for the two times we're
>> +     # handling.
>> +     if ($orig_dst != $conv_dst) {
>> +             if ($orig_dst == 1) {
>> +                     $gm -= 3600;
>> +             } else {
>> +                     $gm += 3600;
>> +             }
>> +     }
>> +
>>       my $sign = qw( + + - )[ $t <=> $gm ];
>>       return sprintf("%s%02d%02d", $sign, (gmtime(abs($t - $gm)))[2,1]);
>>  }


Sorry for the slow response, I didn't have a good chance to look at
this until now.  You are correct; your solution appears simpler and
also avoids the oddball 1/2 hour DST shift.  I can re-roll the series
with your code (and credit for it) or you can apply you change on top
of my series...whichever is easiest for you.

Thanks
-Ben
--
---------------------------------------------------------------------------------------------------------------------------
Take the risk of thinking for yourself.  Much more happiness,
truth, beauty and wisdom will come to you that way.

-Christopher Hitchens
---------------------------------------------------------------------------------------------------------------------------
