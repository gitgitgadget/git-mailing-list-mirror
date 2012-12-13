From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] Add directory pattern matching to attributes
Date: Thu, 13 Dec 2012 12:08:57 -0800
Message-ID: <7vfw39yasm.fsf@alter.siamese.dyndns.org>
References: <201212082104.39411.avila.jn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Jean-No=C3=ABl_AVILA?= <avila.jn@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 21:09:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjF5t-0002Up-QE
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 21:09:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756640Ab2LMUJD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Dec 2012 15:09:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37821 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756343Ab2LMUJB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Dec 2012 15:09:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A768DA6DE;
	Thu, 13 Dec 2012 15:09:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=C/q+YDsAZl4t
	cq0SFQ3U6Liubyg=; b=wtaaRbEzAVBQ4aLgaZtT8RgW/gmpcFH9CJDL62gkHN+p
	H/RcVYJqT2C3b7oRjQjt88cUS3DgQC6rLpLvN/YUKWhbmsC3FSY0B/xAonOW46cH
	GR1hpDLeC3q48R2bmlBcFwA2vEw7wIzR0YijID4jQ9iqKWvvpQko57LFCVTiw6k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=VonhEX
	0YHgEATZgESpD/VDmX5ZLWPAPy7z1oOJOSFGuojtij5TLvnWxK0s/cdstWrCS5yg
	DJ9t6rfnl9Z8mlI0FDaJIiePUSv+Oi8s5bGxIjedsuWQKnlF4GREL4ZBdbXyh55j
	7mSZY5WHJBKrUo/1ASK9jFiYoEMVVn0aoAYzM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94998A6DD;
	Thu, 13 Dec 2012 15:09:00 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F096AA6DB; Thu, 13 Dec 2012
 15:08:59 -0500 (EST)
In-Reply-To: <201212082104.39411.avila.jn@gmail.com> (=?utf-8?Q?=22Jean-No?=
 =?utf-8?Q?=C3=ABl?= AVILA"'s message of "Sat, 8 Dec 2012 21:04:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EEC9F856-4560-11E2-AD24-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211470>

"Jean-No=C3=ABl AVILA" <avila.jn@gmail.com> writes:

> The manpage of gitattributes says: "The rules how the pattern
> matches paths are the same as in .gitignore files" and the gitignore
> pattern matching has a pattern ending with / for directory matching.
>
> This rule is specifically relevant for the 'export-ignore' rule used
> for git archive.
>
> Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
> ---
>  archive.c                       |    3 ++-
>  attr.c                          |   32 ++++++++++++++++------
>  t/t5002-archive-attr-pattern.sh |   57 +++++++++++++++++++++++++++++=
++++++++++
>  3 files changed, 83 insertions(+), 9 deletions(-)
>  create mode 100644 t/t5002-archive-attr-pattern.sh

Looks nicely done.

> diff --git a/attr.c b/attr.c
> index 097ae87..cdba88a 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -564,17 +564,31 @@ static void bootstrap_attr_stack(void)
>  	attr_stack =3D elem;
>  }
> =20
> +static const char *find_basename(const char *path)
> +{
> +	char pathbuf[PATH_MAX];
> +	int pathlen;
> +	const char *cp;
> +
> +	pathlen =3Dstrlen(path);
> +	if (path[pathlen-1] !=3D '/') {
> +		cp =3Dstrrchr(path, '/');
> +		return cp ? cp + 1: path;
> +	} else {
> +		strncpy(pathbuf, path, pathlen);
> +		pathbuf[pathlen-1] =3D '\0';
> +		cp =3Dstrrchr(pathbuf, '/');
> +		return cp ? path + (cp - pathbuf) + 1 : path;
> +	}
> +}

Let's do this function like this instead; shorter and equally easy
to understand.

        static const char *find_basename(const char *path)
        {
                const char *cp, *last_slash =3D NULL;

                for (cp =3D path; *cp; cp++) {
                        if (*cp =3D=3D '/' && cp[1])
                                last_slash =3D cp;
                }
                return last_slash ? last_slash + 1 : path;
        }

Thanks; will queue.
