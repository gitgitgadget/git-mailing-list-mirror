From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mingw: emulate write(2) that fails with a EPIPE
Date: Wed, 16 Dec 2015 10:35:32 -0800
Message-ID: <xmqq7fkedyx7.fsf@gitster.mtv.corp.google.com>
References: <01da36219c18373f8507e19035e141d7e56b2d18.1450267413.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 16 19:35:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9GvO-00052R-7B
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 19:35:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755134AbbLPSfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 13:35:36 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61606 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755126AbbLPSff (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 13:35:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8B4DF333B7;
	Wed, 16 Dec 2015 13:35:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RD5PVYqs2rK1c4yZ/shA5U9BUF4=; b=PUN2H0
	YPxi41Ce4lbA9xDpI3WpMHJDNJ8tYV8qAs9rvMWMQNiPJcY4ikH7R7V+2Wwu0zih
	3SzUkTVLSjQ0ndu3bVgT7QZJS+JE61cxQUVG5+LcgBiVK0eDOnJ8Ij2SO0jT9iff
	f5dl99TUjTE0vBATbji0Oslyd8HSx048Lm4kQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pKeOfC1JvhYhGG6JU1hM3SHVdm2snspe
	BnlfQYpB3dNl6prv20bxF7JLgG+YEb9jAPmvZHVNgqlrTwPSV8r09udQYdOew8bP
	dc0MNSJKtVt/At5SuxX70p9S3PvYmXr7hi3fNd5laCO1UiaHSB7rAw2BN/6bvfso
	cs46KBbL5oc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 83AF3333B6;
	Wed, 16 Dec 2015 13:35:34 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 054DB333B3;
	Wed, 16 Dec 2015 13:35:33 -0500 (EST)
In-Reply-To: <01da36219c18373f8507e19035e141d7e56b2d18.1450267413.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Wed, 16 Dec 2015 13:14:57 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CAF273F2-A423-11E5-9666-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282581>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> On Windows, when writing to a pipe fails, errno is always
> EINVAL. However, Git expects it to be EPIPE.
>
> According to the documentation, there are two cases in which write()
> triggers EINVAL: the buffer is NULL, or the length is odd but the mode
> is 16-bit Unicode (the broken pipe is not mentioned as possible cause).
> Git never sets the file mode to anything but binary, therefore we know
> that errno should actually be EPIPE if it is EINVAL and the buffer is
> not NULL.

Makes sense.

>  int mingw_fflush(FILE *stream);
>  #define fflush mingw_fflush
>  
> +static inline ssize_t mingw_write(int fd, const void *buf, size_t len)
> +{
> +	ssize_t result = write(fd, buf, len);
> +
> +	if (result < 0 && errno == EINVAL && buf) {
> +		/* check if fd is a pipe */
> +		HANDLE h = (HANDLE) _get_osfhandle(fd);
> +		if (GetFileType(h) == FILE_TYPE_PIPE)
> +			errno = EPIPE;
> +		else
> +			errno = EINVAL;
> +	}
> +
> +	return result;
> +}
> +
> +#define write mingw_write
> +

It strikes me a bit strange to see this inlined compared to what
appears in the context.  Shouldn't the implementation be done in
compat/mingw.c like all others?

>  int mingw_access(const char *filename, int mode);
>  #undef access
>  #define access mingw_access
