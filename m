From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] nedmalloc: allow compiling with MSys2's compiler
Date: Wed, 13 Jan 2016 11:28:50 -0800
Message-ID: <xmqq8u3tnurx.fsf@gitster.mtv.corp.google.com>
References: <cover.1452691805.git.johannes.schindelin@gmx.de>
	<cb506b103e7102073a1567044727837ab8ff5c64.1452691805.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 13 20:28:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJR6I-0005s1-GL
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 20:28:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754111AbcAMT2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 14:28:54 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53619 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753927AbcAMT2x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 14:28:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3C2FE3A8D9;
	Wed, 13 Jan 2016 14:28:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BgDr3np3AK0uAXffVgXg49VwtNI=; b=W4iuIy
	r57pcEpWEJ69Z7owENPaUiYNhTRbMZzDU3tDcHmdWoWsImGGFMgPM32GAVebE/uw
	AqRLe1A1JcCesfPmz3vVOw/qWxoAI9tnUUz67wMGslH77mn/FcgcJbkY3ISeIlvP
	af1oFmAc+CI2yToRQhl7FaXp+hCYCS46I1XKY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q9z+6noHb4bNAfGyWZTy7+xcFBeEcJD2
	cUiOIdN5eGZ95dV3OIDaYrRVTmlQwQaOsNalO5KUpGnF7c1hwSGprWoaCilBzXDr
	AH4gpbV6AuRwzuTStOmMwN6cj43DI4gsqRzJA7tuk2krn0i7mtiEQl41QP69fVuu
	bR3rWveO1Yk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 33CCC3A8D8;
	Wed, 13 Jan 2016 14:28:52 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A73893A8D5;
	Wed, 13 Jan 2016 14:28:51 -0500 (EST)
In-Reply-To: <cb506b103e7102073a1567044727837ab8ff5c64.1452691805.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Wed, 13 Jan 2016 14:31:05 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E077CEAC-BA2B-11E5-88D8-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283975>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> With MSys2's GCC, `ReadWriteBarrier` is already defined, and FORCEINLINE
> unfortunately gets defined incorrectly.
>
> Let's work around both problems, using the MSys2-specific
> __MINGW64_VERSION_MAJOR constant to guard them.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Thanks.  I actually do not think #undef _ReadWriteBarrier needs to
be inside any #ifdef, though.  It isn't like it is an error to
#undef that you did not #define before.

>  compat/nedmalloc/malloc.c.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
> index f216a2a..18634e3 100644
> --- a/compat/nedmalloc/malloc.c.h
> +++ b/compat/nedmalloc/malloc.c.h
> @@ -720,6 +720,9 @@ struct mallinfo {
>    inlining are defined as macros, so these aren't used for them.
>  */
>  
> +#ifdef __MINGW64_VERSION_MAJOR
> +#undef FORCEINLINE
> +#endif
>  #ifndef FORCEINLINE
>    #if defined(__GNUC__)
>  #define FORCEINLINE __inline __attribute__ ((always_inline))
> @@ -1382,6 +1385,9 @@ LONG __cdecl _InterlockedExchange(LONG volatile *Target, LONG Value);
>  
>    /*** Atomic operations ***/
>    #if (__GNUC__ * 10000 + __GNUC_MINOR__ * 100 + __GNUC_PATCHLEVEL__) > 40100
> +    #ifdef __MINGW64_VERSION_MAJOR
> +      #undef _ReadWriteBarrier
> +    #endif
>      #define _ReadWriteBarrier() __sync_synchronize()
>    #else
>      static __inline__ __attribute__((always_inline)) long __sync_lock_test_and_set(volatile long * const Target, const long Value)
