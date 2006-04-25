From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links
Date: Tue, 25 Apr 2006 08:10:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604250758000.3701@g5.osdl.org>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 25 17:12:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYPBm-0003bt-Kd
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 17:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWDYPKt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 11:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWDYPKs
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 11:10:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31457 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932254AbWDYPKr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Apr 2006 11:10:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3PFAbtH010280
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 25 Apr 2006 08:10:38 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3PFAahV026689;
	Tue, 25 Apr 2006 08:10:37 -0700
To: Sam Vilain <sam.vilain@catalyst.net.nz>
In-Reply-To: <20060425035421.18382.51677.stgit@localhost.localdomain>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19148>



On Tue, 25 Apr 2006, Sam Vilain wrote:
>
> This patch series implements "prior" links in commit objects.  A
> 'prior' link on a commit represents its historical precedent, as
> opposed to the previous commit(s) that this commit builds upon.

I really don't think this is worth it.

We already have a very useful notion of "prior" commit that is used daily 
(well, weekly) for the Linux kernel, and it's used for one of the few 
places where this really makes unequivocal sense. "git revert".

It's also implemented in the only way that has clear and unambiguous 
semantics: by putting the prior link into the free-form part. The reason 
this is clear and unambiguous is that it makes it clear that it has no 
actual technical impact on any serious git strategy, ie there is never any 
question of "What does it _mean_?".

At the same time, it gives exactly what you actually _want_ for a prior 
link: it makes it easy to look up the commit that was replaced, or fixed, 
or that is related, or just any random semantics that you can explain 
easily in the text.

Both gitk and qgit already support it, and it's trivially 
cut-and-pasteable from any log message to see what it is when you work on 
the command line too.

In contrast, adding a new header is serious trouble:

 - What does it _mean_ from a technical angle? 

   Does it matter for merging? One of your patches seems to make it so, 
   which is _really_ confusing. Why should it? And does it affect anything 
   else that git does?

   Does "prior" have any meaning for "git-fsck-objects" and/or for object 
   pruning? For "git fetch/pull"?

 - What does it mean from a semantic standpoint?

   Is "prior" a note that something was reverted? Fixed? Changed? 
   Cherry-picked? And if it is Cherry-picked, than I would flat-out refuse 
   to ever merge with a tree that has it, because it pretty much by 
   definition means that the object that "prior" points to simply doesn't 
   _exist_ in my tree (since it was cherry-picked from somebody elses 
   tree). Or that it means that my history got tangled up with the history 
   of the failed branch that needed cherry-picking to clean up..

 - You say that there is just one "prior" parent, but why just one? 
   There's no way to even _think_ about this, since it seems to have no 
   actual semantic meaning.

I think all the problems really boil down to "What does this mean?"

Without an answer to that question, it's just a random feature. It's 
something that you can use and mis-use, but that has no "meaning". It only 
has whatever meaning you personally assign to it, but that implies that 
git shouldn't parse it, and shouldn't care about it.

Which again says that it should act like the current free-form thing does 
so well - it has no meaning, but it allows easy lookups.

		Linus
