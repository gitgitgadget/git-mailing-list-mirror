From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] make_absolute_path: return the input path if it
 points to our buffer
Date: Wed, 16 Mar 2011 13:51:13 -0700
Message-ID: <7vaagu7pry.fsf@alter.siamese.dyndns.org>
References: <1300291579-25852-1-git-send-email-cmn@elego.de>
 <1300291579-25852-2-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Mar 16 21:51:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzxgn-0006vD-BL
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 21:51:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872Ab1CPUvZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2011 16:51:25 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38188 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753798Ab1CPUvY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Mar 2011 16:51:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 341AE4D30;
	Wed, 16 Mar 2011 16:52:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=omq7YvCyJA11
	Tc/k9YPGzxy4bj8=; b=XM9hVBEUNWmKsakc6n908+N8o/gpNCmLx4ylntqB7fYF
	9YNKmofmpWzaJA1P1D0TTb/5/bxRy3c0WDfnSoDVRlGqf/6bxq47fKDiQQks1NLl
	BPE1xElOiOBtbWx4y4Q8XJXLcnTtGDDfRJjyEP+gKhI9r7r61l9tjI/rTKAXe/k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=o/AzlH
	q3+AUGzXD2/sfoldnFK+5OxZRM2F7YR8lchi6fuW/ODNG+JFdgdIHCFiuwLcNScQ
	N3S2S5NN3bPykoIE+mXDmgoid1DrwiKse6q5y3I/Ev2ZePCrmbz0lltLhpEc7Z04
	Bd/AfHHhK0pt/m0zP3K5Io47RBdOp/SEGSQR0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 00F9D4D2D;
	Wed, 16 Mar 2011 16:52:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C3B444D23; Wed, 16 Mar 2011
 16:52:48 -0400 (EDT)
In-Reply-To: <1300291579-25852-2-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Wed, 16 Mar 2011 17:06:17
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5C96AEAE-500F-11E0-9984-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169195>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> Some codepaths call make_absolute_path with its own return value as
> input. In such a cases, return the path immediately.
>
> This fixes a valgrind-discovered error, whereby we tried to copy a
> string onto itself.
>
> Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
> ---
>  abspath.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/abspath.c b/abspath.c
> index 91ca00f..ff14068 100644
> --- a/abspath.c
> +++ b/abspath.c
> @@ -24,6 +24,10 @@ const char *make_absolute_path(const char *path)
>  	char *last_elem =3D NULL;
>  	struct stat st;
> =20
> +	/* We've already done it */
> +	if (path =3D=3D buf || path =3D=3D next_buf)
> +		return path;
> +

I like this, as it is very obvious what we are checking here.  Thanks.
