From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] index-helper: use watchman to avoid refreshing index with
 lstat()
Date: Fri, 13 May 2016 21:17:49 +0100
Message-ID: <5736366D.6080706@ramsayjones.plus.com>
References: <57350D7F.5030006@ramsayjones.plus.com>
 <1463164054-15342-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Fri May 13 22:17:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1JX4-00048S-AJ
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 22:17:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbcEMURy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 May 2016 16:17:54 -0400
Received: from avasout07.plus.net ([84.93.230.235]:38035 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932211AbcEMURx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 16:17:53 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout07 with smtp
	id twHo1s0062D2Veb01wHpVw; Fri, 13 May 2016 21:17:50 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=pGLkceISAAAA:8 a=8vuQ4NNQVP-xEmDly-sA:9 a=QEXdDO2ut3YA:10
 a=6kGIvZw6iX1k4Y-7sg4_:22
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <1463164054-15342-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294574>



On 13/05/16 19:27, David Turner wrote:
> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
[snip]

> +
> +static void reply_to_poke(int client_fd, const char *pid_buf)
> +{
> +	char *capabilities;
> +	struct strbuf sb =3D STRBUF_INIT;
> +
> +#ifdef USE_WATCHMAN
> +	pid_t client_pid =3D strtoull(pid_buf, NULL, 10);
> +
> +	prepare_index(client_pid);
> +#endif
> +	capabilities =3D strchr(pid_buf, ' ');

So, if the pid is *not* followed by a space, the capabilities
will be NULL here, and ...

> +
> +	if (!strcmp(capabilities, " watchman"))

=2E.. we segfault here.

> +#ifdef USE_WATCHMAN
> +		packet_buf_write(&sb, "OK watchman");
> +#else
> +		packet_buf_write(&sb, "NAK watchman");
> +#endif
> +	else
> +		packet_buf_write(&sb, "OK");
> +	if (write_in_full(client_fd, sb.buf, sb.len) !=3D sb.len)
> +		warning(_("client write failed"));
> +}
> +
>  static void loop(int fd, int idle_in_seconds)
>  {
>  	assert(idle_in_seconds < INT_MAX / 1000);
> @@ -252,11 +341,15 @@ static void loop(int fd, int idle_in_seconds)
>  			buf[bytes_read] =3D 0;
>  			if (!strcmp(buf, "refresh")) {
>  				refresh();
> -			} else if (!strcmp(buf, "poke")) {
> -				/*
> -				 * Just a poke to keep us
> -				 * alive, nothing to do.
> -				 */
> +			} else if (starts_with(buf, "poke")) {
> +				if (buf[4] =3D=3D ' ') {
> +					reply_to_poke(client_fd, buf + 5);
> +				} else {
> +					/*
> +					 * Just a poke to keep us
> +					 * alive, nothing to do.
> +					 */
> +				}
>  			} else {
>  				warning("BUG: Bogus command %s", buf);
>  			}
> diff --git a/read-cache.c b/read-cache.c
> index 1719f5a..8ec4be3 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1235,7 +1235,7 @@ int refresh_index(struct index_state *istate, u=
nsigned int flags,
>  		if (!new) {
>  			const char *fmt;
> =20
> -			if (really && cache_errno =3D=3D EINVAL) {
> +			if (really || cache_errno =3D=3D EINVAL) {
>  				/* If we are doing --really-refresh that
>  				 * means the index is not valid anymore.
>  				 */
> @@ -1375,11 +1375,75 @@ static int verify_hdr(const struct cache_head=
er *hdr, unsigned long size)
>  	return 0;
>  }
> =20
> +static struct untracked_cache_dir *find_untracked_cache_dir(
> +	struct untracked_cache *uc, struct untracked_cache_dir *ucd,
> +	const char *name)
> +{
> +	int component_len;
> +	const char *end;
> +	struct untracked_cache_dir *dir;
> +
> +	if (!*name)
> +		return ucd;
> +
> +	end =3D strchr(name, '/');
> +	if (end)
> +		component_len =3D end - name;
> +	else
> +		component_len =3D strlen(name);
> +
> +	dir =3D lookup_untracked(uc, ucd, name, component_len);
> +	if (dir)
> +		return find_untracked_cache_dir(uc, dir, name + component_len + 1)=
;
> +
> +	return NULL;
> +}
> +
>  static void mark_no_watchman(size_t pos, void *data)
>  {
>  	struct index_state *istate =3D data;
> +	struct cache_entry *ce =3D istate->cache[pos];
> +	struct strbuf sb =3D STRBUF_INIT;
> +	char *c;
> +	struct untracked_cache_dir *dir;
> +
>  	assert(pos < istate->cache_nr);
> -	istate->cache[pos]->ce_flags |=3D CE_WATCHMAN_DIRTY;
> +	ce->ce_flags |=3D CE_WATCHMAN_DIRTY;
> +
> +	if (!istate->untracked || !istate->untracked->root)
> +		return;
> +
> +	strbuf_add(&sb, ce->name, ce_namelen(ce));
> +
> +	for (c =3D sb.buf + sb.len - 1; c > sb.buf; c--) {
> +		if (*c =3D=3D '/') {
> +			strbuf_setlen(&sb, c - sb.buf);
> +			break;
> +		}
> +	}
> +
> +	if (c =3D=3D sb.buf)
> +		strbuf_setlen(&sb, 0);
> +
> +	dir =3D find_untracked_cache_dir(istate->untracked,
> +				       istate->untracked->root, sb.buf);
> +	if (dir)
> +		dir->valid =3D 0;
> +
> +	strbuf_release(&sb);
> +}
> +
> +static int mark_untracked_invalid(struct string_list_item *item, voi=
d *uc)
> +{
> +	struct untracked_cache *untracked =3D uc;
> +	struct untracked_cache_dir *dir;
> +
> +	dir =3D find_untracked_cache_dir(untracked, untracked->root,
> +				       item->string);
> +	if (dir)
> +		dir->valid =3D 0;
> +
> +	return 0;
>  }
> =20
>  static int read_watchman_ext(struct index_state *istate, const void =
*data,
> @@ -1409,10 +1473,24 @@ static int read_watchman_ext(struct index_sta=
te *istate, const void *data,
>  	ewah_each_bit(bitmap, mark_no_watchman, istate);
>  	ewah_free(bitmap);
> =20
> -	/*
> -	 * TODO: update the untracked cache from the untracked data in this
> -	 * extension.
> -	 */
> +	if (istate->untracked && istate->untracked->root) {
> +		int i;
> +		const char *untracked;
> +
> +		untracked =3D (const char *)data + len + 8 + bitmap_size;
> +		for (i =3D 0; i < untracked_nr; ++i) {
> +			int len =3D strlen(untracked);
> +			string_list_append(&istate->untracked->invalid_untracked,
> +					   untracked);
> +			untracked +=3D len + 1;
> +		}
> +
> +		for_each_string_list(&istate->untracked->invalid_untracked,
> +			 mark_untracked_invalid, istate->untracked);
> +
> +		if (untracked_nr)
> +			istate->cache_changed |=3D WATCHMAN_CHANGED;
> +	}
>  	return 0;
>  }
> =20
> @@ -1645,29 +1723,88 @@ static void post_read_index_from(struct index=
_state *istate)
>  	tweak_untracked_cache(istate);
>  }
> =20
> +/* in ms */
> +#define WATCHMAN_TIMEOUT 1000
> +
> +static int poke_and_wait_for_reply(int fd)
> +{
> +	int ret =3D -1;
> +	struct pollfd pollfd;
> +	int bytes_read;
> +	char reply_buf[4096];
> +	const char *requested_capabilities =3D "";
> +
> +#ifdef USE_WATCHMAN
> +	requested_capabilities =3D "watchman";
> +#endif
> +
> +	if (fd < 0)
> +		return -1;
> +
> +	if (packet_write_gently(fd, "poke %d %s", getpid(), requested_capab=
ilities))

So, adding the empty capabilities (and more importantly the
separating space) is not so much 'doesn't hurt', rather than=20
'prevents a core-dump!' ;-)

> +		return -1;
> +	if (packet_flush_gently(fd))
> +		return -1;

And yes, I'd forgotten about the 'maybe sometime in the future, we
could buffer the packets' ...

ATB,
Ramsay Jones
