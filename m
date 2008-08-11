From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: How to replace a single corrupt, packed object?
Date: Sun, 10 Aug 2008 20:07:44 -0700
Message-ID: <20080811030744.GD27195@spearce.org>
References: <alpine.DEB.1.00.0808081639490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <0BF03F86-8E4E-46D2-9B04-4385CEBD6902@ai.rug.nl> <20080808161937.GC9152@spearce.org> <90E12BC7-1950-41DF-8BE5-C6B63CE060D9@ai.rug.nl> <alpine.DEB.1.00.0808081841290.24820@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.LFD.1.10.0808102146050.22892@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Aug 11 05:08:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSNm2-0002uJ-MI
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 05:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753803AbYHKDHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 23:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753807AbYHKDHp
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 23:07:45 -0400
Received: from george.spearce.org ([209.20.77.23]:51470 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753684AbYHKDHo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 23:07:44 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 3E93538375; Mon, 11 Aug 2008 03:07:44 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0808102146050.22892@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91914>

Nicolas Pitre <nico@cam.org> wrote:
> OK, here's what the patch to allow repacking without -f and still using 
> redundant objects in presence of pack corruption might look like.  
> Please tell me if that works for you.

Aside from goto being considered harmful by some really smart people,
this patch makes a lot of sense.  Its only downside is a backwards
goto within this function, but the code is actually still quite
clear to me.

If this allows git to magically fix Dscho's bad pack, it may be
worth including in the core tree.

 
> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index 2dadec1..88e73f3 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -277,6 +277,7 @@ static unsigned long write_object(struct sha1file *f,
>  				 */
>  
>  	if (!to_reuse) {
> +		no_reuse:
>  		if (!usable_delta) {
>  			buf = read_sha1_file(entry->idx.sha1, &type, &size);
>  			if (!buf)
> @@ -364,14 +365,28 @@ static unsigned long write_object(struct sha1file *f,
>  			reused_delta++;
>  		}
>  		hdrlen = encode_header(type, entry->size, header);
> +
>  		offset = entry->in_pack_offset;
>  		revidx = find_pack_revindex(p, offset);
>  		datalen = revidx[1].offset - offset;
>  		if (!pack_to_stdout && p->index_version > 1 &&
> -		    check_pack_crc(p, &w_curs, offset, datalen, revidx->nr))
> -			die("bad packed object CRC for %s", sha1_to_hex(entry->idx.sha1));
> +		    check_pack_crc(p, &w_curs, offset, datalen, revidx->nr)) {
> +			error("bad packed object CRC for %s", sha1_to_hex(entry->idx.sha1));
> +			if (entry->delta)
> +				reused_delta--;
> +			goto no_reuse;
> +		}
> +
>  		offset += entry->in_pack_header_size;
>  		datalen -= entry->in_pack_header_size;
> +		if (!pack_to_stdout && p->index_version == 1 &&
> +		    check_pack_inflate(p, &w_curs, offset, datalen, entry->size)) {
> +			die("corrupt packed object for %s", sha1_to_hex(entry->idx.sha1));
> +			if (entry->delta)
> +				reused_delta--;
> +			goto no_reuse;
> +		}
> +
>  		if (type == OBJ_OFS_DELTA) {
>  			off_t ofs = entry->idx.offset - entry->delta->idx.offset;
>  			unsigned pos = sizeof(dheader) - 1;
> @@ -394,10 +409,6 @@ static unsigned long write_object(struct sha1file *f,
>  				return 0;
>  			sha1write(f, header, hdrlen);
>  		}
> -
> -		if (!pack_to_stdout && p->index_version == 1 &&
> -		    check_pack_inflate(p, &w_curs, offset, datalen, entry->size))
> -			die("corrupt packed object for %s", sha1_to_hex(entry->idx.sha1));
>  		copy_pack_data(f, p, &w_curs, offset, datalen);
>  		unuse_pack(&w_curs);
>  		reused++;
> 
> 
> Nicolas

-- 
Shawn.
