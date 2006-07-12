From: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
Subject: Re: [PATCH 2/3] sha1_file: add the ability to parse objects in "pack file format"
Date: Wed, 12 Jul 2006 08:49:17 +0200
Message-ID: <slrneb96rd.dma.Peter.B.Baumann@xp.machine.xx>
References: <20060710230132.GA11132@hpsvcnb.fc.hp.com> <Pine.LNX.4.64.0607101623230.5623@g5.osdl.org> <20060711145527.GA32468@hpsvcnb.fc.hp.com> <Pine.LNX.4.64.0607111004360.5623@g5.osdl.org> <Pine.LNX.4.64.0607111010320.5623@g5.osdl.org> <44B4172B.3070503@stephan-feder.de> <Pine.LNX.4.64.0607111449190.5623@g5.osdl.org> <7vejwr3ftl.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0607111656250.5623@g5.osdl.org>
X-From: git-owner@vger.kernel.org Wed Jul 12 08:51:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0YYi-0001PF-SZ
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 08:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWGLGux (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 02:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWGLGux
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 02:50:53 -0400
Received: from main.gmane.org ([80.91.229.2]:31902 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750746AbWGLGux (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Jul 2006 02:50:53 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G0YYS-0001Lv-U8
	for git@vger.kernel.org; Wed, 12 Jul 2006 08:50:41 +0200
Received: from mason.hofmann.stw.uni-erlangen.de ([131.188.24.36])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Jul 2006 08:50:40 +0200
Received: from Peter.B.Baumann by mason.hofmann.stw.uni-erlangen.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 12 Jul 2006 08:50:40 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mason.hofmann.stw.uni-erlangen.de
User-Agent: slrn/0.9.8.0 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23767>

On 2006-07-12, Linus Torvalds <torvalds@osdl.org> wrote:
[...]
> Anyway, I think this following patch replaces the old 2/3 and 3/3 (it 
> still depends on the original [1/3] cleanup.
>
> (It also renames and reverses the meaning of the config file option: it's 
> now "[core] LegacyHeaders = true" for using legacy headers.)
>
> Not heavily tested, but seems ok.
>
> sf? Dscho? Can you check this thing out?
>
> 		Linus
> ----
[...]
> diff --git a/sha1_file.c b/sha1_file.c
> index 8734d50..475b23d 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -684,26 +684,74 @@ static void *map_sha1_file_internal(cons
>  	return map;
>  }
>  
> -static int unpack_sha1_header(z_stream *stream, void *map, unsigned long mapsize, void *buffer, unsigned long size)
> +static int unpack_sha1_header(z_stream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz)
>  {
> +	unsigned char c;
> +	unsigned int word, bits;
> +	unsigned long size;
> +	static const char *typename[8] = {
> +		NULL,	/* OBJ_EXT */
> +		"commit", "tree", "blob", "tag",
> +		NULL, NULL, NULL
> +	};
> +	const char *type;
> +
>  	/* Get the data stream */
>  	memset(stream, 0, sizeof(*stream));
>  	stream->next_in = map;
>  	stream->avail_in = mapsize;
>  	stream->next_out = buffer;
> -	stream->avail_out = size;
> +	stream->avail_out = bufsiz;
> +
> +	/*
> +	 * Is it a zlib-compressed buffer? If so, the first byte
> +	 * must be 0x78 (15-bit window size, deflated), and the
> +	 * first 16-bit word is evenly divisible by 31
> +	 */
> +	word = (map[0] << 8) + map[1];
> +	if (map[0] == 0x78 && !(word % 31)) {
> +		inflateInit(stream);
> +		return inflate(stream, 0);
> +	}
> +
> +	c = *map++;
> +	mapsize--;
> +	type = typename[(c >> 4) & 7];
> +	if (!type)
> +		return -1;
> +
> +	bits = 4;
> +	size = c & 0xf;
> +	while (!(c & 0x80)) {
> +		if (bits >= 8*sizeof(long))
> +			return -1;
> +		c = *map++;
> +		size += (c & 0x7f) << bits;
> +		bits += 7;
> +		mapsize--;
> +	}

This doesn't match the logic used in unpack_object_header, which is used
in the packs:

static unsigned long unpack_object_header(struct packed_git *p, unsigned long offset,
        enum object_type *type, unsigned long *sizep)
{
	unsigned shift;
	unsigned char *pack, c;
	unsigned long size;

	if (offset >= p->pack_size)
		die("object offset outside of pack file");

	pack =  (unsigned char *) p->pack_base + offset;
	c = *pack++;
	offset++;
	*type = (c >> 4) & 7;
	size = c & 15;
	shift = 4;
	while (c & 0x80) {			<==========
		if (offset >= p->pack_size)
	        	die("object offset outside of pack file");
		c = *pack++;
		offset++;
		size += (c & 0x7f) << shift;
		shift += 7;
	}
	*sizep = size;				<==========
	return offset;
}

> @@ -1414,6 +1462,49 @@ static int write_buffer(int fd, const vo
>  	return 0;
>  }
>  
> +static int write_binary_header(unsigned char *hdr, enum object_type type, unsigned long len)
> +{
> +	int hdr_len;
> +	unsigned char c;
> +
> +	c = (type << 4) | (len & 15);
> +	len >>= 4;
> +	hdr_len = 1;
> +	while (len) {
> +		*hdr++ = c;
> +		hdr_len++;
> +		c = (len & 0x7f);
> +		len >>= 7;
> +	}
> +	*hdr = c | 0x80;
> +	return hdr_len;
> +}
> +

Dito, but in this case see pack-objects.c

/*
 * The per-object header is a pretty dense thing, which is
 *  - first byte: low four bits are "size", then three bits of "type",
 *    and the high bit is "size continues".
 *  - each byte afterwards: low seven bits are size continuation,
 *    with the high bit being "size continues"
 */
static int encode_header(enum object_type type, unsigned long size, unsigned char *hdr)
{
        int n = 1;
        unsigned char c;

        if (type < OBJ_COMMIT || type > OBJ_DELTA)
                die("bad type %d", type);

        c = (type << 4) | (size & 15);
        size >>= 4;
        while (size) {
                *hdr++ = c | 0x80;	<=======
                c = size & 0x7f;
                size >>= 7;
                n++;
        }
        *hdr = c;			<=======
        return n;
}



-Peter Baumann
