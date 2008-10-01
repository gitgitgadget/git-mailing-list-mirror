From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH, resent] fix openssl headers conflicting with custom
	SHA1 implementations
Date: Wed, 1 Oct 2008 08:54:58 -0700
Message-ID: <20081001155458.GF21310@spearce.org>
References: <alpine.LFD.2.00.0809301621091.3635@xanadu.home> <20080930203928.GN21310@spearce.org> <alpine.LFD.2.00.0809301645340.3635@xanadu.home> <20080930205122.GO21310@spearce.org> <20081001034712.GE24513@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 01 17:56:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl43e-0005OA-Go
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 17:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600AbYJAPy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 11:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752331AbYJAPy7
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 11:54:59 -0400
Received: from george.spearce.org ([209.20.77.23]:44697 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179AbYJAPy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 11:54:59 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 826CA3835F; Wed,  1 Oct 2008 15:54:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081001034712.GE24513@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97242>

Jeff King <peff@peff.net> wrote:
> On Tue, Sep 30, 2008 at 01:51:22PM -0700, Shawn O. Pearce wrote:
> 
> > Yea, its a bit ugly due to the rats nest of system includes.
> > Right now I don't see how we can include your patch, it breaks a
> > major platform for us.  But obviously my "fix" is also bogus and
> > won't get ARM working again.
> > 
> > Any other ideas we can try?  'cause I don't have any right now.  :-|
> 
> I think you have an inherent conflict. Using openssl is going to end up
> including their SHA definition, and we clearly can't include both..
...
> So I think the right way is probably to use a level of indirection. Turn
> the ARM implementation into
> 
>   void ARM_SHA1_Init()
> 
> and
> 
>   #define SHA1_Init ARM_SHA1_Init

Ick.  I agree that renaming our SHA1 implementation to a different
set of symbols is the right solution.  But this could cause trouble
in any code that needs both SHA1 implementation and OpenSSL,
especially if a SHA_CTX was passed to a function in another module.
 
> You can make it even simpler by just having all code call git_SHA1_Init,
> and that will expand to whichever implementation has been chosen.

 $ git grep --cached SHA1_Init | wc -l
 32
 $ git grep --cached SHA1_Final | wc -l
 26
 $ git grep --cached SHA1_Update | wc -l
 39
 $ git grep --cached SHA_CTX | wc -l
 48

I think its easy enough to just rename our SHA_CTX and SHA_*
functions to something more git specific.  Since its mostly a global
s/// we should be able to run it through into master without too
much effort.  It would however make merging certain changes from
maint fun, but I think we can handle it until the 1.6.1 release
goes final.  We tend not to twiddle SHA1 related code in maint.

Of course this is me speaking... Junio is the one that would be faced
with the brunt of that pain.  If it comes down to it I'd be willing
to handle the maint branch and its merges back into master for him.

A funny thing from the above stats... we have 6 SHA1_Init calls
which aren't balanced by a SHA1_Final call.  Weird.

-- 
Shawn.
