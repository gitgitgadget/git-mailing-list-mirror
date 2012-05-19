From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v2 3/4] pack-objects: refactor write_object()
Date: Fri, 18 May 2012 22:43:59 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1205182243180.13185@xanadu.home>
References: <1336818375-16895-1-git-send-email-pclouds@gmail.com>
 <1337169731-23416-1-git-send-email-pclouds@gmail.com>
 <1337169731-23416-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_o6RseUrxHmmaHCbIHfmu3A)"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 19 04:44:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVZeK-0003E8-Mh
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 04:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346Ab2ESCoD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 22:44:03 -0400
Received: from relais.videotron.ca ([24.201.245.36]:58106 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473Ab2ESCoB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 22:44:01 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR003.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0M49007CV0XBM910@VL-VM-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 18 May 2012 22:44:00 -0400 (EDT)
In-reply-to: <1337169731-23416-3-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198008>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_o6RseUrxHmmaHCbIHfmu3A)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Wed, 16 May 2012, Nguyễn Thái Ngọc Duy wrote:

> Move !to_reuse and to_reuse write code out into two separate functions
> and remove "goto no_reuse;" hack
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

I like this very much.

Acked-by: Nicolas Pitre <nico@fluxnic.net>


> ---
>  builtin/pack-objects.c |  322 ++++++++++++++++++++++++++----------------------
>  1 files changed, 172 insertions(+), 150 deletions(-)
> 
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index b2e0940..ccfcbad 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -200,22 +200,178 @@ static void copy_pack_data(struct sha1file *f,
>  }
>  
>  /* Return 0 if we will bust the pack-size limit */
> -static unsigned long write_object(struct sha1file *f,
> -				  struct object_entry *entry,
> -				  off_t write_offset)
> +static unsigned long write_no_reuse_object(struct sha1file *f, struct object_entry *entry,
> +					   unsigned long limit, int usable_delta)
>  {
> -	unsigned long size, limit, datalen;
> -	void *buf;
> +	unsigned long size, datalen;
>  	unsigned char header[10], dheader[10];
>  	unsigned hdrlen;
>  	enum object_type type;
> +	void *buf;
> +
> +	if (!usable_delta) {
> +		buf = read_sha1_file(entry->idx.sha1, &type, &size);
> +		if (!buf)
> +			die("unable to read %s", sha1_to_hex(entry->idx.sha1));
> +		/*
> +		 * make sure no cached delta data remains from a
> +		 * previous attempt before a pack split occurred.
> +		 */
> +		free(entry->delta_data);
> +		entry->delta_data = NULL;
> +		entry->z_delta_size = 0;
> +	} else if (entry->delta_data) {
> +		size = entry->delta_size;
> +		buf = entry->delta_data;
> +		entry->delta_data = NULL;
> +		type = (allow_ofs_delta && entry->delta->idx.offset) ?
> +			OBJ_OFS_DELTA : OBJ_REF_DELTA;
> +	} else {
> +		buf = get_delta(entry);
> +		size = entry->delta_size;
> +		type = (allow_ofs_delta && entry->delta->idx.offset) ?
> +			OBJ_OFS_DELTA : OBJ_REF_DELTA;
> +	}
> +
> +	if (entry->z_delta_size)
> +		datalen = entry->z_delta_size;
> +	else
> +		datalen = do_compress(&buf, size);
> +
> +	/*
> +	 * The object header is a byte of 'type' followed by zero or
> +	 * more bytes of length.
> +	 */
> +	hdrlen = encode_in_pack_object_header(type, size, header);
> +
> +	if (type == OBJ_OFS_DELTA) {
> +		/*
> +		 * Deltas with relative base contain an additional
> +		 * encoding of the relative offset for the delta
> +		 * base from this object's position in the pack.
> +		 */
> +		off_t ofs = entry->idx.offset - entry->delta->idx.offset;
> +		unsigned pos = sizeof(dheader) - 1;
> +		dheader[pos] = ofs & 127;
> +		while (ofs >>= 7)
> +			dheader[--pos] = 128 | (--ofs & 127);
> +		if (limit && hdrlen + sizeof(dheader) - pos + datalen + 20 >= limit) {
> +			free(buf);
> +			return 0;
> +		}
> +		sha1write(f, header, hdrlen);
> +		sha1write(f, dheader + pos, sizeof(dheader) - pos);
> +		hdrlen += sizeof(dheader) - pos;
> +	} else if (type == OBJ_REF_DELTA) {
> +		/*
> +		 * Deltas with a base reference contain
> +		 * an additional 20 bytes for the base sha1.
> +		 */
> +		if (limit && hdrlen + 20 + datalen + 20 >= limit) {
> +			free(buf);
> +			return 0;
> +		}
> +		sha1write(f, header, hdrlen);
> +		sha1write(f, entry->delta->idx.sha1, 20);
> +		hdrlen += 20;
> +	} else {
> +		if (limit && hdrlen + datalen + 20 >= limit) {
> +			free(buf);
> +			return 0;
> +		}
> +		sha1write(f, header, hdrlen);
> +	}
> +	sha1write(f, buf, datalen);
> +	free(buf);
> +
> +	return hdrlen + datalen;
> +}
> +
> +/* Return 0 if we will bust the pack-size limit */
> +static unsigned long write_reuse_object(struct sha1file *f, struct object_entry *entry,
> +					unsigned long limit, int usable_delta)
> +{
> +	struct packed_git *p = entry->in_pack;
> +	struct pack_window *w_curs = NULL;
> +	struct revindex_entry *revidx;
> +	off_t offset;
> +	enum object_type type = entry->type;
> +	unsigned long datalen;
> +	unsigned char header[10], dheader[10];
> +	unsigned hdrlen;
> +
> +	if (entry->delta)
> +		type = (allow_ofs_delta && entry->delta->idx.offset) ?
> +			OBJ_OFS_DELTA : OBJ_REF_DELTA;
> +	hdrlen = encode_in_pack_object_header(type, entry->size, header);
> +
> +	offset = entry->in_pack_offset;
> +	revidx = find_pack_revindex(p, offset);
> +	datalen = revidx[1].offset - offset;
> +	if (!pack_to_stdout && p->index_version > 1 &&
> +	    check_pack_crc(p, &w_curs, offset, datalen, revidx->nr)) {
> +		error("bad packed object CRC for %s", sha1_to_hex(entry->idx.sha1));
> +		unuse_pack(&w_curs);
> +		return write_no_reuse_object(f, entry, limit, usable_delta);
> +	}
> +
> +	offset += entry->in_pack_header_size;
> +	datalen -= entry->in_pack_header_size;
> +
> +	if (!pack_to_stdout && p->index_version == 1 &&
> +	    check_pack_inflate(p, &w_curs, offset, datalen, entry->size)) {
> +		error("corrupt packed object for %s", sha1_to_hex(entry->idx.sha1));
> +		unuse_pack(&w_curs);
> +		return write_no_reuse_object(f, entry, limit, usable_delta);
> +	}
> +
> +	if (type == OBJ_OFS_DELTA) {
> +		off_t ofs = entry->idx.offset - entry->delta->idx.offset;
> +		unsigned pos = sizeof(dheader) - 1;
> +		dheader[pos] = ofs & 127;
> +		while (ofs >>= 7)
> +			dheader[--pos] = 128 | (--ofs & 127);
> +		if (limit && hdrlen + sizeof(dheader) - pos + datalen + 20 >= limit) {
> +			unuse_pack(&w_curs);
> +			return 0;
> +		}
> +		sha1write(f, header, hdrlen);
> +		sha1write(f, dheader + pos, sizeof(dheader) - pos);
> +		hdrlen += sizeof(dheader) - pos;
> +		reused_delta++;
> +	} else if (type == OBJ_REF_DELTA) {
> +		if (limit && hdrlen + 20 + datalen + 20 >= limit) {
> +			unuse_pack(&w_curs);
> +			return 0;
> +		}
> +		sha1write(f, header, hdrlen);
> +		sha1write(f, entry->delta->idx.sha1, 20);
> +		hdrlen += 20;
> +		reused_delta++;
> +	} else {
> +		if (limit && hdrlen + datalen + 20 >= limit) {
> +			unuse_pack(&w_curs);
> +			return 0;
> +		}
> +		sha1write(f, header, hdrlen);
> +	}
> +	copy_pack_data(f, p, &w_curs, offset, datalen);
> +	unuse_pack(&w_curs);
> +	reused++;
> +	return hdrlen + datalen;
> +}
> +
> +/* Return 0 if we will bust the pack-size limit */
> +static unsigned long write_object(struct sha1file *f,
> +				  struct object_entry *entry,
> +				  off_t write_offset)
> +{
> +	unsigned long limit, len;
>  	int usable_delta, to_reuse;
>  
>  	if (!pack_to_stdout)
>  		crc32_begin(f);
>  
> -	type = entry->type;
> -
>  	/* apply size limit if limited packsize and not first object */
>  	if (!pack_size_limit || !nr_written)
>  		limit = 0;
> @@ -243,11 +399,11 @@ static unsigned long write_object(struct sha1file *f,
>  		to_reuse = 0;	/* explicit */
>  	else if (!entry->in_pack)
>  		to_reuse = 0;	/* can't reuse what we don't have */
> -	else if (type == OBJ_REF_DELTA || type == OBJ_OFS_DELTA)
> +	else if (entry->type == OBJ_REF_DELTA || entry->type == OBJ_OFS_DELTA)
>  				/* check_object() decided it for us ... */
>  		to_reuse = usable_delta;
>  				/* ... but pack split may override that */
> -	else if (type != entry->in_pack_type)
> +	else if (entry->type != entry->in_pack_type)
>  		to_reuse = 0;	/* pack has delta which is unusable */
>  	else if (entry->delta)
>  		to_reuse = 0;	/* we want to pack afresh */
> @@ -256,153 +412,19 @@ static unsigned long write_object(struct sha1file *f,
>  				 * and we do not need to deltify it.
>  				 */
>  
> -	if (!to_reuse) {
> -		no_reuse:
> -		if (!usable_delta) {
> -			buf = read_sha1_file(entry->idx.sha1, &type, &size);
> -			if (!buf)
> -				die("unable to read %s", sha1_to_hex(entry->idx.sha1));
> -			/*
> -			 * make sure no cached delta data remains from a
> -			 * previous attempt before a pack split occurred.
> -			 */
> -			free(entry->delta_data);
> -			entry->delta_data = NULL;
> -			entry->z_delta_size = 0;
> -		} else if (entry->delta_data) {
> -			size = entry->delta_size;
> -			buf = entry->delta_data;
> -			entry->delta_data = NULL;
> -			type = (allow_ofs_delta && entry->delta->idx.offset) ?
> -				OBJ_OFS_DELTA : OBJ_REF_DELTA;
> -		} else {
> -			buf = get_delta(entry);
> -			size = entry->delta_size;
> -			type = (allow_ofs_delta && entry->delta->idx.offset) ?
> -				OBJ_OFS_DELTA : OBJ_REF_DELTA;
> -		}
> -
> -		if (entry->z_delta_size)
> -			datalen = entry->z_delta_size;
> -		else
> -			datalen = do_compress(&buf, size);
> -
> -		/*
> -		 * The object header is a byte of 'type' followed by zero or
> -		 * more bytes of length.
> -		 */
> -		hdrlen = encode_in_pack_object_header(type, size, header);
> -
> -		if (type == OBJ_OFS_DELTA) {
> -			/*
> -			 * Deltas with relative base contain an additional
> -			 * encoding of the relative offset for the delta
> -			 * base from this object's position in the pack.
> -			 */
> -			off_t ofs = entry->idx.offset - entry->delta->idx.offset;
> -			unsigned pos = sizeof(dheader) - 1;
> -			dheader[pos] = ofs & 127;
> -			while (ofs >>= 7)
> -				dheader[--pos] = 128 | (--ofs & 127);
> -			if (limit && hdrlen + sizeof(dheader) - pos + datalen + 20 >= limit) {
> -				free(buf);
> -				return 0;
> -			}
> -			sha1write(f, header, hdrlen);
> -			sha1write(f, dheader + pos, sizeof(dheader) - pos);
> -			hdrlen += sizeof(dheader) - pos;
> -		} else if (type == OBJ_REF_DELTA) {
> -			/*
> -			 * Deltas with a base reference contain
> -			 * an additional 20 bytes for the base sha1.
> -			 */
> -			if (limit && hdrlen + 20 + datalen + 20 >= limit) {
> -				free(buf);
> -				return 0;
> -			}
> -			sha1write(f, header, hdrlen);
> -			sha1write(f, entry->delta->idx.sha1, 20);
> -			hdrlen += 20;
> -		} else {
> -			if (limit && hdrlen + datalen + 20 >= limit) {
> -				free(buf);
> -				return 0;
> -			}
> -			sha1write(f, header, hdrlen);
> -		}
> -		sha1write(f, buf, datalen);
> -		free(buf);
> -	}
> -	else {
> -		struct packed_git *p = entry->in_pack;
> -		struct pack_window *w_curs = NULL;
> -		struct revindex_entry *revidx;
> -		off_t offset;
> -
> -		if (entry->delta)
> -			type = (allow_ofs_delta && entry->delta->idx.offset) ?
> -				OBJ_OFS_DELTA : OBJ_REF_DELTA;
> -		hdrlen = encode_in_pack_object_header(type, entry->size, header);
> -
> -		offset = entry->in_pack_offset;
> -		revidx = find_pack_revindex(p, offset);
> -		datalen = revidx[1].offset - offset;
> -		if (!pack_to_stdout && p->index_version > 1 &&
> -		    check_pack_crc(p, &w_curs, offset, datalen, revidx->nr)) {
> -			error("bad packed object CRC for %s", sha1_to_hex(entry->idx.sha1));
> -			unuse_pack(&w_curs);
> -			goto no_reuse;
> -		}
> -
> -		offset += entry->in_pack_header_size;
> -		datalen -= entry->in_pack_header_size;
> -		if (!pack_to_stdout && p->index_version == 1 &&
> -		    check_pack_inflate(p, &w_curs, offset, datalen, entry->size)) {
> -			error("corrupt packed object for %s", sha1_to_hex(entry->idx.sha1));
> -			unuse_pack(&w_curs);
> -			goto no_reuse;
> -		}
> +	if (!to_reuse)
> +		len = write_no_reuse_object(f, entry, limit, usable_delta);
> +	else
> +		len = write_reuse_object(f, entry, limit, usable_delta);
> +	if (!len)
> +		return 0;
>  
> -		if (type == OBJ_OFS_DELTA) {
> -			off_t ofs = entry->idx.offset - entry->delta->idx.offset;
> -			unsigned pos = sizeof(dheader) - 1;
> -			dheader[pos] = ofs & 127;
> -			while (ofs >>= 7)
> -				dheader[--pos] = 128 | (--ofs & 127);
> -			if (limit && hdrlen + sizeof(dheader) - pos + datalen + 20 >= limit) {
> -				unuse_pack(&w_curs);
> -				return 0;
> -			}
> -			sha1write(f, header, hdrlen);
> -			sha1write(f, dheader + pos, sizeof(dheader) - pos);
> -			hdrlen += sizeof(dheader) - pos;
> -			reused_delta++;
> -		} else if (type == OBJ_REF_DELTA) {
> -			if (limit && hdrlen + 20 + datalen + 20 >= limit) {
> -				unuse_pack(&w_curs);
> -				return 0;
> -			}
> -			sha1write(f, header, hdrlen);
> -			sha1write(f, entry->delta->idx.sha1, 20);
> -			hdrlen += 20;
> -			reused_delta++;
> -		} else {
> -			if (limit && hdrlen + datalen + 20 >= limit) {
> -				unuse_pack(&w_curs);
> -				return 0;
> -			}
> -			sha1write(f, header, hdrlen);
> -		}
> -		copy_pack_data(f, p, &w_curs, offset, datalen);
> -		unuse_pack(&w_curs);
> -		reused++;
> -	}
>  	if (usable_delta)
>  		written_delta++;
>  	written++;
>  	if (!pack_to_stdout)
>  		entry->idx.crc32 = crc32_end(f);
> -	return hdrlen + datalen;
> +	return len;
>  }
>  
>  enum write_one_status {
> -- 
> 1.7.8.36.g69ee2
> 

--Boundary_(ID_o6RseUrxHmmaHCbIHfmu3A)--
