From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Re: [PATCH] fix threaded grep for machines with only one cpu
Date: Tue, 16 Feb 2010 13:59:02 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002161352080.1946@xanadu.home>
References: <20100215225001.GA944@book.hvoigt.net>
 <7vwryet2cw.fsf@alter.siamese.dyndns.org>
 <7vocjpnc5v.fsf@alter.siamese.dyndns.org>
 <7vljetlx8r.fsf@alter.siamese.dyndns.org>
 <20100216180209.GA1532@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 19:59:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhSe4-00067M-Lb
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 19:59:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333Ab0BPS70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 13:59:26 -0500
Received: from relais.videotron.ca ([24.201.245.36]:18278 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756682Ab0BPS70 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 13:59:26 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KXY0021C7EECIT0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 16 Feb 2010 13:59:02 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20100216180209.GA1532@book.hvoigt.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140134>

On Tue, 16 Feb 2010, Heiko Voigt wrote:

> On Mon, Feb 15, 2010 at 06:39:48PM -0800, Junio C Hamano wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> > 
> > > Is this the answer to my question?
> 
> Sorry I forgot to add a reference to the thread from which the patch
> originated: http://groups.google.com/group/msysgit/msg/5da53cf1ccf417cf
> 
> > IOW, please try this patch.  I am planning to queue it to 'maint' as part
> > of 1.7.0.1 if this is the right solution (which I obviously think it is).
> 
> Yes your patch does it correctly I just verified that the segfaults are
> gone as well. I think your solution is even nicer than mine. Thanks.
> 
> > -- >8 --
> > From: Junio C Hamano <gitster@pobox.com>
> > Date: Mon, 15 Feb 2010 18:34:28 -0800
> > Subject: [PATCH] Fix use of mutex in threaded grep
> [...]
> > diff --git a/builtin-grep.c b/builtin-grep.c
> > index 26d4deb..5c1545e 100644
> > --- a/builtin-grep.c
> > +++ b/builtin-grep.c
> > @@ -81,8 +81,8 @@ static pthread_mutex_t read_sha1_mutex;
> >  
> >  #define grep_lock() pthread_mutex_lock(&grep_mutex)
> >  #define grep_unlock() pthread_mutex_unlock(&grep_mutex)
> > -#define read_sha1_lock() pthread_mutex_lock(&read_sha1_mutex)
> > -#define read_sha1_unlock() pthread_mutex_unlock(&read_sha1_mutex)
> > +#define read_sha1_lock() do { if (use_threads) pthread_mutex_lock(&read_sha1_mutex); } while (0)
> > +#define read_sha1_unlock() do { if (use_threads) pthread_mutex_unlock(&read_sha1_mutex); } while (0)
> 
> One minor thing: Would it not be even nicer having the while loop inside
> the if clause? E.g like this
> 
> #define read_sha1_lock() if (use_threads) do { pthread_mutex_lock(&read_sha1_mutex); } while (0)
> #define read_sha1_unlock() if (use_threads) do { pthread_mutex_unlock(&read_sha1_mutex); } while (0)

No.  Think what happens if you have code like this:

	if (foo == 1)
		read_sha1_lock();
	else
		baz();


Nicolas
