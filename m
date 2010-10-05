From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: large files and low memory
Date: Tue, 05 Oct 2010 17:11:45 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010051657440.3107@xanadu.home>
References: <20101004092046.GA4382@nibiru.local>
 <AANLkTimbdrAqoWMxiteT5zNYmwHp8M698BEv1FLuiAxx@mail.gmail.com>
 <20101004185854.GA6466@burratino>
 <AANLkTin-mbzt93DWtp71vYBEUcDLHgo=G-6zynT5NC_r@mail.gmail.com>
 <20101004191657.GC6466@burratino>
 <alpine.LFD.2.00.1010051518570.3107@xanadu.home>
 <20101005203450.GA2096@burratino>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>, weigelt@metux.de,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 23:11:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3Eng-0005xy-Ix
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 23:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755910Ab0JEVLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 17:11:47 -0400
Received: from relais.videotron.ca ([24.201.245.36]:59290 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753226Ab0JEVLq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 17:11:46 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0L9U00IAX5JLXD70@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 05 Oct 2010 17:11:45 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20101005203450.GA2096@burratino>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158249>

On Tue, 5 Oct 2010, Jonathan Nieder wrote:

> Nicolas Pitre wrote:
> 
> > You can't do a one-pass  calculation.  The first one is required to 
> > compute the SHA1 of the file being added, and if that corresponds to an 
> > object that we already have then the operation stops right there as 
> > there is actually nothing to do.
> 
> Ah.  Thanks for a reminder.
> 
> > In the case of big files, what we need to do is to stream the file data 
> > in, compute the SHA1 and deflate it, in order to stream it out into a 
> > temporary file, then rename it according to the final SHA1.  This would 
> > allow Git to work with big files, but of course it won't be possible to 
> > know if the object corresponding to the file is already known until all 
> > the work has been done, possibly just to throw it away.
> 
> To make sure I understand correctly: are you suggesting that for big
> files we should skip the first pass?

For big files we need a totally separate code path to process the file 
data in small chunks at 'git add' time, using a loop containing 
read()+SHA1sum()+deflate()+write().  Then, if the SHA1 matches an 
existing object we delete the temporary output file, otherwise we rename 
it as a valid object.  No CRLF, no smudge filters, no diff, no deltas, 
just plain storage of huge objects, based on the value of 
core.bigFileThreshold config option.

Same thing on the checkout path: a simple loop to 
read()+inflate()+write() in small chunks.

That's the only sane way to kinda support big files with Git.

> I suppose that makes sense: for small files, using a patch application
> tool to reach a postimage that matches an existing object is something
> git historically needed to expect, but for typical big files:
> 
>  - once you've computed the SHA1, you've already invested a noticeable
>    amount of time.
>  - emailing patches around is difficult, making "git am" etc less important
>  - hopefully git or zlib can notice when files are uncompressible,
>    making the deflate not cost so much in that case.

Emailing is out of the question.  We're talking file sizes in the 
hundreds of megabytes and above here.  So yes, simply computing the SHA1 
is a significant cost, given that you are going to trash your page cache 
in the process already, so better pay the price of deflating it at the 
same time even if it turns out to be unnecessary.


Nicolas
