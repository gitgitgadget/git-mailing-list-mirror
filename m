From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/19] dir.c: optionally compute sha-1 of a .gitignore file
Date: Mon, 27 Oct 2014 15:46:03 -0700
Message-ID: <xmqq7fzl5dxw.fsf@gitster.dls.corp.google.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
	<1414411846-4450-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 23:46:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xit3G-0006jC-Pq
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 23:46:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbaJ0WqK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Oct 2014 18:46:10 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55261 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752136AbaJ0WqI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Oct 2014 18:46:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 68A291A62F;
	Mon, 27 Oct 2014 18:46:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=OBA3rW2Et+5R
	7lNQ/d3eeRAujKE=; b=tRPWfBq2O9+WLgBpsMyRh30+ZLt82yWcgOZhSQLTGODp
	5QWSSTXF1QB49LiCJJTEYsF94be/X6ra5u/jD8XgEH/F6MTjNxynxRBsFRL2NVTJ
	VFiM77zA9YVNAANsZ/2b6sKo0yHT0mdxz768LXUcs/QKk+90nOEZLv92l2hE3mg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pjRNyb
	8Ljoo6YUcIwVWQDF60mpnTZJ15WTk3Y2QkmlMVz3MZqrBhRTIzz2/c13WgTIJ9Vn
	51mg6OyNxkDqgQue7N7whcYhtQYJZoBti/Gk2oQ6cpHQh2y/JuieJxjldB8TLdn+
	f5EgDnpJVZkE9xUEX3d5/NIkWzNu41/HeC1is=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6027E1A62E;
	Mon, 27 Oct 2014 18:46:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D5F971A62D;
	Mon, 27 Oct 2014 18:46:04 -0400 (EDT)
In-Reply-To: <1414411846-4450-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 27
 Oct 2014 19:10:28 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 089A01EC-5E2B-11E4-93AC-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This is not used anywhere yet. But the goal is to compare quickly if =
a
> .gitignore file has changed when we have the SHA-1 of both old (cache=
d
> somewhere) and new (from index or a tree) versions.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  dir.c | 50 +++++++++++++++++++++++++++++++++++++++++++-------
>  dir.h |  5 +++++
>  2 files changed, 48 insertions(+), 7 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index bd274a7..33a35c1 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -466,7 +466,8 @@ void add_exclude(const char *string, const char *=
base,
>  	x->el =3D el;
>  }
> =20
> -static void *read_skip_worktree_file_from_index(const char *path, si=
ze_t *size)
> +static void *read_skip_worktree_file_from_index(const char *path, si=
ze_t *size,
> +						struct sha1_stat *ss)
>  {
>  	int pos, len;
>  	unsigned long sz;
> @@ -485,6 +486,10 @@ static void *read_skip_worktree_file_from_index(=
const char *path, size_t *size)
>  		return NULL;
>  	}
>  	*size =3D xsize_t(sz);
> +	if (ss) {
> +		memset(&ss->stat, 0, sizeof(ss->stat));
> +		hashcpy(ss->sha1, active_cache[pos]->sha1);
> +	}
>  	return data;
>  }
> =20
> @@ -529,11 +534,18 @@ static void trim_trailing_spaces(char *buf)
>  		*last_space =3D '\0';
>  }
> =20
> -int add_excludes_from_file_to_list(const char *fname,
> -				   const char *base,
> -				   int baselen,
> -				   struct exclude_list *el,
> -				   int check_index)
> +/*
> + * Given a file with name "fname", read it (either from disk, or fro=
m
> + * the index if "check_index" is non-zero), parse it and store the
> + * exclude rules in "el".
> + *
> + * If "ss" is not NULL, compute SHA-1 of the exclude file and fill
> + * stat data from disk (only valid if add_excludes returns zero). If
> + * ss_valid is non-zero, "ss" must contain good value as input.
> + */

Hmm, do we want a separate parameter for that?  Wouldn't it be
sufficient and cleaner to pass is_null_sha1(ss->sha1[]), or
alternatively have an element ss->valid that is initialized to
false?

That is...

> @@ -571,6 +587,19 @@ int add_excludes_from_file_to_list(const char *f=
name,
>  		}
>  		buf[size++] =3D '\n';
>  		close(fd);
> +		if (ss) {
> +			int pos;
> +			if (ss_valid && !match_stat_data(&ss->stat, &st))

s/ss_valid/ss->valid/;

> +				; /* no content change, ss->sha1 still good */
> +			else if (check_index &&
> +				 (pos =3D cache_name_pos(fname, strlen(fname))) >=3D 0 &&
> +				 !ce_stage(active_cache[pos]) &&
> +				 ce_uptodate(active_cache[pos]))
> +				hashcpy(ss->sha1, active_cache[pos]->sha1);
> +			else
> +				hash_sha1_file(buf, size, "blob", ss->sha1);
> +			fill_stat_data(&ss->stat, &st);

And toggle "ss->valid =3D 1"; here...

> @@ -589,6 +618,13 @@ int add_excludes_from_file_to_list(const char *f=
name,
>  	return 0;
>  }
> =20
> +int add_excludes_from_file_to_list(const char *fname, const char *ba=
se,
> +				   int baselen, struct exclude_list *el,
> +				   int check_index)
> +{
> +	return add_excludes(fname, base, baselen, el, check_index, NULL, 0)=
;
> +}
> +
>  struct exclude_list *add_exclude_list(struct dir_struct *dir,
>  				      int group_type, const char *src)
>  {
> diff --git a/dir.h b/dir.h
> index 6c45e9d..032d197 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -73,6 +73,11 @@ struct exclude_list_group {
>  	struct exclude_list *el;
>  };
> =20
> +struct sha1_stat {
> +	struct stat_data stat;
> +	unsigned char sha1[20];
> +};
> +
>  struct dir_struct {
>  	int nr, alloc;
>  	int ignored_nr, ignored_alloc;
