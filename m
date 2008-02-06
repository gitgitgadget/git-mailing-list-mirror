From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/4] Improve message-id generation flow control for 
 format-patch
Date: Wed, 6 Feb 2008 18:01:09 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802061800490.13593@iabervon.org>
References: <alpine.LNX.1.00.0802061140360.13593@iabervon.org> <7vsl05vncj.fsf@gitster.siamese.dyndns.org> <20080206211326.GA9441@artemis.madism.org> <alpine.LNX.1.00.0802061703230.13593@iabervon.org> <20080206225335.GA23510@artemis.madism.org>
 <20080206225648.GB23510@artemis.madism.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Feb 07 00:01:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMtH0-0001RE-Gf
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 00:01:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758134AbYBFXBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 18:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758211AbYBFXBM
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 18:01:12 -0500
Received: from iabervon.org ([66.92.72.58]:51108 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756949AbYBFXBL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 18:01:11 -0500
Received: (qmail 20743 invoked by uid 1000); 6 Feb 2008 23:01:09 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Feb 2008 23:01:09 -0000
In-Reply-To: <20080206225648.GB23510@artemis.madism.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72872>

On Wed, 6 Feb 2008, Pierre Habouzit wrote:

> On Wed, Feb 06, 2008 at 10:53:35PM +0000, Pierre Habouzit wrote:
> > On Wed, Feb 06, 2008 at 10:10:30PM +0000, Daniel Barkalow wrote:
> > > On Wed, 6 Feb 2008, Pierre Habouzit wrote:
> > > 
> > > > On Wed, Feb 06, 2008 at 08:31:08PM +0000, Junio C Hamano wrote:
> > > > > I wonder how the rule established by b315c5c (strbuf change: be
> > > > > sure ->buf is never ever NULL) and at the beginning of strbuf.h
> > > > > applies here.  I think the current implementation of strbuf
> > > > > happens to allow this, and it is very handy.  Perhaps the rule
> > > > > stated there should be loosened and allow copying the buf away
> > > > > when you know you have stuff in there (i.e. ->buf != slopbuf).
> > > > > Pierre, what do you think?
> > > > > 
> > > > > What the patch does itself is much nicer than the original.
> > > > 
> > > >   Why wouldn't you just use strbuf_detach ? I mean replacing:
> > > > 
> > > > +	info->message_id = buf.buf;
> > > > 
> > > > with:
> > > > 
> > > > +	info->message_id = strbuf_detach(&buf, NULL);
> > > > 
> > > >   isn't really hard to read, and has the nice side effect to prevent
> > > > errors that could happen in the future (like reusing buf and screwing
> > > > with info->message_id without noticing it). I'd rather stand on the safe
> > > > side here, it's more forward-compatible and idiot-proof[0].
> > > 
> > > Is it actually right to have buf go out of scope right after 
> > > strbuf_detach()? It sort of looks like it would leak memory from buf.buf. 
> > > I'm happy to do whatever the API wants there, and I didn't see anything to 
> > > leave the struct as if strbuf_release were called, but with the string 
> > > extracted for the caller.
> > 
> >   err no, strbuf_detach gives you a pointer you are supposed to free()
> > later, and inits the strbuf passed as its argument to be used again,
> > though if you don't, you leak nothing.
> 
>   In fact, strbuf_detach is the rough equivalent of doing that:
> 
>   info->message_id = buf.buf;
>   buf.buf = NULL;
> 
> 
>   Except that it sets buf.buf to a magic place so that it's never NULL,
> and that it also keeps the internal invariants in place. But after a
> strbuf_detach, a strbuf doesn't holds any allocated memory anymore.
> You'll see in many places in the code that
> `return strbuf_detach(&sb, NULL)` is quite idiomatic, and the function
> does exactly what it means "Please detach the memory allocated in that
> buffer and give it to me".

Ah, good. That's what I'll use, then.

	-Daniel
*This .sig left intentionally blank*
