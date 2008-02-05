From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 5/9] Add "skip_unmerged" option to unpack_trees.
Date: Tue, 5 Feb 2008 15:38:52 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802042127210.13593@iabervon.org>
References: <alpine.LNX.1.00.0802041335530.13593@iabervon.org> <alpine.LSU.1.00.0802050129570.8543@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 05 21:39:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMUa1-00046i-Ie
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 21:39:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758471AbYBEUi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 15:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758325AbYBEUi5
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 15:38:57 -0500
Received: from iabervon.org ([66.92.72.58]:48622 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758106AbYBEUi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 15:38:56 -0500
Received: (qmail 9471 invoked by uid 1000); 5 Feb 2008 20:38:52 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Feb 2008 20:38:52 -0000
In-Reply-To: <alpine.LSU.1.00.0802050129570.8543@racer.site>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72695>

On Tue, 5 Feb 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Mon, 4 Feb 2008, Daniel Barkalow wrote:
> 
> 
> >  		if (any_files) {
> > -			if (o->merge) {
> > +			if (skip_entry) {
> > +				do
> > +					o->pos++;
> > +				while (o->pos < active_nr &&
> > +				       !strcmp(active_cache[o->pos]->name,
> > +					       src[0]->name));
> > +			} else if (o->merge) {
> 
> Maybe it is just me, but I would have thought
> 
> 				while (++o->pos < active_nr)
> 					if (strcmp(active_cache[o->pos]->name,
> 							src[0]->name))
> 						break;
> 
> more readable.  But that's maybe because I have trouble with do ... while 
> constructs logically (I like to see the loop condition first, then the 
> loop body).

I find yours less readable, because the loop condition is an exceptional 
case (this is the last entry, so we run out of active_cache before finding 
anything else), and you've got the actual effect of the loop in the 
condition instead of the body, and I find using the value of ++x or x++ a 
bit confusing outside of regular idioms. I'd go for:

				o->pos++;
				while (o->pos < active_nr &&
				       !strcmp(active_cache[o->pos]->name,
					       src[0]->name))
					o->pos++;

if you care, though; it's not bad to make it clear we're skipping the 
first of these entries based on a different consideration from the rest 
(the first is the entry we decided to skip, and the rest are ones that 
match it in filename).

	-Daniel
*This .sig left intentionally blank*
