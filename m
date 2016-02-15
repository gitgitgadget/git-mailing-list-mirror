From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] dir.c: fix match_pathname()
Date: Mon, 15 Feb 2016 15:29:59 -0800
Message-ID: <xmqqmvr1o8lk.fsf@gitster.mtv.corp.google.com>
References: <1455527019-7787-1-git-send-email-pclouds@gmail.com>
	<1455527019-7787-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 00:30:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVSaq-000545-RH
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 00:30:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350AbcBOXaH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2016 18:30:07 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57211 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751927AbcBOXaF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Feb 2016 18:30:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 19FED456AA;
	Mon, 15 Feb 2016 18:30:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=JMcKsvwCFw/b
	PvQlk64RwY6IZ2A=; b=ArYPLYKl2UG5auQTCyRFyMfcuBjkrppccm+Mk3ACZI5u
	vxQDYK0o0YZErNJ6PBejhuOs580wH3oTWrlH8fQIRePTx2QGxlPJ7ZUrb6R0ViUQ
	iXsgilXG5+ugSg34uyr7S1m0YVEYwNyq7/DCxHptpkExAYfRyf0Ewo3ZTQX8lkc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=MKmcdQ
	OGjPx9lHq6itBJE7TwggPwoXx3fCJtj8HC73h0nObAlCv1W2HY8KEW0h9pl6+vJT
	SMWBrDjC+Lr2k4HZ5hDFTe27X9uybYrG+L53jaCEkXU7RPtqa3x+K0uMBQat7HFE
	/daZIfDOJMwtA9tPuJk9SOao1PFkX12MRV4tY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 806AF456A7;
	Mon, 15 Feb 2016 18:30:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9101D456A1;
	Mon, 15 Feb 2016 18:30:00 -0500 (EST)
In-Reply-To: <1455527019-7787-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 15
 Feb 2016 16:03:36 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 083E4D74-D43C-11E5-802A-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286289>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Given the pattern "1/2/3/4" and the path "1/2/3/4/f", the pattern
> prefix is "1/2/3/4". We will compare and remove the prefix from both
> pattern and path and come to this code
>
> 	/*
> 	 * If the whole pattern did not have a wildcard,
> 	 * then our prefix match is all we need; we
> 	 * do not need to call fnmatch at all.
> 	 */
> 	if (!patternlen && !namelen)
> 		return 1;
>
> where patternlen is zero (full pattern consumed) and the remaining
> path in "name" is "/f". We fail to realize it's matched in this case
> and fall back to fnmatch(), which also fails to catch it. Fix it.

OK.  And by checking *name against '/', we won't mistakenly say that
"1/2/3/4f" matches the pattern.  Nicely explained.

Can a pattern end with a '/'?

>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  dir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/dir.c b/dir.c
> index f0b6d0a..bcaafac 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -878,7 +878,7 @@ int match_pathname(const char *pathname, int path=
len,
>  		 * then our prefix match is all we need; we
>  		 * do not need to call fnmatch at all.
>  		 */
> -		if (!patternlen && !namelen)
> +		if (!patternlen && (!namelen || *name =3D=3D '/'))
>  			return 1;
>  	}
