From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] pathspec: do exact comparison on the leading
 non-wildcard part
Date: Mon, 19 Nov 2012 12:54:45 -0800
Message-ID: <7vzk2duw3m.fsf@alter.siamese.dyndns.org>
References: <1353229989-13075-1-git-send-email-pclouds@gmail.com>
 <1353229989-13075-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 22:22:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TaYnX-0001xO-Fz
	for gcvg-git-2@plane.gmane.org; Mon, 19 Nov 2012 22:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015Ab2KSVWJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Nov 2012 16:22:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36744 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751905Ab2KSVWH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Nov 2012 16:22:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 306189F08;
	Mon, 19 Nov 2012 16:22:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=TRCQbxuTBrkdG/UXOJ62Hn571
	cQ=; b=Rbp9Oipu7TJAa3XPg3D5aZd7H0qXjAqfxAx76jwjtdSw8L8Z2H4wH4/z+
	dZSPJmT/U4HyN/vQ+dKWzn5fkJrTHwFXi5IgbJdl3vxAA+eX9HncBfQx4uB09CP2
	MpGPvuTP5feNzsJ7arOHXjHZOTQ3VziJnqS585KnHZEjO5aOO0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=Z11pP9WlJFao6m0rlYy
	jpa+OEqUZW/uEh4qNVtnph0dK/HLlF9wkzdhcqvnDon9ARQnIEWlbtQFBlRS+Gd+
	YNSqO/hlTgw1pAeitnxJJJfQxjcFe+DWoyFgiDU6F2+fEYiCNNQyslptxv586hWC
	li1oISWmAFETGp/MuUXBULoo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CE229F07;
	Mon, 19 Nov 2012 16:22:07 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 717609F06; Mon, 19 Nov 2012
 16:22:06 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2B6B8ACA-328F-11E2-89D8-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210056>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  dir.c       | 18 +++++++++++++++++-
>  dir.h       |  8 ++++++++
>  tree-walk.c |  6 ++++--
>  3 files changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index c391d46..e4e6ca1 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -34,6 +34,21 @@ int fnmatch_icase(const char *pattern, const char =
*string, int flags)
>  	return fnmatch(pattern, string, flags | (ignore_case ? FNM_CASEFOLD=
 : 0));
>  }
> =20
> +inline int git_fnmatch(const char *pattern, const char *string,
> +		       int flags, int prefix)
> +{
> +	int fnm_flags =3D 0;
> +	if (flags & GF_PATHNAME)
> +		fnm_flags |=3D FNM_PATHNAME;
> +	if (prefix > 0) {
> +		if (strncmp(pattern, string, prefix))
> +			return FNM_NOMATCH;
> +		pattern +=3D prefix;
> +		string +=3D prefix;
> +	}
> +	return fnmatch(pattern, string, fnm_flags);

How would we protect this optimization from future breakages?

Once we start using FNM_PERIOD, this becomes unsafe, as the simple
part in "foo/bar*baz" would be "foo/bar" with remainder "*baz".

The pattern "foo/bar*baz" should match "foo/bar.baz" with FNM_PERIOD
set.  But with this optimization, fnmatch is fed pattern=3D"*baz",
string=3D".baz" and they would not match.
