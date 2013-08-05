From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] OS X: Fix redeclaration of die warning
Date: Mon, 05 Aug 2013 11:00:59 -0700
Message-ID: <7vwqo0j9us.fsf@alter.siamese.dyndns.org>
References: <1375718364-13824-1-git-send-email-brian@gernhardtsoftware.com>
	<1375718364-13824-3-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jeremy Huddleston <jeremyhu@apple.com>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Mon Aug 05 20:01:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6P5f-0003DB-UR
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 20:01:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753728Ab3HESBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 14:01:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35717 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753281Ab3HESBB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 14:01:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70FCF3653E;
	Mon,  5 Aug 2013 18:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2H4GNwIIpWV4RPYrhWmEAKgB1CQ=; b=wsyGlC
	ctmCTt1bfASFahl2yAqByrAsOCtII9FCWA96c4oKyU3oTB7FV73knGIN+HpwBKCS
	iCqvXLUlWfJTNa3pPxrWDHunL6VAr8VYJq0xa+BNwkigA7rETcRzlvF7Zp1S8jNf
	5gw1k4+tXP1QGhVIllEHsghvLOlKpcUHC9bsI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mbKh56lsiXNUH1LhN3PFIyKvwtBhPEBK
	EE05sKtbeJAvTAApYiGgc8q/x+TU1q+4OpwO2+GhmlYdWRESyTTQHdpJgI+QV5ei
	Cv/r/6o0iRF5l/JYsJytdO1Z0duEC0ZD338Wrv76T9SPbBPCE/5x6lmz/+AYuWKb
	e7+CMvkWDG0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 682D73653D;
	Mon,  5 Aug 2013 18:01:01 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B2F9036539;
	Mon,  5 Aug 2013 18:01:00 +0000 (UTC)
In-Reply-To: <1375718364-13824-3-git-send-email-brian@gernhardtsoftware.com>
	(Brian Gernhardt's message of "Mon, 5 Aug 2013 11:59:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FCAC801E-FDF8-11E2-986B-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231684>

Brian Gernhardt <brian@gernhardtsoftware.com> writes:

> compat/apple-common-crypto.h uses die() in one of its macros, but was
> included in git-compat-util.h before the definition of die.
>
> Fix by simply moving the relevant block after the die/error/warning
> declarations.

Puzzled.  What needs fixing???

Ahh, that one is not just making #define macros, but defining static
inline functions.

I wonder if they need to be static inlines to be duplicated at each
call sites in the first place.  Wouldn't it be better to create a
compat/something.c file to be linked with?

> Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
> ---
>
>  Not sure if this is the best place to move it to, but it's the earliest it can
>  be in the file without causing errors.  (Namely that clang has to guess what
>  die() means in apple-common-crypto.h and guesses differently than the actual
>  definition.)
>
>  git-compat-util.h | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index af5f6bb..d60e28d 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -129,16 +129,6 @@
>  #include <poll.h>
>  #endif
>  
> -#ifndef NO_OPENSSL
> -#ifdef APPLE_COMMON_CRYPTO
> -#include "compat/apple-common-crypto.h"
> -#else
> -#include <openssl/evp.h>
> -#include <openssl/hmac.h>
> -#endif /* APPLE_COMMON_CRYPTO */
> -#include <openssl/x509v3.h>
> -#endif /* NO_OPENSSL */
> -
>  #if defined(__MINGW32__)
>  /* pull in Windows compatibility stuff */
>  #include "compat/mingw.h"
> @@ -340,6 +330,16 @@ extern NORETURN void die_errno(const char *err, ...) __attribute__((format (prin
>  extern int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
>  extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
>  
> +#ifndef NO_OPENSSL
> +#ifdef APPLE_COMMON_CRYPTO
> +#include "compat/apple-common-crypto.h"
> +#else
> +#include <openssl/evp.h>
> +#include <openssl/hmac.h>
> +#endif /* APPLE_COMMON_CRYPTO */
> +#include <openssl/x509v3.h>
> +#endif /* NO_OPENSSL */
> +
>  /*
>   * Let callers be aware of the constant return value; this can help
>   * gcc with -Wuninitialized analysis. We restrict this trick to gcc, though,
