From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: warning: no common commits - slow pull
Date: Sun, 17 Feb 2008 12:46:03 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802171236560.5496@iabervon.org>
References: <200802102007.38838.lenb@kernel.org> <7vd4r4clnb.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0802162239090.5496@iabervon.org> <alpine.LSU.1.00.0802171449230.30505@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Len Brown <lenb@kernel.org>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 17 18:47:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQnbP-0007hy-Fq
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 18:46:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012AbYBQRqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 12:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbYBQRqH
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 12:46:07 -0500
Received: from iabervon.org ([66.92.72.58]:36260 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752006AbYBQRqG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 12:46:06 -0500
Received: (qmail 833 invoked by uid 1000); 17 Feb 2008 17:46:03 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Feb 2008 17:46:03 -0000
In-Reply-To: <alpine.LSU.1.00.0802171449230.30505@racer.site>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74141>

On Sun, 17 Feb 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Sat, 16 Feb 2008, Daniel Barkalow wrote:
> 
> > I wonder if the problem is that something isn't getting reinitialized 
> > for the second connection. It's not a separate invocation of fetch-pack, 
> > and I can't say for sure that it's sending the right info to the server 
> > when the statics in builtin-fetch-pack.c are left over from the earlier 
> > call. This would particularly explain the information that hitting 
> > ctrl-c and trying again fixes it.
> 
> Oh, that should be it!  After all, the code in get_rev() in 
> builtin-fetch-pack.c marks commits as SEEN and COMMON and POPPED.
> 
> So I guess you'd need to set something like
> 
> 	struct commit_list *rev_list_orig;
> 	...
> 	rev_list_orig = rev_list;
> 
> before
> 
>         while ((sha1 = get_rev())) {
> 
> in the function find_common(), and then, after the while() loop, do 
> something like
> 
> 	while (rev_list_orig) {
> 		clear_commit_marks(rev_list->item,
> 			COMPLETE | COMMON | COMMON_REF | SEEN | POPPED);
> 		rev_list_orig = rev_list_orig->next;
> 	}
> 
> possibly free()ing the rev_lists in the process.

What's currently confusing me, which is probably why I haven't been able 
to reproduce the problem, is how we don't have the newly-received commits 
as still interesting. Clearly there's some way to end up with them 
either not being applicable or being already marked, but I'm not seeing 
it.

(There's a good change that we could fix the problem with your loop, but 
I'd like to have a test case to make sure it's fixed and stays fixed)

	-Daniel
*This .sig left intentionally blank*
