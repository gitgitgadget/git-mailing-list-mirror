From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: large files and low memory
Date: Tue, 05 Oct 2010 16:17:47 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010051518570.3107@xanadu.home>
References: <20101004092046.GA4382@nibiru.local>
 <AANLkTimbdrAqoWMxiteT5zNYmwHp8M698BEv1FLuiAxx@mail.gmail.com>
 <20101004185854.GA6466@burratino>
 <AANLkTin-mbzt93DWtp71vYBEUcDLHgo=G-6zynT5NC_r@mail.gmail.com>
 <20101004191657.GC6466@burratino>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>, weigelt@metux.de,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 22:17:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3DxR-0007zY-Fe
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 22:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756974Ab0JEURs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 16:17:48 -0400
Received: from relais.videotron.ca ([24.201.245.36]:51991 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728Ab0JEURr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 16:17:47 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0L9U00BE831NRF70@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 05 Oct 2010 16:17:47 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20101004191657.GC6466@burratino>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158232>

On Mon, 4 Oct 2010, Jonathan Nieder wrote:

> Shawn Pearce wrote:
> 
> > This change only removes the deflate copy.  But due to the SHA-1
> > consistency issue I alluded to earlier, I think we're still making a
> > full copy of the file in memory before we SHA-1 it or deflate it.
> 
> Hmm, I _think_ we still use mmap for that (which is why 748af44c needs
> to compare the sha1 before and after).
> 
> But
> 
>  1) a one-pass calculation would presumably be a little (5%?) faster

You can't do a one-pass  calculation.  The first one is required to 
compute the SHA1 of the file being added, and if that corresponds to an 
object that we already have then the operation stops right there as 
there is actually nothing to do.  The second pass is to deflate the 
data, and recompute the SHA1 to make sure what we deflated and written 
out is still the same data.

In the case of big files, what we need to do is to stream the file data 
in, compute the SHA1 and deflate it, in order to stream it out into a 
temporary file, then rename it according to the final SHA1.  This would 
allow Git to work with big files, but of course it won't be possible to 
know if the object corresponding to the file is already known until all 
the work has been done, possibly just to throw it away.  But normally 
big files are the minority.


Nicolas
