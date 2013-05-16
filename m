From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 2/2] imap-send: eliminate HMAC deprecation warnings on Mac OS X
Date: Wed, 15 May 2013 17:39:04 -0700
Message-ID: <7v7gizahcn.fsf@alter.siamese.dyndns.org>
References: <1368663120-47102-1-git-send-email-davvid@gmail.com>
	<1368663120-47102-2-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 02:39:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcmDy-0000qu-0M
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 02:39:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421Ab3EPAjK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 20:39:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46045 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096Ab3EPAjH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 20:39:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23178F9B7;
	Thu, 16 May 2013 00:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VpfXFaVIWDQ1IV242aVb7hR2Qlk=; b=T79wgY
	VDPsIludcfgtjyQ3pt3ITrIAmziowQSKQAzLBdR8BMM11DKYj3rQzm21JfyOFzQn
	NBjWPnF24BR658AJ2nNahLKtPPx7ZYn0XVZazkZH+A4nObPMSO0K0TItqPFfQ+KY
	YNOZoAzU9S+QNec5/KZxZwjnWb77WbO0Ky5+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YxXvd2jTlOIY23Sav4+kD0GWa3F/9yNW
	xNOAQbcri+wr9mwe3KDlszAafy0GRbt3aXfsCDl7svHA9iog4J6KzbUi5P5mrLzj
	tfw88vrJef+FDCYgIEGSXQj8I5aOHoc75jGrpqj8qvVu0vpkFA3zVrKhnIDkSKRA
	i81Y7Ubn3iw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16C62F9B5;
	Thu, 16 May 2013 00:39:07 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 74ED9F9B0;
	Thu, 16 May 2013 00:39:06 +0000 (UTC)
In-Reply-To: <1368663120-47102-2-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Wed, 15 May 2013 17:12:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 03D0B1BC-BDC1-11E2-A69D-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224464>

David Aguilar <davvid@gmail.com> writes:

> Mac OS X 10.8 Mountain Lion warns that HMAC_Init() and friends
> are deprecated.  Detect the COMMON_CRYPTO_FOR_OPENSSL definition

Ahh, I think you meant to use that name but forgot to adjust the
symbol you use in the patch ;-)

I'll queue with s/COMMON_DIGEST_FOR_OPENSSL/COMMON_CRYPTO_FOR_OPENSSL/;

> and use CommonCrypto's HMAC functions to eliminate the warnings.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> Changes since last time: None.
>
>  imap-send.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/imap-send.c b/imap-send.c
> index d9bcfb4..96012b1 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -29,8 +29,18 @@
>  #ifdef NO_OPENSSL
>  typedef void *SSL;
>  #else
> +#ifdef COMMON_DIGEST_FOR_OPENSSL
> +#include <CommonCrypto/CommonHMAC.h>
> +#define HMAC_CTX CCHmacContext
> +#define HMAC_Init(hmac, key, len, algo) CCHmacInit(hmac, algo, key, len)
> +#define HMAC_Update CCHmacUpdate
> +#define HMAC_Final(hmac, hash, ptr) CCHmacFinal(hmac, hash)
> +#define HMAC_CTX_cleanup
> +#define EVP_md5() kCCHmacAlgMD5
> +#else
>  #include <openssl/evp.h>
>  #include <openssl/hmac.h>
> +#endif
>  #include <openssl/x509v3.h>
>  #endif
