From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] block-sha1: Windows declares ntohl() in winsock2.h
Date: Tue, 18 Aug 2009 04:07:31 -0700
Message-ID: <7vtz05idn0.fsf@alter.siamese.dyndns.org>
References: <4A8A552D.6020407@viscovery.net> <4A8A8661.5060908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	msysGit <msysgit@googlegroups.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 13:07:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdMXi-0008UQ-9c
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 13:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758728AbZHRLHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 07:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758692AbZHRLHm
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 07:07:42 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56770 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758624AbZHRLHl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 07:07:41 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9F7A82DEF4;
	Tue, 18 Aug 2009 07:07:42 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 34A612DEEF; Tue, 18 Aug 2009
 07:07:33 -0400 (EDT)
In-Reply-To: <4A8A8661.5060908@gmail.com> (Sebastian Schuberth's message of
 "Tue\, 18 Aug 2009 12\:45\:53 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 59B19E62-8BE7-11DE-A7EC-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126373>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> As ntohl()/htonl() are function calls (that internally do shifts), I
> doubt they're faster than the shift macros, though I haven't measured
> it. However, I do not suggest to go for the macros on Windows/Intel,
> but to apply the following patch on top of your patch:

Your proposed commit log message makes it sound as if this change is
limited to Windows, but it is not protected with "#ifdef WIN32"; the
change should be applicable to non-windows but the message is misleading.

It should help any i386/amd64 platform whose ntohl()/htonl() is crappy, as
long as __builtin_bswap32() is supported by the compiler.  And it should
not harm other platforms, nor i386/amd64 whose ntohl()/htonl() are sane.
As i386/amd64 part of block-sha1/sha1.c has gcc dependency already, I
think it would be safe to assume __builtin_bswap32() is available.

But I'd want an Ack/Nack from the original authors (Cc'ed).

It seems that your patch is linewrapped, so please be careful _if_ it
needs to be modified and resent (if this version gets trivially acked I
can fix it up when applying and in such a case there is no need to
resend).

> From: Sebastian Schuberth <sschuberth@gmail.com>
> Date: Tue, 18 Aug 2009 12:33:35 +0200
> Subject: [PATCH] block-sha1: On Intel, use bswap built-in in favor of
> ntohl()/htonl()
>
> On Windows/Intel, ntohl()/htonl() are function calls that do shifts to
> swap the
> byte order. Using the native bswap instruction boths gets rid of the
> shifts and
> the function call overhead to gain some performance.
>
> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---
>  block-sha1/sha1.c |   15 ++++++++++-----
>  1 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
> index f2830c0..07f2937 100644
> --- a/block-sha1/sha1.c
> +++ b/block-sha1/sha1.c
> @@ -66,15 +66,20 @@
>
>  /*
>   * Performance might be improved if the CPU architecture is OK with
> - * unaligned 32-bit loads and a fast ntohl() is available.
> + * unaligned 32-bit loads and a fast ntohl() is available. On Intel,
> + * use the bswap built-in to get rid of the function call overhead.
>   * Otherwise fall back to byte loads and shifts which is portable,
>   * and is faster on architectures with memory alignment issues.
>   */
>
> -#if defined(__i386__) || defined(__x86_64__) || \
> -    defined(__ppc__) || defined(__ppc64__) || \
> -    defined(__powerpc__) || defined(__powerpc64__) || \
> -    defined(__s390__) || defined(__s390x__)
> +#if defined(__i386__) || defined(__x86_64__)
> +
> +#define get_be32(p)	__builtin_bswap32(*(unsigned int *)(p))
> +#define put_be32(p, v)	do { *(unsigned int *)(p) =
> __builtin_bswap32(v); } while (0)
> +
> +#elif defined(__ppc__) || defined(__ppc64__) || \
> +      defined(__powerpc__) || defined(__powerpc64__) || \
> +      defined(__s390__) || defined(__s390x__)
>
>  #define get_be32(p)	ntohl(*(unsigned int *)(p))
>  #define put_be32(p, v)	do { *(unsigned int *)(p) = htonl(v); } while (0)
> -- 
> 1.6.4.169.g64d5.dirty
