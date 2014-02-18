From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] streaming: simplify attaching a filter
Date: Tue, 18 Feb 2014 15:56:21 -0800
Message-ID: <xmqqd2ikasbe.fsf@gitster.dls.corp.google.com>
References: <cover.1392565571.git.john@keeping.me.uk>
	<0120f99a7cccc118782cda63f478d7d3f528ee3f.1392565571.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Feb 19 00:56:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFuWc-0006n1-T6
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 00:56:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbaBRX40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 18:56:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52274 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750832AbaBRX40 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 18:56:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F1C36E3AF;
	Tue, 18 Feb 2014 18:56:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AT2WJfr2rkkRMA0IuyjekdJTmdc=; b=I+EKA3
	9qnIHFnI0QGYhwKBxto06BcxFd30UbhT6EuOmTGEn0eCWpgpKond0zwlyXF81oiX
	ripfIlosGaKlZnAPHqqm+EJb9Tz6zEMez/6pqpCpSjKm+DlFP7VXCxNqmxMixd75
	JGMzQXom0TlfzgOet9Cc3/UHV94jvMrqkppYs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uU5Uaz28cAuxbjJNA5ymgnaHrxRXwYK9
	5liuHf6ke5BlnFerO3I1lYUh9EoP+t4/xWI9ncthQTcpEYApuoCykG+B20zTmOeh
	iGFuKfmYv+SL51CMCbmUe/lWQbwjphgZmEKkDSV1190dQvRvTrSJdQtYVsf1T6r7
	U/HKBxCcOJA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 464B86E3AE;
	Tue, 18 Feb 2014 18:56:25 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 818BC6E3AD;
	Tue, 18 Feb 2014 18:56:24 -0500 (EST)
In-Reply-To: <0120f99a7cccc118782cda63f478d7d3f528ee3f.1392565571.git.john@keeping.me.uk>
	(John Keeping's message of "Sun, 16 Feb 2014 16:06:06 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 460668D4-98F8-11E3-9993-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242375>

John Keeping <john@keeping.me.uk> writes:

> We are guaranteed that 'nst' is non-null because it is allocated with
> xmalloc(), and in fact we rely on this three lines later by
> unconditionally dereferencing it.

The intent of the original code is for attach_stream_filter() to
detect an error condition and return NULL, in which case it closes
the istream it allocated and signal error to the caller, I think,
and falling thru to use st->anything and return st when that happens
is *not* a guarantee that a-s-f will not detect an error ever, but
rather is a bug in the error codepath.

>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
>  streaming.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/streaming.c b/streaming.c
> index d7c9f32..8a7135d 100644
> --- a/streaming.c
> +++ b/streaming.c
> @@ -151,10 +151,7 @@ struct git_istream *open_istream(const unsigned char *sha1,
>  	}
>  	if (filter) {
>  		/* Add "&& !is_null_stream_filter(filter)" for performance */
> -		struct git_istream *nst = attach_stream_filter(st, filter);
> -		if (!nst)
> -			close_istream(st);
> -		st = nst;
> +		st = attach_stream_filter(st, filter);
>  	}
>  
>  	*size = st->size;
