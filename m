From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v2] Make xmalloc and xrealloc thread-safe
Date: Wed, 07 Apr 2010 09:17:04 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004070859540.7232@xanadu.home>
References: <4c8ef71003231421u789c4332h461c066add0ec7b1@mail.gmail.com>
 <alpine.LFD.2.00.1003241133430.694@xanadu.home>
 <ec874dac1003241122s3d592f26n1b23d23144939218@mail.gmail.com>
 <alpine.LFD.2.00.1003241435300.694@xanadu.home>
 <ec874dac1003241257r3cad86c9q1af84d3732e23ca8@mail.gmail.com>
 <alpine.LFD.2.00.1003241613020.694@xanadu.home>
 <4c8ef71003270626y45685e69j28ccb8a8738b9083@mail.gmail.com>
 <alpine.LFD.2.00.1004062152260.7232@xanadu.home>
 <20100407031655.GA7156@spearce.org>
 <alpine.LFD.2.00.1004070043450.7232@xanadu.home>
 <r2xec874dac1004070529p3d21d23z533e471636194c00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_d0gHkr5cIVOu31XP+YRQXg)"
Cc: Fredrik Kuivinen <frekui@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Apr 07 15:17:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzV87-000670-Lm
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 15:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757867Ab0DGNRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 09:17:10 -0400
Received: from relais.videotron.ca ([24.201.245.36]:11563 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556Ab0DGNRG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 09:17:06 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L0I00JMHCWGHR90@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 07 Apr 2010 09:17:05 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <r2xec874dac1004070529p3d21d23z533e471636194c00@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144218>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_d0gHkr5cIVOu31XP+YRQXg)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Wed, 7 Apr 2010, Shawn Pearce wrote:

> On Tue, Apr 6, 2010 at 9:51 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > In practice memset() will optimize the memory access by using words and
> > no bytes.  But in theory this is not guaranteed.  The solution for this
> > would be to have yet another mutex just to protect the read_mutex
> > hownership information modifications in order to make it atomic to
> > potential readers.  That is becoming ugly for a feature (the freeing of
> > pack data) that is not supposed to be the common case.
> 
> Multi-threaded programming is hard.  Its never easy to get it right.

Indeed.  But in this case what makes it harder is the willingness to 
stick to standard APIs.

> We had really excellent reasons for avoiding multiple threads in the
> early days of Git.  We still have those excellent reasons, but we have
> been pushing more and more into these async threads to support
> windows, and now its making us realize we never really thought about
> this stuff very much.

Well, pack-objects was "broken" even without Windows in the picture.  
What I'm trying to fix here is not Windows specific (although the thread 
API limitations are).

> You mentioned avoiding a recursive mutex only because windows
> emulation doesn't have support for it.  But that's exactly what we
> need here.  Shouldn't windows have a recursive mutex object that can
> just be used inside of the emulation layer when we really need a
> recursive mutex?

Maybe.  That would in fact just mean pushing the double mutex issue into 
the pthread emulation instead of having it outside it.  This would 
impact performances for all mutexes although only one instance of them 
currently require a recursive behavior.

Yet, the memset() issue comes up only because pthread_t is meant to be 
an opaque type.  The only information we would need here is the actual 
thread ID as returned by gettid() on Linux or GetCurrentThreadId() on 
Windows, and then the read_mutex_owner could be a simple atomically 
modifiable integer.  But what about other pthread-capable non Linux 
systems?


Nicolas

--Boundary_(ID_d0gHkr5cIVOu31XP+YRQXg)--
