From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] archive-zip: stream large blobs into zip file
Date: Mon, 30 Apr 2012 12:12:51 -0700
Message-ID: <7vipghf2z0.fsf@alter.siamese.dyndns.org>
References: <1335761837-12482-1-git-send-email-pclouds@gmail.com>
 <1335761837-12482-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 21:13:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOw20-0007FS-Te
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 21:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756372Ab2D3TMy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 15:12:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40132 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756114Ab2D3TMx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Apr 2012 15:12:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3807D7397;
	Mon, 30 Apr 2012 15:12:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=fsnpDiLlszwa
	2cdbbEThxGXNit8=; b=KiyFgbiShpedVdV67QUQRm0i5Y0SUEJTejcjORVLcl/1
	umcrChJhUQs+wiLKTA5Q8/tw/DhExA2oW7er+eeFOH4wrazJKbXqfVtuByxJCsZs
	Yj3XSyZWJBNKvGHQWnMo/UDnW6IEGcTYmagz0BJ7SJZ6MAoMbJ7Hykuy6Y+Wi5o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dOyKLr
	Ovm+LNb3kEozuQ5AkB+ajAnLeiMBgshjgEjWo854O8hKAgKXV0WLeGwcsFX9qZAt
	AQrdU86RcHLsmdcxBiL/d2A34lGoqik6GaiYtAYsY7clHJGfIEZiSA5Kf1Y1IE09
	JM/4fCBasp4Eq3yeacHsmX5Vd9sPqUE5MYzhk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EAA17396;
	Mon, 30 Apr 2012 15:12:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B2417395; Mon, 30 Apr 2012
 15:12:52 -0400 (EDT)
In-Reply-To: <1335761837-12482-6-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 30 Apr
 2012 11:57:17 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7BE257CC-92F8-11E1-AB72-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196595>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> A large blob will be read twice. One for calculating crc32, one for
> actual writing.

Is that because you need the checksum before the payload?  That is
unfortunate.  It would be nice (read: not a rejection of this patch---i=
t
is a good first step to do it stupid but correct way before trying to
optimize it) to avoid it when the output is seekable, especially becaus=
e
we are talking about a *large* payload.

> diff --git a/t/t1050-large.sh b/t/t1050-large.sh
> index fe47554..458fdde 100755
> --- a/t/t1050-large.sh
> +++ b/t/t1050-large.sh
> @@ -138,4 +138,8 @@ test_expect_success 'tar achiving' '
>  	git archive --format=3Dtar HEAD >/dev/null
>  '
> =20
> +test_expect_success 'zip achiving' '
> +	git archive --format=3Dzip HEAD >/dev/null
> +'

Can't we do better than "we only check if it finishes without barfing; =
we
cannot afford to check the correctness of the output"?  The same commen=
t
applies to all the tests you added to this file in the past 3 months.
