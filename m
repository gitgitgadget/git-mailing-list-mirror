From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] help: correct behavior for is_executable on Windows
Date: Sat, 11 Aug 2012 21:30:06 -0700
Message-ID: <7vd32whgvl.fsf@alter.siamese.dyndns.org>
References: <20120811070030.GA83665@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Aug 12 06:30:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0Pop-0004OC-3l
	for gcvg-git-2@plane.gmane.org; Sun, 12 Aug 2012 06:30:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445Ab2HLEaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Aug 2012 00:30:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45266 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751390Ab2HLEaK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2012 00:30:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA1138F83;
	Sun, 12 Aug 2012 00:30:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CotS0C1nmd5cyVxJQHOrRBL5KWM=; b=k5csQ6
	OfiVm4KNVqxf0OWdcxSFFafuxflAID6CrknjZ8UCmyxyp+L0hk4/3s5dq6ETxKTu
	9ajJBgZm2O5+ScBhZetrxw+wRo0JlvEOnVOAPrNKnNM5Of1AmxjPlALlWELF5RDZ
	T709Qy8N3uXBVkICBqRTNxHbutpzB3S2VoTqM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=duq6d2CWrtGlbmHBAYy/bpzH3EvYZ3N+
	UrQAgbXskqZiHH8m48qXlYO0r2/Hos0ZhvIe9x5xjWjG7t7mtzV2VouzwZGRhTU+
	gf4z1+EZ0h8qPV2O22ZBkbU65/hYFOzUPqfenuNe7jUARBkGk0BWsVzHTq9Jpz5b
	jfFOFCQ+O70=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C760A8F82;
	Sun, 12 Aug 2012 00:30:09 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 38A088F81; Sun, 12 Aug 2012
 00:30:08 -0400 (EDT)
In-Reply-To: <20120811070030.GA83665@book.hvoigt.net> (Heiko Voigt's message
 of "Sat, 11 Aug 2012 09:00:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 65A3670A-E436-11E1-A8FD-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203302>

Heiko Voigt <hvoigt@hvoigt.net> writes:

>  help.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/help.c b/help.c
> index 662349d..b41fa21 100644
> --- a/help.c
> +++ b/help.c
> @@ -103,10 +103,19 @@ static int is_executable(const char *name)
>  		return 0;
>  
>  #if defined(WIN32) || defined(__CYGWIN__)
> +	/* On Windows we cannot use the executable bit. The executable
> +	 * state is determined by extension only. We do this first
> +	 * because with virus scanners opening an executeable for
> +	 * reading is potentially expensive.
> +	 */
> +	if (has_extension(name, ".exe"))
> +		return S_IXUSR;
> +
>  #if defined(__CYGWIN__)
>  if ((st.st_mode & S_IXUSR) == 0)
>  #endif
> -{	/* cannot trust the executable bit, peek into the file instead */
> +{	/* now that we know it does not have an executable extension,
> +	   peek into the file instead */
>  	char buf[3] = { 0 };
>  	int n;
>  	int fd = open(name, O_RDONLY);
> @@ -114,8 +123,8 @@ if ((st.st_mode & S_IXUSR) == 0)
>  	if (fd >= 0) {
>  		n = read(fd, buf, 2);
>  		if (n == 2)
> -			/* DOS executables start with "MZ" */
> -			if (!strcmp(buf, "#!") || !strcmp(buf, "MZ"))
> +			/* look for a she-bang */
> +			if (!strcmp(buf, "#!"))
>  				st.st_mode |= S_IXUSR;
>  		close(fd);
>  	}

Would it make sense to move this to compat/win32/, compat/cygwin.c,
and compat/posix.c, each exporting is_executable(const char *path),
so that we do not have to suffer the #ifdef mess?
