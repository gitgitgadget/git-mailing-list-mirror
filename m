From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git bisect with history manipulation
Date: Mon, 23 Oct 2006 08:34:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610230826080.3962@g5.osdl.org>
References: <a425f86c0610230718i556537dei9a4b2a5fa8d7f003@mail.gmail.com>
 <a425f86c0610230722r2a0ae473o467d303f915b6c1e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 17:35:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc1pO-00041E-0L
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 17:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964957AbWJWPey (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 11:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbWJWPey
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 11:34:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43465 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964957AbWJWPex (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 11:34:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9NFYhaX017807
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 23 Oct 2006 08:34:44 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9NFYeBs027790;
	Mon, 23 Oct 2006 08:34:42 -0700
To: Kalle Pokki <kalle.pokki@iki.fi>
In-Reply-To: <a425f86c0610230722r2a0ae473o467d303f915b6c1e@mail.gmail.com>
X-Spam-Status: No, hits=-0.478 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29835>



On Mon, 23 Oct 2006, Kalle Pokki wrote:
> 
> So is there any way to insert a few patches to an arbitrary point
> backwards in time and start bisecting from that to the present time?
> Or am I thinking this somehow all wrong?

It's possible, but you have to do it the patch-application manually at 
each stage, so it's not a lot of fun. I've had to do it for the opposite 
reason: hunting down a bug with "git bisect" when there was _another_ 
unrelated bug that I already had fixed, but that made it impossible to 
test for the first one. Again, in order to see the first one, I did git 
bisect, but then at each stage applied the fix for the second one if 
needed.

So what you would do is to simply do the bisect _as_if_ those patches 
weren't there, and then apply the patches on top of the kernel that "git 
bisect" suggests. Then (and this is important), when you mark the result 
good or bad, don't use just "git bisect good/bad" - but name explicitly 
the commit that you applied your patch-series on.

(This gets a bit easier if you instead of actually cherry-picking the 
patches you want to apply, just apply it as a single patch _without_ 
committing it - then all your changes will be effectively "invisible" to 
git bisect anyway, and you don't need to do much of anything special, 
except do a "git checkout -f" to remove the patch before you say "that was 
bad" or "that was good").

HOWEVER. It's quite possibly easier to just do it the other way: if your 
series of patches causes problems when rebased on top of a newer kernel, 
just bisect your rebased series itself (at which point it's all a totally 
normal "git bisect", and you don't need to do anything special). It may be 
that once you see _which_ patch in the series caused problems, you'll 
immediately say "Oh, duh, that got mis-merged" or (perhaps more likely) by 
pointing to a particular commit it will point to a certain area that 
changed and you suddenly realize _why_ the series caused a problem.

So depending on the problem, you can try two different approaches.

It might make sense to extend "git bisect" with a "apply this patch at 
each point" capability, but that doesn't exist right now. If you do end up 
going that way, and automate it, please do send the patches out for 
discussion.

		Linus
