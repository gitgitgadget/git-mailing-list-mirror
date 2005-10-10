From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: First cut at git port to Cygwin
Date: Mon, 10 Oct 2005 16:27:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0510101620290.23242@iabervon.org>
References: <20051005155457.GA30303@trixie.casa.cgf.cx> <20051005191741.GA25493@steel.home>
 <20051005202947.GA6184@trixie.casa.cgf.cx> <81b0412b0510060205v4cd510c9wb4b06a3ed9242c8@mail.gmail.com>
 <81b0412b0510060307q431b64edt4196553bce28346c@mail.gmail.com>
 <81b0412b0510070544v3e7cf0b4n521db8ff7e4e335a@mail.gmail.com>
 <Pine.LNX.4.64.0510070828270.31407@g5.osdl.org> <20051007205450.GA14827@steel.home>
 <20051007212250.GA1423@steel.home> <4346E8AC.5030503@citi.umich.edu>
 <20051007213952.GA8821@steel.home> <Pine.LNX.4.64.0510080900510.31407@g5.osdl.org>
 <Pine.LNX.4.63.0510082023130.25971@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vr7avrgr2.fsf@assigned-by-dhcp.cox.net> <434AB663.8050205@zytor.com>
 <Pine.LNX.4.63.0510102100010.7688@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Oct 10 22:25:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP4Aj-0005cc-6Z
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 22:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbVJJUWy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 16:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbVJJUWy
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 16:22:54 -0400
Received: from iabervon.org ([66.92.72.58]:39185 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751203AbVJJUWy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Oct 2005 16:22:54 -0400
Received: (qmail 31795 invoked by uid 1000); 10 Oct 2005 16:27:46 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Oct 2005 16:27:46 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0510102100010.7688@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9920>

On Mon, 10 Oct 2005, Johannes Schindelin wrote:

> Hi,
> 
> On Mon, 10 Oct 2005, H. Peter Anvin wrote:
> 
> > Junio C Hamano wrote:
> > > 
> > > PROT_WRITE is true, but we do MAP_PRIVATE, and if I recall
> > > correctly we do not write file via mmap -- at least we do not
> > > intend to.
> > > 
> > 
> > Then PROT_READ probably makes more sense?
> 
> Not necessarily. Sometimes you need to annotate the data from the index, 
> and this does not need to be written back to the index file.

In fact, it is intentional that we open the file O_RDONLY, and mmap it 
PROT_READ | PROT_WRITE, MAP_PRIVATE. We prepare the next index in the 
memory where we mapped the old index, but we don't want to change what's 
on the disk using the mapping; we write that later to a different file 
using write().

> > > Yes.  It might have been overkill that you supported writing
> > > changes back, though.
> > 
> > Not just overkill; if we do MAP_PRIVATE it's actively WRONG.
> 
> See above.
> 
> BTW, is there a mechanism to make sure that the index file is locked 
> between reading and writing?

There's definitely locking; the new file is written to "(filename).lock", 
which is openned O_CREAT | O_EXCL, and is moved to the destination when 
it's complete. I believe everything that intends to write a new index gets 
the lock before reading the old index, although I haven't actually 
checked.

	-Daniel
*This .sig left intentionally blank*
