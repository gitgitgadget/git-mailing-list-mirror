From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] path.c: Don't discard the return value of vsnpath()
Date: Tue, 04 Sep 2012 13:53:28 -0700
Message-ID: <7vipbt8q7r.fsf@alter.siamese.dyndns.org>
References: <50463A1A.9000801@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Sep 04 22:53:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T907u-0005gi-TL
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 22:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757594Ab2IDUxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 16:53:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39897 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757043Ab2IDUxb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 16:53:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7ACB89CCA;
	Tue,  4 Sep 2012 16:53:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xhPPFLgrEEat++dvfknlkzEZMWI=; b=N1+mHJ
	mmgQK4X9yNISB4uQfhHPTYm0B6sUzO8MlmsDVfTLbz2fGyYxAOjYIL13uS+7xEkn
	48bVRAVzUJJG+H8PGMo+Ou+O41mBj/7gc8JMlnzhhCU8REYMviA5qIuwu/oUPxVO
	C6lxxEBDP/6I6GZcBpma8H85T0Dy9IsejyFiE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XU199PFWf9ob8SCbV7wBjdktXUGJFY3R
	JFWEWV5A4watCGmchlZh1XpuSCUa7huLOtYv3vNpXrSl6PoFvneJkEijxIQLV/ZF
	tk6+rN3k31jtNqysaCm7InON5YrbstQyX7GJcdEoi2vVCrDTLHoRaURRMLvperAJ
	C8nTP9EuvtM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66FE59CC9;
	Tue,  4 Sep 2012 16:53:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A54699CC8; Tue,  4 Sep 2012
 16:53:29 -0400 (EDT)
In-Reply-To: <50463A1A.9000801@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Tue, 04 Sep 2012 18:27:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 94BDC522-F6D2-11E1-AA33-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204785>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> The git_snpath() and git_pathdup() functions both use the (static)
> function vsnpath() in their implementation. Also, they both discard
> the return value of vsnpath(), which has the effect of ignoring the
> side effect of calling cleanup_path() in the non-error return path.
>
> In order to ensure that the required cleanup happens, we use the
> pointer returned by vsnpath(), rather than the buffer passed into
> vsnpath(), to derive the return value from git_snpath() and
> git_pathdup().
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>  path.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/path.c b/path.c
> index 9eb5333..741ae77 100644
> --- a/path.c
> +++ b/path.c
> @@ -70,21 +70,22 @@ bad:
>  
>  char *git_snpath(char *buf, size_t n, const char *fmt, ...)
>  {
> +	char *ret;
>  	va_list args;
>  	va_start(args, fmt);
> -	(void)vsnpath(buf, n, fmt, args);
> +	ret = vsnpath(buf, n, fmt, args);
>  	va_end(args);
> -	return buf;
> +	return ret;
>  }
>  
>  char *git_pathdup(const char *fmt, ...)
>  {
> -	char path[PATH_MAX];
> +	char path[PATH_MAX], *ret;
>  	va_list args;
>  	va_start(args, fmt);
> -	(void)vsnpath(path, sizeof(path), fmt, args);
> +	ret = vsnpath(path, sizeof(path), fmt, args);
>  	va_end(args);
> -	return xstrdup(path);
> +	return xstrdup(ret);
>  }
>  
>  char *mkpathdup(const char *fmt, ...)

cleanup_path() is a quick-and-dirty hack that only deals with
leading ".///" (e.g. "foo//bar" is not reduced to "foo/bar"), and
the callers that allocate 4 bytes for buf to hold "foo" may not be
able to fit it if for some reason there are some bytes that must be
cleaned, e.g. ".///foo".

The worst part of its use is that buf and ret could be different,
which means you cannot safely do:

	char *buf = xmalloc(...);
        buf = git_snpath(buf, n, "%s", ...);
        ... use buf ...
        free(buf);

but instead have to do something like:

	char *path, *buf = xmalloc(...);
        path = git_snpath(buf, n, "%s", ...);
        ... use path ...
        free(buf);

And this series goes in a direction of making more callers aware of
the twisted calling convention, which smells really bad.

As long as the callers are contained within this file, it is not
making things _too_ bad, so...
