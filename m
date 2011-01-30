From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [RFC] Add --create-cache to repack
Date: Sun, 30 Jan 2011 12:14:47 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1101301208270.8580@xanadu.home>
References: <1296201984-24426-1-git-send-email-spearce@spearce.org>
 <4D42878E.2020502@viscovery.net>
 <AANLkTim+AUY9SdeAFfkny2_a3qQ9SCDLUHR3s9Q3M98u@mail.gmail.com>
 <alpine.LFD.2.00.1101281304270.8580@xanadu.home>
 <AANLkTikPcp5CUTWfhy6FYbCEkNG6epGBAMNT5vTfSbvy@mail.gmail.com>
 <alpine.LFD.2.00.1101281502170.8580@xanadu.home>
 <AANLkTi=U7qRRij=BQXC1Goqa9toDFfaVKT=+-8zYxCcc@mail.gmail.com>
 <7voc6yc2au.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	John Hawley <warthog19@eaglescrag.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 30 18:15:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pjarb-0007p0-5i
	for gcvg-git-2@lo.gmane.org; Sun, 30 Jan 2011 18:14:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834Ab1A3ROs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Jan 2011 12:14:48 -0500
Received: from relais.videotron.ca ([24.201.245.36]:32694 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023Ab1A3ROs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jan 2011 12:14:48 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ20.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LFU008OIIKAD4B0@VL-MR-MRZ20.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 30 Jan 2011 12:14:34 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7voc6yc2au.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165690>

On Sat, 29 Jan 2011, Junio C Hamano wrote:

> Shawn Pearce <spearce@spearce.org> writes:
> 
> > I fully implemented the reuse of a cached pack behind a thin pack idea
> > I was trying to describe in this thread.  It saved 1m7s off the JGit
> > running time, but increased the data transfer by 25 MiB.  I didn't
> > expect this much of an increase, I honestly expected the thin pack
> > portion to be well, thinner.  The issue is the thin pack cannot delta
> > against all of the history, its only delta compressing against the tip
> > of the cached pack.  So long-lived side branches that forked off an
> > older part of the history aren't delta compressing well, or at all,
> > and that is significantly bloating the thin pack.  (Its also why that
> > "newer" pack is 57M, but should be 14M if correctly combined with the
> > cached pack.)  If I were to consider all of the objects in the cached
> > pack as potential delta base candidates for the thin pack, the entire
> > benefit of the cached pack disappears.
> 
> What if you instead use the cached pack this way?
> 
>  0. You perform the proposed pre-traversal until you hit the tip of cached
>     pack(s), and realize that you will end up sending everything.
> 
>  1. Instead of sending the new part of the history first and then sending
>     the cached pack(s), you send the contents of cached pack(s), but also
>     note what objects you sent;
> 
>  2. Then you send the new part of the history, taking full advantage of
>     what you have already sent, perhaps doing only half of the reuse-delta
>     logic (i.e. you reuse what you can reuse, but you do _not_ punt on an
>     object that is not a delta in an existing pack).

The problem is to determine the best base object to delta against.  If 
you end up listing all the already sent objects and perform delta 
attempts against them for the remaining non delta objects to find the 
best match then you might end up taking more CPU time than the current 
enumeration phase.


Nicolas
