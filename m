From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] Recognize magic pathspec as filenames
Date: Wed, 12 Oct 2011 13:49:26 -0700
Message-ID: <7v4nze7x61.fsf@alter.siamese.dyndns.org>
References: <1318373083-13840-1-git-send-email-pclouds@gmail.com>
 <1318373083-13840-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 22:49:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE5k6-0000XE-Px
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 22:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754106Ab1JLUta convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Oct 2011 16:49:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56388 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754094Ab1JLUt3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Oct 2011 16:49:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5FD16A70;
	Wed, 12 Oct 2011 16:49:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8KyH2xXadduo
	hr9yPFnUx7c/G20=; b=aJaI5KM0g7WW/Up7Qry1rC2iUWw1NmiyszU6V2zzenUv
	upVPapco7g4eLaEF1Bd/bAUqJRpbM/dfHeUrgAvM+HuC72JBm1r8NsM7RXaNx2Hu
	LrOrUDhU3/KWKaW8isfDBr3vAz9K9u1iYqeG/Cg6Bu4YTxzBghBmYRyHrIcdIUw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=me4nCb
	0tiCS9ePVRi3NkufpduauikOi+iFU45nvjfAKvwk43pf36hNvRs+M5jPh25LhLET
	6SsHng/VIjMFerdscAC6FsgO9DR/gBkYhlqdN7fzpFtmu5wpWy/dLNUVIwB6E49n
	DYUajlbIadG/2Wer1QxHNxJevQtry40jSDX5w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE8A96A6F;
	Wed, 12 Oct 2011 16:49:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3916A6A6D; Wed, 12 Oct 2011
 16:49:28 -0400 (EDT)
In-Reply-To: <1318373083-13840-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 12 Oct
 2011 09:44:38 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AD56CE06-F513-11E0-89D7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183413>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  .. so that "git log :/" works, not so sure this is correct though

At least the first half should be in the commit log message, and also i=
t
should contrast it against "git log -- :/".

I doubt the approach taken by this particular patch (I do not know abou=
t
the rest of the series) is correct, as it breaks the symmetry between
verify_filename() and verify_non_filename().

When given a list of command line arguments, we do:

 (1) If there is "--", then no verification is needed. Everything befor=
e
     the double-dash that is not a "-flag" will be interpreted as revs
     (and get_sha1() will error out otherwise), and everything after th=
e
     double-dash will be used as an pathspec element.

 (2) If there is no "--", then earlier ones must be all revs and cannot=
 be
     pathnames in the working tree. The first argument that is not a re=
v
     and everything after that must be a pathname in the working tree, =
and
     must not be interpretable as revs.

That "must be a pathname in the working tree" is what verify_filename()
does. and you say that ":/foo" is OK to be a pathname in this patch.

But shouldn't the opposite "cannot be pathnames in the working tree" ch=
eck
done by verify_non_filename() also be told the same logic? If ":/foo" i=
s
OK to be a pathname, shouldn't check_filename() call in that function a=
lso
be avoided the same way?

And once that happens, I think you will be back to square one.

"git log :/foo" is ambiguous no matter how you slice it, if you are goi=
ng
to look at only the first character in the string. It could be asking t=
o
show only commits that touch the path in the top-level directory "foo" =
and
its subdirectories, or it could be asking to start traversal at a commi=
t
with "foo" in the log message.

Longhand magic pathspecs e.g. ":(icase)foo" might have better chance, b=
ut
not by a wide margin. It can be a rev that names the blob object in the
index registered for the literal path "'(icase)foo", or it could be an
element in the pathspec to match [Ff][Oo][[Oo].

>  setup.c |   16 +++++++---------
>  1 files changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/setup.c b/setup.c
> index 27c1d47..08f605b 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -58,15 +58,8 @@ static void NORETURN die_verify_filename(const cha=
r *prefix, const char *arg)
>  	unsigned char sha1[20];
>  	unsigned mode;
> =20
> -	/*
> -	 * Saying "'(icase)foo' does not exist in the index" when the
> -	 * user gave us ":(icase)foo" is just stupid.  A magic pathspec
> -	 * begins with a colon and is followed by a non-alnum; do not
> -	 * let get_sha1_with_mode_1(only_to_die=3D1) to even trigger.
> -	 */
> -	if (!(arg[0] =3D=3D ':' && !isalnum(arg[1])))
> -		/* try a detailed diagnostic ... */
> -		get_sha1_with_mode_1(arg, sha1, &mode, 1, prefix);
> +	/* try a detailed diagnostic ... */
> +	get_sha1_with_mode_1(arg, sha1, &mode, 1, prefix);
> =20
>  	/* ... or fall back the most general message. */
>  	die("ambiguous argument '%s': unknown revision or path not in the w=
orking tree.\n"
> @@ -85,6 +78,11 @@ void verify_filename(const char *prefix, const cha=
r *arg)
>  {
>  	if (*arg =3D=3D '-')
>  		die("bad flag '%s' used after filename", arg);
> +
> +	/* If it's magic pathspec, just assume it's file name */
> +	if (arg[0] =3D=3D ':' && is_pathspec_magic(arg[1]))
> +		return;
> +
>  	if (check_filename(prefix, arg))
>  		return;
>  	die_verify_filename(prefix, arg);
