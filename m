From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] mv: flatten error handling code block
Date: Fri, 08 Aug 2014 10:54:05 -0700
Message-ID: <xmqqbnrukgua.fsf@gitster.dls.corp.google.com>
References: <1407503462-32632-1-git-send-email-pclouds@gmail.com>
	<1407503462-32632-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 19:54:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFoMt-0006Go-Pu
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 19:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbaHHRyP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Aug 2014 13:54:15 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51410 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750853AbaHHRyP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Aug 2014 13:54:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5AE522E31E;
	Fri,  8 Aug 2014 13:54:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2IeOPm9DSk8I
	Kc9C9wbwemAPPhI=; b=QB0/2rI9fDmfyj3Wfzc458o1N5e/S6K90LdJZPBvutZ9
	UqQtBYvSMTgfl3HqCButY7PFZGHurC13XY0dAhnDQAcNaKsD3j7HSF3o7MRztMxD
	5y59be7dc5r2bGDeYt2BQxq8gwW1Tlz287PtfmfnOaeM17IcCEjKZ5FUB65BKJE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=u6pKnt
	dOSsPk0ysWIJFAmufZKfymUOBj31XCAZg5Qav02INOuu06ZjPumXDRljk+aKgGqH
	GxyBSzqagRlLZdHwP5E6K3y8H19v1WGlvNZxWyGzuDpBktCBjipqkNxX64fWLQ9R
	JRIl7EzuvYjKpFA8OUZ0zCUB8agcyntcy/CC4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 51D682E31D;
	Fri,  8 Aug 2014 13:54:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6B2CB2E313;
	Fri,  8 Aug 2014 13:54:07 -0400 (EDT)
In-Reply-To: <1407503462-32632-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 8 Aug
 2014 20:10:57 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FE595AA6-1F24-11E4-94C9-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255060>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/mv.c | 35 +++++++++++++++++------------------
>  1 file changed, 17 insertions(+), 18 deletions(-)
>
> diff --git a/builtin/mv.c b/builtin/mv.c
> index a7e02c0..5c6f58f 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -58,6 +58,11 @@ static const char *add_slash(const char *path)
>  	return path;
>  }
> =20
> +static void move_up_one(void *p, int nmemb, int size)
> +{
> +	memmove(p, (char*)p + size, nmemb * size);
> +}
> +
>  static struct lock_file lock_file;
>  #define SUBMODULE_WITH_GITDIR ((const char *)1)
> =20
> @@ -224,24 +229,18 @@ int cmd_mv(int argc, const char **argv, const c=
har *prefix)
>  		else
>  			string_list_insert(&src_for_dst, dst);
> =20
> -		if (bad) {
> -			if (ignore_errors) {
> -				if (--argc > 0) {
> -					memmove(source + i, source + i + 1,
> -						(argc - i) * sizeof(char *));
> -					memmove(destination + i,
> -						destination + i + 1,
> -						(argc - i) * sizeof(char *));
> -					memmove(modes + i, modes + i + 1,
> -						(argc - i) * sizeof(enum update_mode));
> -					memmove(submodule_gitfile + i,
> -						submodule_gitfile + i + 1,
> -						(argc - i) * sizeof(char *));
> -					i--;
> -				}
> -			} else
> -				die (_("%s, source=3D%s, destination=3D%s"),
> -				     bad, src, dst);
> +		if (!bad)
> +			continue;
> +		if (!ignore_errors)
> +			die (_("%s, source=3D%s, destination=3D%s"),
> +			     bad, src, dst);
> +		if (--argc > 0) {
> +			int n =3D argc - i;
> +			move_up_one(source + i, n, sizeof(*source));
> +			move_up_one(destination + i, n, sizeof(*destination));
> +			move_up_one(modes + i, n, sizeof(*modes));
> +			move_up_one(submodule_gitfile + i, n, sizeof(*submodule_gitfile))=
;
> +			i--;

The resulting end-of-loop code structure certainly looks a lot
better, even if the original memmove()s were left inline without the
helper.

The helper itself however looks a bit half-hearted.  It may be more
appropriate to go one step further to have a macro whose use looks
like this, perhaps, to avoid the last remaining repetition?

	MOVE_UP_BY_ONE(source, i, n);


>  		}
>  	}
