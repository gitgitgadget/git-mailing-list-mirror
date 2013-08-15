From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] create_delta_index: simplify condition always evaluating to true
Date: Thu, 15 Aug 2013 14:43:35 -0700
Message-ID: <7vzjsipr3s.fsf@alter.siamese.dyndns.org>
References: <1376595460-6546-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stefan Beller <stefanbeller@googlemail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Aug 15 23:43:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA5Kc-0005Nf-Ed
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 23:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574Ab3HOVnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 17:43:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47208 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752524Ab3HOVni (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 17:43:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF46739EA3;
	Thu, 15 Aug 2013 21:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ddc9KaNSiaVGC8OVgu63xvhyIJc=; b=GuX9KP
	0GpmTlRH4rb1OVE4CufSEvGIGC1RoBwfUPxQbHFdaMQodJIYAAN8TXFUlXgkhGZL
	KEIWveWk0E7hTVkyoZIQce+wA9a+PPVBOjKQKgek6uieVfv9Dg9JL8LA2XGATSbq
	NHm/FMxRAaoyiB7qoifhyKWW3U7BuBnBnhshQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MYeSvLBdKPPQrgvZEnqejSujFhOQyANI
	v3SMcovL7E+Da2h01l9pDwfUgqL95BXjEhtN/NGzhCLrvsGgxUTUVIeRVOt+ZSy+
	QOJ1gVzqeZwHsPesj8Nj1w+raZv/31s5sw/g+AnrXly3pAKDdjyIhaTYwFp3HDr+
	uS3FOa/FTg0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B62A239EA2;
	Thu, 15 Aug 2013 21:43:37 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0909539E9D;
	Thu, 15 Aug 2013 21:43:36 +0000 (UTC)
In-Reply-To: <1376595460-6546-1-git-send-email-stefanbeller@googlemail.com>
	(Stefan Beller's message of "Thu, 15 Aug 2013 21:37:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BDC884D0-05F3-11E3-9058-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232375>

Forwarding to the area expert...

Stefan Beller <stefanbeller@googlemail.com> writes:

> When checking the previous lines in that function, we can deduct that
> hsize must always be smaller than (1u<<31), since 506049c7df2c6
> (fix >4GiB source delta assertion failure), because the entries is
> capped at an upper bound of 0xfffffffeU, so hsize contains a maximum
> value of 0x3fffffff, which is smaller than (1u<<31), so i will never
> be larger than 31.
>
> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
> ---
>  diff-delta.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/diff-delta.c b/diff-delta.c
> index 93385e1..54da95b 100644
> --- a/diff-delta.c
> +++ b/diff-delta.c
> @@ -154,8 +154,15 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
>  		 */
>  		entries = 0xfffffffeU / RABIN_WINDOW;
>  	}
> +
> +	/*
> +	 * Do not check i < 31 in the loop, because the assignement
> +	 * previous to the loop makes sure, hsize is definitely
> +	 * smaller than 1<<31, hence the loop will always stop
> +	 * before i exceeds 31 resulting in an infinite loop.
> +	 */
>  	hsize = entries / 4;
> -	for (i = 4; (1u << i) < hsize && i < 31; i++);
> +	for (i = 4; (1u << i) < hsize; i++);
>  	hsize = 1 << i;
>  	hmask = hsize - 1;
