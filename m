From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] inet_ntop.c: Work around GCC 4.6's detection of
 uninitialized variables
Date: Tue, 18 Oct 2011 10:32:45 -0700
Message-ID: <7vehyagq82.fsf@alter.siamese.dyndns.org>
References: <4E9DA88E.40500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mschub@elegosoft.com
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 19:32:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGDX3-0002h3-Ca
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 19:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933380Ab1JRRct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 13:32:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34545 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756242Ab1JRRcs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 13:32:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B1915239;
	Tue, 18 Oct 2011 13:32:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FHcMuD2y12r0/WbHrk52DaOykJA=; b=a/we1n
	9W/knxRZWkYqPEgJe4q8P/ZFqgMtHTmzHuJGXvtUJNyCqfu2qss/Vu945ezuLW23
	yFUJNY+VjE0SlEoZAaEYosRZS2t34Vvw25n8mMm1KYoQg9SybuRzZS+xhFE2cTjJ
	3676Z738rTlKgaB1bfUzMrdmfvMAHC85V+xT8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KxbCHB0/2YFNwKwJQave/AibwwItlyj8
	1DsijzkxxKJYJi180lwE6DENRBFTfVWvW3l3E+9HWWMWkMukbw+/ay3XRkZrjGtT
	6BWl7aa9O07+h/5rXhcU17nfiOWMvfJ3K1pfmb16Mc99fiL/nl8sF7RwoQFpVdGz
	pMVdJLh0fUE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92D3B5238;
	Tue, 18 Oct 2011 13:32:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 249845237; Tue, 18 Oct 2011
 13:32:47 -0400 (EDT)
In-Reply-To: <4E9DA88E.40500@gmail.com> (Sebastian Schuberth's message of
 "Tue, 18 Oct 2011 18:25:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 31D2EBDE-F9AF-11E0-8590-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183890>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> GCC 4.6 claims that
>
>     error: 'best.len' may be used uninitialized in this function
>
> so silence that warning which is treated as an error by also initializing
> the "len" members of the struct.
>
> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---
>  compat/inet_ntop.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/compat/inet_ntop.c b/compat/inet_ntop.c
> index ea249c6..60b5a1d 100644
> --- a/compat/inet_ntop.c
> +++ b/compat/inet_ntop.c
> @@ -98,7 +98,9 @@ inet_ntop6(const u_char *src, char *dst, size_t size)
>  	for (i = 0; i < NS_IN6ADDRSZ; i++)
>  		words[i / 2] |= (src[i] << ((1 - (i % 2)) << 3));
>  	best.base = -1;
> +	best.len = 0;
>  	cur.base = -1;
> +	cur.len = 0;

It may be just the "taste" thing, but I wonder if

	best.base = -1;
        best.len = 0;
        cur = best;

might be easier on the eyes.

Will queue as-is anyway. Thanks.

>  	for (i = 0; i < (NS_IN6ADDRSZ / NS_INT16SZ); i++) {
>  		if (words[i] == 0) {
>  			if (cur.base == -1)
