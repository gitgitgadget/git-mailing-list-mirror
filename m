From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 17/17] rename_tmp_log(): on SCLD_VANISHED, retry
Date: Mon, 06 Jan 2014 10:21:17 -0800
Message-ID: <xmqqtxdhhsyq.fsf@gitster.dls.corp.google.com>
References: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
	<1389015935-21936-18-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jan 06 19:21:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0Enr-0001XX-G0
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 19:21:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755257AbaAFSV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 13:21:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40712 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754486AbaAFSV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 13:21:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A131F5F203;
	Mon,  6 Jan 2014 13:21:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LCcviWqWQAcxjAP+c+s/V3pmUWc=; b=mFSgUA
	qcIMqbXRkB54Rl7eneQwMkH1jeryDNQhFcYi8X9wi5pURaUpcJ90dOsHyFt3ffVN
	nxVWhVSvXzN/R5n1o+9FXIGGyL0I3yO6DupjtwoeOeGtEuBMuokb/o6NEMd7WdIh
	9f3SKZrpBpZrkfRksK5g99kYMgMkS/fL6+7rI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z7fG7jeqnKyh6+f+SCoZFWVWWY5QVbKz
	QcXXNfz3lIpi0CZUspu1lo64PVFhQW7rk5cnIEOIQ/qR66Jn5CC/RZ6OBtMZ0vlz
	U8maMJgZiUYJ4/6tNc+ADUbgmW1UJzP4wBb+zI0GQjI4BXH8QWJVPPE3j466ghQK
	6yYNXCSMUgY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 072315F1FF;
	Mon,  6 Jan 2014 13:21:22 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 430D45F1F4;
	Mon,  6 Jan 2014 13:21:20 -0500 (EST)
In-Reply-To: <1389015935-21936-18-git-send-email-mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Mon, 6 Jan 2014 14:45:35 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 57317060-76FF-11E3-A7C3-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240042>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> If safe_create_leading_directories() fails because a file along the
> path unexpectedly vanished, try again from the beginning.  Try at most
> 3 times.

As the previous step bumped it from 3 to 4 without explanation, the
above no longer reflects reality ;-)

The series mostly looked sane from a cursory read.

Will re-queue.  Thanks.


>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/refs.c b/refs.c
> index 490525a..810f802 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2533,7 +2533,14 @@ static int rename_tmp_log(const char *newrefname)
>  	int attempts = 4;
>  
>   retry:
> -	if (safe_create_leading_directories(git_path("logs/%s", newrefname))) {
> +	switch (safe_create_leading_directories(git_path("logs/%s", newrefname))) {
> +	case SCLD_OK:
> +		break; /* success */
> +	case SCLD_VANISHED:
> +		if (--attempts > 0)
> +			goto retry;
> +		/* fall through */
> +	default:
>  		error("unable to create directory for %s", newrefname);
>  		return -1;
>  	}
