From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Storing permissions
Date: Sun, 17 Apr 2005 09:10:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504170857580.7211@ppc970.osdl.org>
References: <20050416230058.GA10983@ucw.cz> <118833cc05041618017fb32a2@mail.gmail.com>
 <20050416183023.0b27b3a4.pj@sgi.com> <Pine.LNX.4.58.0504162138020.7211@ppc970.osdl.org>
 <42620092.9040402@dwheeler.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Jackson <pj@sgi.com>, Morten Welinder <mwelinder@gmail.com>,
	mj@ucw.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 18:05:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNCGT-0007Ty-QR
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 18:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbVDQQIn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 12:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbVDQQIn
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 12:08:43 -0400
Received: from fire.osdl.org ([65.172.181.4]:43454 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261344AbVDQQIj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 12:08:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3HG8Ss4031730
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 17 Apr 2005 09:08:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3HG8Rjx024836;
	Sun, 17 Apr 2005 09:08:27 -0700
To: "David A. Wheeler" <dwheeler@dwheeler.com>
In-Reply-To: <42620092.9040402@dwheeler.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 17 Apr 2005, David A. Wheeler wrote:
> 
> There's a minor reason to write out ALL the perm bit data, but
> only care about a few bits coming back in: Some people use
> SCM systems as a generalized backup system

Yes. I was actually thinking about having system config files in a git 
repository when I started it, since I noticed how nicely it would do 
exactly that.

However, since the mode bits also end up being part of the name of the 
tree object (ie they are most certainly part of the hash), it's really 
basically impossible to only care about one bit but writing out many bits: 
it's the same issue of having multiple "identical" blocks with different 
names.

It's ok if it happens occasionally (it _will_ happen at the point of a
tree conversion to the new format, for example), but it's not ok if it
happens all the time - which it would, since some people have umask 002
(and individual groups) and others have umask 022 (and shared groups), and
I can imagine that some anal people have umask 0077 ("I don't want to play
with others").

The trees would constantly bounce between a million different combinations 
(since _some_ files would be checked out with the "other" mode).

At least if you always honor umask or always totally ignore umask, you get 
a nice repetable thing. We tried the "always ignore" umask thing, and the 
problem with that is that while _git_ ended up always doing a "fchmod()" 
to reset the whole permission mask, anybody who created files any other 
way and then checked them in would end up using umask.

One solution is to tell git with a command line flag and/or config file 
entry that "for this repo, I want you to honor all bits". That should be 
easy enough to add at some point, and then you really get what you want.

That said, git won't be really good at doing system backup. I actually 
_do_ save a full 32-bit of "mode" (hey, you could have "immutable" bits 
etc set), but anybody who does anything fancy at all with mtime would be 
screwed, for example.

Also, right now we don't actually save any other type of file than
regular/directory, so you'd have to come up with a good save-format for
symlinks (easy, I guess - just make a "link" blob) and device nodes (that
one probably should be saved in the "cache_entry"  itself, possibly
encoded where the sha1 hash normally is).

Also, I made a design decision that git only cares about non-dotfiles. Git 
literally never sees or looks at _anything_ that starts with a ".". I 
think that's absolutely the right thing to do for an SCM (if you hide your 
files, I really don't think you should expect the SCM to see it), but it's 
obviously not the right thing for a backup thing.

(It _might_ be the right thing for a system config file, though, eg 
tracking something like "/etc" with git might be ok, modulo the other 
issues).

			Linus
