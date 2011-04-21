From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 3/5] Date Mode: Implementation
Date: Thu, 21 Apr 2011 15:44:22 -0700
Message-ID: <7vk4enusvt.fsf@alter.siamese.dyndns.org>
References: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
 <4e4fea2a-c9fe-47ff-b947-64aa4662adae-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 00:44:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QD2c3-0005Me-0P
	for gcvg-git-2@lo.gmane.org; Fri, 22 Apr 2011 00:44:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755536Ab1DUWoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2011 18:44:34 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41576 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753658Ab1DUWoc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2011 18:44:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 83C934C6F;
	Thu, 21 Apr 2011 18:46:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=oKr/jF+SRx07hxa8zSSzxmTfcCI=; b=uPeDu1vt3uZRUE271vAX
	IguIJolbPl0MH6ESjUkHd7pfY8kr5EcQ3t0wifAelBbTzCJVna4yocwq3Vx26v18
	Wgu2sM4MWn4b/t3L7QszRQIhvo86DIk7iJKgO8ED9/cO8zgUpCVd2c238UVR0r6U
	fAs+hjk/gayZhpaQ1zZrhXY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=eW7ixvSgv3OdE2s94FW1fqKKl5l68GhYICTmcb865I+sw9
	xb1ad647+f2DPX13cRlYATJEZHJCsxDfA5LmdR3iIDtvvkWRKyLFNSIBr5eUoU9F
	buPMv3zwtLUA20Y56T+ak/WpVKzXUxf25LB3coqGCz/RIiYqS2kJthjtZOaYs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6142B4C6B;
	Thu, 21 Apr 2011 18:46:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2114E4C66; Thu, 21 Apr 2011
 18:46:25 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3254B296-6C69-11E0-A719-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171926>

Michael Witten <mfwitten@gmail.com> writes:

> Date: Sat, 12 Feb 2011 03:56:17 +0000
> This introduces and employs infrastructure for manipulating
> and bundling time zone and date format specifications in
> code, on the command line, and in git configuration files.
>
> In particular, this commit includes the following:

Even though I think it is going in the right direction to separate "in
what timezone do we show timestamps (original vs user-specified)" and "in
what format do we show them (short? with tz? like in e-mail? iso? etc.),
this particular commit seems to do too many things at once.

Can you think of a way split this into smaller steps?  I am not asking
"Could you pretty please split this?" nor "Are you willing to do so?"
I am asking if the task is possible to begin with.

A valid answer could be "everything is so intertwined that this patch is
the smallest logical unit of change", and I would be somewhat sympathetic
to that.  Once you change the type of revs->date_mode from the current
single scalar to a struct, all the callers need to change the way they
initialize and update the field, and I understand that such a change would
have to touch a major part of the system.

But if that step can be done without changing the semantics nor behaviour
at all, it would be easier to review and verify. The the next patch can
enhance the struct in revs->date_mode to express timezone information as a
new field, opening the door to the new command line option.

> Essentially, what was:
>
>   git log --date=local
>
> should now be:
>
>   git log --time-zone=local

The above _should_ read something like:

	"git log --date=local"

        is now a short-hand for

        "git log --date-format=local --time-zone=local"

        It specifies that the timestamps should be stringified using the
        local timezone, and the value should be shown like "Tue Apr 19
        12:34:56 2011" without the timezone.

        "git log --time-zone=local" would give the same output but you
        will also see the timezone, e.g. "Tue Apr 19 12:34:56 2011 -0800",
        because --date-format defaults to "default".

In other words, this new feature should allow people who do not care about
it to keep saying "--date=local" without being told that they now _should_
say things differently.

If it is absolutely impossible to implement the separation between the
timezone and the format without breaking existing option handling, we
would have to consider if the new feature (i.e. separation of zone and
format) is worth breaking scripts and existing users, and we may end up
rejecting the implementation of new feature.  I however do think this
particular feature is possible to implement without such a regression.

This patch makes the date-related infrastructure rich enough to deserve
its own "date.h" that is included by "cache.h" near the beginning of it.
The documentation part in [4/5] has such a separation, which I think is a
sensible thing to do, except that date-mode-docs.txt is probably a wrong
name for the file.  If you followed the precedence set by most other
includable pieces about the set of options, you would probably call it
date-opts.txt or something.

> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 60d6b32..add9299 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -361,26 +360,58 @@ static const char *copy_email(const char *buf)
>  	return xmemdupz(email, eoemail + 1 - email);
>  }
>  
> +#define PARSE_DATE_MODE(marker_0, parser_0, date_mode_member_0, \
> +                        marker_1, parser_1, date_mode_member_1) \
> +	if (*atomname == marker_0) { \
> +		const char *spec_0 = ++atomname; \
> +		do { \
> +			if (*atomname == marker_1) { \
> +				date_mode_member_1 = parser_1(atomname+1); \
> +				char *spec_0_dup  = xmemdupz(spec_0, atomname - spec_0); \
> +				date_mode_member_0 = parser_0(spec_0_dup); \
> +				free(spec_0_dup); \
> +				goto finish; \
> +			} \

This introduces:

builtin/for-each-ref.c:386: error: ISO C90 forbids mixed declarations and code
builtin/for-each-ref.c:390: error: ISO C90 forbids mixed declarations and code

> diff --git a/date.c b/date.c
> index caa14fe..879b0e1 100644
> --- a/date.c
> +++ b/date.c
> @@ -147,40 +147,42 @@ const char *show_date_relative(unsigned long time, int tz,
>  	return timebuf;
>  }
>  
> -const char *show_date(unsigned long time, int tz, enum date_mode mode)
> +const char *show_date(unsigned long time, int tz, struct date_mode date_mode)
>  {
> ...

I may be being old-fashioned, but I'd really prefer to see structures
passed by pointer, not by value, even if the structure starts out as a
small container for just two enum fields.  There are a few other places
you pass this structure by value.

> @@ -653,7 +655,7 @@ int parse_date(const char *date, char *result, int maxlen)
>  	return date_string(timestamp, offset, result, maxlen);
>  }
>  
> -enum date_mode parse_date_format(const char *format)
> +enum date_format parse_date_format(const char *format)
>  {
>  	if (!strcmp(format, "relative"))
>  		return DATE_RELATIVE;
> @@ -675,6 +677,67 @@ enum date_mode parse_date_format(const char *format)
>  		die("unknown date format %s", format);
>  }
>  
> +enum time_zone parse_time_zone(const char *time_zone)
> +{
> +	if (!strcmp(time_zone, "local"))
> +		return TIME_ZONE_LOCAL;
> +	else if (!strcmp(time_zone, "default"))
> +		return TIME_ZONE_DEFAULT;
> +	else
> +		die("unknown time zone %s", time_zone);
> +}

Hmm, I was hoping that we can enhance this to allow feeding a string
(e.g. "GMT", "+0900"), but "enum time_zone" makes it almost impossible.

> +int parse_date_mode_config_internal(const char *var_date,
> +                                     const char *var_timezone,
> +                                     const char *var,
> +                                     const char *value,
> +                                     struct date_mode *d,
> +                                     int *ret)
> +{

I'd rather see you drop the preprocessor trick to synthesize "blame.date"
and "blame.timezone" out of "blame", drop _internal from this function
(which is not static to the file scope to begin with), and take a single
"const char *var" as the first parameter.  Otherwise, future users of the
API cannot pass a variable to (your version of) parse_date_mode_config().
It is not implausible that someday somebody might want to parse per-branch
timezone specification out of "branch.master.timezone", and most likely
"branch.master" part would be created runtime in a strbuf, not limited to
hardcoded program names such as "blame".

No other config callback function uses "a pointer to int as an argument to
store the return value"; if you absolutely need a new calling convention,
it needs to be documented better.  What do *ret and the return value from
this function mean from the caller's point of view?

Thanks.
