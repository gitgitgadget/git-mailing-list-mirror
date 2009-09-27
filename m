From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] Remove various dead assignments and dead increments found
 by the clang static analyzer
Date: Sat, 26 Sep 2009 20:41:35 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0909262038470.4997@xanadu.home>
References: <87ab0hepcn.fsf@master.homenet>
 <alpine.DEB.1.00.0909261756510.4985@pacific.mpi-cbg.de>
 <871vltefdj.fsf@master.homenet>
 <fabb9a1e0909261134qd90dba1n9637fe4adc253fc1@mail.gmail.com>
 <87ske9cya9.fsf@master.homenet> <20090926204604.GA2960@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Giuseppe Scrivano <gscrivano@gnu.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 27 02:42:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mrhqq-0004dC-0Q
	for gcvg-git-2@lo.gmane.org; Sun, 27 Sep 2009 02:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855AbZI0Alc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 20:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752780AbZI0Alc
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 20:41:32 -0400
Received: from relais.videotron.ca ([24.201.245.36]:41816 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752746AbZI0Alb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 20:41:31 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KQL0023TTXBWF10@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 26 Sep 2009 20:41:35 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090926204604.GA2960@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129189>

On Sat, 26 Sep 2009, Jeff King wrote:

> On Sat, Sep 26, 2009 at 09:15:58PM +0200, Giuseppe Scrivano wrote:
> 
> > Here is a cleaned patch.  I think these assignments can be removed
> > without any problem.
> 
> I don't agree. For example:
> 
> > --- a/builtin-fetch--tool.c
> > +++ b/builtin-fetch--tool.c
> > @@ -169,7 +169,7 @@ static int append_fetch_head(FILE *fp,
> >  			note_len += sprintf(note + note_len, "%s ", kind);
> >  		note_len += sprintf(note + note_len, "'%s' of ", what);
> >  	}
> > -	note_len += sprintf(note + note_len, "%.*s", remote_len, remote);
> > +	sprintf(note + note_len, "%.*s", remote_len, remote);
> 
> This is a very particular C idiom: you are building a string over
> several statements using a function that adds to the string and tells
> you how much it added. The implicit invariant of the note_len variable
> is that it _always_ contains the current length, so each statement uses
> it as input and pushes it forward on output.
> 
> Any experienced C programmer should look at that and be able to see
> exactly what's going on. And people adding more lines don't need to
> munge the existing lines; the invariant property of note_len means they
> just need to add more, similar lines.
> 
> But your patch destroys that invariant. It makes it harder to see what's
> going on, because it breaks the idiom. And it makes it more likely for
> somebody adding a line further on to make a mistake (and certainly it
> makes their patch harder to read and review, as they have to munge
> unrelated lines).
> 
> So no, while there is no code _now_ that is relying on the invariant
> being kept after the last statement (which is what the static analyzer
> is finding out), the point is not for the compiler to realize that, but
> for human programmers to see it.

And the compiler (at least gcc) is indeed smart enough to realize that 
nothing uses the result from the last statement, and does optimize away 
the code associated to it already.  So this patch is unlikely to change 
anything to the compiled result.


Nicolas
