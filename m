From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How to replace a single corrupt, packed object?
Date: Mon, 11 Aug 2008 20:59:46 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808111818460.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.DEB.1.00.0808081639490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <0BF03F86-8E4E-46D2-9B04-4385CEBD6902@ai.rug.nl> <20080808161937.GC9152@spearce.org> <90E12BC7-1950-41DF-8BE5-C6B63CE060D9@ai.rug.nl> <alpine.DEB.1.00.0808081841290.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <alpine.LFD.1.10.0808102146050.22892@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Aug 11 20:56:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KScZ8-0007fZ-SY
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 20:56:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128AbYHKSzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 14:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753481AbYHKSzJ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 14:55:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:60960 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753050AbYHKSzH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 14:55:07 -0400
Received: (qmail invoked by alias); 11 Aug 2008 18:55:05 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp025) with SMTP; 11 Aug 2008 20:55:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18GKuwKPBEGSosWFx9daw4ggKM9G8btSgzN/6qx0E
	bFA2ujmL9gegfi
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <alpine.LFD.1.10.0808102146050.22892@xanadu.home>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91974>

Hi,

On Sun, 10 Aug 2008, Nicolas Pitre wrote:

> On Fri, 8 Aug 2008, Johannes Schindelin wrote:
> 
> > In any case, the pack is too large for me to let my computer repack 
> > everything, when only one object needs repacking.
> 
> By that you mean you cannot/don't want to use repack -f, right?

Right.  However, I had a relatively fast machine standing nearby today, 
so that scp was not too painful.

> There _could_ be a way to hack pack-objects so not to reuse bad objects.  
> However I don't want that to impact the code too much for an event that 
> hopefully should almost never happens, especially if using -f does work 
> around it already.
> 
> Well, let's see.
> 
> [...]
> 
> OK, here's what the patch to allow repacking without -f and still using 
> redundant objects in presence of pack corruption might look like.  
> Please tell me if that works for you.

The testing took quite a while unfortunately, mainly because I followed 
Shawn's advice, and added not only a loose object, but also a single pack 
with the single object in it, and a newer timestamp.

This resulted in my CPU being hogged when Git tried to read the object.  I 
do not know exactly what is happening, but I suspect an infinite loop due 
to the funny interaction between a valid and a corrupt pack containing the 
same object.  Or maybe the issue described later in this mail.

Only when I removed the pack did things actually go further, so there is 
still a bug lurking.

Your patch worked _almost_:

>  		offset += entry->in_pack_header_size;
>  		datalen -= entry->in_pack_header_size;
> +		if (!pack_to_stdout && p->index_version == 1 &&
> +		    check_pack_inflate(p, &w_curs, offset, datalen, entry->size)) {
> +			die("corrupt packed object for %s", sha1_to_hex(entry->idx.sha1));

This needs to be an error(), obviously.

> +			if (entry->delta)
> +				reused_delta--;
> +			goto no_reuse;
> +		}
> +
>  		if (type == OBJ_OFS_DELTA) {
>  			off_t ofs = entry->idx.offset - entry->delta->idx.offset;
>  			unsigned pos = sizeof(dheader) - 1;

With that, it took quite a while, then it told me about the corrupt 
object.

And then it hangs in the loop sha1_file.c:1511.  The function inflate() 
returns Z_BUF_ERROR, and nothing is read.

Oh, and it still tries to access the same corrupt pack.

Thanks,
Dscho

P.S.: I have to wrap up my work at my current (interim) job, and will be 
moving in the next days, so do not expect too much from my side before 
Monday.
