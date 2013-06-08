From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v3 2/2] read-cache: plug a few leaks
Date: Sat, 08 Jun 2013 13:32:33 +0200
Message-ID: <51B31651.6020307@lsrfire.ath.cx>
References: <1370644168-4745-1-git-send-email-felipe.contreras@gmail.com> <1370644168-4745-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Adam Spiers <git@adamspiers.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 13:32:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlHNz-0007rw-Bx
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 13:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752366Ab3FHLcj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Jun 2013 07:32:39 -0400
Received: from india601.server4you.de ([85.25.151.105]:58934 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367Ab3FHLci (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 07:32:38 -0400
Received: from [192.168.2.105] (p579BEA5D.dip0.t-ipconnect.de [87.155.234.93])
	by india601.server4you.de (Postfix) with ESMTPSA id 7590E17D;
	Sat,  8 Jun 2013 13:32:36 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <1370644168-4745-3-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226802>

Am 08.06.2013 00:29, schrieb Felipe Contreras:
> We are not freeing 'istate->cache' properly.
>
> We can't rely on 'initialized' to keep track of the 'istate->cache',
> because it doesn't really mean it's initialized. So assume it always =
has
> data, and free it before overwriting it.

That sounds a bit backwards to me.  If ->initialized doesn't mean that=20
the index state is initialized then something is fishy.  Would it make=20
sense and be sufficient to set ->initialized in add_index_entry?  Or to=
=20
get rid of it and check for ->cache_alloc instead?

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>   read-cache.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/read-cache.c b/read-cache.c
> index 5e30746..a1dd04d 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1451,6 +1451,7 @@ int read_index_from(struct index_state *istate,=
 const char *path)
>   	istate->version =3D ntohl(hdr->hdr_version);
>   	istate->cache_nr =3D ntohl(hdr->hdr_entries);
>   	istate->cache_alloc =3D alloc_nr(istate->cache_nr);
> +	free(istate->cache);
>   	istate->cache =3D xcalloc(istate->cache_alloc, sizeof(*istate->cac=
he));
>   	istate->initialized =3D 1;

You wrote earlier that this change is safe with current callers and tha=
t=20
it prevents leaks with the following sequence:

discard_cache();
# add entries
read_cache();

Do we currently have such a call sequence somewhere?  Wouldn't that be =
a=20
bug, namely forgetting to call discard_cache before read_cache?

I've added a "assert(istate->cache_nr =3D=3D 0);" a few lines above and=
 the=20
test suite still passed.  With the hunk below, ->cache is also always=20
NULL and cache_alloc is always 0 at that point.  So we don't need that=20
free call there in the cases covered by the test suite at least --=20
better leave it out.

> @@ -1512,6 +1513,9 @@ int discard_index(struct index_state *istate)
>
>   	for (i =3D 0; i < istate->cache_nr; i++)
>   		free(istate->cache[i]);
> +	free(istate->cache);
> +	istate->cache =3D NULL;
> +	istate->cache_alloc =3D 0;
>   	resolve_undo_clear_index(istate);
>   	istate->cache_nr =3D 0;
>   	istate->cache_changed =3D 0;

I still like this part, but also would still recommend to remove the no=
w=20
doubly-outdated comment a few lines below that says "no need to throw=20
away allocated active_cache".  It was valid back when there was only a=20
single in-memory instance of the index and no istate parameter.

Ren=C3=A9
