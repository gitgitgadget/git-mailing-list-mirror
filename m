From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v2] Make xmalloc and xrealloc thread-safe
Date: Wed, 07 Apr 2010 00:51:12 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004070043450.7232@xanadu.home>
References: <4c8ef71003231421u789c4332h461c066add0ec7b1@mail.gmail.com>
 <alpine.LFD.2.00.1003231945480.31128@xanadu.home>
 <4c8ef71003240823o7cd733bn5f19699305c94cba@mail.gmail.com>
 <alpine.LFD.2.00.1003241133430.694@xanadu.home>
 <ec874dac1003241122s3d592f26n1b23d23144939218@mail.gmail.com>
 <alpine.LFD.2.00.1003241435300.694@xanadu.home>
 <ec874dac1003241257r3cad86c9q1af84d3732e23ca8@mail.gmail.com>
 <alpine.LFD.2.00.1003241613020.694@xanadu.home>
 <4c8ef71003270626y45685e69j28ccb8a8738b9083@mail.gmail.com>
 <alpine.LFD.2.00.1004062152260.7232@xanadu.home>
 <20100407031655.GA7156@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <frekui@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Apr 07 06:51:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzNEh-0004eB-5N
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 06:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508Ab0DGEvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 00:51:14 -0400
Received: from relais.videotron.ca ([24.201.245.36]:26095 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422Ab0DGEvN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 00:51:13 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0L0H00KNZPHCBP90@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 07 Apr 2010 00:51:12 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20100407031655.GA7156@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144192>

On Tue, 6 Apr 2010, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@fluxnic.net> wrote:
> > To avoid a deadlock if try_to_free_from_threads() is called while
> > read_lock is already locked within the same thread (may happen through
> > the read_sha1_file() path), a simple mutex ownership is added. This 
> > could have been handled automatically with the PTHREAD_MUTEX_RECURSIVE 
> > type but the Windows pthread emulation would get much more complex.
> ...
> > +static void try_to_free_from_threads(size_t size)
> > +{
> > +	int self = pthread_equal(read_mutex_owner, pthread_self());
> > +	if (!self)
> > +		read_lock();
> > +	release_pack_memory(size, -1);
> > +	if (!self)
> > +		read_unlock();
> > +}
> 
> Is there any concern that a partially unset read_mutex_owner might
> look like the current thread's identity?
> 
> That is, memset() can be setting the bytes one by one.  If the lock
> is being released we might observe the current owner as ourselves
> if we see only part of that release, and our identity is the same
> as another thread, only with the lower-address bytes unset.

In practice memset() will optimize the memory access by using words and 
no bytes.  But in theory this is not guaranteed.  The solution for this 
would be to have yet another mutex just to protect the read_mutex 
hownership information modifications in order to make it atomic to 
potential readers.  That is becoming ugly for a feature (the freeing of 
pack data) that is not supposed to be the common case.


Nicolas
