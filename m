From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH/WIP v2 05/14] read-cache: put some limits on file watching
Date: Sun, 19 Jan 2014 18:06:03 +0100
Message-ID: <87ha8zewas.fsf@thomasrast.ch>
References: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
	<1389952060-12297-1-git-send-email-pclouds@gmail.com>
	<1389952060-12297-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 19 18:06:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4vp7-0003tz-I4
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jan 2014 18:06:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbaASRGJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Jan 2014 12:06:09 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:53176 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751668AbaASRGI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jan 2014 12:06:08 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 979EB4D6572;
	Sun, 19 Jan 2014 18:06:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ekWV_kLCZ4dP; Sun, 19 Jan 2014 18:06:04 +0100 (CET)
Received: from linux-1gf2.thomasrast.ch (unknown [213.55.184.196])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 3E9BB4D64BD;
	Sun, 19 Jan 2014 18:06:04 +0100 (CET)
In-Reply-To: <1389952060-12297-6-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 17
 Jan 2014 16:47:31 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240695>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> watch_entries() is a lot of computation and could trigger a lot more
> lookups in file-watcher. Normally after the first set of watches are
> in place, we do not need to update often. Moreover if the number of
> entries is small, the overhead of file watcher may actually slow git
> down.
>
> This patch only allows to update watches if the number of watchable
> files is over a limit (and there are new files added if this is not
> the first time). Measurements on Core i5-2520M and Linux 3.7.6, about
> 920 lstat() take 1ms. Somewhere between 2^16 and 2^17 lstat calls tha=
t
> it starts to take longer than 100ms. 2^16 is chosen at the minimum
> limit to start using file watcher.
>
> Recently updated files are not considered watchable because they are
> likely to be updated again soon, not worth the ping-pong game with
> file watcher. The default limit 30min is just a random value.

But then a fresh clone of a big repository would not get any benefit
from the watcher?

Not yet sure how to best handle this.

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/config.txt |  9 +++++++++
>  cache.h                  |  1 +
>  read-cache.c             | 44 ++++++++++++++++++++++++++++++++++++--=
------
>  3 files changed, 46 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index a405806..e394399 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1038,6 +1038,15 @@ difftool.<tool>.cmd::
>  difftool.prompt::
>  	Prompt before each invocation of the diff tool.
> =20
> +filewatcher.minfiles::
> +	Start watching files if the number of watchable files are
> +	above this limit. Default value is 65536.
> +
> +filewatcher.recentlimit::
> +	Files that are last updated within filewatcher.recentlimit
> +	seconds from now are not considered watchable. Default value
> +	is 1800 (30 minutes).
> +
>  fetch.recurseSubmodules::
>  	This option can be either set to a boolean value or to 'on-demand'.
>  	Setting it to a boolean changes the behavior of fetch and pull to
> diff --git a/cache.h b/cache.h
> index 0d55551..bcec29b 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -278,6 +278,7 @@ struct index_state {
>  	struct cache_tree *cache_tree;
>  	struct cache_time timestamp;
>  	unsigned name_hash_initialized : 1,
> +		 update_watches : 1,
>  		 initialized : 1;
>  	struct hashmap name_hash;
>  	struct hashmap dir_hash;
> diff --git a/read-cache.c b/read-cache.c
> index 21c3207..406834a 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -38,6 +38,8 @@ static struct cache_entry *refresh_cache_entry(stru=
ct cache_entry *ce, int reall
>  #define CACHE_EXT_WATCH 0x57415443	  /* "WATC" */
> =20
>  struct index_state the_index;
> +static int watch_lowerlimit =3D 65536;
> +static int recent_limit =3D 1800;
> =20
>  static void set_index_entry(struct index_state *istate, int nr, stru=
ct cache_entry *ce)
>  {
> @@ -1014,6 +1016,7 @@ int add_index_entry(struct index_state *istate,=
 struct cache_entry *ce, int opti
>  			(istate->cache_nr - pos - 1) * sizeof(ce));
>  	set_index_entry(istate, pos, ce);
>  	istate->cache_changed =3D 1;
> +	istate->update_watches =3D 1;
>  	return 0;
>  }
> =20
> @@ -1300,13 +1303,14 @@ static void read_watch_extension(struct index=
_state *istate, uint8_t *data,
>  				 unsigned long sz)
>  {
>  	int i;
> -	if ((istate->cache_nr + 7) / 8 !=3D sz) {
> +	if ((istate->cache_nr + 7) / 8 + 1 !=3D sz) {
>  		error("invalid 'WATC' extension");
>  		return;
>  	}
>  	for (i =3D 0; i < istate->cache_nr; i++)
>  		if (data[i / 8] & (1 << (i % 8)))
>  			istate->cache[i]->ce_flags |=3D CE_WATCHED;
> +	istate->update_watches =3D data[sz - 1];
>  }
> =20
>  static int read_index_extension(struct index_state *istate,
> @@ -1449,6 +1453,19 @@ static struct cache_entry *create_from_disk(st=
ruct ondisk_cache_entry *ondisk,
>  	return ce;
>  }
> =20
> +static int watcher_config(const char *var, const char *value, void *=
data)
> +{
> +	if (!strcmp(var, "filewatcher.minfiles")) {
> +		watch_lowerlimit =3D git_config_int(var, value);
> +		return 0;
> +	}
> +	if (!strcmp(var, "filewatcher.recentlimit")) {
> +		recent_limit =3D git_config_int(var, value);
> +		return 0;
> +	}
> +	return 0;
> +}
> +
>  static void validate_watcher(struct index_state *istate, const char =
*path)
>  {
>  	int i;
> @@ -1458,6 +1475,7 @@ static void validate_watcher(struct index_state=
 *istate, const char *path)
>  		return;
>  	}
> =20
> +	git_config(watcher_config, NULL);
>  	istate->watcher =3D connect_watcher(path);
>  	if (istate->watcher !=3D -1) {
>  		struct strbuf sb =3D STRBUF_INIT;
> @@ -1478,6 +1496,7 @@ static void validate_watcher(struct index_state=
 *istate, const char *path)
>  			istate->cache[i]->ce_flags &=3D ~CE_WATCHED;
>  			istate->cache_changed =3D 1;
>  		}
> +	istate->update_watches =3D 1;
>  }
> =20
>  static int sort_by_date(const void *a_, const void *b_)
> @@ -1524,7 +1543,7 @@ static int do_watch_entries(struct index_state =
*istate,
>  	return 0;
>  }
> =20
> -static inline int ce_watchable(struct cache_entry *ce)
> +static inline int ce_watchable(struct cache_entry *ce, time_t now)
>  {
>  	return ce_uptodate(ce) && /* write_index will catch late ce_uptodat=
e bits */
>  		!(ce->ce_flags & CE_WATCHED) &&
> @@ -1534,7 +1553,8 @@ static inline int ce_watchable(struct cache_ent=
ry *ce)
>  		 * obviously. S_IFLNK could be problematic because
>  		 * inotify may follow symlinks without IN_DONT_FOLLOW
>  		 */
> -		S_ISREG(ce->ce_mode);
> +		S_ISREG(ce->ce_mode) &&
> +		(ce->ce_stat_data.sd_mtime.sec + recent_limit < now);
>  }
> =20
>  static void watch_entries(struct index_state *istate)
> @@ -1544,15 +1564,20 @@ static void watch_entries(struct index_state =
*istate)
>  	struct strbuf sb =3D STRBUF_INIT;
>  	int val;
>  	socklen_t vallen =3D sizeof(val);
> +	time_t now =3D time(NULL);
> =20
> -	if (istate->watcher <=3D 0)
> +	if (istate->watcher <=3D 0 || !istate->update_watches)
>  		return;
> +	istate->update_watches =3D 0;
> +	istate->cache_changed =3D 1;
>  	for (i =3D nr =3D 0; i < istate->cache_nr; i++)
> -		if (ce_watchable(istate->cache[i]))
> +		if (ce_watchable(istate->cache[i], now))
>  			nr++;
> +	if (nr < watch_lowerlimit)
> +		return;
>  	sorted =3D xmalloc(sizeof(*sorted) * nr);
>  	for (i =3D nr =3D 0; i < istate->cache_nr; i++)
> -		if (ce_watchable(istate->cache[i]))
> +		if (ce_watchable(istate->cache[i], now))
>  			sorted[nr++] =3D istate->cache[i];
> =20
>  	getsockopt(istate->watcher, SOL_SOCKET, SO_SNDBUF, &val, &vallen);
> @@ -1616,6 +1641,7 @@ int read_index_from(struct index_state *istate,=
 const char *path)
>  	istate->cache_alloc =3D alloc_nr(istate->cache_nr);
>  	istate->cache =3D xcalloc(istate->cache_alloc, sizeof(*istate->cach=
e));
>  	istate->initialized =3D 1;
> +	istate->update_watches =3D 1;
> =20
>  	if (istate->version =3D=3D 4)
>  		previous_name =3D &previous_name_buf;
> @@ -2024,8 +2050,9 @@ int write_index(struct index_state *istate, int=
 newfd)
>  		if (err)
>  			return -1;
>  	}
> -	if (has_watches) {
> -		int id, sz =3D (entries - removed + 7) / 8;
> +	if (has_watches ||
> +	    (istate->watcher !=3D -1 && !istate->update_watches)) {
> +		int id, sz =3D (entries - removed + 7) / 8 + 1;
>  		uint8_t *data =3D xmalloc(sz);
>  		memset(data, 0, sz);
>  		for (i =3D 0, id =3D 0; i < entries && has_watches; i++) {
> @@ -2038,6 +2065,7 @@ int write_index(struct index_state *istate, int=
 newfd)
>  			}
>  			id++;
>  		}
> +		data[sz - 1] =3D istate->update_watches;
>  		err =3D write_index_ext_header(&c, newfd, CACHE_EXT_WATCH, sz) < 0
>  			|| ce_write(&c, newfd, data, sz) < 0;
>  		free(data);

--=20
Thomas Rast
tr@thomasrast.ch
