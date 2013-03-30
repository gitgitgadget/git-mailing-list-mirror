From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/5] commit.c/GPG signature verification: Also look at
 the first GPG status line
Date: Fri, 29 Mar 2013 20:37:31 -0700
Message-ID: <7va9pllfr8.fsf@alter.siamese.dyndns.org>
References: <7vy5d7qhmm.fsf@alter.siamese.dyndns.org>
 <cover.1364601337.git.jaseg@physik-pool.tu-berlin.de>
 <51562E5C.8020206@physik.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sebastian =?utf-8?Q?G=C3=B6tte?= <jaseg@physik.tu-berlin.de>
X-From: git-owner@vger.kernel.org Sat Mar 30 04:38:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULmcG-0004IG-2X
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 04:38:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757867Ab3C3Dhg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Mar 2013 23:37:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61399 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757673Ab3C3Dhf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Mar 2013 23:37:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77B32F68A;
	Sat, 30 Mar 2013 03:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=VSBQs8iXqrRpLbHf8E9nhtZi8
	vs=; b=pLJeFmZu7ctQwerU2MhWfIyzIDFrLJ600wIdwInKHZKZsGzpikNNCjDsX
	X3mzhcRVFDiQMmaupZEDtzbDM+lQELFZrlCwgKJcrVr+fyMY2Qs9Q0nyqbq2Uro5
	jPHeTBrX33J4/4xfHYuDaVyi/Q1mY4M7LlaquOgOZ0B7UBx7f4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=RcgGZMqJpAQmarMO/Wg
	pOhY2vnbxIxuLCQtQfTaYyAtiD3K+OaeOFWMGWwQlcqfjl95a192+bK6iZpeCHPp
	Z8c3nyy4GNEo//SZeTtmkJb1Vp0BOKUU5tTWqhLtGhz5fHt4bRBbmhAOEZMB9lqq
	u85jIMKbX6af7ZTIvDdJruN4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B96CF689;
	Sat, 30 Mar 2013 03:37:34 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EEED3F67E; Sat, 30 Mar 2013
 03:37:33 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2890EE0E-98EB-11E2-AECF-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219549>

Sebastian G=C3=B6tte <jaseg@physik.tu-berlin.de> writes:

>  static void parse_gpg_output(struct signature_check *sigc)
>  {
> -	const char *buf =3D sigc->gpg_status;
>  	int i;
> =20
> +	/* Iterate over all search strings */
>  	for (i =3D 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
> +		const char *found =3D sigc->gpg_status;
> +
> +		/* Iterate over all lines */
> +		do {
> +			if (!prefixcmp(found, sigcheck_gpg_status[i].check)) {
> +				const char *next;
> +			=09
> +				found +=3D strlen(sigcheck_gpg_status[i].check);
> +				sigc->check_result =3D sigcheck_gpg_status[i].result;
> +				sigc->key =3D xmemdupz(found, 16);
> +				found +=3D 17;
> +				next =3D strchrnul(found, '\n');
> +				sigc->signer =3D xmemdupz(found, next - found);
> +				return;
> +			}
> +			found =3D strchr(found, '\n')+1;
> +		} while(found-1);

Yuck.  That termination condition is horrible.

Honestly speaking, I find the one I suggested the other day (which
has been queued on 'pu') much nicer than this loop.

If you really really want to do a line at a time, discarding the
"allow strstr() to scan over multiple lines" optimization, it is
more natural to iterate over buffer one line at a time, and check
for each expected output with an inner loop, perhaps like this:

	const char *cp =3D buf;
        while (*cp) {
		for (i =3D 0; i < ARRAY_SIZE(sig_check); i++) {
	        	if (!prefixcmp(cp, sig_check[i].check) &&
                            parse_gpg_status(sigc, cp, &sig_check[i]))
				return;
		}
                cp =3D strchrnul(cp, '\n');
                if (*cp)
	                cp++;
	}

But I do not see much point in doing so.
