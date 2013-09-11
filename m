From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Wed, 11 Sep 2013 11:39:39 -0700
Message-ID: <xmqqzjrjryms.fsf@gitster.dls.corp.google.com>
References: <523094F0.9000509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Karsten Blees <karsten.blees@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 20:40:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJpKe-0000Mo-5k
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 20:40:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756717Ab3IKSju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 14:39:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45690 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753989Ab3IKSjr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 14:39:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89B55413E2;
	Wed, 11 Sep 2013 18:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Twyc6zR9gAYQMZg7t3F/keM5698=; b=T5MMQZ
	zR0XS3Mla7LuTgRh7WXMlnK9ZZtZTtAFfjuwLYfmt4r3RjM+vcX7eks/FhqLIYmL
	ICinSl4q6ndqNPzxEa+6bWWRrhzdeOuyOBkJZ4Gidj4VaaP5a1nmKEXBz35jpe2T
	8tKzwSEkYdVWAlU4+HpzmE26DDm1ir0WWtd/4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SrVqjbnX7Bd7GyXTwgWKKXS7Ap57Pnpn
	hezzm36rn/F0ZTIRIQoRBMb4WiKlrPwCaJIo/Vwe19tN8xw6hbTmJK2KbORhmHUz
	Z6EsH5APGXNFO4xIfm1FIRfCAKLaJT+VwUS1G6J9G94B8r58mp1YewxqkaIbFivC
	UJsWzdZrsqk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 188AB413D6;
	Wed, 11 Sep 2013 18:39:45 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E77AC413CB;
	Wed, 11 Sep 2013 18:39:42 +0000 (UTC)
In-Reply-To: <523094F0.9000509@gmail.com> (Sebastian Schuberth's message of
	"Wed, 11 Sep 2013 18:06:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 864A3700-1B11-11E3-B415-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234596>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> This is necessary so that read_mailmap() can obtain a pointer to the
> function.

Whoa, I didn't think it is even legal for a C library to supply
strcmp() or strcasecmp() that are purely inline you cannot take the
address of.  The "solution" looks a bit too large a hammer that
affects everybody, not just those who have such a set of header
files.

>  
> +#define __NO_INLINE__ /* do not inline strcasecmp() */
> +#include <string.h>
> +#ifdef HAVE_STRINGS_H
> +#include <strings.h> /* for strcasecmp() */
> +#endif
> +#undef __NO_INLINE__
> +
>  #ifdef WIN32 /* Both MinGW and MSVC */
>  #define _WIN32_WINNT 0x0502
>  #define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
> @@ -99,10 +106,6 @@
>  #include <stddef.h>
>  #include <stdlib.h>
>  #include <stdarg.h>
> -#include <string.h>
> -#ifdef HAVE_STRINGS_H
> -#include <strings.h> /* for strcasecmp() */
> -#endif
>  #include <errno.h>
>  #include <limits.h>
>  #ifdef NEEDS_SYS_PARAM_H
