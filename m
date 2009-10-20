From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use faster byte swapping when compiling with MSVC
Date: Tue, 20 Oct 2009 00:04:46 -0700
Message-ID: <7vzl7mr1f5.fsf@alter.siamese.dyndns.org>
References: <hbi4mt$tjt$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 09:05:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N08mJ-00042H-If
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 09:05:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755402AbZJTHE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 03:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752785AbZJTHE5
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 03:04:57 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44389 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbZJTHE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 03:04:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BED7D7E7B3;
	Tue, 20 Oct 2009 03:04:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hdsBXC/Nzk7MpvduWVyKoV/b+kw=; b=ebUf0k
	aP47IxDr6+SCbX0yDuXDO/rPy1YtiMLyFxeT+5+NCt82G2NfcKtUH3AagzDpksN9
	C3kgBPE1u7ltMrzfLSGNnOjEKSbUzBamRwEkmhsOztU/vuqXvWfWcAFTTYGWMDq2
	9gtvAhmY8jIStjJHpJXW7T7KzWj/PD/AgML7M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ECU4S/xWxmsGdW4qs327Maekm5r7PGzu
	09D4Ob4VrnaTio/fFU7eEe6ehi8cuj2uDvNVKLmsEpHSGlMcPlNaceNJ5sscYNuV
	oPrFLKHJTW8syVAXUKcXMe3+mq9Myj+1uZcRp4CDH6IcTR6a5BYuhOwcUs2UC9ci
	zvKUE9SjM5w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7879A7E7AF;
	Tue, 20 Oct 2009 03:04:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AEC3F7E7AE; Tue, 20 Oct 2009
 03:04:47 -0400 (EDT)
In-Reply-To: <hbi4mt$tjt$1@ger.gmane.org> (Sebastian Schuberth's message of
 "Mon\, 19 Oct 2009 18\:37\:05 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DE69950C-BD46-11DE-93BE-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130769>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> When compiling with MSVC on x86-compatible, use an intrinsic for byte swapping.
> In contrast to the GCC path, we do not prefer inline assembly here as it is not
> supported for the x64 platform.
>
> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>

Unlike the other one this is not Acked by Marius, Dscho, or J6t; should I
pick this up myself, or should I wait to be fed by one of msysgit people?


> ---
>  compat/bswap.h |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/compat/bswap.h b/compat/bswap.h
> index 5cc4acb..279e0b4 100644
> --- a/compat/bswap.h
> +++ b/compat/bswap.h
> @@ -28,6 +28,16 @@ static inline uint32_t default_swab32(uint32_t val)
>  	} \
>  	__res; })
>  
> +#elif defined(_MSC_VER) && (defined(_M_IX86) || defined(_M_X64))
> +
> +#include <stdlib.h>
> +
> +#define bswap32(x) _byteswap_ulong(x)
> +
> +#endif
> +
> +#ifdef bswap32
> +
>  #undef ntohl
>  #undef htonl
>  #define ntohl(x) bswap32(x)
> -- 
> 1.6.5.rc2.13.g1be2
