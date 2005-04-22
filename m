From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: (anal) Q: Are there any coding styles or development guidelines?
Date: Fri, 22 Apr 2005 10:50:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504221044400.2344@ppc970.osdl.org>
References: <87hdi5oet6.dancerj@netfort.gr.jp> <Pine.LNX.4.58.0504171039460.7211@ppc970.osdl.org>
 <20050418055824.42d621b8.froese@gmx.de> <Pine.LNX.4.58.0504211238150.2344@ppc970.osdl.org>
 <17000.43340.760901.175004@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0504220824480.2344@ppc970.osdl.org>
 <Pine.LNX.4.58.0504220838340.2344@ppc970.osdl.org>
 <20050422155845.GC52771@xdt04.mpe-garching.mpg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 22 19:45:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP2CY-0007Wc-Ie
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 19:44:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbVDVRtA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 13:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262087AbVDVRtA
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 13:49:00 -0400
Received: from fire.osdl.org ([65.172.181.4]:51332 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262084AbVDVRsz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 13:48:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3MHmms4022937
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 22 Apr 2005 10:48:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3MHmk8P004185;
	Fri, 22 Apr 2005 10:48:47 -0700
To: Klaus Robert Suetterlin <robert@mpe.mpg.de>
In-Reply-To: <20050422155845.GC52771@xdt04.mpe-garching.mpg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 22 Apr 2005, Klaus Robert Suetterlin wrote:
>
> I'm currently doing a source audit of the git core components.
> Mainly I want to check if I can spot some left over memory leaks.
> 
> Unfortunately ;) I didn't find any so far (after reading five files).
> 
> Still I did find quite a lot of stuff that lint would most likely
> complain about.  Like not checking return values.  Should this be
> fixed now or isn't it time to do the cleanup, yet?

I personally don't think we're quite there yet. You'll note that a lot of 
routines just call "die()" when they don't find the data they want etc. 
All things that we probably will need to clean up eventually, but is fine 
for now.

> I also found several literal copies of the same function including
> function name, parameter list, etc.  Wouldn't it be better do clean
> those up and put them in a utility.{c,h} file?

Yes, we can start doing things like that, especially if they really _do_ 
end up making sense in a bigger picture.

Some of that is because I didn't clean up the Makefile until fairly
recently, so it used to be harder than it is now to have a shared object
file. In contrast, now you just add it to the list of library objects, and
off you go.

> A similar problem
> is the continous reimplementation of linked lists, dynamic memory,
> smart strings / vectors, etc.

Sometimes specific duplication is just _easier_ than trying to be clever 
and having some generic shared version. For example, there's a few 
data-specific versions of "insert into sorted array" there, and the fact 
is, they are so simple that it's likely less work to keep them that way 
than it would be to create some "generic" thing that did it and was passed 
in some descriptor of the data. 

Generic routines aren't always good. Sometimes the abstraction ends up 
adding more of a mental burden than just doing the thing in a simple way 
in the first place. 

> And then there are some stale files (i.e. revision.*) that the Changelog
> already mentions as removed, but which are still active in HEAD.

They definitely are _not_ active in HEAD, at least not in my version.

You may have stale copies in your directory, but they should show up as
being stale when you do "show-files --others".

		Linus
