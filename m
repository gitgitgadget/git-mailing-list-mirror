From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Write index file on any checkout of files
Date: Thu, 28 Feb 2008 16:21:33 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802281547320.19665@iabervon.org>
References: <87wsop188j.fsf@wine.dyndns.org> <alpine.LNX.1.00.0802281058190.19665@iabervon.org> <7vfxvcj0b7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Alexandre Julliard <julliard@winehq.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 22:22:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUqDA-0007Lv-R0
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 22:22:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754508AbYB1VVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 16:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754445AbYB1VVg
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 16:21:36 -0500
Received: from iabervon.org ([66.92.72.58]:60096 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751753AbYB1VVf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 16:21:35 -0500
Received: (qmail 26552 invoked by uid 1000); 28 Feb 2008 21:21:33 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Feb 2008 21:21:33 -0000
In-Reply-To: <7vfxvcj0b7.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75460>

On Thu, 28 Feb 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > We need to rewrite the index file when we check out files, even if we
> > haven't modified the blob info by reading from another tree, so that
> > we get the stat cache to include the fact that we just modified the
> > file so it doesn't need to be refreshed.
> 
> Thanks, Alexandre, for spotting.
> 
> > -static int checkout_paths(const char **pathspec)
> > +static int checkout_paths(const char **pathspec, int newfd, struct lock_file *lock_file)
> >  {
> > ...
> > @@ -554,11 +549,14 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
> >  			}
> >  		}
> >  
> > +		int newfd;
> > +		struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
> > +		newfd = hold_locked_index(lock_file, 1);
> > +		read_cache();
> > +
> >  		if (source_tree)
> >  			read_tree_some(source_tree, pathspec);
> > -		else
> > -			read_cache();
> > -		return checkout_paths(pathspec);
> > +		return checkout_paths(pathspec, newfd, lock_file);
> 
> Aside from decl-after-statement, I suspect that at this point
> these all should go to checkout_paths() function itself, that
> takes pathspec and source_tree (which could be NULL), but that
> is only "logical code organization" issue.  Thanks for fixing.

Yeah, that's a better organization, and makes the code nice. Want it as a 
replacement patch or as an additional patch on top of this one?

> I however would have liked if this were caught while the topic
> was still cooking in 'next'.
> 
> There was a process failure somewhere, which makes me worry more
> than just this single bug that escaped to 'master'.  Alex
> Riesen's segv fix in another thread makes it double X-<.

This one is a stat cache problem, and those tend not to get noticed for a 
while in normal use, simply because everything works fine, but makes 
subsequent operations a bit slower.

Alex's is a case where an operation that should fail fails ungracefully, 
which is again unlikely to be uncovered by normal use, because people just 
don't do that.

I think that cooking in next isn't likely to matter much to either of 
these classes of problems, and we need to catch them in regression 
testing. They're also not the sort of thing that we're likely to test for 
specifically, so it would be nice to have something in test-lib to do it 
in general. It would be nice to have automatic checks after every test 
that nothing segfaulted, and a helper (which could be sprinkled liberally 
through the test suite) to make sure that nothing has stale stat cache 
info (without being actually changed).

	-Daniel
*This .sig left intentionally blank*
