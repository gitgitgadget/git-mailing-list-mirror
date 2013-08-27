From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/23] pack v4: object data copy
Date: Tue, 27 Aug 2013 08:53:44 -0700
Message-ID: <xmqqli3ndt9z.fsf@gitster.dls.corp.google.com>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
	<1377577567-27655-15-git-send-email-nico@fluxnic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Aug 27 17:53:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VELab-00040L-KL
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 17:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667Ab3H0Pxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 11:53:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41166 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751570Ab3H0Pxt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 11:53:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67EF83A5E0;
	Tue, 27 Aug 2013 15:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=niJaxatLn64m7x9a6G++W1IESCY=; b=ftuD81
	j17akJ41+F+Ji75D9ZEPT2vf+HrujN/qk93k8BhX5DDExxyS9G4Z70TwoiSlMXtC
	FNZEBubB28SrKk3ULRJroZ2nCqCjHzAuIouiN3OYTGxVV4+IuiEQgM/mBeffzc1W
	haddCqqSSOAb32//3Ld54XA3e17VuWdGvhozQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K/vWMx+0NSkXiMJshu611+QfPgFXyFXR
	huFNWTbP7987kMYbh4XtKHf44c61KgNrdKD1HKZdX/oF5XniSy36hd0VZWd+cfwZ
	bSFG+NDTG6kXIIdB/roGs/3iVARxXPnF7lT6mlIWOzPzXVLjtEgW2x5USHjgd7b3
	TynM5eUzsiQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BC8A3A5DF;
	Tue, 27 Aug 2013 15:53:48 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DECB23A5D9;
	Tue, 27 Aug 2013 15:53:46 +0000 (UTC)
In-Reply-To: <1377577567-27655-15-git-send-email-nico@fluxnic.net> (Nicolas
	Pitre's message of "Tue, 27 Aug 2013 00:25:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DC0380C6-0F30-11E3-A84B-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233107>

Nicolas Pitre <nico@fluxnic.net> writes:

> Blob and tag objects have no particular changes except for their object
> header.
>
> Delta objects are also copied as is, except for their delta base reference
> which is converted to the new way as used elsewhere in pack v4 encoding
> i.e. an index into the SHA1 table or a literal SHA1 prefixed by 0 if not
> found in the table (see add_sha1_ref).  This is true for both REF_DELTA
> as well as OFS_DELTA.
>
> Object payload is validated against the recorded CRC32 in the source
> pack index file when possible.
>
> Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
> ---

The title somewhat confused me until I realized that this series is
building a program that would convert existing data from a single
pack into packv4 format, not a "pack-objects --pack-verison=4".

>  packv4-create.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>
> diff --git a/packv4-create.c b/packv4-create.c
> index 6e0bb1d..a6dc818 100644
> --- a/packv4-create.c
> +++ b/packv4-create.c
> @@ -12,6 +12,7 @@
>  #include "object.h"
>  #include "tree-walk.h"
>  #include "pack.h"
> +#include "pack-revindex.h"
>  
>  
>  static int pack_compression_level = Z_DEFAULT_COMPRESSION;
> @@ -673,6 +674,71 @@ static unsigned int write_object_header(struct sha1file *f, enum object_type typ
>  	return end - buf;
>  }
>  
> +static unsigned long copy_object_data(struct sha1file *f, struct packed_git *p,
> +				      off_t offset)
> +{
> +	struct pack_window *w_curs = NULL;
> +	struct revindex_entry *revidx;
> +	enum object_type type;
> +	unsigned long avail, size, datalen, written;
> +	int hdrlen, idx_nr;
> +	unsigned char *src, *end, buf[24];
> +
> +	revidx = find_pack_revindex(p, offset);
> +	idx_nr = revidx->nr;
> +	datalen = revidx[1].offset - offset;
> +
> +	src = use_pack(p, &w_curs, offset, &avail);
> +	hdrlen = unpack_object_header_buffer(src, avail, &type, &size);
> +
> +	written = write_object_header(f, type, size);
> +
> +	if (type == OBJ_OFS_DELTA) {
> +		unsigned char c = src[hdrlen++];
> +		off_t base_offset = c & 127;
> +		while (c & 128) {
> +			base_offset += 1;
> +			if (!base_offset || MSB(base_offset, 7))
> +				die("delta offset overflow");
> +			c = src[hdrlen++];
> +			base_offset = (base_offset << 7) + (c & 127);
> +		}
> +		base_offset = offset - base_offset;
> +		if (base_offset <= 0 || base_offset >= offset)
> +			die("delta offset out of bound");
> +		revidx = find_pack_revindex(p, base_offset);
> +		end = add_sha1_ref(buf, nth_packed_object_sha1(p, revidx->nr));
> +		sha1write(f, buf, end - buf);
> +		written += end - buf;
> +	} else if (type == OBJ_REF_DELTA) {
> +		end = add_sha1_ref(buf, src + hdrlen);
> +		hdrlen += 20;
> +		sha1write(f, buf, end - buf);
> +		written += end - buf;
> +	}
> +
> +	if (p->index_version > 1 &&
> +	    check_pack_crc(p, &w_curs, offset, datalen, idx_nr))
> +		die("bad CRC for object at offset %"PRIuMAX" in %s",
> +		    (uintmax_t)offset, p->pack_name);
> +
> +	offset += hdrlen;
> +	datalen -= hdrlen;
> +
> +	while (datalen) {
> +		src = use_pack(p, &w_curs, offset, &avail);
> +		if (avail > datalen)
> +			avail = datalen;
> +		sha1write(f, src, avail);
> +		written += avail;
> +		offset += avail;
> +		datalen -= avail;
> +	}
> +	unuse_pack(&w_curs);
> +
> +	return written;
> +}
> +
>  static struct packed_git *open_pack(const char *path)
>  {
>  	char arg[PATH_MAX];
