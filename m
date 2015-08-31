From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] date: allow any format to display local time
Date: Mon, 31 Aug 2015 10:28:24 -0700
Message-ID: <xmqqtwrfweo7.fsf@gitster.mtv.corp.google.com>
References: <d3b9f8f6524e45c9fc7a3e104669572c8c4ddd8a.1440942688.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Aug 31 19:28:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWSsk-0007R5-DV
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 19:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753988AbbHaR22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 13:28:28 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36557 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753415AbbHaR21 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 13:28:27 -0400
Received: by pabpg12 with SMTP id pg12so13175309pab.3
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 10:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=s+K3OPBf0gHCsLpVg93TtpoyKF+rq1zDGGqU8AXa8Rs=;
        b=sIIS5wmLJhcFx+fP5Q5x33eP5s4axXM2MfMfqu1Wbxa4AQZGJMWMg9sq7rg+EL0nF/
         JB1PZdgfKt4CzUYEITKG1HV1f37cz2cATboE0AlJL6+zU85bVObGVil6SBmrkfMG9nkV
         zbGXPWJCae50jEDrkOrgxiHdSzLSGFhrWs9XGCifqaiO/DxvMHQ3BEnkB+AEHf5ngeEa
         vcLT/T4cHdoElPwp+dpvlGV7VMSlxcuGL5+CGCE1tAS7od3ekM/X+K+SvvG+Fglukdf/
         6FQFqVlkJHQ/8g0CVjASiNf4RSoIElj1bw4e+7qrmQqMOlc6M9mnTn7T9cYWJn71OlBm
         xd/w==
X-Received: by 10.68.107.100 with SMTP id hb4mr16823422pbb.93.1441042106456;
        Mon, 31 Aug 2015 10:28:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:1937:16f4:ede1:6d38])
        by smtp.gmail.com with ESMTPSA id b6sm15251370pdo.63.2015.08.31.10.28.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 31 Aug 2015 10:28:25 -0700 (PDT)
In-Reply-To: <d3b9f8f6524e45c9fc7a3e104669572c8c4ddd8a.1440942688.git.john@keeping.me.uk>
	(John Keeping's message of "Sun, 30 Aug 2015 14:54:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276894>

John Keeping <john@keeping.me.uk> writes:

> Make DATE_LOCAL a bit flag that may be combined with the other formats.
> In order to keep date_mode_type as a true enumeration the possible
> combinations are included explicitly (except "relative local time" which
> is nonsensical).
>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---

This needs to be CC'ed to the author of a5481a6c (convert "enum
date_mode" into a struct, 2015-06-25), which I just did.

I am unhappy with the change to blame.c, and that is not because I
do not want "blame" to be touched.

The fact that this change has to touch it indicates that it is easy
for other new callers of date formatting code to forget masking
DATE_LOCAL bit like this patch does when they want to change their
behaviour based on the settings of date-mode.  And it would be hard
to catch such a subtle breakage during future reviews.

> diff --git a/builtin/blame.c b/builtin/blame.c
> index 4db01c1..dff6934 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2575,7 +2575,7 @@ parse_done:
>  	}
>  
>  	/* The maximum width used to show the dates */
> -	switch (blame_date_mode.type) {
> +	switch (blame_date_mode.type & ~DATE_LOCAL) {
>  	case DATE_RFC2822:
>  		blame_date_width = sizeof("Thu, 19 Oct 2006 16:00:04 -0700");
>  		break;
> @@ -2600,7 +2600,6 @@ parse_done:
>  		   fewer display columns. */
>  		blame_date_width = utf8_strwidth(_("4 years, 11 months ago")) + 1; /* add the null */
>  		break;
> -	case DATE_LOCAL:
>  	case DATE_NORMAL:
>  		blame_date_width = sizeof("Thu Oct 19 16:00:04 2006 -0700");
>  		break;

> diff --git a/cache.h b/cache.h
> index 4e25271..cda5c51 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1091,12 +1091,17 @@ struct date_mode {
>  		DATE_NORMAL = 0,
>  		DATE_RELATIVE,
>  		DATE_SHORT,
> -		DATE_LOCAL,
>  		DATE_ISO8601,
>  		DATE_ISO8601_STRICT,
>  		DATE_RFC2822,
>  		DATE_STRFTIME,
> -		DATE_RAW
> +		DATE_RAW,
> +		DATE_LOCAL = 0x80,
> +		DATE_SHORT_LOCAL = (DATE_SHORT | DATE_LOCAL),
> +		DATE_ISO8601_LOCAL = (DATE_ISO8601 | DATE_LOCAL),
> +		DATE_ISO8601_STRICT_LOCAL = (DATE_ISO8601_STRICT | DATE_LOCAL),
> +		DATE_RFC2822_LOCAL = (DATE_RFC2822 | DATE_LOCAL),
> +		DATE_STRFTIME_LOCAL = (DATE_STRFTIME | DATE_LOCAL),
>  	} type;
>  	const char *strftime_fmt;
>  };

I agree that among "enum date_mode_type", DATE_LOCAL is an oddball.
It should be able to act as an orthogonal and independent flag with
at least some, like NORMAL, SHORT, etc.  Specifying DATE_LOCAL with
some others at the same time, however, would not make much sense,
would it?  What does it even mean to say time as relative under
DATE_LOCAL bit?

But this point is minor.  A bigger design issue is in show_date()
below.

> diff --git a/date.c b/date.c
> index 8f91569..e0e0f3b 100644
> --- a/date.c
> +++ b/date.c
> @@ -163,7 +163,7 @@ void show_date_relative(unsigned long time, int tz,
>  struct date_mode *date_mode_from_type(enum date_mode_type type)
>  {
>  	static struct date_mode mode;
> -	if (type == DATE_STRFTIME)
> +	if (type == DATE_STRFTIME || type == DATE_STRFTIME_LOCAL)
>  		die("BUG: cannot create anonymous strftime date_mode struct");
>  	mode.type = type;
>  	return &mode;
> @@ -173,6 +173,7 @@ const char *show_date(unsigned long time, int tz, const struct date_mode *mode)
>  {
>  	struct tm *tm;
>  	static struct strbuf timebuf = STRBUF_INIT;
> +	enum date_mode_type type = mode->type;
>  
>  	if (mode->type == DATE_RAW) {
>  		strbuf_reset(&timebuf);
> @@ -189,8 +190,10 @@ const char *show_date(unsigned long time, int tz, const struct date_mode *mode)
>  		return timebuf.buf;
>  	}
>  
> -	if (mode->type == DATE_LOCAL)
> +	if (type & DATE_LOCAL) {
>  		tz = local_tzoffset(time);
> +		type &= ~DATE_LOCAL;
> +	}
>  
>  	tm = time_to_tm(time, tz);
>  	if (!tm) {
> @@ -199,17 +202,17 @@ const char *show_date(unsigned long time, int tz, const struct date_mode *mode)
>  	}
>  
>  	strbuf_reset(&timebuf);
> -	if (mode->type == DATE_SHORT)
> +	if (type == DATE_SHORT)
>  		strbuf_addf(&timebuf, "%04d-%02d-%02d", tm->tm_year + 1900,
>  				tm->tm_mon + 1, tm->tm_mday);
> -	else if (mode->type == DATE_ISO8601)
> +	else if (type == DATE_ISO8601)
>  		strbuf_addf(&timebuf, "%04d-%02d-%02d %02d:%02d:%02d %+05d",
>  				tm->tm_year + 1900,
>  				tm->tm_mon + 1,
>  				tm->tm_mday,
>  				tm->tm_hour, tm->tm_min, tm->tm_sec,
>  				tz);
> -	else if (mode->type == DATE_ISO8601_STRICT) {
> +	else if (type == DATE_ISO8601_STRICT) {
>  		char sign = (tz >= 0) ? '+' : '-';
>  		tz = abs(tz);
>  		strbuf_addf(&timebuf, "%04d-%02d-%02dT%02d:%02d:%02d%c%02d:%02d",
> @@ -218,12 +221,12 @@ const char *show_date(unsigned long time, int tz, const struct date_mode *mode)
>  				tm->tm_mday,
>  				tm->tm_hour, tm->tm_min, tm->tm_sec,
>  				sign, tz / 100, tz % 100);
> -	} else if (mode->type == DATE_RFC2822)
> +	} else if (type == DATE_RFC2822)
>  		strbuf_addf(&timebuf, "%.3s, %d %.3s %d %02d:%02d:%02d %+05d",
>  			weekday_names[tm->tm_wday], tm->tm_mday,
>  			month_names[tm->tm_mon], tm->tm_year + 1900,
>  			tm->tm_hour, tm->tm_min, tm->tm_sec, tz);
> -	else if (mode->type == DATE_STRFTIME)
> +	else if (type == DATE_STRFTIME)
>  		strbuf_addftime(&timebuf, mode->strftime_fmt, tm);
>  	else
>  		strbuf_addf(&timebuf, "%.3s %.3s %d %02d:%02d:%02d %d%c%+05d",

What cannot be seen in the post-context of this hunk is that we
deliberately drop the timezone information when tweaking the
"normal" format to "local".  This is done only in the final else
clause in show_date() because the code knows that LOCAL is not an
independent bit.

I think the original motivation is that there is no need to show the
timezone information when the user knows the time is shown in the
local timezone---after all, the --date=local option was given by her
in the first place.  This kind of tweaking should be made consistent
with other variants, now the other variants are interacting with
this LOCAL bit.  If we were to go forward with this patch, I think
we probably should remove this special casing of "showing normal
date in localzone, drop the zone information", as we cannot sanely
drop the TZ offset from the output of some of the formats and stay
valid (e.g RFC2822).

> @@ -777,14 +780,25 @@ void parse_date_format(const char *format, struct date_mode *mode)
>  	else if (!strcmp(format, "iso8601") ||
>  		 !strcmp(format, "iso"))
>  		mode->type = DATE_ISO8601;
> +	else if (!strcmp(format, "iso8601-local") ||
> +		 !strcmp(format, "iso-local"))
> +		mode->type = DATE_ISO8601_LOCAL;
>  	else if (!strcmp(format, "iso8601-strict") ||
>  		 !strcmp(format, "iso-strict"))
>  		mode->type = DATE_ISO8601_STRICT;
> +	else if (!strcmp(format, "iso8601-strict-local") ||
> +		 !strcmp(format, "iso-strict-local"))
> +		mode->type = DATE_ISO8601_STRICT_LOCAL;
>  	else if (!strcmp(format, "rfc2822") ||
>  		 !strcmp(format, "rfc"))
>  		mode->type = DATE_RFC2822;
> +	else if (!strcmp(format, "rfc2822-local") ||
> +		 !strcmp(format, "rfc-local"))
> +		mode->type = DATE_RFC2822_LOCAL;
>  	else if (!strcmp(format, "short"))
>  		mode->type = DATE_SHORT;
> +	else if (!strcmp(format, "short-local"))
> +		mode->type = DATE_SHORT_LOCAL;
>  	else if (!strcmp(format, "local"))
>  		mode->type = DATE_LOCAL;
>  	else if (!strcmp(format, "default"))
> @@ -794,6 +808,9 @@ void parse_date_format(const char *format, struct date_mode *mode)
>  	else if (skip_prefix(format, "format:", &format)) {
>  		mode->type = DATE_STRFTIME;
>  		mode->strftime_fmt = xstrdup(format);
> +	} else if (skip_prefix(format, "format-local:", &format)) {
> +		mode->type = DATE_STRFTIME_LOCAL;
> +		mode->strftime_fmt = xstrdup(format);
>  	} else
>  		die("unknown date format %s", format);
>  }
