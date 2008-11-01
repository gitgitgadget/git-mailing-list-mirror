From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: libgit2 - a true git library
Date: Sat, 1 Nov 2008 03:26:45 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811010320370.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20081031174745.GA4058@artemis.corp> <alpine.LFD.2.00.0810311558540.13034@xanadu.home> <20081031213114.GA21799@artemis.corp> <CBF2AF68-BA41-4394-A837-F62864CF8BFB@ai.rug.nl> <20081031232829.GC14786@spearce.org> <7v63n872bs.fsf@gitster.siamese.dyndns.org>
 <20081101001300.GE14786@spearce.org> <alpine.LFD.2.00.0810312106310.13034@xanadu.home> <20081101011910.GH14786@spearce.org> <alpine.LFD.2.00.0810312135190.13034@xanadu.home> <20081101015217.GJ14786@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <gitster@pobox.com>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Nov 01 03:20:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw66T-0007dq-P7
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 03:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbYKACT3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 22:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbYKACT3
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 22:19:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:33126 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751809AbYKACT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 22:19:27 -0400
Received: (qmail invoked by alias); 01 Nov 2008 02:19:26 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp050) with SMTP; 01 Nov 2008 03:19:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/WJw0h5VbWCxTA08f0MWRL72N3FenEYtsN35S0cs
	JlTKa2i7SdWKV3
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20081101015217.GJ14786@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99712>

Hi,

On Fri, 31 Oct 2008, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > On Fri, 31 Oct 2008, Shawn O. Pearce wrote:
> > 
> > > > Both the negative code and errno style are lightweight in the 
> > > > common "no error" case.  The errno style is probably more handy 
> > > > for those functions returning a pointer which should be NULL in 
> > > > the error case.

Unfortunately, errno would not be thread-safe, unless you can guarantee 
that errno is a thread-local variable.

> > > 
> > > I'm sticking with return a negative code for now, to the extent that 
> > > some functions which return a pointer but also have many common 
> > > failure modes (e.g. git_odb_open) use an output parameter as their 
> > > first arg, so the error code can be returned as the result of the 
> > > function.
> > 
> > Actually, the pointer-returning functions can encode error cases into a 
> > "negative" pointer. See include/linux/err.h for example.
> > 
> > 	void *ptr = git_alloc_foo(...);
> > 	if (IS_ERR(ptr))
> > 		die("git_alloc_foo failed: %s", git_strerr(PTR_ERR(ptr)));
> 
> Oh, good point.  We could also stagger the errors so they are
> always odd, and never return an odd-alignment pointer from a
> successful function.  Thus IS_ERR can be written as:
> 
>   #define IS_ERR(ptr) (((intptr_t)(ptr)) & 1)
> 
> which is quite cheap, and given the (probably required anyway)
> aligned allocation policy means we still have 2^31 possible
> error codes available.

Oh boy, both solutions are ugly as hell.  Although the &1 method does not 
limit the memory space as much (except if you plan to work in 
space-contrained environments, where you do not want to be forced to 
word-align structs).

The only pointer game I would remotely consider clean is if you had

	const char *errors[] = {
		...
	};

	inline int is_error(void *ptr) {
		return ptr >= errors && ptr < errors + ARRAY_SIZE(errors);
	}

although that would be less performant.

Ciao,
Dscho
