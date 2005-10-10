From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: First cut at git port to Cygwin
Date: Mon, 10 Oct 2005 21:42:49 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510102139540.7861@wbgn013.biozentrum.uni-wuerzburg.de>
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
 <434AC058.60803@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Oct 10 21:42:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP3Xz-0001eU-6j
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 21:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbVJJTmv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 15:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbVJJTmv
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 15:42:51 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:31360 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751174AbVJJTmu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 15:42:50 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C16EA13F09F; Mon, 10 Oct 2005 21:42:49 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A55F79E398; Mon, 10 Oct 2005 21:42:49 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 91B479DFD4; Mon, 10 Oct 2005 21:42:49 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 75B7613F09F; Mon, 10 Oct 2005 21:42:49 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <434AC058.60803@zytor.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9916>

Hi,

On Mon, 10 Oct 2005, H. Peter Anvin wrote:

> Johannes Schindelin wrote:
> > 
> > > Junio C Hamano wrote:
> > > 
> > > > PROT_WRITE is true, but we do MAP_PRIVATE, and if I recall
> > > > correctly we do not write file via mmap -- at least we do not
> > > > intend to.
> > > > 
> > > 
> > > Then PROT_READ probably makes more sense?
> > 
> > Not necessarily. Sometimes you need to annotate the data from the index, and
> > this does not need to be written back to the index file.
> > 
> 
> In the above sentence, emphasis on "at least we do not intend to."  If writes
> are done legitimately then that's fine, but we shouldn't have "accidental
> writes" -- those would be program bugs!

Yes, those would be bugs. However, if I understood the man page for mmap() 
correctly, then PROT_WRITE && MAP_PRIVATE makes the data copy-on-write, 
which means that those bugs would have been found (because the changes 
would no longer be present when git was called the next time). And I 
checked: all mmap() calls in git are MAP_PRIVATE.

> > > > Yes.  It might have been overkill that you supported writing
> > > > changes back, though.
> > > 
> > > Not just overkill; if we do MAP_PRIVATE it's actively WRONG.
> > 
> > See above.
> > 
> 
> Eh?  If we MAP_PRIVATE, *and* we (intentionally) write to it, we *BETTER* not
> write anything back.

Yes. That was *my* mistake.

Ciao,
Dscho
