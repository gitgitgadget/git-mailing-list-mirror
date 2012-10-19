From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fix potential hang in https handshake (v2).
Date: Thu, 18 Oct 2012 17:33:54 -0700
Message-ID: <7v8vb3l2q5.fsf@alter.siamese.dyndns.org>
References: <5080906b.xT6aRtW1ELoWhZZw%szager@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sop@google.com
To: szager@google.com
X-From: git-owner@vger.kernel.org Fri Oct 19 02:34:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TP0XX-0008Iz-IT
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 02:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659Ab2JSAd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 20:33:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57584 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751577Ab2JSAd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 20:33:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBBAC9C3A;
	Thu, 18 Oct 2012 20:33:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QxUnUCsQmeTgewwqLPxfp6prpsI=; b=xUgxdK
	hk0TglWQsoi0LsP6J177nNodiLePC4z5fz/2o3eVu4Ux9Cv1cBdKVAdtyxMo+qE0
	yD4HqHOS6NCucXke4V+1a+0Xsl5WF1pW9TKwslW7m8uv2/YNmcRarRH3cMIqR5KA
	4CKm0T2yG5CfagHCFO26RCi0GOe0G31DiEh+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DJUar1NgE67UOKIi84zWAGCZSlVsijuk
	DS8d3U3hNncplkQ3ekRvwbL4/diWEBC/vN+LAA28jwPkjEQdNQ3Mn7bfkyAsOu74
	P+YV9j4Z7hWI2ckJ2pqBZnKmP1YnsVlNwrG0Qh8d32U8usAokW3fFO/CHh/tlKOk
	KJouOoxquCA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A89B59C39;
	Thu, 18 Oct 2012 20:33:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D88BC9C38; Thu, 18 Oct 2012
 20:33:55 -0400 (EDT)
In-Reply-To: <5080906b.xT6aRtW1ELoWhZZw%szager@google.com>
 (szager@google.com's message of "Thu, 18 Oct 2012 16:27:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AA5A1C9E-1984-11E2-8991-9A8C2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208032>

szager@google.com writes:

> From aa77ab3dd5b98a5786ac158528f45355fc0ddbc3 Mon Sep 17 00:00:00 2001
> From: Stefan Zager <szager@google.com>
> Date: Thu, 18 Oct 2012 16:23:53 -0700
> Subject: [PATCH] Fix potential hang in https handshake.

Please don't do the above (as usual ;-)

> It will sometimes happen that curl_multi_fdset() doesn't
> return any file descriptors.  In that case, it's recommended
> that the application sleep for a short time before running
> curl_multi_perform() again.
>
> http://curl.haxx.se/libcurl/c/curl_multi_fdset.html
>
> Signed-off-by: Stefan Zager <szager@google.com>
> ---

The above sounds like "the code is doing something against a
recommended practice", but is there a user-visible symptom due to
this?

We end up calling select() without any bit set in fds, so it would
become micro-sleep of select_timeout in such a case, but as far as I
can see, the existing code either

 * does not select() and keeps polling step_active_slots() without
   delay, when curl_timeout gives a 0 return value; or

 * sets 50ms timeout or whatever negative value derived from
   curl_timeout when the returned value is not 0 nor -1.

Is the symptom that select(), when given a negative timeout and no
fd to wake it, sleeps forever (or "loooong time, taking that negative
value as if it is a large unsigned long") or something?

Thanks.

>  http.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/http.c b/http.c
> index df9bb71..e8aba7f 100644
> --- a/http.c
> +++ b/http.c
> @@ -630,6 +630,10 @@ void run_active_slot(struct active_request_slot *slot)
>  			FD_ZERO(&writefds);
>  			FD_ZERO(&excfds);
>  			curl_multi_fdset(curlm, &readfds, &writefds, &excfds, &max_fd);
> +			if (max_fd < 0) {
> +				select_timeout.tv_sec  = 0;
> +				select_timeout.tv_usec = 50000;
> +			}
>  
>  			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
>  		}
