From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 31/38] sha1_file.c: make use of decode_varint()
Date: Thu, 5 Sep 2013 09:35:52 +0200
Message-ID: <20130905073552.GD28959@goldbirke>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
 <1378362001-1738-32-git-send-email-nico@fluxnic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 05 09:36:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHU6h-0006qn-PW
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 09:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757821Ab3IEHf4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Sep 2013 03:35:56 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:63311 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756452Ab3IEHfz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 03:35:55 -0400
Received: from localhost6.localdomain6 (84-236-67-158.pool.digikabel.hu [84.236.67.158])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0Ls9Wx-1VzO1m10KV-013z4j; Thu, 05 Sep 2013 09:35:53 +0200
Content-Disposition: inline
In-Reply-To: <1378362001-1738-32-git-send-email-nico@fluxnic.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:ONDpECqdCgvdQW78vjyI/wb//vb9FQkU6YlF4zUySya
 bCGepfwj9BHnJgkZZ0Zz5Y3lQhSnkop6PJJPfMlKdk17vQQGhm
 Ksxf+F3jdpqBP+CZYJaJtdHgYvUwyyCTkFIEJaGn1eW9kh1VUp
 DlWpzrhR+uvOZD6o57fGsTk7kW0O1QEYKknP8M8DEvgzc5Uz1c
 AV0g5asFMARwwxCPkEVvr0YoYPVq+iJFB9WuYJb7izVdxhSr0x
 ClmikFy106GWUNZKKDCe4EL2X3DrirZgLV5dEIExovdlZAodMq
 cvIH/S5IKFZZmZAyRlvAH6cqJA54dlnxdcNw/0p4FOxDJKI/+S
 6NkraZ9CGQvhr+V1FNs8nGBMf47GsFIv7JvWn0S/g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233937>

On Thu, Sep 05, 2013 at 02:19:54AM -0400, Nicolas Pitre wrote:
> ... replacing the equivalent open coded loop.
>=20
> Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
> ---
>  sha1_file.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
>=20
> diff --git a/sha1_file.c b/sha1_file.c
> index a298933..67eb903 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1687,20 +1687,12 @@ static off_t get_delta_base(struct packed_git=
 *p,
>  	 * is stupid, as then a REF_DELTA would be smaller to store.
>  	 */
>  	if (type =3D=3D OBJ_OFS_DELTA) {
> -		unsigned used =3D 0;
> -		unsigned char c =3D base_info[used++];
> -		base_offset =3D c & 127;
> -		while (c & 128) {
> -			base_offset +=3D 1;
> -			if (!base_offset || MSB(base_offset, 7))
> -				return 0;  /* overflow */
> -			c =3D base_info[used++];
> -			base_offset =3D (base_offset << 7) + (c & 127);
> -		}
> +		const unsigned char *cp =3D base_info;
> +		base_offset =3D decode_varint(&cp);
>  		base_offset =3D delta_obj_offset - base_offset;
>  		if (base_offset <=3D 0 || base_offset >=3D delta_obj_offset)
>  			return 0;  /* out of bound */
> -		*curpos +=3D used;
> +		*curpos +=3D cp - base_info;
>  	} else if (type =3D=3D OBJ_REF_DELTA) {
>  		/* The base entry _must_ be in the same pack */
>  		base_offset =3D find_pack_entry_one(base_info, p);
> --=20
> 1.8.4.38.g317e65b

This patch seems to be a cleanup independent from pack v4, it applies
cleanly on master and passes all tests in itself.

Best,
G=E1bor
