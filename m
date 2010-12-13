From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/19] tree_entry_interesting(): factor out most matching
 logic
Date: Mon, 13 Dec 2010 10:10:07 -0800
Message-ID: <7vfwu135og.fsf@alter.siamese.dyndns.org>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
 <1292233616-27692-11-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 19:10:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSCr6-0000Ws-Ib
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 19:10:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758617Ab0LMSKT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Dec 2010 13:10:19 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59207 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758556Ab0LMSKP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Dec 2010 13:10:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 763302F2B;
	Mon, 13 Dec 2010 13:10:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=PbsEBsSGanQk+j/0vMClP3fOU
	pA=; b=IW52NsLf3cr0iRmQPm9XAvCHvHZjYWjdYGCLUaVdRtmkMylDkfPk7pYzH
	sNBtvslXOtq+61gOZs02y/PE35O7J4LUJooVMac92awdilfK/FvZbboNIoDWHON+
	b499BlxIwcDWXOwT5U6Pl4UWUIVt6Fzk9e5JDPJ68ipDgH6sm8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=EcHbWJYDJvEcEiHZjtN
	2wKw32zaMf5o6brVGn2hfcaOD+nas7ImiVclWW92XQNew4rWhIzyDu0ONn0+FYYe
	MP8iosDZVId1D4AcVXVMx+r2IxHw39r5926qqKZfukzY5O6LYNVJL+jTCvOHcyzR
	guVU7DI4HMQrcXEOt5IWPw+Q=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 334E82F28;
	Mon, 13 Dec 2010 13:10:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0B5042F22; Mon, 13 Dec 2010
 13:10:34 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 49CEA700-06E4-11E0-9C0B-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163573>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/tree-walk.c b/tree-walk.c
> index 01168ea..40a4657 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -481,88 +566,21 @@ int tree_entry_interesting(const struct name_en=
try *entry,
>  	for (i =3D 0; i < ps->nr; i++) {
>  		const char *match =3D ps->raw[i];
>  		int matchlen =3D ps->items[i].len;
> -		int m =3D -1; /* signals that we haven't called strncmp() */
> =20
>  		if (baselen >=3D matchlen) {
> -			/* If it doesn't match, move along... */

Why lose this comment?  That is exactly what this simplified part is
about.  If match-dir-prefix says it doesn't match, we move along.

Keep this comment here, and drop the one you copied to the beginning of
match-dir-prefix, which is not about "moving along" anymore.  The funct=
ion
is about deciding if they match or not.

> -			if (strncmp(base, match, matchlen))
> +			if (!match_dir_prefix(base, baselen, match, matchlen))
> +				/* Just a random prefix match */
>  				continue;

This comment no longer holds true, even though the same comment at the =
end
of match-dir-prefix function is correct.  This should probably say "doe=
s
not match", but that is something you already said.

Other than that, this is a very nice refactoring.
