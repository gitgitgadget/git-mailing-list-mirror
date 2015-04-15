From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Odd broken "--date=now" behavior in current git
Date: Wed, 15 Apr 2015 07:42:41 -0700
Message-ID: <xmqqk2xdmp0e.fsf@gitster.dls.corp.google.com>
References: <CA+55aFxvcN8Dz-t6fi6etycg+AiyR0crXv5AcfCdv8ji-iNBpw@mail.gmail.com>
	<xmqqzj6ayp3p.fsf@gitster.dls.corp.google.com>
	<20150415072223.GA1389@flurp.local>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 16:43:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiOXB-00077k-K4
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 16:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119AbbDOOnH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 10:43:07 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64168 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752289AbbDOOnF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 10:43:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A77EF46DCA;
	Wed, 15 Apr 2015 10:42:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5g9Dh2kUG6R7cnNdcEe566ypjBQ=; b=DqvXZZ
	0zKzKZNgRqMK5hNoe3EVbe+VOUZ7yhw6Wke2eJSdd3SQWgbJjbca8KWEH5+8Cryf
	Ed7oSUlVHypwcIEtkJzy27LEXnWQGYhoOsDc245HVS9INIUCF7MwWjAVaUsEj538
	tcLr6vep+sIHMSgO7YoYez1yK8KxyCfq0AL7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LOim3xUlWkBv38yWjz5RsXix2aEjf7ex
	rndYr9z7QExMeozXAC2cJYkr8eBAfvEBGNdJM1heCk1p57N0NF7SoaK8zYnKxKsn
	ynBEqdd4f4BWDKffOW9RXshU5mgYY7cHdA99S/LpcPlP9fdwL6A9oqMOWCOcWXWh
	3Qd5DBlsn/Y=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A05B746DC9;
	Wed, 15 Apr 2015 10:42:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A32A846DAD;
	Wed, 15 Apr 2015 10:42:42 -0400 (EDT)
In-Reply-To: <20150415072223.GA1389@flurp.local> (Eric Sunshine's message of
	"Wed, 15 Apr 2015 03:22:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AC2A0AD2-E37D-11E4-99DF-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267203>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Later parse_date_basic() computes the offset from GMT by comparing
> the values returned by tm_to_time_t() and mktime(). The existing 'tm'
> is passed to mktime() with the tm_isdst field already set to 0 by
> gmtime_r(), and mktime() respects that as a statement that DST is not
> in effect, rather than determining it dynamically.
>
> The fix seems to be simply:
>
> ---- >8 ----
> diff --git a/date.c b/date.c
> index 3eba2df..99ad2a0 100644
> --- a/date.c
> +++ b/date.c
> @@ -707,6 +707,7 @@ int parse_date_basic(const char *date, unsigned long *timestamp, int *offset)
>  	/* mktime uses local timezone */
>  	*timestamp = tm_to_time_t(&tm);
>  	if (*offset == -1) {
> +		tm.tm_isdst = -1;
>  		time_t temp_time = mktime(&tm);
>  		if ((time_t)*timestamp > temp_time) {
>  			*offset = ((time_t)*timestamp - temp_time) / 60;
> ---- >8 ----

I briefly wondered if the caller of gmtime_r() in match_digit()
should be preserving the tm_isdst, though, as that codepath knows
that it is handling a bare number without GMT offset.

But resetting it to -1 here makes it even less error prone (we may
gain other code that stomp on tm.tm_isdst before we get here, and
having -1 in *offset is a sign that nobody saw GMT offset in the
input).

I think I see a decl-after-statment, but other than that, this looks
like a good fix.

Thanks.
