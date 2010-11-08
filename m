From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] dir.c: fix EXC_FLAG_MUSTBEDIR match in sparse checkout
Date: Mon, 08 Nov 2010 12:13:35 -0800
Message-ID: <7vfwvbpo9c.fsf@alter.siamese.dyndns.org>
References: <loom.20101107T172926-284@post.gmane.org>
 <1289153098-15684-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, thomasr@sailguy.org,
	Jens Lehmann <Jens.Lehmann@web.de>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 21:13:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFY6E-0003i7-TE
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 21:13:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753558Ab0KHUNt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Nov 2010 15:13:49 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35638 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884Ab0KHUNs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Nov 2010 15:13:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 314583C6D;
	Mon,  8 Nov 2010 15:13:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zX4BK/Tgowbp
	73AybGvAUpUPHkA=; b=UEtoQ10FsKI8NcNCPsxSMtPDqNrzrNaUIjHeQ5ykHn5P
	Mm86N0ikx9nZ5bGe1bgPU3/Esw1NslgiCn6onU1jr48BIaZDK8cEtIQB7WNqDjK3
	1ncSTa9g5pa9tXooEJXB14vv+POBERCuxG9RpqOk582Z/dmcK8+ljaJDDPef2i8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=O0lwUh
	BemeCWlcpcZkT6jYZkpJ12hj1GqhxOXy7mb2EsbtlC+53kEKSwPOce+6E+h/RYKI
	Gi1aFNd+ZjXs0Ibhv9Ze+baGzkFYYUdOOKKyVCB0kkEo4r8o4Nao7yv+ZBoYsyl7
	4oqd3DPYWa8mmjKD6y4WsVLG8wTXWZJlPJLvk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E5B9E3C6C;
	Mon,  8 Nov 2010 15:13:45 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 838863C67; Mon,  8 Nov 2010
 15:13:40 -0500 (EST)
In-Reply-To: <1289153098-15684-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Mon\,  8 Nov
 2010 01\:04\:58 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B0C7D9F8-EB74-11DF-B04E-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160980>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Commit c84de70 (excluded_1(): support exclude files in index -
> 2009-08-20) tries to work around the fact that there is no
> directory/file information in index entries, therefore
> EXC_FLAG_MUSTBEDIR match would fail.
>
> Unfortunately the workaround is flawed. This fixes it.
>
> Reported-by: Thomas Rinderknecht <thomasr@sailguy.org>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

Hmmm...

> diff --git a/dir.c b/dir.c
> index d1e5e5e..b2dfb69 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -360,7 +360,8 @@ int excluded_from_list(const char *pathname,
> =20
>  			if (x->flags & EXC_FLAG_MUSTBEDIR) {
>  				if (!dtype) {
> -					if (!prefixcmp(pathname, exclude))
> +					if (!prefixcmp(pathname, exclude) &&
> +					    pathname[x->patternlen] =3D=3D '/')

- Can pathname be much shorter than x->patternlen (it doesn't matter as
  prefixcmp will return false in that case)?

- Can pathname be equal to exclude (yes it can but in that case pathnam=
e
  is not a directory but is a regular file, symlink or a submodule)?

So it may be a tricky code, but I do not think it is a "workaround" in =
any
way.  Isn't it just a "correct solution"?

By the way, builtin/add.c calls excluded() with DT_UNKNOWN and relies o=
n
the fact that the macro is accidentally defined as 0.  108da0d (git add=
:
Add the "--ignore-missing" option for the dry run, 2010-07-10).  If it
means NULL, it should spell it out as such.

Thanks.
