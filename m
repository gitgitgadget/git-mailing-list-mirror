From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] Provide a dirname() function when NO_LIBGEN_H=YesPlease
Date: Fri, 08 Jan 2016 10:53:40 -0800
Message-ID: <xmqqtwmn298r.fsf@gitster.mtv.corp.google.com>
References: <25a2598e756959f55f06ae6b4dc6f448e3b6b127.1443624188.git.johannes.schindelin@gmx.de>
	<cover.1452270051.git.johannes.schindelin@gmx.de>
	<4e1b6c602e0adccfc11152b00aa23d14b1bbd4a8.1452270051.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 08 19:53:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHcAV-0007qt-O4
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 19:53:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755596AbcAHSxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 13:53:44 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52241 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754281AbcAHSxm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 13:53:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4F4A639DCF;
	Fri,  8 Jan 2016 13:53:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cgJrSuMNRTXfynebTthTJzPobPY=; b=FC4EdG
	9ZebiFUs5So+KPNErFtWAL+nJCrgCv2SASnW7W9A+mhhl9x/VT8PxSi6dRWWVi2A
	q46+Se7KHN2/H8sEzYeHGdPa6qZOsGfeSHQa619NWYop6ay+QAMgyDk/0bXYcWwP
	fG2fbi4HRwIKM0rpy2s1TzgkHBn947SQ17ALg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NHN7yrH3ORZ3sTuOLd6RjsdS4FPqZ+cO
	DZbOXDQnMBTfX8oz70FndRkvx5ekVr803/iqd3lt+dVHIdt/QQn0rr7rxJ2tKB+b
	LNb/MCl+smgdwamVSy5z+dt4CtnaMp5hki7vpn5mQZ/3o1+ngdU0tKhEdRTWy+T4
	RZySKY9bUj4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 45D5E39DCE;
	Fri,  8 Jan 2016 13:53:42 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B95C739DCD;
	Fri,  8 Jan 2016 13:53:41 -0500 (EST)
In-Reply-To: <4e1b6c602e0adccfc11152b00aa23d14b1bbd4a8.1452270051.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Fri, 8 Jan 2016 17:21:18 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 22C9E642-B639-11E5-A856-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283575>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> When there is no `libgen.h` to our disposal, we miss the `dirname()`
> function.
>
> So far, we only had one user of that function: credential-cache--daemon
> (which was only compiled when Unix sockets are available, anyway). But
> now we also have `builtin/am.c` as user, so we need it.
>
> Since `dirname()` is a sibling of `basename()`, we simply put our very
> own `gitdirname()` implementation next to `gitbasename()` and use it
> if `NO_LIBGEN_H` has been set.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  compat/basename.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  git-compat-util.h |  2 ++
>  2 files changed, 46 insertions(+)
>
> diff --git a/compat/basename.c b/compat/basename.c
> index 0f1b0b0..0a2ed25 100644
> --- a/compat/basename.c
> +++ b/compat/basename.c
> @@ -1,4 +1,5 @@
>  #include "../git-compat-util.h"
> +#include "../strbuf.h"
>  
>  /* Adapted from libiberty's basename.c.  */
>  char *gitbasename (char *path)
> @@ -25,3 +26,46 @@ char *gitbasename (char *path)
>  	}
>  	return (char *)base;
>  }
> +
> +char *gitdirname(char *path)
> +{
> +	char *p = path, *slash = NULL, c;
> +	int dos_drive_prefix;
> +
> +	if (!p)
> +		return ".";
> +
> +	if ((dos_drive_prefix = skip_dos_drive_prefix(&p)) && !*p) {
> +		static struct strbuf buf = STRBUF_INIT;
> +
> +dot:
> +		strbuf_reset(&buf);
> +		strbuf_addf(&buf, "%.*s.", dos_drive_prefix, path);

OK, so "Z:" becomes "Z:." (I missed the final '.' in my first reading),
which sounds sensible.

> +		return buf.buf;
> +	}
> +
> +	/*
> +	 * POSIX.1-2001 says dirname("/") should return "/", and dirname("//")
> +	 * should return "//", but dirname("///") should return "/" again.
> +	 */
> +	if (is_dir_sep(*p)) {
> +		if (!p[1] || (is_dir_sep(p[1]) && !p[2]))
> +			return path;
> +		slash = ++p;
> +	}
> +	while ((c = *(p++)))
> +		if (is_dir_sep(c)) {
> +			char *tentative = p - 1;
> +
> +			/* POSIX.1-2001 says to ignore trailing slashes */
> +			while (is_dir_sep(*p))
> +				p++;
> +			if (*p)
> +				slash = tentative;
> +		}

OK, so we find the first slash in a run of slashes, unless that run
of slashes is at the very end of the path.  Either slash is left NUL
(when there is no dir-sep) in which case we want to say "current
directory", or that slash is at the end of the directory name we
want to return in which case we just stuff NUL and return the path.

Sounds sensible.

> +
> +	if (!slash)
> +		goto dot;

;-) this is tricky.  I wondered what the value of dos_drive_prefix
at this point in my first reading, but this is correct.  We must
have done the skip_dos_drive_prefix() thing when we came into the
function already, so it is either 2 (when the original had Z: in
front) or 0 (for all other cases).

OK.

> +	*slash = '\0';
> +	return path;
> +}
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 0d66f3a..94f311a 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -253,6 +253,8 @@ struct itimerval {
>  #else
>  #define basename gitbasename
>  extern char *gitbasename(char *);
> +#define dirname gitdirname
> +extern char *gitdirname(char *);
>  #endif
>  
>  #ifndef NO_ICONV
