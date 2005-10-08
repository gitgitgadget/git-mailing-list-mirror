From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: First cut at git port to Cygwin
Date: Sat, 8 Oct 2005 21:04:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510082100020.26626@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051005155457.GA30303@trixie.casa.cgf.cx> <20051005191741.GA25493@steel.home>
 <20051005202947.GA6184@trixie.casa.cgf.cx> <81b0412b0510060205v4cd510c9wb4b06a3ed9242c8@mail.gmail.com>
 <81b0412b0510060307q431b64edt4196553bce28346c@mail.gmail.com>
 <81b0412b0510070544v3e7cf0b4n521db8ff7e4e335a@mail.gmail.com>
 <Pine.LNX.4.64.0510070828270.31407@g5.osdl.org> <20051007205450.GA14827@steel.home>
 <20051007212250.GA1423@steel.home> <4346E8AC.5030503@citi.umich.edu>
 <20051007213952.GA8821@steel.home> <Pine.LNX.4.64.0510080900510.31407@g5.osdl.org>
 <Pine.LNX.4.63.0510082023130.25971@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vr7avrgr2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Oct 08 21:05:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOK0B-0005kl-Ty
	for gcvg-git@gmane.org; Sat, 08 Oct 2005 21:05:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbVJHTEr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Oct 2005 15:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbVJHTEq
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Oct 2005 15:04:46 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:60902 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751049AbVJHTEq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2005 15:04:46 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 15C8313EF0E; Sat,  8 Oct 2005 21:04:45 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id F02D39DDA5; Sat,  8 Oct 2005 21:04:44 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id DA9E39DD36; Sat,  8 Oct 2005 21:04:44 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BB97713EF0E; Sat,  8 Oct 2005 21:04:44 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr7avrgr2.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9852>

Hi,

On Sat, 8 Oct 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Am I missing something? I don't see where the changes are written back to 
> > the fd. After all, mmap() is called with PROT_WRITE...
> 
> PROT_WRITE is true, but we do MAP_PRIVATE, and if I recall
> correctly we do not write file via mmap -- at least we do not
> intend to.

Ahh! Reading the man page helps!

> Yes.  It might have been overkill that you supported writing
> changes back, though.

Sure. Something like this?

diff --git a/compat/mmap.c b/compat/mmap.c
index fca6321..fda39fc 100644
--- a/compat/mmap.c
+++ b/compat/mmap.c
@@ -49,7 +49,7 @@ void *gitfakemmap(void *start, size_t le
 		n += count;
 	}
 
-	if(prot & PROT_WRITE) {
+	if((prot & PROT_WRITE) && !(flags & MAP_PRIVATE)) {
 		fakemmapwritable *next = xmalloc(sizeof(fakemmapwritable));
 		next->start = start;
 		next->length = length;
