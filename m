From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Thu, 15 Oct 2009 18:16:57 -0400
Message-ID: <20091015221657.GC13180@coredump.intra.peff.net>
References: <alpine.LFD.2.00.0910141616530.20122@xanadu.home>
 <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
 <20091014230934.GC29664@coredump.intra.peff.net>
 <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
 <alpine.LFD.2.00.0910151436180.20122@xanadu.home>
 <7v1vl45t9k.fsf@alter.siamese.dyndns.org>
 <20091015212632.GA13180@coredump.intra.peff.net>
 <7v1vl42uid.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@fluxnic.net>,
	James Pickens <jepicken@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 00:20:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyYgR-0000Dx-Cz
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 00:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758733AbZJOWRf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 18:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758713AbZJOWRf
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 18:17:35 -0400
Received: from peff.net ([208.65.91.99]:38554 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758708AbZJOWRe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 18:17:34 -0400
Received: (qmail 10542 invoked by uid 107); 15 Oct 2009 22:20:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 15 Oct 2009 18:20:30 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Oct 2009 18:16:57 -0400
Content-Disposition: inline
In-Reply-To: <7v1vl42uid.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130430>

On Thu, Oct 15, 2009 at 02:54:18PM -0700, Junio C Hamano wrote:

> Maybe we are reading different messages in the same message.
> 
> My understanding of James's suggestion is:
> 
>  (1) "git checkout $token" makes HEAD point at the refname dwim_ref()
>      expands $token to, iff dwim_ref() is happy, and otherwise detaches
>      HEAD;
> 
>  (2) "git commit" (and other things like "git reset HEAD^" that updates
>      underlying ref thru updates to HEAD when HEAD is a symref) rejects
>      when HEAD points at a ref outside refs/heads/, but works when HEAD
>      points at a local branch, or when HEAD is detached.

Right. I thought the idea of "don't complain at checkout time, but
complain at commit" had been considered and rejected. But I guess you
could argue that the difference between this and the original discussion
is that we are going to have _both_ the detached HEAD state and the
"refs/tags/* in HEAD" state, and treat them differently.

I feel like the latter idea was discussed in more detail (I made
reference to it in the latter email I linked to, but I don't think that
was the origin of it), but I can't seem to find any discussion.

So I will buy that this is somewhat of a new idea. I am still confused
about what happens with this, though:

  $ git checkout origin/next
  $ git fetch ;# updates origin/next

Do we refuse the fetch? Does the user now have a working tree and index
that doesn't match their HEAD?

> This is backward incompatible, and makes what experts are used to do
> slightly cumbersome to spell, i.e.
> 
>     $ git checkout v1.6.5^0      ;# detaches and can commit
>     $ git checkout origin/next^0 ;# ditto
>     $ git checkout $(git merge-base master sp/smart-http) ;# ditto

I think it is less cumbersome if we add "git checkout -d v1.6.5" (well,
same number of characters, but a lot less ugly). Assuming that the rest
of it is a good idea.

-Peff
