From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] test-lib.sh: No POSIXPERM for cygwin
Date: Tue, 19 Mar 2013 14:10:02 -0700
Message-ID: <7vvc8ngkph.fsf@alter.siamese.dyndns.org>
References: <201303192049.58755.tboegi@web.de>
 <7v620nhzle.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	j6t@kdbg.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 19 22:10:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UI3nn-00019Z-LT
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 22:10:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757506Ab3CSVKG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Mar 2013 17:10:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33353 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751542Ab3CSVKF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Mar 2013 17:10:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D1586B9A;
	Tue, 19 Mar 2013 17:10:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=a+KE5xF40h43
	UCTAllW8Lsr+S84=; b=mX2WacZKAElIsI/QDzeXsVyhbD0TfClNLHNy9+imnQWq
	Bq6M+u6/fzOW1FLJuwbBUWGThvXvBxoCiUFbS0j7h3I6mwM+vClByyfwgIoN2zKM
	e1Wyl34PJDuTsr6cvBrmvQrgXZhXT2Pgogj5jf3sK/UfmxkVBg8BD6AZUDo2Ji0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=bXkZT5
	ZC67gKv7yRcZamI777hDjCSI0evN6BBevUYqCsmyd5/wxz0r5Jy+rF291dgtBdx+
	cmPBvg4Arq9WyCNIDJZ0VaqbDmBoekh51FrJFCZ2gvYU8eslEIS8roXvk1W+qEZm
	xF+e2TLLXPRynayEbEqcs5UpN2vQ74HwU67dc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 903B66B98;
	Tue, 19 Mar 2013 17:10:04 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EAE036B93; Tue, 19 Mar 2013
 17:10:03 -0400 (EDT)
In-Reply-To: <7v620nhzle.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 19 Mar 2013 14:03:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5E588250-90D9-11E2-AC34-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218557>

Junio C Hamano <gitster@pobox.com> writes:

> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> Use a compile switch IGNORECYGWINFSTRICKS to disable the usage
>> of cygwin_lstat_fn() only in path.c
>
> The analysis of the problem and the basic idea to disable the
> fast-but-lying fstricks in the code that matters may be good, but
> the implementation is questionable.
>
> What if we later need to move functions around, etc., so that some
> other calls in path.c still do want to use the fstricks bit while
> the existing ones in the file want the real lstat() information?
>
> Actually, that already is the case.  The call to lstat() in
> validate_headref() only cares about the S_ISXXX() type and can
> afford to use the fast-and-lying one, no?
>
> How about doing something like this in the generic codepath, and
> implement your own cygwin_true_mode_bits() function at the cygwin
> compatibility layer, and add
>
>     #define true_mode_bits cygwin_true_mode_bits
>
> in the compat/cygwin.h file?  The change has the documentation value
> to clarify what each lstat() is used for, too.
>
> Ideally, the "#ifndef true_mode_bits" part may want to become a
> generic helper function if there are lstat() calls in other files
> that cygwin wants to use the real lstat() not the fast-but-lying
> one, but one step at a time.
>
> Hrm?
>
>  path.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/path.c b/path.c
> index d3d3f8b..d0b31e5 100644
> --- a/path.c
> +++ b/path.c
> @@ -14,6 +14,21 @@
>  #include "strbuf.h"
>  #include "string-list.h"
> =20
> +#ifndef true_mode_bits
> +/*
> + * The replacement lstat(2) we use on Cygwin is incomplete and
> + * lies about permission bits; most of the time we do not care,
> + * but the callsites of this wrpper do care.
> + */
> +static int true_mode_bits(const char *path, int *mode)
> +{
> +	struct stat st;
> +	if (lstat(path, &st) < 0)
> +		return -1;
> +	return st.st_mode;

Of course this should be more like

	*mode =3D st.st_mode;
        return 0;

but I think you got the idea ;-)

> +}
> +#endif
> +
>  static char bad_path[] =3D "/bad-path/";
> =20
>  static char *get_pathname(void)
> @@ -400,9 +415,8 @@ int set_shared_perm(const char *path, int mode)
>  		return 0;
>  	}
>  	if (!mode) {
> -		if (lstat(path, &st) < 0)
> +		if (true_mode_bits(path, &mode) < 0)
>  			return -1;
> -		mode =3D st.st_mode;
>  		orig_mode =3D mode;
>  	} else
>  		orig_mode =3D 0;
