From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] MSVC: Windows-native implementation for subset of Pthreads
 API
Date: Wed, 04 Nov 2009 21:47:20 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911042111270.10340@xanadu.home>
References: <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>
 <1257350100-29281-1-git-send-email-ahaczewski@gmail.com>
 <alpine.LFD.2.00.0911041247250.10340@xanadu.home>
 <16cee31f0911041316n20fc9f12s6595dadc813d8f46@mail.gmail.com>
 <40aa078e0911041341s1adbbf31t6961207ba9c7905b@mail.gmail.com>
 <4AF20534.2030004@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: kusmabite@gmail.com, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 03:47:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5sNi-0004Eb-VV
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 03:47:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754000AbZKECrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 21:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752863AbZKECrQ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 21:47:16 -0500
Received: from relais.videotron.ca ([24.201.245.36]:41808 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbZKECrP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 21:47:15 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KSM009DC7QWU030@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 04 Nov 2009 21:47:20 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <4AF20534.2030004@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132193>

On Wed, 4 Nov 2009, Andrzej K. Haczewski wrote:

> Erik Faye-Lund pisze:
> > Couldn't the windows version of pthread_create have a wrapper
> > function, that corrected the calling convention, much like the
> > function run_thread that start_async in run-command.c has?
> 
> Can't be done without allocations. I'd have to pass to that wrapping
> thread function an address of original function *and* an original
> argument, and there's no way to pack that as one void*.

What about:

typedef struct {
	HANDLE handle;
	void *(*start_routine)(void *);
	void *arg;
} pthread_t;

DWORD __stdcall windows_thread_start(LPVOID _self)
{
	pthread_t *self = _self;
	void *ret = self->start_routine(self->arg);
	return (DWORD)ret;
}

static inline int pthread_create(pthread_t *thread, const void *unused,
                                 void *(*start_routine)(void *), void *arg)
{
        thread->handle = CreateThread(NULL, 0, windows_thread_start, 
                                      thread, 0, NULL);
        [...]
}

?

Sure this will use 8 to 16 more bytes per thread, but we're dealing with 
a rather small number of threads anyway (more threads than the number of 
CPU cores is useless) making this extra memory usage rather 
insignificant compared to the many megabytes of RAM the rest of the code 
is using.  The advantage is full compatibility with the native pthread 
interface git is using at the source level while still being much 
lighter than a full blown pthread implementation.

And thread creation is a relatively rare event compared to e.g. mutex 
lock/unlock, so the indirection shouldn't be noticeable.  For the same 
reason, I also think that you could make pthread_create() and 
pthread_join() into a C file instead of being inlined which would reduce 
the code footprint at every call site, and allow for only one instance 
of windows_thread_start() which could then be made static.


Nicolas
