From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Fri, 2 Feb 2007 11:42:30 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702021130020.15057@woody.linux-foundation.org>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com>
 <200702010058.43431.jnareb@gmail.com> <20070201003429.GQ10108@waste.org>
 <200702021055.49428.jnareb@gmail.com> <slrnes6mmr.3l6.mdw@metalzone.distorted.org.uk>
 <epvnln$fmn$1@sea.gmane.org> <Pine.LNX.4.64.0702020835550.15057@woody.linux-foundation.org>
 <20070202175923.GA6304@xanadu.kublai.com> <Pine.LNX.4.64.0702021027450.15057@woody.linux-foundation.org>
 <20070202192640.GA7963@ventoux.cs.ubc.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, mercurial@selenic.com,
	git@vger.kernel.org
To: Brendan Cully <brendan@kublai.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 20:42:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD4J0-0007fh-GC
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 20:42:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945898AbXBBTmj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 14:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423186AbXBBTmj
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 14:42:39 -0500
Received: from smtp.osdl.org ([65.172.181.24]:37057 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423183AbXBBTmi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 14:42:38 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l12JgV43014806
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 2 Feb 2007 11:42:31 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l12JgUg5015960;
	Fri, 2 Feb 2007 11:42:31 -0800
In-Reply-To: <20070202192640.GA7963@ventoux.cs.ubc.ca>
X-Spam-Status: No, hits=-0.413 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38530>



On Fri, 2 Feb 2007, Brendan Cully wrote:
> 
> I don't think I do, no. (Maybe it's the double negative construction.)
> Local tags don't get pushed. Tags on private branches don't get
> pushed. Tags on public branches do. This business you describe, where
> you push tags around completely separate from the revisions they tag,
> sounds a little odd. But nothing stops you from maintaining your local
> tags in their own repository, if that's what makes you happy.
> 
> > In other words, tags are just like branches. You don't tie two tags 
> > together, because one may (and does) make sense without the other.
> 
> Which tags are being tied together?

If you tie "tag" together with "history", and push out history, what 
happens?

> It seems to me they clearly do have history.

No they don't. Quite often, tags are generated outside of history, ie you 
tag something as being "known bad" long after it was done. Or you 
(hopefully) tag it with the test-information after it passed (or 
didn't) pass some debug check. Neither of which is something you'd do when 
the thing is actually committed or developed.

So tags are *events*. But if you think they are events "within" the 
history of a tree, you're missing a big issue.

My personal use of tags tends to be
 - I tag releases I make, and sign them etc.
 - when debugging (and using "git bisect" in particular), I tag things for 
   my own memory (ie if a bisection selected something that didn't 
   compile, and I have to pick another point by hand, I tag that bad one 
   temporarily for explanation - the tag shows up nicely in the graphical 
   history viewers)

The "release" tags are done as I develop, since _others_ will do 
regression tests etc later on. I don't know whether those others will add 
their own tags on top of my tag ("passed-regression-test" tag that points 
to my release-tag, which points to whatever commit I released), but it's 
really worth pointing out that that is just a small special case.

That *small* special case I wouldn't mind being part of history. But all 
the other tags should never be, since they are actually personal to 
whoever made them (even though others may well care: for example, if a 
regression run tags something as "passed", a lot of people will care: it 
doesn't mean that the tag should be entirely private!).

And because it's wrong in general to make the tags be bound to history 
(because they may or may not be relevant to others, and they may or may 
not actually happen _during_ the history), it's wrong to design the tags 
that way. Tags really are "outside" the thing, unless you live in a world 
where only the lead engineer is supposed to use tags.

I want tags to be useful for *anybody*. A total non-developer, who decides 
that he wants to test a release, should be able to tag the particular 
versions he happened to test, and it damn well shouldn't be just 
"my-tag-1023". It should allow him to write a small story about what the 
results of the tests were!

Which is how git tags are desiged. They're separate from history, but that 
doesn't make them less useful - it makes them *more* widely useful.

		Linus
