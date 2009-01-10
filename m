From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH/RFC v5 1/1] more cache effective symlink/directory detection
Date: Sat, 10 Jan 2009 11:11:12 +0100
Message-ID: <49687440.5090506@lsrfire.ath.cx>
References: <1231527954-868-1-git-send-email-barvik@broadpark.no> <1231527954-868-2-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Pete Harlan <pgit@pcharlan.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Sat Jan 10 11:12:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLapg-0006ie-1t
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 11:12:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426AbZAJKLU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Jan 2009 05:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753166AbZAJKLU
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 05:11:20 -0500
Received: from india601.server4you.de ([85.25.151.105]:46934 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152AbZAJKLS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 05:11:18 -0500
Received: from [10.0.1.101] (p57B7E561.dip.t-dialin.net [87.183.229.97])
	by india601.server4you.de (Postfix) with ESMTPSA id DA1672F8042;
	Sat, 10 Jan 2009 11:11:16 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <1231527954-868-2-git-send-email-barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105081>

Kjetil Barvik schrieb:
> - Also introduce a 'void clear_lstat_cache(void)' function, which
>   should be used to clean the cache before usage.  If for instance,
>   you have changed the types of directories which should be cached,
>   the cache could contain a path which was not wanted.

Is it possible to make the cache detect these situations automatically
by saving track_flags along with the cache contents?  Not having to
clear the cache manually would be a major feature.

> --- a/cache.h
> +++ b/cache.h
> @@ -719,7 +719,29 @@ struct checkout {
>  };
> =20
>  extern int checkout_entry(struct cache_entry *ce, const struct check=
out *state, char *topath);
> -extern int has_symlink_leading_path(int len, const char *name);
> +
> +#define LSTAT_REG      (1u << 0)
> +#define LSTAT_DIR      (1u << 1)
> +#define LSTAT_NOENT    (1u << 2)
> +#define LSTAT_SYMLINK  (1u << 3)
> +#define LSTAT_LSTATERR (1u << 4)
> +#define LSTAT_ERR      (1u << 5)
> +#define LSTAT_FULLPATH (1u << 6)
> +extern unsigned int lstat_cache(int len, const char *name,
> +				unsigned int track_flags, int prefix_len_stat_func);
> +extern void clear_lstat_cache(void);
> +static inline unsigned int has_symlink_leading_path(int len, const c=
har *name)
> +{
> +	return lstat_cache(len, name, LSTAT_SYMLINK|LSTAT_DIR, -1) &
> +		LSTAT_SYMLINK;
> +}
> +#define clear_symlink_cache() clear_lstat_cache()
> +static inline unsigned int has_symlink_or_noent_leading_path(int len=
, const char *name)
> +{
> +	return lstat_cache(len, name, LSTAT_SYMLINK|LSTAT_NOENT|LSTAT_DIR, =
-1) &
> +		(LSTAT_SYMLINK|LSTAT_NOENT);
> +}
> +#define clear_symlink_or_noent_cache() clear_lstat_cache()

What's the advantage of inlining the wrappers (expressed in units of
space and/or time)?  The interface would be much nicer if you exported
the wrappers, only, and not all those constants along with them.

And why define aliases for clear_lstat_cache()?

> diff --git a/entry.c b/entry.c
> index aa2ee46a84033585d8e07a585610c5a697af82c2..293400cf5be63fd66b797=
a68e17bf953c600fe99 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -8,35 +8,28 @@ static void create_directories(const char *path, co=
nst struct checkout *state)
>  	const char *slash =3D path;
> =20
>  	while ((slash =3D strchr(slash+1, '/')) !=3D NULL) {
> -		struct stat st;
> -		int stat_status;
> -
>  		len =3D slash - path;
>  		memcpy(buf, path, len);
>  		buf[len] =3D 0;
> =20
> -		if (len <=3D state->base_dir_len)
> -			/*
> -			 * checkout-index --prefix=3D<dir>; <dir> is
> -			 * allowed to be a symlink to an existing
> -			 * directory.
> -			 */
> -			stat_status =3D stat(buf, &st);
> -		else
> -			/*
> -			 * if there currently is a symlink, we would
> -			 * want to replace it with a real directory.
> -			 */
> -			stat_status =3D lstat(buf, &st);
> -
> -		if (!stat_status && S_ISDIR(st.st_mode))
> +		/* For 'checkout-index --prefix=3D<dir>', <dir> is
> +		 * allowed to be a symlink to an existing directory,
> +		 * therefore we must give 'state->base_dir_len' to the
> +		 * cache, such that we test path components of the
> +		 * prefix with stat() instead of lstat()
> +		 *
> +		 * We must also tell the cache to test the complete
> +		 * length of the buffer (the '|LSTAT_FULLPATH' part).
> +		 */
> +		if (lstat_cache(len, buf, LSTAT_DIR|LSTAT_FULLPATH,
> +				state->base_dir_len) &
> +		    LSTAT_DIR)
>  			continue; /* ok, it is already a directory. */

I'd say this usage is worth another wrapper.

Also, it's probably worth to split this patch up again.  First switchin=
g
to your improved implementation of has_symlink_leading_path(), then
introducing has_symlink_or_noent_leading_path() and finally adding
LSTAT_FULLPATH and the fourth parameter of lstat_cache() etc. and using
this feature in entry.c seems like a nice incremental progression.

Ren=E9
