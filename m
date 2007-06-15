From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git-send-pack SIGSEGV..
Date: Fri, 15 Jun 2007 10:27:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0706150949300.5848@iabervon.org>
References: <alpine.LFD.0.98.0706142124380.14121@woody.linux-foundation.org>
 <7vvedp935y.fsf@assigned-by-dhcp.pobox.com> <7vr6od92nj.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 16:27:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzCmD-0001xS-Ol
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 16:27:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853AbXFOO1s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 10:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbXFOO1s
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 10:27:48 -0400
Received: from iabervon.org ([66.92.72.58]:4297 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751379AbXFOO1r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2007 10:27:47 -0400
Received: (qmail 32344 invoked by uid 1000); 15 Jun 2007 14:27:46 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Jun 2007 14:27:46 -0000
In-Reply-To: <7vr6od92nj.fsf@assigned-by-dhcp.pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50263>

On Thu, 14 Jun 2007, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Linus Torvalds <torvalds@linux-foundation.org> writes:
> >
> >> I *suspect* it's due to the refspec pattern matching changes Daniel did, 
> >> but again - I haven't actually debugged it any deeper.
> >
> > I am officially recuperating from an operation I had today, so I
> > cannot really take a deep look at this.
> >
> > I think what is going wrong is that struct refspec for pattern
> > match that is parsed by parse_ref_spec does not have ->dst
> > component filled for "refs/tags/*" refspec, but match_refs()
> > does not check if pat->dst is NULL, in which case it should
> > reuse pat->src value.
> >
> > Incidentally I have other remote.c fixes queued in 'next'.  I
> > haven't yet checked if I (accidentally) fixed this already.
> 
> Completely untested, but this may fix it.
> 
> I suspect this has an side effect of allowing
> 
> 	fetch = refs/heads/*
> 
> to mean the same thing as
> 
> 	fetch = refs/heads/*:refs/heads/*
> 
> which is suitable for a bare mirroring repository, but I do not
> think of any downside, so it might be Ok.
> 
> But that is something from a person who was under anesthesia a
> few hours ago, so you should take it with a big grain of salt ;-)

Yeah, that's not right; "push = refs/heads/*" works like that, but 
"fetch = refs/heads/*" puts them in MERGE_HEAD without storing them 
anywhere, unlike "fetch = refs/heads/*:refs/heads/*". That's why I didn't 
just copy the left side to the right side, which is what the old parsing 
code did: what you're going to do with the refspec determines how you 
interpret a missing rhs. So it needs to be the code that uses the refspec 
that handles this case.

Your analysis of the failure was right, though. I reproduced it, and this 
fixes it for me:

--- cut here ---
Author: Daniel Barkalow <barkalow@iabervon.org>
Date:   Fri Jun 15 10:22:37 2007 -0400

    Fix pushing to a pattern with no dst
    
    Refspecs with no colons are left with no dst value, because they are
    interepreted differently for fetch and push. For push, they mean to
    reuse the src side. Fix this for patterns.
    
    Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

diff --git a/remote.c b/remote.c
index 6121416..c860740 100644
--- a/remote.c
+++ b/remote.c
@@ -546,10 +546,11 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 		}
 
 		if (pat) {
-			dst_name = xmalloc(strlen(pat->dst) +
+			const char *dst_side = pat->dst ? pat->dst : pat->src;
+ 			dst_name = xmalloc(strlen(dst_side) +
 					   strlen(src->name) -
 					   strlen(pat->src) + 2);
-			strcpy(dst_name, pat->dst);
+			strcpy(dst_name, dst_side);
 			strcat(dst_name, src->name + strlen(pat->src));
 		} else
 			dst_name = xstrdup(src->name);
