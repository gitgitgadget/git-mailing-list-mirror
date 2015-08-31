From: John Keeping <john@keeping.me.uk>
Subject: Re: [RFC/PATCH] date: allow any format to display local time
Date: Mon, 31 Aug 2015 21:00:16 +0100
Message-ID: <20150831200016.GC30659@serenity.lan>
References: <d3b9f8f6524e45c9fc7a3e104669572c8c4ddd8a.1440942688.git.john@keeping.me.uk>
 <xmqqtwrfweo7.fsf@gitster.mtv.corp.google.com>
 <20150831185018.GA20555@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 31 22:00:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWVFx-0006wZ-Ma
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 22:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174AbbHaUAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 16:00:37 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:57457 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158AbbHaUAf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 16:00:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 195E8CDA568;
	Mon, 31 Aug 2015 21:00:31 +0100 (BST)
X-Quarantine-ID: <KpvE5MYK8odV>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KpvE5MYK8odV; Mon, 31 Aug 2015 21:00:27 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 3DC16CDA5D6;
	Mon, 31 Aug 2015 21:00:18 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20150831185018.GA20555@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276929>

On Mon, Aug 31, 2015 at 02:50:18PM -0400, Jeff King wrote:
> On Mon, Aug 31, 2015 at 10:28:24AM -0700, Junio C Hamano wrote:
> > I am unhappy with the change to blame.c, and that is not because I
> > do not want "blame" to be touched.
> > 
> > The fact that this change has to touch it indicates that it is easy
> > for other new callers of date formatting code to forget masking
> > DATE_LOCAL bit like this patch does when they want to change their
> > behaviour based on the settings of date-mode.  And it would be hard
> > to catch such a subtle breakage during future reviews.
> 
> Yeah, my first instinct on seeing the bitfield was that it would
> probably be much simpler to keep the enum pure, and add a bit to the
> struct. A patch in that direction is below. I think the result is that
> the using code is much cleaner, and the complexity of converting
> "foo-local" into the enum/bitfield combination is contained in
> parse_date_format.

Yes, the result below is much cleaner than my version.

> > I agree that among "enum date_mode_type", DATE_LOCAL is an oddball.
> > It should be able to act as an orthogonal and independent flag with
> > at least some, like NORMAL, SHORT, etc.  Specifying DATE_LOCAL with
> > some others at the same time, however, would not make much sense,
> > would it?  What does it even mean to say time as relative under
> > DATE_LOCAL bit?
> 
> I think the "relative local" thing is not _too_ bad, as John's patch
> enforces it at the user-level (it does not parse "relative-local" at
> all, and mine similarly complains).
> 
> > >  	else
> > >  		strbuf_addf(&timebuf, "%.3s %.3s %d %02d:%02d:%02d %d%c%+05d",
> > 
> > What cannot be seen in the post-context of this hunk is that we
> > deliberately drop the timezone information when tweaking the
> > "normal" format to "local".  This is done only in the final else
> > clause in show_date() because the code knows that LOCAL is not an
> > independent bit.
> 
> I didn't address this in my patch (except to convert the check of
> DATE_LOCAL to mode->local). I agree that we should handle it in other
> formats, too, but I think it must be format-dependent. Certainly "rfc"
> and "iso" must always show the timezone. I'd argue that "raw" probably
> should, as well. That leaves only "short" and "relative", which do not
> display the time zone in the first place. So all of the formats are
> covered, I think.
> 
> > I think the original motivation is that there is no need to show the
> > timezone information when the user knows the time is shown in the
> > local timezone---after all, the --date=local option was given by her
> > in the first place.  This kind of tweaking should be made consistent
> > with other variants, now the other variants are interacting with
> > this LOCAL bit.  If we were to go forward with this patch, I think
> > we probably should remove this special casing of "showing normal
> > date in localzone, drop the zone information", as we cannot sanely
> > drop the TZ offset from the output of some of the formats and stay
> > valid (e.g RFC2822).
> 
> I think I'd rather remain inconsistent between the formats (which, after
> all, do not need to show exactly the same information), then have people
> complain that "--date=local" is regressed and now shows a timezone.
> 
> > > @@ -777,14 +780,25 @@ void parse_date_format(const char *format, struct date_mode *mode)
> > >  	else if (!strcmp(format, "iso8601") ||
> > >  		 !strcmp(format, "iso"))
> > >  		mode->type = DATE_ISO8601;
> > > +	else if (!strcmp(format, "iso8601-local") ||
> > > +		 !strcmp(format, "iso-local"))
> > > +		mode->type = DATE_ISO8601_LOCAL;
> 
> I found the manual "-local" handling here to be a little, well...manual.
> So in the patch below I've revamped the parsing to look left-to-right
> for each component: type, local modifier, strftime format.
> 
> It ends up being about the same amount of code, but has two advantages:
> 
>   1. It's more flexible if we want to make more modifiers later. In
>      fact, it would be trivial to implement the current "-strict" as a
>      separate flag if we chose. I don't think there is much point in
>      doing so, but we could do something like "default-local-strict"
>      for showing the local time _with_ the timezone.
> 
>   2. We can provide more specific error messages (like "relative does
>      not make sense with -local", rather than "unknown date format:
>      relative-local").
> 
> But that is somewhat orthogonal to the enum thing. We could leave the
> parsing as John has it, and just set mode->local as appropriate in each
> conditional block.

I like that the parsing indicates that the format and "local-ness" are
orthogonal in this version.

Are you willing to resend this as a proper patch?

I'm happy to build documentation & tests on top, although there don't
seem to be any tests for date formats outside t6300-for-each-ref.sh at
the moment (and the "format" mode is neither tested nor documented for
git-for-each-ref although it does work)..

> ---
>  builtin/blame.c |  1 -
>  cache.h         |  2 +-
>  date.c          | 77 ++++++++++++++++++++++++++++++++++++++-------------------
>  fast-import.c   |  6 ++++-
>  4 files changed, 57 insertions(+), 29 deletions(-)
> 
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 4db01c1..6fd1a63 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2600,7 +2600,6 @@ parse_done:
>  		   fewer display columns. */
>  		blame_date_width = utf8_strwidth(_("4 years, 11 months ago")) + 1; /* add the null */
>  		break;
> -	case DATE_LOCAL:
>  	case DATE_NORMAL:
>  		blame_date_width = sizeof("Thu Oct 19 16:00:04 2006 -0700");
>  		break;
> diff --git a/cache.h b/cache.h
> index 4e25271..9a91b1d 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1091,7 +1091,6 @@ struct date_mode {
>  		DATE_NORMAL = 0,
>  		DATE_RELATIVE,
>  		DATE_SHORT,
> -		DATE_LOCAL,
>  		DATE_ISO8601,
>  		DATE_ISO8601_STRICT,
>  		DATE_RFC2822,
> @@ -1099,6 +1098,7 @@ struct date_mode {
>  		DATE_RAW
>  	} type;
>  	const char *strftime_fmt;
> +	int local;
>  };
>  
>  /*
> diff --git a/date.c b/date.c
> index 8f91569..aa57cad 100644
> --- a/date.c
> +++ b/date.c
> @@ -166,6 +166,7 @@ struct date_mode *date_mode_from_type(enum date_mode_type type)
>  	if (type == DATE_STRFTIME)
>  		die("BUG: cannot create anonymous strftime date_mode struct");
>  	mode.type = type;
> +	mode.local = 0;
>  	return &mode;
>  }
>  
> @@ -189,7 +190,7 @@ const char *show_date(unsigned long time, int tz, const struct date_mode *mode)
>  		return timebuf.buf;
>  	}
>  
> -	if (mode->type == DATE_LOCAL)
> +	if (mode->local)
>  		tz = local_tzoffset(time);
>  
>  	tm = time_to_tm(time, tz);
> @@ -232,7 +233,7 @@ const char *show_date(unsigned long time, int tz, const struct date_mode *mode)
>  				tm->tm_mday,
>  				tm->tm_hour, tm->tm_min, tm->tm_sec,
>  				tm->tm_year + 1900,
> -				(mode->type == DATE_LOCAL) ? 0 : ' ',
> +				mode->local ? 0 : ' ',
>  				tz);
>  	return timebuf.buf;
>  }
> @@ -770,32 +771,56 @@ int parse_date(const char *date, struct strbuf *result)
>  	return 0;
>  }
>  
> +static enum date_mode_type parse_date_type(const char *format, const char **end)
> +{
> +	if (skip_prefix(format, "relative", end))
> +		return DATE_RELATIVE;
> +	if (skip_prefix(format, "iso8601-strict", end) ||
> +	    skip_prefix(format, "iso-strict", end))
> +		return DATE_ISO8601_STRICT;
> +	if (skip_prefix(format, "iso8601", end) ||
> +	    skip_prefix(format, "iso", end))
> +		return DATE_ISO8601;
> +	if (skip_prefix(format, "rfc2822", end) ||
> +	    skip_prefix(format, "rfc", end))
> +		return DATE_RFC2822;
> +	if (skip_prefix(format, "short", end))
> +		return DATE_SHORT;
> +	if (skip_prefix(format, "default", end))
> +		return DATE_NORMAL;
> +	if (skip_prefix(format, "raw", end))
> +		return DATE_RAW;
> +	if (skip_prefix(format, "format", end))
> +		return DATE_STRFTIME;
> +
> +	die("unknown date format %s", format);
> +}
> +
>  void parse_date_format(const char *format, struct date_mode *mode)
>  {
> -	if (!strcmp(format, "relative"))
> -		mode->type = DATE_RELATIVE;
> -	else if (!strcmp(format, "iso8601") ||
> -		 !strcmp(format, "iso"))
> -		mode->type = DATE_ISO8601;
> -	else if (!strcmp(format, "iso8601-strict") ||
> -		 !strcmp(format, "iso-strict"))
> -		mode->type = DATE_ISO8601_STRICT;
> -	else if (!strcmp(format, "rfc2822") ||
> -		 !strcmp(format, "rfc"))
> -		mode->type = DATE_RFC2822;
> -	else if (!strcmp(format, "short"))
> -		mode->type = DATE_SHORT;
> -	else if (!strcmp(format, "local"))
> -		mode->type = DATE_LOCAL;
> -	else if (!strcmp(format, "default"))
> -		mode->type = DATE_NORMAL;
> -	else if (!strcmp(format, "raw"))
> -		mode->type = DATE_RAW;
> -	else if (skip_prefix(format, "format:", &format)) {
> -		mode->type = DATE_STRFTIME;
> -		mode->strftime_fmt = xstrdup(format);
> -	} else
> -		die("unknown date format %s", format);
> +	const char *p;
> +
> +	/* historical alias */
> +	if (!strcmp(format, "local"))
> +		format = "default-local";
> +
> +	mode->type = parse_date_type(format, &p);
> +	mode->local = 0;
> +
> +	if (skip_prefix(p, "-local", &p)) {
> +		if (mode->type == DATE_RELATIVE)
> +			die("relative-local date format is nonsensical");
> +		mode->local = 1;
> +	}
> +
> +	if (mode->type == DATE_STRFTIME) {
> +		if (!skip_prefix(p, ":", &p))
> +			die("date format missing colon separator: %s", format);
> +		mode->strftime_fmt = xstrdup(p);
> +	}
> +
> +	if (*p)
> +		die("unknown date-mode modifier: %s", p);
>  }
>  
>  void datestamp(struct strbuf *out)
> diff --git a/fast-import.c b/fast-import.c
> index 6c7c3c9..b19a1b5 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -412,6 +412,10 @@ static void write_crash_report(const char *err)
>  	struct branch *b;
>  	unsigned long lu;
>  	struct recent_command *rc;
> +	struct date_mode dm;
> +
> +	dm.type = DATE_NORMAL;
> +	dm.local = 1;
>  
>  	if (!rpt) {
>  		error("can't write crash report %s: %s", loc, strerror(errno));
> @@ -424,7 +428,7 @@ static void write_crash_report(const char *err)
>  	fprintf(rpt, "fast-import crash report:\n");
>  	fprintf(rpt, "    fast-import process: %"PRIuMAX"\n", (uintmax_t) getpid());
>  	fprintf(rpt, "    parent process     : %"PRIuMAX"\n", (uintmax_t) getppid());
> -	fprintf(rpt, "    at %s\n", show_date(time(NULL), 0, DATE_MODE(LOCAL)));
> +	fprintf(rpt, "    at %s\n", show_date(time(NULL), 0, &dm));
>  	fputc('\n', rpt);
>  
>  	fputs("fatal: ", rpt);
> -- 
> 2.5.1.739.g7891f6b
