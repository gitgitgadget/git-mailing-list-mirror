From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] help: correct behavior for is_executable on Windows
Date: Wed, 15 Aug 2012 10:53:55 -0700
Message-ID: <7v7gt06nyk.fsf@alter.siamese.dyndns.org>
References: <20120811070030.GA83665@book.hvoigt.net>
 <7vd32whgvl.fsf@alter.siamese.dyndns.org>
 <20120813170221.GB6418@book.hvoigt.net>
 <7vmx1yel9d.fsf@alter.siamese.dyndns.org>
 <20120815165054.GA43523@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Aug 15 19:54:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1hnn-0001iS-Lz
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 19:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752229Ab2HORyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 13:54:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54177 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751066Ab2HORx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2012 13:53:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 574FD8CE0;
	Wed, 15 Aug 2012 13:53:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tD5h+ava6GWCQqIRb+jzTcjd3FA=; b=eF7i9g
	on5Se9xlD0H/lCmtQzgjsxXtQzMMeT0GueKqVb1c2EmmpgWyM4KTwxomH+HnSQtZ
	k1/UADrK9DP0eIJHMWcmHfxBBlghBykzI/Om6YdrTxkB3wzvp4W+//tz6+RsuoGy
	/ER9g86dXfgySaRfic7jpConZo6Iawaf6EO6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jJW2m4nY7AqP0LBuoPpdohicTEPm36vm
	58nMW/cT0vmNvJx73WpqbVSkvlx2/qze4wgxGgAOcAV4uULZDTChLlGCRygV50L7
	mt12HkfApxA2Wg4o84yDXKPifBNOSnLFjkdf4uQvujgktkMIxOh+jrCxIKQm+3Dk
	r48m1RDM4Lg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 448258CDF;
	Wed, 15 Aug 2012 13:53:58 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 66CB38CDD; Wed, 15 Aug 2012
 13:53:57 -0400 (EDT)
In-Reply-To: <20120815165054.GA43523@book.hvoigt.net> (Heiko Voigt's message
 of "Wed, 15 Aug 2012 18:50:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2FB6D7E8-E702-11E1-B02E-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203477>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> On Mon, Aug 13, 2012 at 10:48:14AM -0700, Junio C Hamano wrote:
>> Heiko Voigt <hvoigt@hvoigt.net> writes:
>> > What do you think?
>> 
>> Does having the "stat()" help on Windows in any way?  Does it ever
>> return an executable bit by itself?
>
> No, AFAIK it does not return anything about executability. But I think
> the stat is still necessary to verify that the file exists and is a
> regular file.

But if you are going to read it anyway, you can tell it from open()
and read() of the first 2 bytes failing, no?  That will still be an
implementation detail of platform specific "is_path_executable()".

So you are forcing Windows an extra and unnecessary stat() that only
is needed on Cygwin, no?

> @@ -1347,7 +1348,8 @@ ifneq (,$(findstring MINGW,$(uname_S)))
>  	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
>  	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
>  		compat/win32/pthread.o compat/win32/syslog.o \
> -		compat/win32/poll.o compat/win32/dirent.o
> +		compat/win32/poll.o compat/win32/dirent.o \
> +		compat/win32/executable.o

Looks sensible, even though the filename does not tell what it does
about "executable".  is_executable.o might be a better name for them.

> diff --git a/help.c b/help.c
> index ebc2c42..d9fae3c 100644
> --- a/help.c
> +++ b/help.c
> @@ -106,34 +106,8 @@ static int is_executable(const char *name)
>  	    !S_ISREG(st.st_mode))
>  		return 0;
>  
> -#if defined(WIN32) || defined(__CYGWIN__)
> -	/* On Windows we cannot use the executable bit. The executable
> -	 * state is determined by extension only. We do this first
> -	 * because with virus scanners opening an executeable for
> -	 * reading is potentially expensive.
> -	 */
> -	if (has_extension(name, ".exe"))
> -		return S_IXUSR;
> -
> -#if defined(__CYGWIN__)
> -if ((st.st_mode & S_IXUSR) == 0)
> -#endif
> -{	/* now that we know it does not have an executable extension,
> -	   peek into the file instead */
> -	char buf[3] = { 0 };
> -	int n;
> -	int fd = open(name, O_RDONLY);
> -	st.st_mode &= ~S_IXUSR;
> -	if (fd >= 0) {
> -		n = read(fd, buf, 2);
> -		if (n == 2)
> -			/* look for a she-bang */
> -			if (!strcmp(buf, "#!"))
> -				st.st_mode |= S_IXUSR;
> -		close(fd);
> -	}
> -}
> -#endif
> +	correct_executable_stat(name, &st);
> +

Yuck.

Why should we need even a single line of the implementation of a
function that tells if a given pathname contains an executable
command, which we know is platform specific?  

On Posix systems, the implementation will be "stat() and check
S_IXUSR".  On pure Windows, it will be "check .exe, or open it and
read the first two bytes". On Cygwin, it will also be "check .exe,
stat() and check S_IXUSR, or open it and read the first two bytes.

It is not like the caller of is_executable() needed to run stat for
other purposes on its own and we can optimize by either borrowing
the stat data the caller already collected for us, or returning the
stat data we collected for later use by the caller.  The use of stat
is entirely contained in the POSIX implementation of this function.

Why are you so dead-set to shoehorn the different semantics into
"struct stat" that we know is not an appropriate abstraction across
platforms?
