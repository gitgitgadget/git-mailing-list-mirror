From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/apply: exit when parse_binary() fails
Date: Wed, 16 Mar 2016 12:44:19 -0700
Message-ID: <xmqqshzq438s.fsf@gitster.mtv.corp.google.com>
References: <1458156675-26109-1-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 20:44:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agHMp-0004O1-5y
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 20:44:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755486AbcCPToX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 15:44:23 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:64063 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752138AbcCPToW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 15:44:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 49F744D943;
	Wed, 16 Mar 2016 15:44:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VUwyjhf38p5n4ipI9+2GjaFaGok=; b=n/l2EP
	ZPMDXxEio5sJKwAQ45IMXKuclW8sjNn47Xr2F9PppKTn2Y+0VlwARCF2EnZ0u140
	OWM38HORWqZvHjKdAMY84Zsf2dLFtY1znQ12hPzaK0t3hqwwDIUgCVDfwxPv7pr5
	84QPYjXkFa2yiV7uEJ1eyBn9LkxEp5hIxrBpw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kxLSuOqHgRcEC+W08wYkdBGj6PB/Mz/K
	e5fuZJ01MZF/jbFteDk6AVdNfajw5G+cy4hXzD1Cna+fN0nibCPQLVqcmu6AhOW+
	FcZ1C0Zlf2RyC+4CzOHWzBBvExEaTnT7qQ7hXd6LPejUlPX3AbUk/n2JTYmRMxP/
	pueX4qjBdUU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 421AB4D942;
	Wed, 16 Mar 2016 15:44:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A1C284D941;
	Wed, 16 Mar 2016 15:44:20 -0400 (EDT)
In-Reply-To: <1458156675-26109-1-git-send-email-chriscool@tuxfamily.org>
	(Christian Couder's message of "Wed, 16 Mar 2016 20:31:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7A34F196-EBAF-11E5-907F-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289024>

Christian Couder <christian.couder@gmail.com> writes:

> In parse_binary() there is:
>
> 	forward = parse_binary_hunk(&buffer, &size, &status, &used);
> 	if (!forward && !status)
> 		/* there has to be one hunk (forward hunk) */
> 		return error(_("unrecognized binary patch at line %d"), linenr-1);
>
> so parse_binary() can return -1, because that's what error() returns.
>
> Also parse_binary_hunk() sets "status" to -1 in case of error and
> parse_binary() does "if (status) return status;".

All of the above sounds sensible, and your follow-up patch expects
parse_chunk() to return -1 on failure--it is a bit sad that you make
parse_chunk() to directly call exit(2).  In the spirit of eventually
libifying this codepath, shouldn't we be turning existing die() to
an error return, instead of introducing more calls to exit(2)?


> In this case parse_chunk() should just exit, rather than add -1 to the
> patchsize it computes.


> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/apply.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 42c610e..18dec0f 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -1872,6 +1872,11 @@ static struct fragment *parse_binary_hunk(char **buf_p,
>  	return NULL;
>  }
>  
> +/*
> + * Returns:
> + *   -1 in case of error,
> + *   the length of the parsed binary patch otherwise
> + */
>  static int parse_binary(char *buffer, unsigned long size, struct patch *patch)
>  {
>  	/*
> @@ -2017,6 +2022,8 @@ static int parse_chunk(char *buffer, unsigned long size, struct patch *patch)
>  			linenr++;
>  			used = parse_binary(buffer + hd + llen,
>  					    size - hd - llen, patch);
> +			if (used < 0)
> +				exit(1);
>  			if (used)
>  				patchsize = used + llen;
>  			else
