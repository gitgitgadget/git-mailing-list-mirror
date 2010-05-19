From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Accept the timezone specifiers [+-]hh:mm and [+-]hh
 in addition to [+-]hhmm
Date: Wed, 19 May 2010 07:31:25 -0700
Message-ID: <7v632karpe.fsf@alter.siamese.dyndns.org>
References: <1274123231-18482-1-git-send-email-marcus@mc.pp.se>
 <1274123231-18482-3-git-send-email-marcus@mc.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marcus Comstedt <marcus@mc.pp.se>
X-From: git-owner@vger.kernel.org Wed May 19 16:31:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEkJC-0005xl-BT
	for gcvg-git-2@lo.gmane.org; Wed, 19 May 2010 16:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752779Ab0ESObh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 May 2010 10:31:37 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58469 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332Ab0ESObg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 May 2010 10:31:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D667B4068;
	Wed, 19 May 2010 10:31:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=hLIiyn9eqhNiZtDu4zj+fykbdb4=; b=tW3U5tyJy2qQYB100s9OJyo
	ze5fdrv1qXnRH93ALXxkBqQ9Gh8V9pWagj53LeZ33UXv6NJ87mE9r1mosmvaJ0oo
	+74HL/jBy0qDHylQPqA07ANQL8Wrb9NL6QoRGU+d66tGjt3Kn01erEnsF0bg5FCp
	ejuMsObOXABKjGnSPQgc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=IMz2R7pENUJy2uqOT+dyYJEFzJIvCWQzn4HJvwqISOCAO7km0
	rfw5g4Pcb94IVDfwFGytLu8ZgDC4u+4zaJlnqXPlQT9zeEnvDKb/5R+8k3ZeAKg7
	gycVgd3aqwcFkQ+J+gNJBL+dZn/QjKqR9XSGuow+RPzB6yuzHC3nzVW1CM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A57EB4059;
	Wed, 19 May 2010 10:31:30 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8A755B404F; Wed, 19 May
 2010 10:31:27 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3734DE6E-6353-11DF-A8B9-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147328>

Marcus Comstedt <marcus@mc.pp.se> writes:

> ISO 8601 specifies three syntaxes for timezones other than "Z".
> git already supports the +-hhmm syntax.  This patch adds support
> for the other two: +-hh:mm and +-hh.
>
> Signed-off-by: Marcus Comstedt <marcus@mc.pp.se>
> ---
> :100644 100644 6bae49c... f83e46e... M	date.c
>  date.c |   23 +++++++++++++++++++++++
>  1 files changed, 23 insertions(+), 0 deletions(-)
>
> diff --git a/date.c b/date.c
> index 6bae49c..f83e46e 100644
> --- a/date.c
> +++ b/date.c
> @@ -555,6 +555,18 @@ static int match_tz(const char *date, int *offp)
>  	int min, hour;
>  	int n = end - date - 1;
>  
> +	/* Check for HH:MM format, allowed by ISO 8601 */
> +	if (n == 2 && date[3] == ':') {
> +		char *end2;
> +		min = strtoul(date+4, &end2, 10);
> +		/* If we have two digits after the colon too, assume HH:MM */
> +		if (end2 == date+6) {
> +			offset = offset*100 + min;
> +			end = end2;
> +			n = end - date - 1;
> +		}
> +	}
> +
>  	min = offset % 100;
>  	hour = offset / 100;
>  
> @@ -570,6 +582,17 @@ static int match_tz(const char *date, int *offp)
>  
>  		*offp = offset;
>  	}
> +	/*
> +	 * Also accept just the hour, allowed by ISO 8601
> +	 */
> +	else if (n == 2 && hour == 0 && min < 24) {
> +		offset = min*60;
> +		if (*date == '-')
> +			offset = -offset;
> +
> +		*offp = offset;
> +	}
> +

I don't recall seeing in ISO 8601 that +hh or -hh without minute
resolution was allowed, but I don't have my copy of ISO 8601 with me (they
are packed and are still in transit with my household goods) so I'll take
your word for it for now [*1*].

But the placement of this second hunk is somewhat curious.  Why doesn't the
updated function look like this?

        int offset = strtoul(date + 1, &end, 10);
        int min, hour;
        int n = end - date - 1;

        if (n == 2 && offset <= 14) {
                /* +HH:MM (ISO 8601) or +HH (ISO 8601 abbreviated) */
                hour = offset;
                if (n == 2 && date[3] == ':') {
                        min = strtoul(date + 4, &end, 10);
                        if (end != date + 6)
                                return 0; /* Bad CRAP */
                } else {
                        min = 0;
                }
        } else if (n < 3) {
                return 0; /* we want at least 3 digits */
        } else {
                min = offset % 100;
                hour = offset / 100;
        }

        if (60 <= min)
                return 0; /* invalid minute */

        offset = hour * 60 + min;
        if (*date == '-')
                offset = -offset;
        *offp = offset;
        return end - date;


[Footnote]

*1* Appendix A of RFC3339 seems to agree with you.
