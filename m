From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 12/12] index-pack: resolve v4 one-base trees
Date: Sat, 07 Sep 2013 23:28:07 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309072312090.20709@syhkavp.arg>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
 <1378550599-25365-1-git-send-email-pclouds@gmail.com>
 <1378550599-25365-13-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_wCNGakhwhFQ7x13knzwr7A)"
Cc: git@vger.kernel.org
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 05:28:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIVfb-0005ql-QB
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 05:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754803Ab3IHD2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 23:28:10 -0400
Received: from relais.videotron.ca ([24.201.245.36]:65152 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934Ab3IHD2I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 23:28:08 -0400
Received: from xanadu.home ([70.83.209.44]) by VL-VM-MR002.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSS00AU1EYV5O00@VL-VM-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 07 Sep 2013 23:28:07 -0400 (EDT)
In-reply-to: <1378550599-25365-13-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234169>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_wCNGakhwhFQ7x13knzwr7A)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Sat, 7 Sep 2013, Nguyễn Thái Ngọc Duy wrote:

> This is the most common case for delta trees. In fact it's the only
> kind that's produced by packv4-create. It fits well in the way
> index-pack resolves deltas and benefits from threading (the set of
> objects depending on this base does not overlap with the set of
> objects depending on another base)
> 
> Multi-base trees will be probably processed differently.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  builtin/index-pack.c | 194 ++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 178 insertions(+), 16 deletions(-)
> 
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 1fa74f4..4a24bc3 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -12,6 +12,8 @@
>  #include "streaming.h"
>  #include "thread-utils.h"
>  #include "packv4-parse.h"
> +#include "varint.h"
> +#include "tree-walk.h"
>  
>  static const char index_pack_usage[] =
>  "git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--verify] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
> @@ -38,8 +40,8 @@ struct base_data {
>  	struct object_entry *obj;
>  	void *data;
>  	unsigned long size;
> -	int ref_first, ref_last;
> -	int ofs_first, ofs_last;
> +	int ref_first, ref_last, tree_first;
> +	int ofs_first, ofs_last, tree_last;
>  };
>  
>  #if !defined(NO_PTHREADS) && defined(NO_THREAD_SAFE_PREAD)
> @@ -437,6 +439,7 @@ static struct base_data *alloc_base_data(void)
>  	memset(base, 0, sizeof(*base));
>  	base->ref_last = -1;
>  	base->ofs_last = -1;
> +	base->tree_last = -1;
>  	return base;
>  }
>  
> @@ -670,6 +673,8 @@ static void *unpack_tree_v4(struct object_entry *obj,
>  	}
>  
>  	if (last_base) {
> +		if (nr_deltas - delta_start > 1)
> +			die("sorry guys, multi-base trees are not supported yet");
>  		strbuf_release(&sb);
>  		return NULL;
>  	} else {
> @@ -794,6 +799,83 @@ static void *unpack_raw_entry(struct object_entry *obj,
>  	return data;
>  }
>  
> +static void *patch_one_base_tree(const struct object_entry *src,
> +				 const unsigned char *src_buf,
> +				 const unsigned char *delta_buf,
> +				 unsigned long delta_size,
> +				 unsigned long *dst_size)
> +{
> +	unsigned int nr;
> +	const unsigned char *last_base = NULL;
> +	struct strbuf sb = STRBUF_INIT;
> +	const unsigned char *p = delta_buf;
> +
> +	nr = decode_varint(&p);
> +	while (nr && p < delta_buf + delta_size) {
> +		unsigned int copy_start_or_path = decode_varint(&p);
> +		if (copy_start_or_path & 1) { /* copy_start */
> +			struct tree_desc desc;
> +			struct name_entry entry;
> +			unsigned int copy_count = decode_varint(&p);
> +			unsigned int copy_start = copy_start_or_path >> 1;
> +			if (!src)
> +				die("we are not supposed to copy from another tree!");
> +			if (copy_count & 1) { /* first delta */
> +				unsigned int id = decode_varint(&p);
> +				if (!id) {
> +					last_base = p;
> +					p += 20;
> +				} else
> +					last_base = sha1_table + (id - 1) * 20;
> +				if (hashcmp(last_base, src->idx.sha1))
> +					die(_("bad tree base in patch_one_base_tree"));
> +			} else if (!last_base)
> +				die(_("bad copy count index in patch_one_base_tree"));
> +			copy_count >>= 1;
> +			if (!copy_count)
> +				die(_("bad copy count index in patch_one_base_tree"));
> +			nr -= copy_count;
> +
> +			init_tree_desc(&desc, src_buf, src->size);
> +			while (tree_entry(&desc, &entry)) {
> +				if (copy_start)
> +					copy_start--;
> +				else if (copy_count) {
> +					strbuf_addf(&sb, "%o %s%c", entry.mode, entry.path, '\0');
> +					strbuf_add(&sb, entry.sha1, 20);
> +					copy_count--;
> +				} else
> +					break;
> +			}
> +		} else {	/* path */
> +			unsigned int path_idx = copy_start_or_path >> 1;
> +			const unsigned char *path;
> +			unsigned mode;
> +			unsigned int id;
> +			const unsigned char *entry_sha1;
> +
> +			if (path_idx >= path_dict->nb_entries)
> +				die(_("bad path index in unpack_tree_v4"));
> +			id = decode_varint(&p);
> +			if (!id) {
> +				entry_sha1 = p;
> +				p += 20;
> +			} else
> +				entry_sha1 = sha1_table + (id - 1) * 20;

You should verify that id doesn't overflow the sha1 table here.
Similarly in other places.


Nicolas

--Boundary_(ID_wCNGakhwhFQ7x13knzwr7A)--
