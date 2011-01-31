From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [RFC] Add --create-cache to repack
Date: Mon, 31 Jan 2011 16:48:08 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1101311421320.8580@xanadu.home>
References: <1296201984-24426-1-git-send-email-spearce@spearce.org>
 <4D42878E.2020502@viscovery.net>
 <AANLkTim+AUY9SdeAFfkny2_a3qQ9SCDLUHR3s9Q3M98u@mail.gmail.com>
 <alpine.LFD.2.00.1101281304270.8580@xanadu.home>
 <AANLkTikPcp5CUTWfhy6FYbCEkNG6epGBAMNT5vTfSbvy@mail.gmail.com>
 <alpine.LFD.2.00.1101281502170.8580@xanadu.home>
 <AANLkTi=U7qRRij=BQXC1Goqa9toDFfaVKT=+-8zYxCcc@mail.gmail.com>
 <AANLkTimW=fuKrhw6+ZDipEtSGX_oR4LbTZzyAxZ8Pry1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_IPk4EMaExkVsOBg4g3wLFg)"
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	John Hawley <warthog19@eaglescrag.net>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 31 22:48:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk1bg-0003Sg-B3
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 22:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756574Ab1AaVsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 16:48:11 -0500
Received: from relais.videotron.ca ([24.201.245.36]:47192 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756418Ab1AaVsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 16:48:09 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ22.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LFW006TOPW85EH0@VL-MR-MRZ22.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 31 Jan 2011 16:48:08 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <AANLkTimW=fuKrhw6+ZDipEtSGX_oR4LbTZzyAxZ8Pry1@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Content-id: <alpine.LFD.2.00.1101311441020.8580@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165759>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_IPk4EMaExkVsOBg4g3wLFg)
Content-id: <alpine.LFD.2.00.1101311441021.8580@xanadu.home>
Content-type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-transfer-encoding: 8BIT

On Mon, 31 Jan 2011, Shawn Pearce wrote:

> On Fri, Jan 28, 2011 at 17:32, Shawn Pearce <spearce@spearce.org> wrote:
> >>> >
> >>> >> This started because I was looking for a way to speed up clones coming
> >>> >> from a JGit server.  Cloning the linux-2.6 repository is painful,
> >
> > Well, scratch the idea in this thread.  I think.
> 
> Nope, I'm back in favor with this after fixing JGit's thin pack
> generation.  Here's why.
> 
> Take linux-2.6.git as of Jan 12th, with the cache root as of Dec 28th:
> 
>   $ git update-ref HEAD f878133bf022717b880d0e0995b8f91436fd605c
>   $ git-repack.sh --create-cache \
>       --cache-root=b52e2a6d6d05421dea6b6a94582126af8cd5cca2 \
>       --cache-include=v2.6.11-tree
>   $ git repack -a -d
> 
>   $ ls -lh objects/pack/
>   total 456M
>   1.4M pack-74af5edca80797736fe4de7279b2a81af98470a5.idx
>   38M pack-74af5edca80797736fe4de7279b2a81af98470a5.pack
> 
>   49M pack-d3e77c8b3045c7f54fa2fb6bbfd4dceca1e2b9fa.idx
>   89 pack-d3e77c8b3045c7f54fa2fb6bbfd4dceca1e2b9fa.keep
>   368M pack-d3e77c8b3045c7f54fa2fb6bbfd4dceca1e2b9fa.pack
> 
> Our "recent history" is 38M, and our "cached pack" is 368M.  Its a bit
> more disk than is strictly necessary, this should be ~380M.  Call it
> ~26M of wasted disk. 

This is fine.  When doing an incremental fetch, the thin pack does 
minimize the transfer size, but it does increase the stored pack size by 
appending a bunch of non delta objects to make the pack complete.

What happens though, is that when gc kicks in, the wasted space is 
collected back.  Here with a single pack we wouldn't claim that space 
back as our current euristics is to reuse delta (non) pairing by 
default.  Maybe in that case we could simply not reuse deltas if they're 
of the REF_DELTA type.

> The "cached object list" I proposed elsewhere in
> this thread would cost about 41M of disk and is utterly useless except
> for initial clones.  Here we are wasting about 26M of disk to have
> slightly shorter delta chains in the cached pack (otherwise known as
> our ancient history).  So its a slightly smaller waste, and we get
> some (minor) benefit.

Well, of course the ancient history you're willing to keep stable for a 
while could be repacked even more aggressively than usual.

> Using the cached pack increased our total data transfer by 2.39 MiB,

That's more than acceptable IMHO. That's less than 1% of the total 
transfer.

> I think this is worthwhile.  If we are afraid of the extra 2.39 MiB
> data transfer this forces on the client when the repository owner
> enables the feature, we should go back and improve our thin-pack code.
>  Transferring 11 MiB to catch up a kernel from Dec 28th to Jan 12th
> sounds like a lot of data, 

Well, your timing for this test corresponds with the 2.6.38 merge window 
which is a high activity peak for this repository.  Still, that would 
probably fit the usage scenario in practice pretty well where the cache 
pack would be produced on a tagged release which happens right before 
the merge window.


> and any improvements in the general
> thin-pack code would shrink the leading thin-pack, possibly getting us
> that 2.39 MiB back.

Any improvement to the thin pack would require more CPU cycles, possibly 
lot more.  So given this transfer overhead is less than 1% already I 
don't think we need to bother.


Nicolas

--Boundary_(ID_IPk4EMaExkVsOBg4g3wLFg)--
