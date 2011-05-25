From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Include unistd.h.
Date: Wed, 25 May 2011 11:30:41 -0700
Message-ID: <7vd3j64oq6.fsf@alter.siamese.dyndns.org>
References: <1306332924-28587-1-git-send-email-mduft@gentoo.org>
 <1306332924-28587-3-git-send-email-mduft@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: mduft@gentoo.org
X-From: git-owner@vger.kernel.org Wed May 25 20:31:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPIrC-0004Pr-K4
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 20:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753324Ab1EYSav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 14:30:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49480 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643Ab1EYSat (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 14:30:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 241095168;
	Wed, 25 May 2011 14:32:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zjqauV4+ZbXsszri3mCZJ23CYeQ=; b=nhJhjm
	NM/GwG376e/GZueMW7HhSuKTynbNREqhTB2O6Njnb2z9AUiOPVL34MCxvtFCpej5
	vj5Oea4rDD9MaD4yXCFv9u4Sn+emu2v59gPuopI/qNVPl9mlqOlmj2XPCqGLwu06
	vohN5divCFQ/1qk+2nwCxwW6o5ZJ0GYchPQF4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KPwXw/1mTiQqNAE/+qRC/0mc2c8gmiY/
	2awh/lrh6t8yjRjjxXaXWn5P7rKsXfTdIVIZIBt1SkR512zhRpzbJHL4V48ezouR
	c9ls0me+CRZhmr54eEox0JEzsS0tsXJFHt3bYNnUJ+Y39Ust4Qme6gpDbCa3nvUC
	RVTf0PN59p0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0001C5167;
	Wed, 25 May 2011 14:32:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0AC2B5166; Wed, 25 May 2011
 14:32:50 -0400 (EDT)
In-Reply-To: <1306332924-28587-3-git-send-email-mduft@gentoo.org>
 (mduft@gentoo.org's message of "Wed, 25 May 2011 16:15:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 674E7AAA-86FD-11E0-8F28-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174444>

mduft@gentoo.org writes:

> At least on Interix, NULL is defined in unistd.h, and not including it
> causes compilation failure.
>
> Signed-off-by: Markus Duft <mduft@gentoo.org>
> ---
>  compat/fnmatch/fnmatch.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/compat/fnmatch/fnmatch.c b/compat/fnmatch/fnmatch.c
> index 14feac7..0238cca 100644
> --- a/compat/fnmatch/fnmatch.c
> +++ b/compat/fnmatch/fnmatch.c
> @@ -25,6 +25,7 @@
>  # define _GNU_SOURCE	1
>  #endif
>  
> +#include <unistd.h>
>  #include <errno.h>
>  #include <fnmatch.h>
>  #include <ctype.h>

The header stddef.h is where NULL is supposed to be defined, and commonly
used headers are supposed to define NULL the same way as stddef.h does.
There is a conditional inclusion of stdlib.h in fnmatch.c and stdlib.h is
one of those files; probably that is how the upstream pulls in NULL when
compiling this.

But we don't define STDC_HEADERS nor _LIBC (and we shouldn't), so I don't
know how the existing users of compat/fnmatch/ gets the defintion of NULL
from. Output from "gcc -E -dD -DNO_FNMATCH compat/fnmatch/fnmatch.c" does
not seem to show any NULL defined.

Other platforms (e.g. SunOS, IRIX, HPUX, Windows) use NO_FNMATCH_CASEFOLD
and compile this file.  How are they getting their NULLs?
