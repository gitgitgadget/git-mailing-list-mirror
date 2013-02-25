From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Fix date checking in case if time was not
 initialized.
Date: Mon, 25 Feb 2013 10:26:10 -0800
Message-ID: <7vzjysxnb1.fsf@alter.siamese.dyndns.org>
References: <CAHXAxrOOqn6ZSVT1AFyO3a3paD1tokBtcnaX68a+ddhodOvZ6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Gorchak <mike.gorchak.qnx@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 19:26:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA2l9-0005P4-Hl
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 19:26:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758639Ab3BYS0S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 13:26:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58085 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347Ab3BYS0R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 13:26:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EBCEB59B;
	Mon, 25 Feb 2013 13:26:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JIAoqDF7ibJPpzS24aEkkQzIKbs=; b=ufN93y
	i1peldUHCC4qLpclE7kSCLXSshdvqw6HMdVTUAh14ueOdbZCIu8LoEKy5eZIYrGg
	0IRVy9oVVjTA2Ixuz+LkCQXZhlGnPhPsLpd9AAkaVqaNYd5fUp4D5/GARqfweDnY
	lWPTnFmccKkwP2yFOTPLFETiK/RUkUiSXjFrw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DdiY44Hon29Fs/tnaIuqaC5gUs/8e5H6
	JO6gQIaFwY2v4GaZmJ6ro4uTArYHA2F6OSGHD4UB+iic8OEmH+cFolpgh7XH8oLD
	hJVKWFHU25fGidWHSbhufBLDS6sM6isXoAZY4/JTdcGesFHbtgErVFe0C3rdgGsf
	UtM5oNMYC9Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D2E7B599;
	Mon, 25 Feb 2013 13:26:17 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 821F7B590; Mon, 25 Feb 2013
 13:26:16 -0500 (EST)
In-Reply-To: <CAHXAxrOOqn6ZSVT1AFyO3a3paD1tokBtcnaX68a+ddhodOvZ6Q@mail.gmail.com> (Mike
 Gorchak's message of "Mon, 25 Feb 2013 10:36:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D7A7719C-7F78-11E2-8BE3-F3C82E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217073>

Mike Gorchak <mike.gorchak.qnx@gmail.com> writes:

> Fix is_date() function failings in detection of correct date in case
> if time was not properly initialized.

Please explain why this patch is needed and what problem this patch
is trying to fix (if any) a bit better in the proposed log message.
For example, on what input do we call this function with partially
filled *r, and is that an error in the code, or is it an indication
that the input has only been consumed partially?

tm_to_time_t() is designed to reject underspecified date input, and
its callers call is_date() starting with partially filled tm on
purpose to reject such input. Doesn't "fixing" partially filled tm
before calling tm_to_time_t() inside is_date() break that logic?

> From: Mike Gorchak <mike.gorchak.qnx@gmail.com>
> Signed-off-by: Mike Gorchak <mike.gorchak.qnx@gmail.com>
> ---
>  date.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/date.c b/date.c
> index 57331ed..ec758f4 100644
> --- a/date.c
> +++ b/date.c
> @@ -357,6 +357,7 @@ static int is_date(int year, int month, int day,
> struct tm *now_tm, time_t now,
>  	if (month > 0 && month < 13 && day > 0 && day < 32) {
>  		struct tm check = *tm;
>  		struct tm *r = (now_tm ? &check : tm);
> +		struct tm fixed_r;
>  		time_t specified;
>
>  		r->tm_mon = month - 1;
> @@ -377,7 +378,16 @@ static int is_date(int year, int month, int day,
> struct tm *now_tm, time_t now,
>  		if (!now_tm)
>  			return 1;
>
> -		specified = tm_to_time_t(r);
> +		/* Fix tm structure in case if time was not initialized */
> +		fixed_r = *r;
> +		if (fixed_r.tm_hour==-1)
> +			fixed_r.tm_hour=0;
> +		if (fixed_r.tm_min==-1)
> +			fixed_r.tm_min=0;
> +		if (fixed_r.tm_sec==-1)
> +			fixed_r.tm_sec=0;
> +
> +		specified = tm_to_time_t(&fixed_r);
>
>  		/* Be it commit time or author time, it does not make
>  		 * sense to specify timestamp way into the future.  Make
