From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] read-cache.c: fix index memory allocation
Date: Mon, 24 Oct 2011 00:28:46 -0700
Message-ID: <7vaa8q4zm9.fsf@alter.siamese.dyndns.org>
References: <4EA20C5B.3090808@gmail.com> <vpqfwiknmh3.fsf@bauges.imag.fr>
 <4EA3D1BB.2010802@gmail.com> <4EA415BD.1040109@lsrfire.ath.cx>
 <20111023162944.GB28156@sigill.intra.peff.net>
 <4EA453D3.7080002@lsrfire.ath.cx> <4EA4B8E7.5070106@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, John Hsing <tsyj2007@gmail.com>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Oct 24 09:28:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIExr-0006zw-IG
	for gcvg-git-2@lo.gmane.org; Mon, 24 Oct 2011 09:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436Ab1JXH2u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Oct 2011 03:28:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50506 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753326Ab1JXH2t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Oct 2011 03:28:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 024B22CB7;
	Mon, 24 Oct 2011 03:28:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=iGUU5fX/wH6u
	LFw+ku4yMfqdLFI=; b=suTR7vb1PlsNuq/QvKQGnHiWoKJ7dahqGNfxIDRNM9ta
	/rcWMA7biBVb9GfuXuvo05ia79Da8Nr7gY+PQisLwPBR6bmzUBCvMUKAoyf7/Ztr
	ACVS1bsYCuZmwyGlSPcV50/1vXR3srCoKl7PxN77w5vPffs9w8P3lemuNZxfKHc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=PokWpt
	t3nxZ2UZ9bzdVda54cUrxwyV4U0j5jnAmamkVF6XhdA+h7e3iGkl+ad9e6Uzk7Em
	PWQT0a2Kh3vPNfgn6IHwZufwKze+12rPLpHqWuoeSyq9/HeWGpjOd+5N0vDA+TE2
	ZTgUSQL8Bi3gx2IUQhvJjCo/MqBAhaXPPojsg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDEE02CB6;
	Mon, 24 Oct 2011 03:28:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6ACC22CB5; Mon, 24 Oct 2011
 03:28:48 -0400 (EDT)
In-Reply-To: <4EA4B8E7.5070106@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Mon, 24 Oct 2011 03:01:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D058B76E-FE11-11E0-9308-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184167>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

>  t/t7510-status-index.sh |   50 +++++++++++++++++++++++++++++++++++++=
++++++++++
>  2 files changed, 53 insertions(+), 3 deletions(-)
>  create mode 100755 t/t7510-status-index.sh

> diff --git a/t/t7510-status-index.sh b/t/t7510-status-index.sh
> new file mode 100755
> index 0000000..bca359d
> --- /dev/null
> +++ b/t/t7510-status-index.sh
> @@ -0,0 +1,50 @@

Hmm, I cannot seem to make this fail this test without the fix on my
=46edora 14 i686 VM when applied to v1.7.6.4 (estimation code originate=
s
cf55870 back in v1.7.6.1 days), but it does break on 'master'.

By the way, I'll move this to 7511.

Also would a patch like this help?

-- >8 --
Subject: [PATCH] read_index(): die on estimation error

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 read-cache.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 0a64103..2926615 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1270,6 +1270,7 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 	int fd, i;
 	struct stat st;
 	unsigned long src_offset, dst_offset;
+	size_t bulk_alloc_size;
 	struct cache_header *hdr;
 	void *mmap;
 	size_t mmap_size;
@@ -1315,7 +1316,8 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 	 * has room for a few  more flags, we can allocate using the same
 	 * index size
 	 */
-	istate->alloc =3D xmalloc(estimate_cache_size(mmap_size, istate->cach=
e_nr));
+	bulk_alloc_size =3D estimate_cache_size(mmap_size, istate->cache_nr);
+	istate->alloc =3D xmalloc(bulk_alloc_size);
 	istate->initialized =3D 1;
=20
 	src_offset =3D sizeof(*hdr);
@@ -1331,7 +1333,9 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
=20
 		src_offset +=3D ondisk_ce_size(ce);
 		dst_offset +=3D ce_size(ce);
+		if (bulk_alloc_size <=3D dst_offset)
+			die("cache size estimation error");
 	}
 	istate->timestamp.sec =3D st.st_mtime;
 	istate->timestamp.nsec =3D ST_MTIME_NSEC(st);
=20
--=20
1.7.7.1.504.gcc718
