From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "git-send-pack"
Date: Thu, 30 Jun 2005 14:29:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506301412470.14331@ppc970.osdl.org>
References: <Pine.LNX.4.21.0506301651250.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 23:26:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do6Xi-0003gg-39
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 23:25:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263074AbVF3VcV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 17:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263073AbVF3V3x
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 17:29:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9406 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263074AbVF3V1U (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jun 2005 17:27:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5ULRDjA028080
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 30 Jun 2005 14:27:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5ULRCB6001698;
	Thu, 30 Jun 2005 14:27:13 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0506301651250.30848-100000@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 30 Jun 2005, Daniel Barkalow wrote:
> 
> I suspect that I'll be able to merge send-pack/receive-pack with
> ssh-push/ssh-pull this evening, and then it'll have the feature of not
> caring too much which side your command line is on.

The simple thing to do is to just get one commit at a time, see if you 
have it already, parse if it not, and go on to the parents.

That would fit the current git-pull thing, and may be good enough, but it 
has the downside that it can need a _lot_ of back-and-forth fecthing of 
commit objects from the other side until you find the one you want. That's 
going to be _very_ slow over a high-latency connection.

So what I'd suggest is:

 - puller starts by just asking "what's your SHA1 for the ref I want"

   The puller wants to know this, because a common case may be that it 
   already has it, in which case it doesn't need to do anything. But more 
   importantly, the puller will need to know this anyway if it gets an 
   object-pack, so that the puller can update it's FETCH_HEAD.

 - if puller doesn't have it, then the _puller_ does:

	"git-rev-list my-current-refs"

   to generate an in-date-order list of commits it has, and it starts 
   feeding the result in chunks of 100 entries or something to the other
   end.

 - now, the server sees this stream of SHA1's that the client wants, and 
   it can very cheaply just test "do I have this SHA1". Now, if the client 
   hasn't made any changes at all, then the first one will be a hit, and 
   we already have sufficient knowledge to tell what the difference 
   between the client and the server is.

   But more importantly, even if the client _has_ made changes, the client 
   likely has more available CPU than the server has, _and_ the client 
   likely has a shorter list of changes than the server has, so it's
   really the client that should do this. We should burden the server as 
   lightly as possible for this to scale.

 - At some point the server sees the first SHA1 it recognizes, and at that 
   point the server will have to start working. It will just send back an 
   "ok, got it" message (telling the client to not bother continuing to 
   send it any more commit ID's), and then does

	git-rev-list --objects ref-client-wants ^first-common-sha1 |
		git-pack-objects --stdout

 - the client just unpacks the objects, and if successful, it puts the new 
   top ref it got into FETCH_HEAD. It's now done.

And I do _not_ think that it makes a lot of sense to try to be symmetric.  
For one thing, while a "git-send-pack" should update all the refs
in-place, a "git-pull-pack" should _not_ update the ref, it should just
set FETCH_HEAD instead and the puller can decide what he wants to do with
that ref (possibly merge it, but possibly just make it be a new local
branch "remote-branch").

So I think sending and receiving are fundamentally non-symmetric.

		Linus
