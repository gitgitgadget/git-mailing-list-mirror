From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/21] bisect: make algorithm behavior independent of DEBUG_BISECT
Date: Fri, 15 Apr 2016 14:25:14 -0700
Message-ID: <xmqq8u0ea7k5.fsf@gitster.mtv.corp.google.com>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
	<1460294354-7031-10-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Apr 15 23:25:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arBF3-0003LH-Tm
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 23:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993AbcDOVZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 17:25:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58570 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751991AbcDOVZR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 17:25:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 38001139B0;
	Fri, 15 Apr 2016 17:25:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oOJ7da/RS1nXVgyTjMFq6adQ/O8=; b=gZuojb
	TN3PnFyUxbzjvWVvTptlsbOJUAdkzsAFphrJeRF7WgFMgRAg3YpnCTP0yat6oPX2
	c6SRHfPj+bB9EJH568bscHmgNSS6fKKHDT7kCKmDQM0S/WqVRDsNN0+dYfgck6wH
	+zQ2pQdG90AFOy28UyV/u2fE5gSND/w+Lxkx0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gWGbssf+HUg+PUcovJW/uuu1OJx8VNbO
	qHPQQRkHTy01LSkgP0wg+H6yulggTIJrHn124pBV6oWmYGQKsKIupT5iaaGwjBa0
	hYEjwRdSJm3kUhBZRFXUNvCR7PErSgVilPsrUUcugwqDWj/H8f0KbOHNFZU9/jZu
	jJ0mTTuMmRU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 30F1A139AF;
	Fri, 15 Apr 2016 17:25:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A0E6F139AE;
	Fri, 15 Apr 2016 17:25:15 -0400 (EDT)
In-Reply-To: <1460294354-7031-10-git-send-email-s-beyer@gmx.net> (Stephan
	Beyer's message of "Sun, 10 Apr 2016 15:19:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8BA849CE-0350-11E6-909B-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291668>

Stephan Beyer <s-beyer@gmx.net> writes:

> If DEBUG_BISECT is set to 1, bisect does not only show debug
> information but also changes the algorithm behavior: halfway()
> is always false.
>
> This commit makes the algorithm independent of DEBUG_BISECT.
>
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> ---

Another good candidate for preliminary clean-up.

I do not remember what the rationale was to do this short-cut when I
wrote it at 1daa09d9 (make the previous optimization work also on
path-limited rev-list --bisect, 2007-03-23).  Thanks for spotting it.

>  bisect.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index 2f54d96..1a13f35 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -101,8 +101,6 @@ static inline int halfway(struct commit_list *p, int nr)
>  	 */
>  	if (p->item->object.flags & TREESAME)
>  		return 0;
> -	if (DEBUG_BISECT)
> -		return 0;
>  	/*
>  	 * 2 and 3 are halfway of 5.
>  	 * 3 is halfway of 6 but 2 and 4 are not.
