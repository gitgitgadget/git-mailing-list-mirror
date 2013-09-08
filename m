From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 08/12] index-pack: parse v4 tree format
Date: Sat, 07 Sep 2013 22:52:05 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309072240230.20709@syhkavp.arg>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
 <1378550599-25365-1-git-send-email-pclouds@gmail.com>
 <1378550599-25365-9-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_tzWz6fYSMD77IIcZna2CPg)"
Cc: git@vger.kernel.org
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 04:52:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIV6v-0000GN-Dk
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 04:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727Ab3IHCwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 22:52:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:43739 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563Ab3IHCwG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 22:52:06 -0400
Received: from xanadu.home ([70.83.209.44]) by VL-VM-MR001.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSS0027YDATBB20@VL-VM-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 07 Sep 2013 22:52:05 -0400 (EDT)
In-reply-to: <1378550599-25365-9-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234165>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_tzWz6fYSMD77IIcZna2CPg)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Sat, 7 Sep 2013, Nguyễn Thái Ngọc Duy wrote:

> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  builtin/index-pack.c | 104 +++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 100 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 210b78d..51ca64b 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -319,6 +319,21 @@ static const unsigned char *read_sha1ref(void)
>  	return sha1_table + index * 20;
>  }
>  
> +static const unsigned char *read_sha1table_ref(void)
> +{
> +	const unsigned char *sha1 = read_sha1ref();
> +	if (sha1 < sha1_table || sha1 >= sha1_table + nr_objects * 20) {
> +		unsigned char *found;
> +		found = bsearch(sha1, sha1_table, nr_objects, 20,
> +				(int (*)(const void *, const void *))hashcmp);
> +		if (!found)
> +			bad_object(consumed_bytes,
> +				   _("SHA-1 %s not found in SHA-1 table"),
> +				   sha1_to_hex(sha1));
> +	}
> +	return sha1;
> +}
> +
>  static const unsigned char *read_dictref(struct packv4_dict *dict)
>  {
>  	unsigned int index = read_varint();
> @@ -561,17 +576,93 @@ static void *unpack_commit_v4(unsigned int offset,
>  	return dst.buf;
>  }
>  
> -static void *unpack_entry_data(unsigned long offset, unsigned long size,
> -			       enum object_type type, unsigned char *sha1)
> +/*
> + * v4 trees are actually kind of deltas and we don't do delta in the
> + * first pass. This function only walks through a tree object to find
> + * the end offset, register object dependencies and performs limited
> + * validation.
> + */
> +static void *unpack_tree_v4(struct object_entry *obj,
> +			    unsigned int offset, unsigned long size,
> +			    unsigned char *sha1)
> +{
> +	unsigned int nr = read_varint();
> +	const unsigned char *last_base = NULL;
> +	struct strbuf sb = STRBUF_INIT;
> +	while (nr) {
> +		unsigned int copy_start_or_path = read_varint();
> +		if (copy_start_or_path & 1) { /* copy_start */
> +			unsigned int copy_count = read_varint();
> +			if (copy_count & 1) { /* first delta */
> +				last_base = read_sha1table_ref();
> +			} else if (!last_base)
> +				bad_object(offset,
> +					   _("bad copy count index in unpack_tree_v4"));

Here the error message could be a little more explicit i.e. "missing 
delta base" or the like in order to distinguish from the next error.

> +			copy_count >>= 1;
> +			if (!copy_count)
> +				bad_object(offset,
> +					   _("bad copy count index in unpack_tree_v4"));
> +			nr -= copy_count;

Also make sure copy_count <= nr here.

> +		} else {	/* path */
> +			unsigned int path_idx = copy_start_or_path >> 1;
> +			const unsigned char *entry_sha1;
> +
> +			if (path_idx >= path_dict->nb_entries)
> +				bad_object(offset,
> +					   _("bad path index in unpack_tree_v4"));
> +			entry_sha1 = read_sha1ref();
> +			nr--;
> +
> +			if (!last_base) {

I've been confused for a while here by the use of last_base in the non 
delta path.  A comment indicating why this used here might be helpful to 
those unfamiliar with the format.

> +				const unsigned char *path;
> +				unsigned mode;
> +
> +				path = path_dict->data + path_dict->offsets[path_idx];
> +				mode = (path[0] << 8) | path[1];
> +				strbuf_addf(&sb, "%o %s%c", mode, path+2, '\0');
> +				strbuf_add(&sb, entry_sha1, 20);
> +				if (sb.len > size)
> +					bad_object(offset,
> +						   _("tree larger than expected"));
> +			}
> +		}
> +	}
> +
> +	if (last_base) {
> +		strbuf_release(&sb);
> +		return NULL;
> +	} else {
> +		git_SHA_CTX ctx;
> +		char hdr[32];
> +		int hdrlen;
> +
> +		if (sb.len != size)
> +			bad_object(offset, _("tree size mismatch"));
> +
> +		hdrlen = sprintf(hdr, "tree %lu", size) + 1;
> +		git_SHA1_Init(&ctx);
> +		git_SHA1_Update(&ctx, hdr, hdrlen);
> +		git_SHA1_Update(&ctx, sb.buf, size);
> +		git_SHA1_Final(sha1, &ctx);
> +		return strbuf_detach(&sb, NULL);
> +	}
> +}
> +
> +static void *unpack_entry_data(struct object_entry *obj, unsigned char *sha1)
>  {
>  	static char fixed_buf[8192];
>  	void *buf;
>  	git_SHA_CTX c;
>  	char hdr[32];
>  	int hdrlen;
> +	unsigned long offset = obj->idx.offset;
> +	unsigned long size = obj->size;
> +	enum object_type type = obj->type;
>  
>  	if (type == OBJ_PV4_COMMIT)
>  		return unpack_commit_v4(offset, size, sha1);
> +	if (type == OBJ_PV4_TREE)
> +		return unpack_tree_v4(obj, offset, size, sha1);
>  
>  	if (!is_delta_type(type)) {
>  		hdrlen = sprintf(hdr, "%s %lu", typename(type), size) + 1;
> @@ -640,16 +731,19 @@ static void *unpack_raw_entry(struct object_entry *obj,
>  	case OBJ_BLOB:
>  	case OBJ_TAG:
>  		break;
> -
>  	case OBJ_PV4_COMMIT:
>  		obj->real_type = OBJ_COMMIT;
>  		break;
> +	case OBJ_PV4_TREE:
> +		obj->real_type = OBJ_TREE;
> +		break;
> +
>  	default:
>  		bad_object(obj->idx.offset, _("unknown object type %d"), obj->type);
>  	}
>  	obj->hdr_size = consumed_bytes - obj->idx.offset;
>  
> -	data = unpack_entry_data(obj->idx.offset, obj->size, obj->type, sha1);
> +	data = unpack_entry_data(obj, sha1);
>  	obj->idx.crc32 = input_crc32;
>  	return data;
>  }
> @@ -1186,6 +1280,8 @@ static void parse_pack_objects(unsigned char *sha1)
>  			nr_deltas++;
>  			delta->obj_no = i;
>  			delta++;
> +		} else if (!data && obj->type == OBJ_PV4_TREE) {
> +			/* delay sha1_object() until second pass */
>  		} else if (!data) {
>  			/* large blobs, check later */
>  			obj->real_type = OBJ_BAD;
> -- 
> 1.8.2.83.gc99314b
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

--Boundary_(ID_tzWz6fYSMD77IIcZna2CPg)--
