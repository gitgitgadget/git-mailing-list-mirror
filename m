From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Wed, 10 Jan 2007 11:30:23 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701101041210.20138@iabervon.org>
References: <7vac11yirf.fsf@assigned-by-dhcp.cox.net> <87ps9xgkjo.wl%cworth@cworth.org>
 <7virfprquo.fsf@assigned-by-dhcp.cox.net> <87odphgfzz.wl%cworth@cworth.org>
 <7vbql9ydd7.fsf@assigned-by-dhcp.cox.net> <20070108131735.GA2647@coredump.intra.peff.net>
 <7vzm8tt5kf.fsf@assigned-by-dhcp.cox.net> <20070109142130.GA10633@coredump.intra.peff.net>
 <7virffkick.fsf@assigned-by-dhcp.cox.net> <20070109213117.GB25012@fieldses.org>
 <87zm8ryiyz.wl%cworth@cworth.org> <45A4AD08.1020002@op5.se>
 <7vwt3vb4ev.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Jeff King <peff@peff.net>, Carl Worth <cworth@cworth.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 17:30:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4gLT-0005oE-9m
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 17:30:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbXAJQaZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 11:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbXAJQaZ
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 11:30:25 -0500
Received: from iabervon.org ([66.92.72.58]:2269 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964929AbXAJQaY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 11:30:24 -0500
Received: (qmail 31899 invoked by uid 1000); 10 Jan 2007 11:30:23 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Jan 2007 11:30:23 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwt3vb4ev.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36517>

On Wed, 10 Jan 2007, Junio C Hamano wrote:

> Andreas Ericsson <ae@op5.se> writes:
> 
> > ... Since committing on
> > detached heads really should be a very rare case I don't think many
> > people will find this terribly annoying.
> 
> Quite the contrary, I would imagine it would be quite natural to
> do throw-away commits and merges on detached head while
> bisecting the history (e.g. commit small fixup to make it
> compile and then mark the result for bisection to hunt for real
> bugs that are hidden by silly compilation problems).  

I don't think this would actually work. If you commit your build fix, and 
then mark the result as bad, won't bisect skew its choices due to 
suspecting that your build fix is the real bug?

I'd think that, if you make changes while bisecting, you probably want to 
leave those changes uncommitted, and merge or discard them when testing 
other commits.

If anything, I'd think you'd want a rather different sort of commit 
mechanism than the usual commit, which says, "whenever you consider commit 
{sha1-from-real-history}, use {tree-with-local-changes} instead of 
{tree-in-real-commit}." Or, more generally, "in order to get the trees 
I want to actually use, this patch (git diff HEAD) needs to be applied to 
every commit in some portion of the history including, at least, 
get_sha1(HEAD)".

I'm not seeing any actual benefit to causing the history to contain a 
dead-end fork off of an antique commit, and then throwing this away. And 
committing your change so that it won't get lost, with the intention of 
losing it in a little while, doesn't seem to make any sense, either.

(Of course, it also makes sense to do merges, but again, you probably want 
to create and temporarily use the working tree resulting from the merge, 
not create the commit.)

I think that the workflow that uses regular commits with a detached HEAD 
is this: do a series of commits representing real work on top of a remote 
branch or a tag, and decide later (once you've tested the results for 
worthiness) whether to turn this into a topic branch or throw it away.

But I don't think this is a good match for detached HEAD, because you may 
want to do exactly the same thing, but start with a regular local head. I 
think the right thing to do is something like "git checkout --anon", which 
puts you on a new branch with no name, which will evaporate if you leave 
it (as per "git branch -d"; you need to force it if it isn't fully 
merged).

So I think the feature which lets you make commits without being on a 
branch from refs/heads is actually a different feature from "detached 
HEAD", which only shares the aspect that "git branch" has no line with a 
"*", because there is no name for what HEAD points to.

(I'd implement "anonymous branch" by putting you on refs/heads/.anon, and 
adding rules for this situation to for_each_ref and update_ref; but that's 
an implementation detail, and shouldn't affect the intended semantics of 
the feature.)

	-Daniel
*This .sig left intentionally blank*
