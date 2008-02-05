From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 9/9] Build in checkout
Date: Tue, 5 Feb 2008 17:28:58 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802051716220.13593@iabervon.org>
References: <alpine.LNX.1.00.0802041336060.13593@iabervon.org> <alpine.LSU.1.00.0802050143050.8543@racer.site> <alpine.LNX.1.00.0802042201060.13593@iabervon.org> <alpine.LSU.1.00.0802052205210.8543@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 05 23:29:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMWIV-0003X2-3O
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 23:29:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbYBEW3D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 17:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbYBEW3D
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 17:29:03 -0500
Received: from iabervon.org ([66.92.72.58]:48702 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932188AbYBEW3B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 17:29:01 -0500
Received: (qmail 16114 invoked by uid 1000); 5 Feb 2008 22:28:58 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Feb 2008 22:28:58 -0000
In-Reply-To: <alpine.LSU.1.00.0802052205210.8543@racer.site>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72711>

On Tue, 5 Feb 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Tue, 5 Feb 2008, Daniel Barkalow wrote:
> 
> > On Tue, 5 Feb 2008, Johannes Schindelin wrote:
> > 
> > So, as an introductory comment, I was working quite strictly from 
> > git-checkout.sh, using the implementations of the operations as given 
> > there, and not looking at what other code has the same goal and may be 
> > doing it differently, so I've almost certainly missed a number of 
> > chances for sharing code (beyond calling functions directly instead of 
> > putting together command lines and having them parsed). In particular, I 
> > hadn't looked at all at builtin-reset, which obviously does a bunch of 
> > the same things.
> 
> Well, it seems like I won't be able to review any more til this weekend.  
> Sorry.

It's okay, I've got other things to work on. I'll probably send out a new 
version of the series now, in any case, so that you can see if I handled 
your comments correctly thus far.

> > > > +	hashcpy(ce->sha1, sha1);
> > > > +	memcpy(ce->name, base, baselen);
> > > > +	memcpy(ce->name + baselen, pathname, len - baselen);
> > > > +	ce->ce_flags = create_ce_flags(len, 0);
> > > > +	ce->ce_mode = create_ce_mode(mode);
> > > > +	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int read_tree_some(struct tree *tree, const char **pathspec)
> > > 
> > > I have a hunch that you could share code with builtin-reset.c, namely 
> > > call function read_from_tree() here.
> > 
> > This version matches the "ls-tree | update-index" implementation in 
> > git-checkout.sh; I'm not terribly fond of the diff-index-based version, 
> > since it messed up the index, rereads it from disk, and then applies 
> > changes. On the other hand, it would probably be good to update the 
> > cache entries with a function that would keep the stat info if nothing 
> > else changed.
> 
> Exactly.  In fact, that is the only reason I suggested that: to prevent 
> the index from needing an update.
> 
> This is quite important if you have a large working tree, and switch 
> branches from A to B.  For example, "make" will punish you where it hurts.

This isn't used for switching branches; this is used for checking out 
paths. If you do "git checkout <not-head> -- <every single path>", make 
will punish you, but why would you do that? I'd guess that people are 
unlikely to have a significant number of non-changes in this piece of 
code, just because they wouldn't list things that they didn't think had 
changes.

> > > > +static void show_local_changes(struct object *head)
> > > > +{
> > > > +	struct rev_info rev;
> > > > +	// I think we want full paths, even if we're in a subdirectory.
> > > 
> > > Please avoid C++-style comments.
> > 
> > Yup. Can we make git build by default with --std=c89, so I get errors for 
> > this sort of thing? *sigh*
> 
> Heh.  You can do that in config.mak.  For the Makefile, I am afraid this 
> is no option, as we try to support other compilers than gcc, too.

I'd say only for the case where CC is initially unset, at which point the 
compiler is going to be "gcc" because we set it to that. And people who 
symlink their non-gcc-like system compiler to gcc have other problems, 
most likely.

> > > > +static int reset_to_new(struct tree *tree, int quiet)
> > > 
> > > Again, I think that this would benefit from code sharing with 
> > > builtin-reset.  It can be a bit tricky to avoid writing files when they 
> > > are already up-to-date...
> > 
> > Reset actually execs "read-tree", which does a bunch of parsing to set up 
> > the arguments like this function does (except that it doesn't keep the 
> > stat info, I think), and then uses the same actual code that this function 
> > calls directly (which has done the only-write-changes thing correctly 
> > since June 2005 or before).
> 
> Okay, I'll just wait and see (as I do not have the time to dive into the 
> code).

Sure. I'll probably actually change builtin-reset to do the non-fork 
thing (in a separate series; it's really unrelated). I doubt there's any 
point to sharing the code for setting all of the options, though, which is 
best to have inlined by the compiler and be easy to find.

	-Daniel
*This .sig left intentionally blank*
