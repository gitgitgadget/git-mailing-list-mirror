From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] Make xmalloc and xrealloc thread-safe
Date: Wed, 24 Mar 2010 17:02:15 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1003241656010.694@xanadu.home>
References: <20100323173114.GB4218@fredrik-laptop>
 <20100323184309.GA31668@spearce.org>
 <4c8ef71003231421u789c4332h461c066add0ec7b1@mail.gmail.com>
 <alpine.LFD.2.00.1003231945480.31128@xanadu.home>
 <4c8ef71003240823o7cd733bn5f19699305c94cba@mail.gmail.com>
 <alpine.LFD.2.00.1003241133430.694@xanadu.home>
 <ec874dac1003241122s3d592f26n1b23d23144939218@mail.gmail.com>
 <alpine.LFD.2.00.1003241435300.694@xanadu.home>
 <ec874dac1003241257r3cad86c9q1af84d3732e23ca8@mail.gmail.com>
 <alpine.LFD.2.00.1003241613020.694@xanadu.home>
 <20100324202814.GA24830@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 24 22:07:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuXnp-0003QK-1l
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 22:07:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752143Ab0CXVHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 17:07:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:37008 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722Ab0CXVHm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 17:07:42 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KZT00GRG13RZH10@VL-MR-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 24 Mar 2010 17:02:16 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20100324202814.GA24830@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143126>

On Wed, 24 Mar 2010, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@fluxnic.net> wrote:
> > Note: there was a dubious usage of fd when calling release_pack_memory() 
> > in xmmap() which is now removed.
> ...
> > @@ -100,7 +112,7 @@ void *xmmap(void *start, size_t length,
> >  	if (ret == MAP_FAILED) {
> >  		if (!length)
> >  			return NULL;
> > -		release_pack_memory(length, fd);
> > +		try_to_free_routine(length);
> 
> This isn't dubious!  The fd passed here is to prevent the pack
> release code from closing this fd right before we try to mmap it.
> Its an actual bug fix that I had to write years ago, check the
> history of that section of code...  :-)

Argh.  My bad.  I somehow thought that fd was the actual pack to free 
when specified.  Let's drop the very last hunk of the patch then.  
xmmap() is certainly not going to be invoked concurrently to the rest of 
sha1_file.c in a separate thread.

Junio: I suppose you don't need me to resend?


Nicolas
