From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 1/2] Make xmalloc and xrealloc thread-safe
Date: Wed, 24 Mar 2010 13:53:01 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1003241133430.694@xanadu.home>
References: <20100323161713.3183.57927.stgit@fredrik-laptop>
 <20100323173114.GB4218@fredrik-laptop> <20100323184309.GA31668@spearce.org>
 <4c8ef71003231421u789c4332h461c066add0ec7b1@mail.gmail.com>
 <alpine.LFD.2.00.1003231945480.31128@xanadu.home>
 <4c8ef71003240823o7cd733bn5f19699305c94cba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_rImVXcxlLtWle5xQaR/Wbw)"
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 24 18:53:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuUli-0008SY-HW
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 18:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476Ab0CXRxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 13:53:20 -0400
Received: from relais.videotron.ca ([24.201.245.36]:35534 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752784Ab0CXRxT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 13:53:19 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KZS0097VSCDYMM0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 24 Mar 2010 13:53:02 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <4c8ef71003240823o7cd733bn5f19699305c94cba@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Content-id: <alpine.LFD.2.00.1003241352010.694@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143098>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_rImVXcxlLtWle5xQaR/Wbw)
Content-id: <alpine.LFD.2.00.1003241352011.694@xanadu.home>
Content-type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-transfer-encoding: 8BIT

On Wed, 24 Mar 2010, Fredrik Kuivinen wrote:

> On Wed, Mar 24, 2010 at 00:50, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Tue, 23 Mar 2010, Fredrik Kuivinen wrote:
> >
> >> On Tue, Mar 23, 2010 at 19:43, Shawn O. Pearce <spearce@spearce.org> wrote:
> >> > If that is what we are doing, disabling the release of pack windows
> >> > when malloc fails, why can't we do that all of the time?
> >>
> >> The idea was that most git programs are single threaded, so they can
> >> still benefit from releasing the pack windows when they are low on
> >> memory.
> >
> > This is bobus. The Git program using the most memory is probably
> > pack-objects and it is threaded.  Most single-threaded programs don't
> > use close to as much memory.
> 
> Ok, you are right. But xmalloc/xrealloc cannot be used in multiple
> threads simultaneously without some serialization.
> 
> For example, I think there are some potential race conditions in the
> pack-objects code. In the threaded code we have the following call
> chains leading to xcalloc, xmalloc, and xrealloc:
> 
> find_deltas -> xcalloc
> find_deltas -> do_compress -> xmalloc
> find_deltas -> try_delta -> xrealloc
> find_deltas -> try_delta -> read_sha1_file -> ... -> xmalloc  (called
> with read_lock held, but it can still race with the other calls)
> 
> As far as I can see there is no serialization between these calls.

True.  We already have a problem.  This is nasty.


Nicolas

--Boundary_(ID_rImVXcxlLtWle5xQaR/Wbw)--
