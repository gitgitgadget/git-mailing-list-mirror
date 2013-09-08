From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 05/11] pack-write.c: add pv4_encode_in_pack_object_header
Date: Sun, 08 Sep 2013 16:51:06 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309081638060.20709@syhkavp.arg>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
 <1378652660-6731-1-git-send-email-pclouds@gmail.com>
 <1378652660-6731-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_fNkcvfQw+eti3SN8dRIrBw)"
Cc: git@vger.kernel.org
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 22:51:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIlwv-0004dc-S8
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 22:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236Ab3IHUvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 16:51:09 -0400
Received: from relais.videotron.ca ([24.201.245.36]:10120 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211Ab3IHUvI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 16:51:08 -0400
Received: from xanadu.home ([70.83.209.44]) by VL-VM-MR005.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MST00JUDR96F820@VL-VM-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 08 Sep 2013 16:51:06 -0400 (EDT)
In-reply-to: <1378652660-6731-6-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234262>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_fNkcvfQw+eti3SN8dRIrBw)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Sun, 8 Sep 2013, Nguyễn Thái Ngọc Duy wrote:

> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  pack-write.c | 29 +++++++++++++++++++++++++++++
>  pack.h       |  1 +
>  2 files changed, 30 insertions(+)
> 
> diff --git a/pack-write.c b/pack-write.c
> index 88e4788..6f11104 100644
> --- a/pack-write.c
> +++ b/pack-write.c
> @@ -1,6 +1,7 @@
>  #include "cache.h"
>  #include "pack.h"
>  #include "csum-file.h"
> +#include "varint.h"
>  
>  void reset_pack_idx_option(struct pack_idx_option *opts)
>  {
> @@ -340,6 +341,34 @@ int encode_in_pack_object_header(enum object_type type, uintmax_t size, unsigned
>  	return n;
>  }
>  
> +/*
> + * The per-object header is a pretty dense thing, which is
> + *  - first byte: low four bits are "size", then three bits of "type",
> + *    and the high bit is "size continues".
> + *  - each byte afterwards: low seven bits are size continuation,
> + *    with the high bit being "size continues"
> + */

This comment is a bit misleading.  It looks almost like the pack v2 
object header encoding which is not a varint encoded value like this one 
is.

> +int pv4_encode_in_pack_object_header(enum object_type type,
> +				     uintmax_t size, unsigned char *hdr)

Could we have a somewhat shorter function name? 
pv4_encode_object_header() should be acceptable given "pv4" already 
implies a pack.

> +{
> +	uintmax_t val;
> +	if (type < OBJ_COMMIT || type > OBJ_PV4_TREE || type == OBJ_OFS_DELTA)
> +		die("bad type %d", type);

This test has holes, such as types 5 and 8.

I think this would be better as:

	switch (type) {
	case OBJ_COMMIT:
	case OBJ_TREE:
	case OBJ_BLOB:
	case OBJ_TAG:
	case OBJ_REF_DELTA:
	case OBJ_PV4_COMMIT:
	case OBJ_PV4_TREE:
		break;
	default:
		die("bad type %d", type);
	}

The compiler ought to be smart enough to optimize the contiguous case 
range.  And that makes it explicit and obvious what we test for.

> +
> +	/*
> +	 * We allocate 4 bits in the LSB for the object type which
> +	 * should be good for quite a while, given that we effectively
> +	 * encodes only 5 object types: commit, tree, blob, delta,
> +	 * tag.
> +	 */
> +	val = size;
> +	if (MSB(val, 4))
> +		die("fixme: the code doesn't currently cope with big sizes");
> +	val <<= 4;
> +	val |= type;
> +	return encode_varint(val, hdr);
> +}
> +
>  struct sha1file *create_tmp_packfile(char **pack_tmp_name)
>  {
>  	char tmpname[PATH_MAX];
> diff --git a/pack.h b/pack.h
> index 855f6c6..38f869d 100644
> --- a/pack.h
> +++ b/pack.h
> @@ -83,6 +83,7 @@ extern off_t write_pack_header(struct sha1file *f, int, uint32_t);
>  extern void fixup_pack_header_footer(int, unsigned char *, const char *, uint32_t, unsigned char *, off_t);
>  extern char *index_pack_lockfile(int fd);
>  extern int encode_in_pack_object_header(enum object_type, uintmax_t, unsigned char *);
> +extern int pv4_encode_in_pack_object_header(enum object_type, uintmax_t, unsigned char *);
>  
>  #define PH_ERROR_EOF		(-1)
>  #define PH_ERROR_PACK_SIGNATURE	(-2)
> -- 
> 1.8.2.83.gc99314b
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

--Boundary_(ID_fNkcvfQw+eti3SN8dRIrBw)--
