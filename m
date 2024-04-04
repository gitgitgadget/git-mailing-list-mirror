Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C0A13C3D1
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 21:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712266187; cv=none; b=RvpvjNlNZ+vlej3Zpy9E9HXZipOuK5AjBhvQzcvdR2lCdy+tkxw0QpbGg0a8B6V6kygs6JmJUwatEw2VM9fBSlEx1OntY9cOhydlA1ijShpakb5s5c4sj+UzjBDKrQIgodwg7FX6SYnYsNpRjuUELRoUf1XIOoujpcjiRpzzwdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712266187; c=relaxed/simple;
	bh=MHPrRD8EyDvGigXcHorUfx4TzWOrXgnRYd/1KuTx8Ds=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jt2kUwTvYiWzqm0KZkKBets2i/wB8dWcIv5MZA2103nbze4Ybw1Lb1zF7h3WHAyICW03rHnVH0zl/Pb0V/rYhvo1rVKyt3omE/8VUB17CqRq2K5WSLaywxh7C4npYKBaMz4K5joyJiqkgh4+kmNPvfL3j9GL49PWu/PF0uwvr0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dl5WOI1W; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dl5WOI1W"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B33F61F7485;
	Thu,  4 Apr 2024 17:29:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=MHPrRD8EyDvG
	igXcHorUfx4TzWOrXgnRYd/1KuTx8Ds=; b=dl5WOI1WxqDIbJhjbiovsnVhdpST
	spUp3tdd1RZnv3oBdJKsMfu902VFZrUGOSpMSQKi6YVv8fwzMw5aPuMFZynywBKR
	+EEfLFgYTaNyBRtjebC7esfzdT5NuyFGUIrcaAK7A4KjZsLAGJ536W9k3gDs0d5W
	dB9tOqW+zHwZeKI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AB0A61F7484;
	Thu,  4 Apr 2024 17:29:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 087031F7483;
	Thu,  4 Apr 2024 17:29:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH] apply: replace mksnpath() with a mkpathdup() call
In-Reply-To: <df774306-f29b-4a75-a282-59db89812b9a@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Thu, 4 Apr 2024 23:08:38 +0200")
References: <df774306-f29b-4a75-a282-59db89812b9a@web.de>
Date: Thu, 04 Apr 2024 14:29:42 -0700
Message-ID: <xmqqo7aozuih.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 741E860C-F2CA-11EE-A44C-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Support paths longer than PATH_MAX in create_one_file() (which is not a
> hard limit e.g. on Linux) by calling mkpathdup() instead of mksnpath().
> Remove the latter, as it becomes unused by this change.  Resist the
> temptation of using the more convenient mkpath() to avoid introducing a
> dependency on a static variable deep inside the apply machinery.
>
> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  apply.c | 13 +++++++++----
>  path.c  | 17 -----------------
>  path.h  |  6 ------
>  3 files changed, 9 insertions(+), 27 deletions(-)

As a patch to "apply", this is perfectly good, but in the larger
picture, the value of the patch is in getting rid of mksnpath, isn't
it?

I am tempted to

 - queue it on rs/retire-mksnpath topic branch

 - remove the mention of mksnpath in contrib/vscode/init.sh (I think
   it is registering non-words to spell checker, so having an extra
   entry there would not hurt, but it would more likely to be a typo
   of mkpath than before this patch retires mksnpath function).

 - ask you to come up with a title with more focus on mksnpath than
   on apply.

Thanks.

> diff --git a/apply.c b/apply.c
> index 432837a674..4793b05f3d 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -4502,17 +4502,22 @@ static int create_one_file(struct apply_state *=
state,
>  		unsigned int nr =3D getpid();
>
>  		for (;;) {
> -			char newpath[PATH_MAX];
> -			mksnpath(newpath, sizeof(newpath), "%s~%u", path, nr);
> +			char *newpath =3D mkpathdup("%s~%u", path, nr);
>  			res =3D try_create_file(state, newpath, mode, buf, size);
> -			if (res < 0)
> +			if (res < 0) {
> +				free(newpath);
>  				return -1;
> +			}
>  			if (!res) {
> -				if (!rename(newpath, path))
> +				if (!rename(newpath, path)) {
> +					free(newpath);
>  					return 0;
> +				}
>  				unlink_or_warn(newpath);
> +				free(newpath);
>  				break;
>  			}
> +			free(newpath);
>  			if (errno !=3D EEXIST)
>  				break;
>  			++nr;
> diff --git a/path.c b/path.c
> index 8bb223c92c..67229edb9c 100644
> --- a/path.c
> +++ b/path.c
> @@ -28,8 +28,6 @@ static int get_st_mode_bits(const char *path, int *mo=
de)
>  	return 0;
>  }
>
> -static char bad_path[] =3D "/bad-path/";
> -
>  static struct strbuf *get_pathname(void)
>  {
>  	static struct strbuf pathname_array[4] =3D {
> @@ -59,21 +57,6 @@ static void strbuf_cleanup_path(struct strbuf *sb)
>  		strbuf_remove(sb, 0, path - sb->buf);
>  }
>
> -char *mksnpath(char *buf, size_t n, const char *fmt, ...)
> -{
> -	va_list args;
> -	unsigned len;
> -
> -	va_start(args, fmt);
> -	len =3D vsnprintf(buf, n, fmt, args);
> -	va_end(args);
> -	if (len >=3D n) {
> -		strlcpy(buf, bad_path, n);
> -		return buf;
> -	}
> -	return (char *)cleanup_path(buf);
> -}
> -
>  static int dir_prefix(const char *buf, const char *dir)
>  {
>  	int len =3D strlen(dir);
> diff --git a/path.h b/path.h
> index e053effef2..ea96487b29 100644
> --- a/path.h
> +++ b/path.h
> @@ -23,12 +23,6 @@ const char *mkpath(const char *fmt, ...)
>  char *mkpathdup(const char *fmt, ...)
>  	__attribute__((format (printf, 1, 2)));
>
> -/*
> - * Construct a path and place the result in the provided buffer `buf`.
> - */
> -char *mksnpath(char *buf, size_t n, const char *fmt, ...)
> -	__attribute__((format (printf, 3, 4)));
> -
>  /*
>   * The `git_common_path` family of functions will construct a path int=
o a
>   * repository's common git directory, which is shared by all worktrees=
.
> --
> 2.44.0
