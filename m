From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 1/2] Make xmalloc and xrealloc thread-safe
Date: Wed, 24 Mar 2010 14:54:48 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1003241435300.694@xanadu.home>
References: <20100323161713.3183.57927.stgit@fredrik-laptop>
 <20100323173114.GB4218@fredrik-laptop> <20100323184309.GA31668@spearce.org>
 <4c8ef71003231421u789c4332h461c066add0ec7b1@mail.gmail.com>
 <alpine.LFD.2.00.1003231945480.31128@xanadu.home>
 <4c8ef71003240823o7cd733bn5f19699305c94cba@mail.gmail.com>
 <alpine.LFD.2.00.1003241133430.694@xanadu.home>
 <ec874dac1003241122s3d592f26n1b23d23144939218@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_gFZphfhVtJRgR94I8DR1xw)"
Cc: Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 24 19:55:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuVjC-0004pU-KZ
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 19:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932737Ab0CXSyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 14:54:50 -0400
Received: from relais.videotron.ca ([24.201.245.36]:30407 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932268Ab0CXSyt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 14:54:49 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KZS009PMV7CYMT0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 24 Mar 2010 14:54:48 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <ec874dac1003241122s3d592f26n1b23d23144939218@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143104>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_gFZphfhVtJRgR94I8DR1xw)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Wed, 24 Mar 2010, Shawn Pearce wrote:

> On Wed, Mar 24, 2010 at 10:53 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Wed, 24 Mar 2010, Fredrik Kuivinen wrote:
> >
> >> On Wed, Mar 24, 2010 at 00:50, Nicolas Pitre <nico@fluxnic.net> wrote:
> >> > On Tue, 23 Mar 2010, Fredrik Kuivinen wrote:
> >> >
> >> >> On Tue, Mar 23, 2010 at 19:43, Shawn O. Pearce <spearce@spearce.org> wrote:
> >> >> > If that is what we are doing, disabling the release of pack windows
> >> >> > when malloc fails, why can't we do that all of the time?
> >> >>
> >> >> The idea was that most git programs are single threaded, so they can
> >> >> still benefit from releasing the pack windows when they are low on
> >> >> memory.
> >> >
> >> > This is bobus. The Git program using the most memory is probably
> >> > pack-objects and it is threaded.  Most single-threaded programs don't
> >> > use close to as much memory.
> >>
> >> Ok, you are right. But xmalloc/xrealloc cannot be used in multiple
> >> threads simultaneously without some serialization.
> >>
> >> For example, I think there are some potential race conditions in the
> >> pack-objects code. In the threaded code we have the following call
> >> chains leading to xcalloc, xmalloc, and xrealloc:
> >>
> >> find_deltas -> xcalloc
> >> find_deltas -> do_compress -> xmalloc
> >> find_deltas -> try_delta -> xrealloc
> >> find_deltas -> try_delta -> read_sha1_file -> ... -> xmalloc  (called
> >> with read_lock held, but it can still race with the other calls)
> >>
> >> As far as I can see there is no serialization between these calls.
> >
> > True.  We already have a problem.  This is nasty.
> 
> The easy solution is probably to remove the use of xmalloc from
> find_deltas code path.  But then we run into hard failures when we
> can't get the memory we need, there isn't a way to recover from a
> malloc() failure deep within read_sha1_file for example.

The read_sha1_file path is not the problem -- it is always protected 
against concurrency with a mutex.

It is more about do_compress() called on line 1476 of pack-objects.c for 
example.


> The current solution is the best we can do, try to ditch pack windows 
> and hope that releases sufficient virtual memory space that a second 
> malloc() attempt can succeed by increasing heap.
> 
> We could use a mutex during the malloc failure code-path of xmalloc,
> to ensure only one thread goes through that pack window cleanup at a
> time.  But that will still mess with the main thread which doesn't
> really want to acquire mutexes during object access as it uses the
> existing pack windows.

Right.

> I thought pack-objects did all object access from the main thread and
> only delta searches on the worker threads?

No.  Each thread is responsible for grabbing its own data set.

> If that is true, maybe we
> can have the worker threads signal the main thread on malloc failure
> to release pack windows, and then wait for that signal to be
> acknowledged before they attempt to retry the malloc.  This means the
> main thread would need to periodically test that condition as its
> dispatching batches of objects to the workers.
> 
> Ugly.

Indeed.

The real solution, of course, would be to have pack window manipulations 
protected by a mutex of its own.  This, plus another mutex for the delta 
base cache, and then read_sha1_file() could almost be reentrant.

Another solution could be for xmalloc() to use a function pointer for 
the method to use on malloc error path, which would default to a 
function calling release_pack_memory(size, -1).  Then pack-objects.c 
would override the default with its own to acquire the read_mutex around 
the call to release_pack_memory().  That is probably the easiest 
solution for now.


Nicolas

--Boundary_(ID_gFZphfhVtJRgR94I8DR1xw)--
