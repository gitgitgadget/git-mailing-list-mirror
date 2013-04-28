From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] compat/nedmalloc: Fix compiler warnings on linux
Date: Sun, 28 Apr 2013 12:25:56 -0700
Message-ID: <7v7gjmqwxn.fsf@alter.siamese.dyndns.org>
References: <517C1CF9.2080903@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Apr 28 21:26:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWXEb-0004fj-Bb
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 21:26:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756485Ab3D1T0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Apr 2013 15:26:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35974 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756392Ab3D1TZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Apr 2013 15:25:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F096F1A178;
	Sun, 28 Apr 2013 19:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=emRDoRMMHlc2a8kypcptrj8nK/o=; b=gxH68P
	HPT1ezUgexU8VybvUdL5uWHXCxC/4lxw/nxCQ62Yv6Ea2+izJBRcd5j83OVVk1Ly
	1IVJNxh/D+NH1tumCIWNZZgSW0gq4CwXZA7gtsyTP6U5SFQm/iF0DRqIKkTs/H0e
	Ta75rxJNanBJgrTFu4uayxO8OGD5AY2vl0SN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aN1MjxJPqPZAT8DzrDKNwu5OJYavab2v
	Z1nFaw+J20opn49SbQPSfKsICf2ikd5Dv/+UxvWF6J5LvWkdRffl90K5O36uSgh3
	/buTMCKfnF/ll41lkCYCnasTtAS8e/WdIKY1med+A8JEROYeDp5iLLsz3dmfa/Bm
	GgGEpfJ7vA4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E477C1A176;
	Sun, 28 Apr 2013 19:25:58 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 667FE1A174;
	Sun, 28 Apr 2013 19:25:58 +0000 (UTC)
In-Reply-To: <517C1CF9.2080903@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Sat, 27 Apr 2013 19:46:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 743C3740-B039-11E2-BFC5-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222746>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> On linux, when the build variable USE_NED_ALLOCATOR is set, gcc
> issues the following warnings:
>
>     In file included from compat/nedmalloc/nedmalloc.c:63:
>     .../malloc.c.h: In function 'mmap_resize':
>     .../malloc.c.h:3762: warning: implicit declaration of function 'mremap'
>     .../malloc.c.h: In function 'sys_trim':
>     .../malloc.c.h:4195: warning: comparison between pointer and integer
>
> The warnings are caused by the <sys/mman.h> header not enabling the
> (conditional) declaration of the mremap() function.  The declaration
> can be enabled by defining the _GNU_SOURCE symbol prior to including
> certain system header files. In particular, it may not be sufficient
> to simply define _GNU_SOURCE just prior to including the <sys/mman.h>
> header. (e.g. defining the symbol after including <sys/types.h> will
> be completely ineffective.)
>
> In order to suppress the warnings, we define the _GNU_SOURCE symbol
> at the start of the malloc.c.h header file.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---

Hmmmm, is this even worth worrying about?  I somehow thought this
was only meant to replace malloc on non GNU systems...

>  compat/nedmalloc/malloc.c.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
> index fdcca82..5a44dea 100644
> --- a/compat/nedmalloc/malloc.c.h
> +++ b/compat/nedmalloc/malloc.c.h
> @@ -484,6 +484,10 @@ MAX_RELEASE_CHECK_RATE   default: 4095 unless not HAVE_MMAP
>  #define DLMALLOC_VERSION 20804
>  #endif /* DLMALLOC_VERSION */
>  
> +#if defined(linux)
> +#define _GNU_SOURCE 1
> +#endif
> +
>  #ifndef WIN32
>  #ifdef _WIN32
>  #define WIN32 1
