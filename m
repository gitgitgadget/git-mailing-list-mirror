From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 4/4] Accept tags in HEAD or MERGE_HEAD
Date: Fri, 19 Aug 2011 13:17:00 -0700
Message-ID: <7vaab52m2r.fsf@alter.siamese.dyndns.org>
References: <1313674994-22902-1-git-send-email-pclouds@gmail.com>
 <1313765407-29925-1-git-send-email-pclouds@gmail.com>
 <1313765407-29925-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 22:17:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuVV7-000563-QN
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 22:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253Ab1HSURF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Aug 2011 16:17:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55920 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753930Ab1HSURD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Aug 2011 16:17:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86E5C4405;
	Fri, 19 Aug 2011 16:17:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5rWMg/KX1Hnt
	ektUg3Ylp+zqQwA=; b=VuKtpnocBKTjisLRCpKBL08urZf3jiWJ5mA/zatoqEsp
	IeJuoeOq3UfPQeUfluhX4+KP6n2nWVLscqCZBiknJJDTUZ0B+MusgaNUOoPZ8nsM
	5h/AlcOGwbnrkZHmB5JldjPn+/yosnugaTbC40cRFOeZP3VZf0je5kukYmYMZEo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=IKUyE8
	t80f5ifcaTIYSjVxqOcwqI2vWmWYfoIvvjNOuhkj67gsoj0h5ykg0HFShI69Zbmu
	yqFEi3G3eZ8DRz/DjDcsMichmSKSaactZFPplhf+eO0U++VRc45Cz80n9CZp8cbB
	sYmIak2JWhIdIv10KKqmR3QIallKaxuTqkUHM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D7C34404;
	Fri, 19 Aug 2011 16:17:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 03C554403; Fri, 19 Aug 2011
 16:17:01 -0400 (EDT)
In-Reply-To: <1313765407-29925-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 19 Aug
 2011 21:50:07 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 32FEE55A-CAA0-11E0-92BF-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179721>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

>  Junio's point, that if HEAD holds a tag, then head_sha1 and head->ob=
ject.sha1
>  in statement [1] are different, is entirely correct. However, favori=
ng
>  head->object.sha1 over head_sha1 is not enough. The variable head_sh=
a1 is
>  still there. Somewhere, some time, people may misuse it.

That is why I suggested _removing_ head_sha1[] altogether, so that ther=
e
is only one source of information. is_initial becomes !current_head and=
=20
head_sha1 becomes (current_head ? current_head->object.sha1 : null_sha1=
).

> diff --git a/commit.c b/commit.c
> index ac337c7..9e7f7ef 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -39,6 +39,25 @@ struct commit *lookup_commit_reference(const unsig=
ned char *sha1)
>  	return lookup_commit_reference_gently(sha1, 0);
>  }
> =20
> +/*
> + * Look sha1 up for a commit, defer if needed. If deference occurs,
> + * update "sha1" for consistency with retval->object.sha1. Also warn
> + * users this case because it is expected that sha1 points directly =
to
> + * a commit.
> + */

That's de-reference, not deference ;-). You may want to be more explici=
t
about what kind of de-reference you are talking about.

/*
 * Get a commit object for the given sha1, unwrapping a tag object that
 * point at a commit while at it. ref_name is only used when the result=
=20
 * is not a commit in the error message to report where we got the sha1
 * from.
 */

I actually was hoping that you would have this comment in commit.h to h=
elp
people who want to add callers of this function, not next to the
implementation.

As I said earlier, I do not think updating sha1[] here is necessary. Th=
e
caller should be updated to use c->object.sha1 instead.

> +struct commit *lookup_commit_or_die(unsigned char *sha1, const char =
*ref_name)
> +{
> +	struct commit *c =3D lookup_commit_reference(sha1);
> +	if (!c)
> +		die(_("could not parse %s"), ref_name);
> +	if (hashcmp(sha1, c->object.sha1)) {
> +		warning(_("%s %s is not a commit!"),
> +			ref_name, sha1_to_hex(sha1));
> +		hashcpy(sha1, c->object.sha1);
> +	}
> +	return c;
> +}
