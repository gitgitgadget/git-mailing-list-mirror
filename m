From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http.c: Use curl_multi_fdset to select on curl fds
 instead of just sleeping
Date: Wed, 02 Nov 2011 11:29:14 -0700
Message-ID: <7v62j2js3p.fsf@alter.siamese.dyndns.org>
References: <1320230734-5933-1-git-send-email-mika.fischer@zoopnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Stenberg <daniel@haxx.se>
To: Mika Fischer <mika.fischer@zoopnet.de>
X-From: git-owner@vger.kernel.org Wed Nov 02 19:29:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLfYx-00085C-Kd
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 19:29:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755831Ab1KBS3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 14:29:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40598 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752834Ab1KBS3S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 14:29:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 228335140;
	Wed,  2 Nov 2011 14:29:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yV4gzPg5abEJu9l/fZ0BY6NuBaI=; b=PpIU2f
	TYg83T5T1DYHDwOfOYRHkommTXNA9+s4mFL/4XqqGpTr6XDjcKeCjGskReX9UaGb
	9jAUPV6yuOcUtwdfFxOhDVjWGRL1EqIjj5szCvy1fngsC+8FvZJnooDZ7uHm2m0N
	4UQWOQir1+IYeES/zeZdLSlzvFAIuKXWVrTV4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fjAAgIFNzKozLsNVlJ6eksDk223CAgjZ
	bxpkM9kAZ0bTGJqcj05xm4DUOfec7zRMC3pXJW9Rij99KBIHzmaDbe5vYQabOPJl
	fZoopICooSXbdCEZAW3zJdEiDUFrqgwd4OTs/Hi5iY8qWMXrGSHKDNWR9alkwwU7
	lv3t7VNCICI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 196F8513F;
	Wed,  2 Nov 2011 14:29:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7B310513E; Wed,  2 Nov 2011
 14:29:16 -0400 (EDT)
In-Reply-To: <1320230734-5933-1-git-send-email-mika.fischer@zoopnet.de> (Mika
 Fischer's message of "Wed, 2 Nov 2011 11:45:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 923B8F3A-0580-11E1-962E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184654>

Mika Fischer <mika.fischer@zoopnet.de> writes:

> Previously, when nothing could be read from the connections curl had
> open, git would just sleep unconditionally for 50ms. This patch changes
> this behavior and instead obtains the recommended timeout and the actual
> file descriptors from curl. This should eliminate time spent sleeping when
> data could actually be read/written on the socket.
>
> Signed-off-by: Mika Fischer <mika.fischer@zoopnet.de>
> ---

Thanks. I added Daniel back to Cc: list as I know he is the area expert
when it comes to the use of libcurl, and also his input helped to polish
this patch during the initial round of discussion.

>  http.c |   21 ++++++++++++++++-----
>  1 files changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/http.c b/http.c
> index a4bc770..12180f3 100644
> --- a/http.c
> +++ b/http.c
> @@ -649,6 +649,7 @@ void run_active_slot(struct active_request_slot *slot)
>  	fd_set excfds;
>  	int max_fd;
>  	struct timeval select_timeout;
> +	long int curl_timeout;

Just a style nit, but we usually spell this "long" not "long int" in our
codebase.

> @@ -664,14 +665,24 @@ void run_active_slot(struct active_request_slot *slot)
>  		}
>  
>  		if (slot->in_use && !data_received) {
> -			max_fd = 0;
> +			curl_multi_timeout(curlm, &curl_timeout);

According to http://curl.haxx.se/libcurl/c/curl_multi_timeout.html
this was added in 7.15.4 which may be much newer than some of the versions
the existing code checks LIBCURL_VERSION_NUM against (grep for it in http.c).

Shouldn't you make this conditional?

> +			if (curl_timeout == 0) {
> +				continue;
> +			} else if (curl_timeout == -1) {
> +				select_timeout.tv_sec  = 0;
> +				select_timeout.tv_usec = 50000;
> +			} else {
> +				select_timeout.tv_sec  =  curl_timeout / 1000;
> +				select_timeout.tv_usec = (curl_timeout % 1000) * 1000;
> +			}
> +
> +			max_fd = -1;
>  			FD_ZERO(&readfds);
>  			FD_ZERO(&writefds);
>  			FD_ZERO(&excfds);
> -			select_timeout.tv_sec = 0;
> -			select_timeout.tv_usec = 50000;
> -			select(max_fd, &readfds, &writefds,
> -			       &excfds, &select_timeout);
> +			curl_multi_fdset(curlm, &readfds, &writefds, &excfds, &max_fd);

I couldn't find in http://curl.haxx.se/libcurl/c/curl_multi_fdset.html
what the version requirement for using this function is, but the same
comment as above applies here.

By the way, I think I saw Daniel posting a link to a nicely formatted
table that lists each and every functions and CURLOPT_* symbol with
ranges of version it is usable, but I seem to be unable to find it.

> +
> +			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
>  		}
>  	}
>  #else
