From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/5] setup: sanity check file size in read_gitfile_gently
Date: Sat, 25 Apr 2015 09:47:51 -0700
Message-ID: <xmqqa8xw17ew.fsf@gitster.dls.corp.google.com>
References: <1429952801-2646-1-git-send-email-erik.elfstrom@gmail.com>
	<1429952801-2646-3-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Erik =?utf-8?Q?Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 18:48:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ym3FI-0006Qh-5q
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 18:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752304AbbDYQrz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Apr 2015 12:47:55 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59606 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750825AbbDYQrx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Apr 2015 12:47:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EE322498C1;
	Sat, 25 Apr 2015 12:47:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2ZD6+clKMw4z
	0FGuFwCqYT/DF5s=; b=M3m2pFtCM/ZbU77wT6dBm9Un4J2vJT+lDbIudSDEArgX
	OmB/qz+TfjqWKcH6JBLJuhh0myNqeRUmKl3f/aM5iF/twpr49TJpqjZQ2z4Q3CHq
	moLTkGZwEEf9EbB9GU//c1V0mRnbbu3+vBK9sYh9ejUuyLtiGZmSKC/6KxTZWYw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=KzWxMn
	8q7neEOa/awiEr3lAdSgI3ih6HJsPztFn07JwIWcH+bssU7g5VGqAQoCVn+4DRnQ
	GGR9zlFkz6xDYNULekPuVGDHofMJpmTk5cKmEIdNIKtOjWY8mcyefNedht9BxdFA
	GwaxD2wBq8I3HMxKwiZx7MgAfvHpUxepHlSkI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E71FD498C0;
	Sat, 25 Apr 2015 12:47:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6FF16498BF;
	Sat, 25 Apr 2015 12:47:52 -0400 (EDT)
In-Reply-To: <1429952801-2646-3-git-send-email-erik.elfstrom@gmail.com>
 ("Erik
	=?utf-8?Q?Elfstr=C3=B6m=22's?= message of "Sat, 25 Apr 2015 11:06:38
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D07A7486-EB6A-11E4-A88F-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267793>

Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com> writes:

> read_gitfile_gently will allocate a buffer to fit the entire file tha=
t
> should be read. Add a sanity check of the file size before opening to
> avoid allocating a potentially huge amount of memory if we come acros=
s
> a large file that someone happened to name ".git". The limit is set t=
o
> a sufficiently unreasonable size that should never be exceeded by a
> genuine .git file.
>
> Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
> ---
>
> I'm not sure about this one but it felt like the safe thing to do.
> This patch can be dropped if it is not desired.

I do not think it is wrong per-se, but the changes in this patch
shows why hardcoded values assigned to error_code without #define is
not a good idea, as these values are now exposed to the callers of
the new function.  After we gain a new caller that does care about
the exact error code (e.g. to react differently to the reason why we
failed to read by giving different error messages) if we decide to
revert this step, or if we decide to add a new error type, for
whatever reason, this organization forces the caller to be updated.

> I considered testing it using
>  "mkdir foo && truncate -s 200G foo/.git && git clean -f -d"
> but that feels like a pretty evil test that is likely to cause lots
> of problems and not fail in any good way.

Amen to that.

>
>  setup.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/setup.c b/setup.c
> index e1897cc..ed87334 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -364,22 +364,26 @@ const char *read_gitfile_gently(const char *pat=
h, int *return_error_code)
>  		error_code =3D 3;
>  		goto cleanup_return;
>  	}
> +	if (st.st_size > PATH_MAX * 4) {
> +		error_code =3D 4;
> +		goto cleanup_return;
> +	}
>  	buf =3D xmalloc(st.st_size + 1);
>  	len =3D read_in_full(fd, buf, st.st_size);
>  	close(fd);
>  	if (len !=3D st.st_size) {
> -		error_code =3D 4;
> +		error_code =3D 5;
>  		goto cleanup_return;
>  	}
>  	buf[len] =3D '\0';
>  	if (!starts_with(buf, "gitdir: ")) {
> -		error_code =3D 5;
> +		error_code =3D 6;
>  		goto cleanup_return;
>  	}
>  	while (buf[len - 1] =3D=3D '\n' || buf[len - 1] =3D=3D '\r')
>  		len--;
>  	if (len < 9) {
> -		error_code =3D 6;
> +		error_code =3D 7;
>  		goto cleanup_return;
>  	}
>  	buf[len] =3D '\0';
> @@ -397,7 +401,7 @@ const char *read_gitfile_gently(const char *path,=
 int *return_error_code)
>  	}
> =20
>  	if (!is_git_directory(dir)) {
> -		error_code =3D 7;
> +		error_code =3D 8;
>  		goto cleanup_return;
>  	}
>  	path =3D real_path(dir);
> @@ -419,12 +423,14 @@ cleanup_return:
>  		case 3:
>  			die_errno("Error opening '%s'", path);
>  		case 4:
> -			die("Error reading %s", path);
> +			die("Too large to be a .git file: '%s'", path);
>  		case 5:
> -			die("Invalid gitfile format: %s", path);
> +			die("Error reading %s", path);
>  		case 6:
> -			die("No path in gitfile: %s", path);
> +			die("Invalid gitfile format: %s", path);
>  		case 7:
> +			die("No path in gitfile: %s", path);
> +		case 8:
>  			die("Not a git repository: %s", dir);
>  		default:
>  			assert(0);
