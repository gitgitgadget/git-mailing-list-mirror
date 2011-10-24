From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] read-cache.c: fix index memory allocation
Date: Mon, 24 Oct 2011 17:52:57 +0200
Message-ID: <4EA589D9.2000402@lsrfire.ath.cx>
References: <4EA20C5B.3090808@gmail.com> <vpqfwiknmh3.fsf@bauges.imag.fr> <4EA3D1BB.2010802@gmail.com> <4EA415BD.1040109@lsrfire.ath.cx> <20111023162944.GB28156@sigill.intra.peff.net> <4EA453D3.7080002@lsrfire.ath.cx> <4EA4B8E7.5070106@lsrfire.ath.cx> <7vaa8q4zm9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, John Hsing <tsyj2007@gmail.com>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 24 17:53:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIMpt-0004gS-HD
	for gcvg-git-2@lo.gmane.org; Mon, 24 Oct 2011 17:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932906Ab1JXPxI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Oct 2011 11:53:08 -0400
Received: from india601.server4you.de ([85.25.151.105]:60177 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932804Ab1JXPxH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2011 11:53:07 -0400
Received: from [192.168.2.104] (p4FFD8D85.dip.t-dialin.net [79.253.141.133])
	by india601.server4you.de (Postfix) with ESMTPSA id 179132F8038;
	Mon, 24 Oct 2011 17:53:05 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <7vaa8q4zm9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184175>

Am 24.10.2011 09:28, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>>  t/t7510-status-index.sh |   50 ++++++++++++++++++++++++++++++++++++=
+++++++++++
>>  2 files changed, 53 insertions(+), 3 deletions(-)
>>  create mode 100755 t/t7510-status-index.sh
>=20
>> diff --git a/t/t7510-status-index.sh b/t/t7510-status-index.sh
>> new file mode 100755
>> index 0000000..bca359d
>> --- /dev/null
>> +++ b/t/t7510-status-index.sh
>> @@ -0,0 +1,50 @@
>=20
> Hmm, I cannot seem to make this fail this test without the fix on my
> Fedora 14 i686 VM when applied to v1.7.6.4 (estimation code originate=
s
> cf55870 back in v1.7.6.1 days), but it does break on 'master'.

Err, yes, I forgot to mention in the commit message that on my test
system the breakage occurs only after 2548183ba, "fix phantom untracked
files when core.ignorecase is set", which adds the pointer dir_next to
struct cache_entry.  This seems to have caused an unlucky constellation
of offsets and struct sizes for the size estimator.

> By the way, I'll move this to 7511.
>=20
> Also would a patch like this help?

Only a little, I suspect.  If we've moved past the end then it's too
late.  And if we catch the error before it happens, dying is only
slightly better than crashing.

> -- >8 --
> Subject: [PATCH] read_index(): die on estimation error
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  read-cache.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
>=20
> diff --git a/read-cache.c b/read-cache.c
> index 0a64103..2926615 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1270,6 +1270,7 @@ int read_index_from(struct index_state *istate,=
 const char *path)
>  	int fd, i;
>  	struct stat st;
>  	unsigned long src_offset, dst_offset;
> +	size_t bulk_alloc_size;
>  	struct cache_header *hdr;
>  	void *mmap;
>  	size_t mmap_size;
> @@ -1315,7 +1316,8 @@ int read_index_from(struct index_state *istate,=
 const char *path)
>  	 * has room for a few  more flags, we can allocate using the same
>  	 * index size
>  	 */
> -	istate->alloc =3D xmalloc(estimate_cache_size(mmap_size, istate->ca=
che_nr));
> +	bulk_alloc_size =3D estimate_cache_size(mmap_size, istate->cache_nr=
);
> +	istate->alloc =3D xmalloc(bulk_alloc_size);
>  	istate->initialized =3D 1;
> =20
>  	src_offset =3D sizeof(*hdr);
> @@ -1331,7 +1333,9 @@ int read_index_from(struct index_state *istate,=
 const char *path)
> =20
>  		src_offset +=3D ondisk_ce_size(ce);
>  		dst_offset +=3D ce_size(ce);
> +		if (bulk_alloc_size <=3D dst_offset)
> +			die("cache size estimation error");
>  	}
>  	istate->timestamp.sec =3D st.st_mtime;
>  	istate->timestamp.nsec =3D ST_MTIME_NSEC(st);
> =20
