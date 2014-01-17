From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH/WIP v2 02/14] read-cache: new extension to mark what file is watched
Date: Fri, 17 Jan 2014 12:19:05 +0100
Message-ID: <87ha92c0uu.fsf@gmail.com>
References: <1389524622-6702-1-git-send-email-pclouds@gmail.com> <1389952060-12297-1-git-send-email-pclouds@gmail.com> <1389952060-12297-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 17 12:18:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W47Ry-00038F-B4
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 12:18:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbaAQLSt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Jan 2014 06:18:49 -0500
Received: from mail-ie0-f182.google.com ([209.85.223.182]:43480 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374AbaAQLSs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jan 2014 06:18:48 -0500
Received: by mail-ie0-f182.google.com with SMTP id as1so5349701iec.13
        for <git@vger.kernel.org>; Fri, 17 Jan 2014 03:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        bh=87+DTK9xUIU6m1uqHb3bhHnCL0gVw4BFrBimOeZ0Exc=;
        b=XMNjPK05uLHsNScSIt2CS8t4IgTbVQntOtc75O0LUbAEgDgbwGy5hlDwyIVnquKFR5
         vL5HIDMjmogQqxmQbj4MFE4fRKoktktp2UCUeMZDwYAzDg1YEJOi9ROzt15q2fFUIom/
         Gl8WaeEzM63uBVXQVBvaOyvRU4VruEMj8oSCaJghFN1Hk506lqe7kXi1MqbOOQJX3EX9
         s8Tg3G9jqtzI8ved9sBobgVRrWxswocE9A+vWPxXoe76Go+CeQWHhbXidKG+zZfY+O/a
         g4oZQDSGRKtKak50tJutjdzCiiuj97OHB68w7gynfIOOjpaM3cYB8RuO2+gt3pnXpIEw
         V6YQ==
X-Received: by 10.50.79.168 with SMTP id k8mr2200369igx.18.1389957527459;
        Fri, 17 Jan 2014 03:18:47 -0800 (PST)
Received: from localhost ([216.18.212.218])
        by mx.google.com with ESMTPSA id ml2sm2843223igb.10.2014.01.17.03.18.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jan 2014 03:18:46 -0800 (PST)
In-Reply-To: <1389952060-12297-3-git-send-email-pclouds@gmail.com>
User-Agent: Notmuch/0.17~rc1+8~g4a09c1a (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240593>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> If an entry is "watched", git lets an external program decide if the
> entry is modified or not. It's more like --assume-unchanged, but
> designed to be controlled by machine.
>
> We are running out of on-disk ce_flags, so instead of extending
> on-disk entry format again, "watched" flags are in-core only and
> stored as extension instead.

As you said yourself in http://thread.gmane.org/gmane.comp.version-cont=
rol.git/240339/focus=3D240385
this is not quite true.  As for your explanation there,

> Anyway using extended flags means 2 extra bytes per entry for
> almost every entry in this case (and for index v5 it means redoing
> crc32 for almost every entry too when the bit is updated) so it may
> still be a good idea to keep the new flag separate.

I don't think adding 2 extra bytes would be too bad, since we are
already using 62 bytes plus the bytes for the filename for each index
entry, so it would be a less than 3% increase in the index file size.
(And the extended flags may be used anyway in some cases)

As for index-v5 (if that's ever going to happen), it depends mostly on
how often the CE_WATCHED is going to be updated, to decide whether it
makes sense to store this as extension.

That said, I don't care too deeply if it's stored one way or another,
but I think it would be good to update the commit message with a better
rationale for the choice.

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  cache.h      |  2 ++
>  read-cache.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 42 insertions(+), 1 deletion(-)
>
> diff --git a/cache.h b/cache.h
> index a09d622..069dce7 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -168,6 +168,8 @@ struct cache_entry {
>  /* used to temporarily mark paths matched by pathspecs */
>  #define CE_MATCHED           (1 << 26)
>
> +#define CE_WATCHED           (1 << 27)
> +
>  /*
>   * Extended on-disk flags
>   */
> diff --git a/read-cache.c b/read-cache.c
> index fe1d153..6f21e3f 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -33,6 +33,7 @@ static struct cache_entry *refresh_cache_entry(stru=
ct cache_entry *ce, int reall
>  #define CACHE_EXT(s) ( (s[0]<<24)|(s[1]<<16)|(s[2]<<8)|(s[3]) )
>  #define CACHE_EXT_TREE 0x54524545	/* "TREE" */
>  #define CACHE_EXT_RESOLVE_UNDO 0x52455543 /* "REUC" */
> +#define CACHE_EXT_WATCH 0x57415443	  /* "WATC" */
>
>  struct index_state the_index;
>
> @@ -1293,6 +1294,19 @@ static int verify_hdr(struct cache_header *hdr=
,
>  	return 0;
>  }
>
> +static void read_watch_extension(struct index_state *istate, uint8_t=
 *data,
> +				 unsigned long sz)
> +{
> +	int i;
> +	if ((istate->cache_nr + 7) / 8 !=3D sz) {
> +		error("invalid 'WATC' extension");
> +		return;
> +	}
> +	for (i =3D 0; i < istate->cache_nr; i++)
> +		if (data[i / 8] & (1 << (i % 8)))
> +			istate->cache[i]->ce_flags |=3D CE_WATCHED;
> +}
> +
>  static int read_index_extension(struct index_state *istate,
>  				const char *ext, void *data, unsigned long sz)
>  {
> @@ -1303,6 +1317,9 @@ static int read_index_extension(struct index_st=
ate *istate,
>  	case CACHE_EXT_RESOLVE_UNDO:
>  		istate->resolve_undo =3D resolve_undo_read(data, sz);
>  		break;
> +	case CACHE_EXT_WATCH:
> +		read_watch_extension(istate, data, sz);
> +		break;
>  	default:
>  		if (*ext < 'A' || 'Z' < *ext)
>  			return error("index uses %.4s extension, which we do not understa=
nd",
> @@ -1781,7 +1798,7 @@ int write_index(struct index_state *istate, int=
 newfd)
>  {
>  	git_SHA_CTX c;
>  	struct cache_header hdr;
> -	int i, err, removed, extended, hdr_version;
> +	int i, err, removed, extended, hdr_version, has_watches =3D 0;
>  	struct cache_entry **cache =3D istate->cache;
>  	int entries =3D istate->cache_nr;
>  	struct stat st;
> @@ -1790,6 +1807,8 @@ int write_index(struct index_state *istate, int=
 newfd)
>  	for (i =3D removed =3D extended =3D 0; i < entries; i++) {
>  		if (cache[i]->ce_flags & CE_REMOVE)
>  			removed++;
> +		else if (cache[i]->ce_flags & CE_WATCHED)
> +			has_watches++;
>
>  		/* reduce extended entries if possible */
>  		cache[i]->ce_flags &=3D ~CE_EXTENDED;
> @@ -1861,6 +1880,26 @@ int write_index(struct index_state *istate, in=
t newfd)
>  		if (err)
>  			return -1;
>  	}
> +	if (has_watches) {
> +		int id, sz =3D (entries - removed + 7) / 8;
> +		uint8_t *data =3D xmalloc(sz);
> +		memset(data, 0, sz);
> +		for (i =3D 0, id =3D 0; i < entries && has_watches; i++) {
> +			struct cache_entry *ce =3D cache[i];
> +			if (ce->ce_flags & CE_REMOVE)
> +				continue;
> +			if (ce->ce_flags & CE_WATCHED) {
> +				data[id / 8] |=3D 1 << (id % 8);
> +				has_watches--;
> +			}
> +			id++;
> +		}
> +		err =3D write_index_ext_header(&c, newfd, CACHE_EXT_WATCH, sz) < 0
> +			|| ce_write(&c, newfd, data, sz) < 0;
> +		free(data);
> +		if (err)
> +			return -1;
> +	}
>
>  	if (ce_flush(&c, newfd) || fstat(newfd, &st))
>  		return -1;
> --
> 1.8.5.1.208.g05b12ea
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
Thomas
