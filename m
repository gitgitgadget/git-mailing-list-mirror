From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Figured out how to get Mozilla into git
Date: Fri, 9 Jun 2006 20:08:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606092001590.5498@g5.osdl.org>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>
 <46a038f90606091814n1922bf25l94d913238b260296@mail.gmail.com>
 <Pine.LNX.4.64.0606091825080.5498@g5.osdl.org> <Pine.LNX.4.64.0606091837040.5498@g5.osdl.org>
 <9e4733910606091848r5fb4d565taabfc5198140daf2@mail.gmail.com>
 <Pine.LNX.4.64.0606091853180.5498@g5.osdl.org>
 <9e4733910606091921o1d07826w8292dc22b1872345@mail.gmail.com>
 <87y7w5lowc.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 10 05:09:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FotqY-0003KG-Dd
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 05:09:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWFJDJA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 23:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWFJDJA
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 23:09:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37783 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932192AbWFJDI7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jun 2006 23:08:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5A38tgt016013
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 9 Jun 2006 20:08:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5A38sBU007776;
	Fri, 9 Jun 2006 20:08:54 -0700
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87y7w5lowc.wl%cworth@cworth.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 9 Jun 2006, Carl Worth wrote:

> On Fri, 9 Jun 2006 22:21:17 -0400, "Jon Smirl" wrote:
> > 
> > Could you clone the repo and delete changesets earlier than 2004? Then
> > I would clone the small repo and work with it. Later I decide I want
> > full history, can I pull from a full repository at that point and get
> > updated? That would need a flag to trigger it since I don't want full
> > history to come over if I am just getting updates from someone else's
> > tree that has a full history.
> 
> This is clearly a desirable feature, and has been requested by several
> people (including myself) looking to switch some large-ish histories
> from an existing system to git.

The thing is, to some degree it's really fundamentally hard.

It's easy for a linear history. What you do for a linear history is to 
just get the top commit, and the tree associated with it, and then you 
cauterize the parent by just grafting it to go away. Boom. You're done.

The problems are that if the preceding history _wasn't_ linear (or, in 
fact, _subsequent_ development refers to it by having branched off at an 
earlier point), and you try to pull your updates, the other end (that 
knows about all the history) will assume you have all the history that you 
don't have, and will send you a pack assuming that.

Which won't even necessarily have all the tree/blob objects (it assumed 
you already had them), but more annoyingly, the history won't be 
cauterized, and you'll have dangling commits. Which you can cauterize by 
hand, of course, but you literally _will_ have to get the objects and 
cauterize the thing by hand.

You're right that it's not "fundamentally impossible" to do: the git 
format certainly _allows_ it. But the git protocol handshake really does 
end up optimizing away all the unnecessary work by knowing that the other 
side will have all the shared history, so lacking the shared history will 
mean that you're a bit screwed.

Using the http protocol actually works. It doesn't do any handshake: it 
will just fetch objects from the other end as it needs them. The downside, 
of course, is that it also doesn't understand packs, so if the source is 
packed (and it pretty much _will_ be, for any big source), you're going to 
end up getting it all _anyway_.

		Linus
