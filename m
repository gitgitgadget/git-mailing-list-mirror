From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Support non-WIN32 system lacking poll() while keeping
 the WIN32 part intact
Date: Wed, 22 Aug 2012 10:13:15 -0700
Message-ID: <7vd32ialzo.fsf@alter.siamese.dyndns.org>
References: <002101cd8078$eb2eb4f0$c18c1ed0$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Marius Storm-Olsen <mstormo@gmail.com>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Wed Aug 22 19:13:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4EUg-0007H8-4e
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 19:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823Ab2HVRNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 13:13:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44884 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756897Ab2HVRNS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 13:13:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 374F28EC0;
	Wed, 22 Aug 2012 13:13:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wkMIYMqFAxZM9OV1OB57kKh/LwQ=; b=FfUPVq
	qkNi/VConfl5LN3Vlj0iuRznnAw9GBZqYcToqfDTcLa4bjw773ZIWVKeTxLGdRW9
	52nUk+0LOyqXG5ZdX/GWk5JRuoeA4K7jdHSqYyGga3iTKj+Ssbugc2f1S1gUVD3F
	2raeYtyVkxTXMpsY91VPHh5qlNnU5RnlbcQvY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Nw2SKORu41U1VrAlZV/Cd8kTmqO1PRfx
	9Vaw5X/Wbch2mn10Ajpy5FDkN/70YhK825HXOBzZt0XcNtAdCbHRKoAh7mlEIhvG
	IU6k8aBovl6YZvyLJESCT2igC6aXN+5PO0/gJKDtgNOb6LPiiDSqakvHOkNTey7h
	h/t0nhBgoiU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2595C8EBF;
	Wed, 22 Aug 2012 13:13:18 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6896B8EBE; Wed, 22 Aug 2012
 13:13:17 -0400 (EDT)
In-Reply-To: <002101cd8078$eb2eb4f0$c18c1ed0$@schmitz-digital.de> (Joachim
 Schmitz's message of "Wed, 22 Aug 2012 17:15:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AA41FC20-EC7C-11E1-8F0E-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204033>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

> Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
> ---
>  Makefile            | 18 ++++++++++++++----
>  compat/win32/poll.c |  8 ++++++--
>  2 files changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 6b0c961..2af4db3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -152,6 +152,11 @@ all::
>  #
>  # Define NO_MMAP if you want to avoid mmap.
>  #
> +# Define NO_SYS_POLL_H if you don't have sys/poll.h.
> +#
> +# Define NO_POLL if you do not have or do not want to use poll.
> +# This also implies NO_SYS_POLL_H.

Do you really need to have both?  I suspect "If you do not have a
usable sys/poll.h, set NO_SYS_POLL_H" may be a simpler alternative,
but there must be a reason why you had to add a new one instead of
going that route.  It would be a good idea to describe that reason
in the log message above, in the space before your Sign-off.

> @@ -1257,7 +1262,7 @@ ifeq ($(uname_S),Windows)
>         BASIC_CFLAGS = -nologo -I. -I../zlib -Icompat/vcbuild
> -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H
> -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
>         COMPAT_OBJS = compat/msvc.o compat/winansi.o \
>                 compat/win32/pthread.o compat/win32/syslog.o \
> -               compat/win32/poll.o compat/win32/dirent.o
> +               compat/win32/dirent.o
>         COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H
> ...
> @@ -1347,7 +1352,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
>         COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
>         COMPAT_OBJS += compat/mingw.o compat/winansi.o \
>                 compat/win32/pthread.o compat/win32/syslog.o \
> -               compat/win32/poll.o compat/win32/dirent.o
> +               compat/win32/dirent.o
>         EXTLIBS += -lws2_32
> ...
> @@ -1601,6 +1606,11 @@ ifdef NO_GETTEXT
> ...
> +ifdef NO_POLL
> +       NO_SYS_POLL_H = YesPlease
> +       COMPAT_CFLAGS += -DNO_POLL -Icompat/win32 # so it find poll.h
> +       COMPAT_OBJS += compat/win32/poll.c
> +endif

In general, I think this is a good direction to go.  If the existing
emulation in win32/poll.c turns out to be usable across platforms
and not windows specific, sharing it would be a good idea.

But if the emulation is no longer windows specific, shouldn't you
also move it outside compat/win32/ and somewhere more generic?

> diff --git a/compat/win32/poll.c b/compat/win32/poll.c
> index 403eaa7..49541f1 100644
> --- a/compat/win32/poll.c
> +++ b/compat/win32/poll.c
> @@ -24,7 +24,9 @@
>  # pragma GCC diagnostic ignored "-Wtype-limits"
>  #endif
>
> -#include <malloc.h>
> +#if defined(WIN32)
> +# include <malloc.h>
> +#endif

Hrm, are the Windows folks OK with this?  MINGW and MSVC are
affected; Cygwin should be OK, I think.

>  #include <sys/types.h>
>
> @@ -48,7 +50,9 @@
>  #else
>  # include <sys/time.h>
>  # include <sys/socket.h>
> -# include <sys/select.h>
> +# ifndef NO_SYS_SELECT_H
> +#  include <sys/select.h>
> +# endif
>  # include <unistd.h>
>  #endif
