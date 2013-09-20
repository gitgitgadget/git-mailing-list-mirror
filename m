From: Josef Wolf <jw@raven.inka.de>
Subject: Re: Re-Transmission of blobs?
Date: Fri, 20 Sep 2013 11:27:15 +0200
Message-ID: <20130920092715.GG14259@raven.wolf.lan>
References: <20130910130837.GA14259@raven.wolf.lan>
 <xmqqsixcy395.fsf@gitster.dls.corp.google.com>
 <20130911112758.GB14259@raven.wolf.lan>
 <xmqqsixbth4h.fsf@gitster.dls.corp.google.com>
 <20130912074241.GC14259@raven.wolf.lan>
 <20130912092339.GA30702@sigill.intra.peff.net>
 <20130912103531.GD14259@raven.wolf.lan>
 <20130912194453.GD32069@sigill.intra.peff.net>
 <20130913100934.GE14259@raven.wolf.lan>
 <20130916215536.GB5477@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 20 11:30:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMx2r-0002Vl-4I
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 11:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754236Ab3ITJaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Sep 2013 05:30:12 -0400
Received: from quechua.inka.de ([193.197.184.2]:54845 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754184Ab3ITJaK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Sep 2013 05:30:10 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1VMx1S-0005Q7-IW; Fri, 20 Sep 2013 11:29:10 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id 794377638F; Fri, 20 Sep 2013 11:27:15 +0200 (CEST)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20130916215536.GB5477@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235062>

On Mon, Sep 16, 2013 at 05:55:36PM -0400, Jeff King wrote:
> On Fri, Sep 13, 2013 at 12:09:35PM +0200, Josef Wolf wrote:
> 
> > > > I'm not sure I understand correctly. I see that bitmaps can be used to
> > > > implement set operations. But how comes that walking the graph requires a lot
> > > > of CPU? Isn't it O(n)?
> > > 
> > > Yes and no. Your "n" there is the entirety of history.
> > 
> > Is this really true?
> 
> Yes. If you know that the receiver has commit X, and you want to know if
> it has some blob Y, the only way to know for sure is to look at every
> tree of every commit reachable from X, and see whether any of them
> references Y.

Jeff, in my original example, I did a cherry-pick from origin/somebranch.
Even without asking, we can assume with great probability that
origin/somebranch is available at origin. And the file in question happens to
reside in the tree at the very tip of origin/somebranch, not in some of its
ancestors. In this case, there's no need to search the history at all. And
even in this pretty simple case, the algorithm seems to fail for some reason.

> Yes, you do not have to recurse into sub-trees (or commits) you have
> already seen. And we already do that optimization.

Why is the file re-transmitted, then?


With a little change in the protocol, a very simple optimization could be
implemented, avoiding the complicated bitmap strategy you were talking about:

Please consider Junio's description of the dialog:

[ Junio wrote: ]
> Consider this simple history with only a handful of commits (as
> usual, time flows from left to right):
>
>              E
>             /   
>    A---B---C---D
>
> where D is at the tip of the sending side, E is at the tip of the
> receiving side.  The exchange goes roughly like this:
>
>    (receiving side): what do you have?
>
>    (sending side): my tip is at D.
>
>    (receiving side): D?  I've never heard of it --- please give it
>                      to me.  I have E.
>
>    (sending side): E?  I don't know about it; must be something you
>                    created since you forked from me.  Tell me about
>                    its ancestors.
>
>    (receiving side): OK, I have C.
>
>    (sending side): Oh, C I know about. You do not have to tell me
>                    anything more.  A packfile to bring you up to
>                    date will follow.

In the last step, instead of sending a packfile, the sending side should send
a list of the SHA's which would be included in this packfile. The receiving
side would then be able to request all the objects it needs to get up-to-date.

I think this change would be considerably simpler than the reachability bitmap
you are talking about. And it would avoid all those time consuming traversals
through the history and the tree. And it would omit _all_ redundant
retransmissions. Even in the case when sender and receiver do not have _any_
common heads at all, _no_ files at all would be retransmitted unnecessarily.

-- 
Josef Wolf
jw@raven.inka.de
