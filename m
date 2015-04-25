From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/5] setup: add gentle version of read_gitfile
Date: Sat, 25 Apr 2015 09:51:45 -0700
Message-ID: <xmqq1tj8178e.fsf@gitster.dls.corp.google.com>
References: <1429952801-2646-1-git-send-email-erik.elfstrom@gmail.com>
	<1429952801-2646-2-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Erik =?utf-8?Q?Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 18:51:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ym3J5-0002ui-Ix
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 18:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460AbbDYQvu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Apr 2015 12:51:50 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52464 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964956AbbDYQvt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Apr 2015 12:51:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E591B4996E;
	Sat, 25 Apr 2015 12:51:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=rwENq+gzkm2w
	38vgNZEVTO5qwvI=; b=RP56XQyiXlNoLBG12Z9/3yYb6jIuK5Qd5kDWGpOdczlj
	f4s0jbRSAOPdrUyGXZHEfRWxwRtRVLtnT54/O1mjfTY5jTXnneKrQuYXEGRHE2Jo
	Kmq8ORr8co4TUHtj8aGDOO0pzypFM9bOM9WXz8EAfEKh2AC92E2Z+o3QB0Bt7k4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xqpFNP
	kdD1FMB3FciA6wK0zXxMxRNv2stWRaJ/S3tsnGnO80q6iakFsjXwh2QLLofQIY8P
	zDIsBjUhVJyhcxU9u4tKlXUAvT9gdJUyJ/kE8WqgB/dDSDuGFi8tix/OoW9gpgE7
	p3/wKCFo6G1izkkOzSNHU/dkT+jK2t4QDyE6I=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DDD8E4996D;
	Sat, 25 Apr 2015 12:51:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3309B4996C;
	Sat, 25 Apr 2015 12:51:47 -0400 (EDT)
In-Reply-To: <1429952801-2646-2-git-send-email-erik.elfstrom@gmail.com>
 ("Erik
	=?utf-8?Q?Elfstr=C3=B6m=22's?= message of "Sat, 25 Apr 2015 11:06:37
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5C670CDE-EB6B-11E4-86D6-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267794>

Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com> writes:

> read_gitfile will die on most error cases. This makes it unsuitable
> for speculative calls. Extract the core logic and provide a gentle
> version that returns NULL on failure.
>
> The first usecase of the new gentle version will be to probe for
> submodules during git clean.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
> ---
>  cache.h |  3 ++-
>  setup.c | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++----=
----------
>  2 files changed, 67 insertions(+), 18 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 3d3244b..6e29068 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -431,7 +431,8 @@ extern int set_git_dir(const char *path);
>  extern const char *get_git_namespace(void);
>  extern const char *strip_namespace(const char *namespaced_ref);
>  extern const char *get_git_work_tree(void);
> -extern const char *read_gitfile(const char *path);
> +extern const char *read_gitfile_gently(const char *path, int *return=
_error_code);
> +#define read_gitfile(path) read_gitfile_gently((path), NULL)
>  extern const char *resolve_gitdir(const char *suspect);
>  extern void set_git_work_tree(const char *tree);
> =20
> diff --git a/setup.c b/setup.c
> index 979b13f..e1897cc 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -335,35 +335,53 @@ static int check_repository_format_gently(const=
 char *gitdir, int *nongit_ok)
>  /*
>   * Try to read the location of the git directory from the .git file,
>   * return path to git directory if found.
> + *
> + * On failure, if return_error_code is not NULL, return_error_code
> + * will be set to an error code and NULL will be returned. If
> + * return_error_code is NULL the function will die instead (for most
> + * cases).
>   */
> -const char *read_gitfile(const char *path)
> +const char *read_gitfile_gently(const char *path, int *return_error_=
code)
>  {
> -	char *buf;
> -	char *dir;
> +	int error_code =3D 0;
> +	char *buf =3D NULL;
> +	char *dir =3D NULL;
>  	const char *slash;
>  	struct stat st;
>  	int fd;
>  	ssize_t len;
> =20
> -	if (stat(path, &st))
> -		return NULL;
> -	if (!S_ISREG(st.st_mode))
> -		return NULL;
> +	if (stat(path, &st)) {
> +		error_code =3D 1;
> +		goto cleanup_return;
> +	}
> +	if (!S_ISREG(st.st_mode)) {
> +		error_code =3D 2;
> +		goto cleanup_return;
> +	}
>  	fd =3D open(path, O_RDONLY);
> -	if (fd < 0)
> -		die_errno("Error opening '%s'", path);
> +	if (fd < 0) {
> +		error_code =3D 3;
> +		goto cleanup_return;
> +	}
>  	buf =3D xmalloc(st.st_size + 1);
>  	len =3D read_in_full(fd, buf, st.st_size);
>  	close(fd);
> -	if (len !=3D st.st_size)
> -		die("Error reading %s", path);
> +	if (len !=3D st.st_size) {
> +		error_code =3D 4;
> +		goto cleanup_return;
> +	}
>  	buf[len] =3D '\0';
> -	if (!starts_with(buf, "gitdir: "))
> -		die("Invalid gitfile format: %s", path);
> +	if (!starts_with(buf, "gitdir: ")) {
> +		error_code =3D 5;
> +		goto cleanup_return;
> +	}
>  	while (buf[len - 1] =3D=3D '\n' || buf[len - 1] =3D=3D '\r')
>  		len--;
> -	if (len < 9)
> -		die("No path in gitfile: %s", path);
> +	if (len < 9) {
> +		error_code =3D 6;
> +		goto cleanup_return;
> +	}
>  	buf[len] =3D '\0';
>  	dir =3D buf + 8;
> =20
> @@ -378,11 +396,41 @@ const char *read_gitfile(const char *path)
>  		buf =3D dir;
>  	}
> =20
> -	if (!is_git_directory(dir))
> -		die("Not a git repository: %s", dir);
> +	if (!is_git_directory(dir)) {
> +		error_code =3D 7;
> +		goto cleanup_return;
> +	}
>  	path =3D real_path(dir);
> =20
> +cleanup_return:
>  	free(buf);
> +
> +	if (return_error_code)
> +		*return_error_code =3D error_code;
> +
> +	if (error_code) {
> +		if (return_error_code)
> +			return NULL;
> +
> +		switch (error_code) {
> +		case 1: // failed to stat
> +		case 2: // not regular file

Please do not use C++ // comments.

> +			return NULL;
> +		case 3:
> +			die_errno("Error opening '%s'", path);
> +		case 4:
> +			die("Error reading %s", path);
> +		case 5:
> +			die("Invalid gitfile format: %s", path);
> +		case 6:
> +			die("No path in gitfile: %s", path);
> +		case 7:
> +			die("Not a git repository: %s", dir);
> +		default:
> +			assert(0);
> +		}
> +	}
> +
>  	return path;
>  }
