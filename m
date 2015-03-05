From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] xfdopen(): if first attempt fails, free memory and try again
Date: Thu, 05 Mar 2015 11:06:12 -0800
Message-ID: <xmqq4mpz463f.fsf@gitster.dls.corp.google.com>
References: <1425571669-22800-1-git-send-email-mhagger@alum.mit.edu>
	<1425571669-22800-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 05 20:06:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTb6D-000680-DA
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 20:06:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755885AbbCETGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 14:06:17 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50364 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751029AbbCETGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 14:06:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 65BC03DF5A;
	Thu,  5 Mar 2015 14:06:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o1km70cDPtqj2F6jArmK5NqZcqs=; b=F0WsDL
	SNxkIKtVgkUrPnDZVjT4RCHmUy0+JbZRA8x/ysy6MVpaYt+I5j3FUKTJVv5n5A2A
	lK1C1c7YSYLb416ue+pA0LH90KiHhAyLlpftzUhrz4OLO/ddo/DzRefIbBrqznLT
	j5Cqp/UaGsPG/4ccViOLlUZyiGpi/uTrjLlgM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=enCaVsPlSKriVJEH6LkZ+jctf2c8on/4
	wj0eNMoNX+7ItXShPdQVVBB1MNCxCbF9pTDwPyO9OTbnSC9Bx5YanNJktasMmhfs
	mEjTe4N3B1mIxQhSsqxz6vNXWcJ9f7zl6B9onYYTGL5Xpm3xUUdVrxLNqzXI6v9J
	9ivvAXCvOYM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E4B03DF59;
	Thu,  5 Mar 2015 14:06:14 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D24B03DF58;
	Thu,  5 Mar 2015 14:06:13 -0500 (EST)
In-Reply-To: <1425571669-22800-2-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Thu, 5 Mar 2015 17:07:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B16EF72E-C36A-11E4-93DF-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264859>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> One likely reason for the failure of fdopen() is a lack of free
> memory.

Interesting.

Did you find this by code inspection?

Or did you actually hit this issue in real life, and applying this
patch helped?  The latter would indicate that this failure is rather
common with your workload, and that Git can continue working even
when the process is so memory starved to cause fdopen() to fail.

> Also expose a new function, fdopen_with_retry(), which retries on
> ENOMEM but doesn't die() on errors. In a moment this function will be
> used elsewhere.

Hmm, OK, I guess these three lines answers my question---asking that
question at this point in the series is moot ;-)

The code looks good.

> Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  git-compat-util.h | 11 +++++++++++
>  wrapper.c         | 28 +++++++++++++++++++++++++---
>  2 files changed, 36 insertions(+), 3 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 3455c5e..a5652a7 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -672,7 +672,18 @@ extern ssize_t xread(int fd, void *buf, size_t len);
>  extern ssize_t xwrite(int fd, const void *buf, size_t len);
>  extern ssize_t xpread(int fd, void *buf, size_t len, off_t offset);
>  extern int xdup(int fd);
> +
> +/*
> + * Like fdopen(), but if the first attempt fails with ENOMEM, try to
> + * free up some memory and try again.
> + */
> +extern FILE *fdopen_with_retry(int fd, const char *mode);
> +
> +/*
> + * Like fdopen_with_retry(), but die on errors.
> + */
>  extern FILE *xfdopen(int fd, const char *mode);
> +
>  extern int xmkstemp(char *template);
>  extern int xmkstemp_mode(char *template, int mode);
>  extern int odb_mkstemp(char *template, size_t limit, const char *pattern);
> diff --git a/wrapper.c b/wrapper.c
> index d5a6cef..b60cc03 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -311,14 +311,36 @@ int xdup(int fd)
>  	return ret;
>  }
>  
> -FILE *xfdopen(int fd, const char *mode)
> +FILE *fdopen_with_retry(int fd, const char *mode)
>  {
>  	FILE *stream = fdopen(fd, mode);
> -	if (stream == NULL)
> -		die_errno("Out of memory? fdopen failed");
> +
> +	if (!stream && errno == ENOMEM) {
> +		/*
> +		 * Try to free up some memory, then try again. We
> +		 * would prefer to use sizeof(FILE) here, but that is
> +		 * not guaranteed to be defined (e.g., FILE might be
> +		 * an incomplete type).
> +		 */
> +		try_to_free_routine(1000);
> +		stream = fdopen(fd, mode);
> +	}
> +
>  	return stream;
>  }
>  
> +FILE *xfdopen(int fd, const char *mode)
> +{
> +	FILE *stream = fdopen_with_retry(fd, mode);
> +
> +	if (stream)
> +		return stream;
> +	else if (errno == ENOMEM)
> +		die_errno("Out of memory? fdopen failed");
> +	else
> +		die_errno("fdopen failed");
> +}
> +
>  int xmkstemp(char *template)
>  {
>  	int fd;
