From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: add NO_CLOCK_GETTIME check
Date: Wed, 03 Sep 2014 12:45:39 -0700
Message-ID: <xmqqwq9kwkrg.fsf@gitster.dls.corp.google.com>
References: <1409771687-5597-1-git-send-email-reubenhwk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, karsten.blees@gmail.com
To: Reuben Hawkins <reubenhwk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 21:45:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPGV5-0003f8-Rp
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 21:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876AbaICTpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 15:45:47 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51052 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754001AbaICTpq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 15:45:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1A77937D0F;
	Wed,  3 Sep 2014 15:45:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uGBvZRk5908FheMToTg85Ek11yY=; b=KHLqom
	Rp7qUPwaxkNjqUDg8GEWX0i/tGU9RlY1dXYEmIRu5NWr+HTzPii+i0s7M7Nt3/Xk
	hOOxfrQ+WdN7flkrNQwN7j1NH3cMb2/AB3yfOrTYr5oQRpoDD/biVmbmcg11knyp
	6/FLyg9Vpem11rPNN0JIw1FvmjKAgi+FZQeKg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sh3aE026DHOYE3CQ8e+dXfdvOt9f6flI
	RZWnyqnqzmfb5rigrmljdHHXhh0/j8pIywFmpfeMVpTUlIoZzhxKqDt6dVRtC+VL
	/+QTNqJj41WGDz/BYkcYU1OeN1ZcaecuzzEuQ8W8Td9OZNaKfYmQ4+jE16v3aT62
	uhERdBQQJOQ=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CA90237D0C;
	Wed,  3 Sep 2014 15:45:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2B13737D07;
	Wed,  3 Sep 2014 15:45:43 -0400 (EDT)
In-Reply-To: <1409771687-5597-1-git-send-email-reubenhwk@gmail.com> (Reuben
	Hawkins's message of "Wed, 3 Sep 2014 12:14:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E40F4588-33A2-11E4-BE56-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256409>

Reuben Hawkins <reubenhwk@gmail.com> writes:

> Some really old platforms, rhel3, which don't define CLOCK_MONOTONIC, still
> need a way to build git.  Some high resolution timer code was added Jul 12,
> 2014 to aid debugging performance issues.  That code uses clock_gettime and
> CLOCK_MONOTONIC.  That change breaks building git on ancient platforms which
> don't support CLOCK_MONOTONIC, so a way to disable that code is needed.
>
> To use this feature...
>
> $ make NO_CLOCK_GETTIME=1
>
> This change amends the commit...
>
>  commit 148d6771bf5e00aa1d7fa2221507a3dfe4c1e37f
>  Author: Karsten Blees <karsten.blees@gmail.com>
>  Date:   Sat Jul 12 02:05:42 2014 +0200
>
>   trace: add high resolution timer function to debug performance issues
> ---

>  Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 9f984a9..0c1c8cf 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1502,10 +1502,12 @@ ifdef GMTIME_UNRELIABLE_ERRORS
>  	BASIC_CFLAGS += -DGMTIME_UNRELIABLE_ERRORS
>  endif
>  
> +ifndef NO_CLOCK_GETTIME
>  ifdef HAVE_CLOCK_GETTIME
>  	BASIC_CFLAGS += -DHAVE_CLOCK_GETTIME
>  	EXTLIBS += -lrt
>  endif
> +endif

I am not sure why you even need this change.  Wouldn't you get
exactly the same result if you did not define HAVE_CLOCK_GETTIME
when building?



>  
>  ifeq ($(TCLTK_PATH),)
>  NO_TCLTK = NoThanks
