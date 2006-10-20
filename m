From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 16:59:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610201630000.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> 
 <ehao3e$2qv$1@sea.gmane.org> <4538EC8F.7020502@utoronto.ca> 
 <200610201821.34712.jnareb@gmail.com>  <20061020181210.GA29843@artax.karlin.mff.cuni.cz>
  <Pine.LNX.4.64.0610201133260.3962@g5.osdl.org> <1161382416.9241.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jan Hudec <bulb@ucw.cz>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 21 02:00:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb4Ha-0006FB-7Q
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 02:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWJUAAA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 20:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbWJUAAA
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 20:00:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21159 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030205AbWJTX77 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 19:59:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9KNxfaX016394
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 20 Oct 2006 16:59:42 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9KNxew0008024;
	Fri, 20 Oct 2006 16:59:40 -0700
To: Jeff Licquia <jeff@licquia.org>
In-Reply-To: <1161382416.9241.19.camel@localhost.localdomain>
X-Spam-Status: No, hits=-0.366 required=5 tests=AWL,BAD_CREDIT,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29560>



On Fri, 20 Oct 2006, Jeff Licquia wrote:
> 
> After this conflict is resolved, merging from b causes conflicts, while
> merging from c appears to work fine.  This continues until b merges from
> a (and resolves a conflict in a similar manner to a), at which time
> merging/pulling works as you'd expect between the branches.  Whenever b
> is marked as conflicting before it merges from a, bzr preserves b's
> changes by moving b's modified file.

This sounds somewhat like what I think BK did. I'm not sure if BK actually 
marked it as a conflict or whether BK just warned about "changes to 
deleted file" or something similar, but it didn't entirely _silently_ 
throw them away.

But I hope this shows some of the basic problems.

The much more _serious_ problem of "file identity" tracking is actually 
that you can't track partial file movement or file copies sanely. The 
thing is, tracking things at file boundaries simply is fundamnetally a 
broken notion, simply because _code_ doesn't get done at file boundaries.

Both of these things that git can actually do. Admittedly it does not do 
that in any _released_ version, so you'd have to work with the development 
branch, and it's a fairly early thing, but currently it can actually 
notice that our "revision.c" file largely came from the "rev-list.c" file 
that still exists!

And btw, that's not just some random feature that happened to get 
implemented last week. Yes, it actually _did_ get implemented last week, 
but this was something I outlined when I started git in April of last 
year, and tried to explain to people WHY TRACKING FILE ID'S ARE WRONG!

You can find me explaining these things to people in April-2005, which 
should tell you something: the initial revision of "git" was on Thursday, 
April 7. So the lack of file identity tracking has been controversial from 
the very beginning, but I was right then, and I'm right now.

Because the _fact_ is, that as long as you track stuff on a file basis, 
you're _never_ going to be able to do the things that git alreadt does, 
and that are very natural.

Here's the real-world example of something that git CAN DO TODAY:

 - we used to have a file called "rev-list.c", which did a lot of the 
   commit history revision traversal, and is the source of the git command 
   "git rev-list".

 - I (and others) extended it a lot, and turned it into a more generic 
   library interface, so that other commands could traverse the commit 
   graph on their own, rather than forking and executing "git-rev-list" 
   and piping the output between them.

 - as a result, the old "rev-list.c" still exists (except it was renamed 
   to "builtin-rev-list.c" since it's now a builtin command to the main 
   "git" binary). 

 - HOWEVER, a lot of the actual code got split into the library file, 
   called "revision.c", which contains the real smarts of the program.

See? There was a file rename involved (rev-list.c => builtin-rev-list.c), 
but that actually happened after a lot of the really _interesting_ code 
had been excised from that file, and put into the new internal library 
file (revision.c).

Now, as a result, in many ways the rename is _much_ less interesting than 
the question about the history of the code in "revision.c" (because that's 
really some very core code). And that was never a rename at all. That was 
just a file create, where a lot of the contents happened to come from a 
file that continued to exist.

Wouldn't you want "annotate" to be able to follow this kind of data 
movement? Notice how there is no "file" that moved at all. Only code that 
moved between files.

I tell you: as long as you work with "file ID's", you'll always be 
inferior. You'll never be able to see that some code was copied 
_partially_ from one file into another. You'll never be able to see an 
important function moving between file boundaries.

Unless you work with "git", that is. Because git isn't so _stupid_ as to 
think that file boundaries matter. Git knows better. The only thing that 
matters is the actual _data_, and file boundaries are just one way of 
delimiting that data.

Just try it out. Get the "next" branch of the git repository (that's the 
"stable development" branch in git.git - ie it's going to be in the next 
release and is expected to work, unless some of the more "experimental 
development" that is in the "pu" branch - pu = proposed updates), compile 
it, and run

	git pickaxe -C revision.c | less -S

and marvel. Marvel at my shining intelligence (and the small matter of 
programming, which was all done by Junio, but I'm taking all the credit 
_anyway_, because *dammit* I talked about this last year when people 
didn't understand! And besides, I always take all the credit regardless, 
so what are you whining about? Get off my back!).

More seriously, Junio really did a kick-ass job. I really had nothing at 
all to do with it, and deserve no real credit. But I _did_ forsee it, and 
yes, it really is about the fact that git tracks _contents_.

As somebody smarter that I have said (*): "I'm always right, but this time 
I'm even more right than usual".

			Linus

(*) Just kidding. It was me. Of course.
