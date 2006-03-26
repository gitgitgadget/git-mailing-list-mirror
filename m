From: Petr Baudis <pasky@suse.cz>
Subject: Re: Following renames
Date: Sun, 26 Mar 2006 12:52:48 +0200
Message-ID: <20060326105248.GG18185@pasky.or.cz>
References: <20060326014946.GB18185@pasky.or.cz> <7virq1sywj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 26 12:52:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNSrV-0006Kn-RA
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 12:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWCZKwi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 05:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWCZKwi
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 05:52:38 -0500
Received: from w241.dkm.cz ([62.24.88.241]:26561 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751261AbWCZKwh (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Mar 2006 05:52:37 -0500
Received: (qmail 15144 invoked by uid 2001); 26 Mar 2006 12:52:48 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7virq1sywj.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18035>

(Note that I do *not* want to raise the explicit vs. implicit rename
tracking argument, in case anyone would misunderstood. I've accepted
implicit rename tracking as a fact of Git life for now. I just want to
make use of it now. ;-)

Dear diary, on Sun, Mar 26, 2006 at 04:49:48AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Looking at the evolution of rev-list.c file itself was a good
> exercise to realize that rename tracking (more specifically,
> having whatchanged to follow renames) is not such a useful
> thing (at least for me).

Well, noone argues that rename tracking cures all the woes of hackerkind
and anything more precise than that is useless. I'm rather saying that
rename tracking indeed _is_ a special case of something more general and
truly very interesting, but a special case so frequent that it's worth
doing even if we can't do the general case yet. Or at least people
*think* it's very frequent and it gives them the warm fuzzy feeling
knowing that the tool can handle it (at least somehow) - and the warm
fuzzy feeling is important, especially if you're trusting your sources
to the tool.

So, obviously, you'll find plenty of counter-examples where rename
detection won't help. I don't argue that. I merely say that there will
still be enough cases where following renames will help to warrant
doing it.

Now, Git history has enough examples of where rename following would be
useful. When I'm digging into the history, I'm hitting the big tools
rename barrier all the time, and just yesterday when wondering about
jdl's <snap> removal from git.txt I've hit 2cf565c53 - coming along any
file to that commit should make me follow Documentation/core-git.txt out
of the commit (well, that's rather copy than rename detection).

> Another example.  Today's tar-tree updates have one interesting
> function I think should belong to strbuf.c, and before merging
> it to the mainline, I may move that function from tar-tree.c to
> strbuf.c.  After that happens, if I run "whatchanged strbuf.c"
> to see where that function came from, I would want it to notice
> it came from tar-tree.c, although it is not a rename at all.
> Just one function moved from a file to another.

A wild pickaxe - when the string disappears from file X, scan all the
changes in the commit and start following files where it reappears. This
should help, right?

But when you want to implement this, you hit the exact same problems as
when you try to follow renames, only a different part of diffcore
detects it. So, what I'm trying to solve is actually not just following
renames but a more general problem.

> If a file A and file B were cleaned up and merged into a single file
> C, which is in the tip of the tree, which one you would want
> whatchanged to switch following depends on which part of the C you
> were interested in.

If in doubt (and the user does not use pickaxe to clarify it), you can
just follow both. The user will get some extra stuff (or maybe even not
if he wants to know about pieces from both), but we are at least trying
to be useful and DTRT instead of doing nothing in case we would by any
chance not do the very best.

> Unless you are interested in the _entire_ contents of the file,
> that is.  Then tracking or even recording renames becomes
> useful, but that is a special case.

A frequent (and wanted) special case.

> That is the reason I am not so enthused about recording renames.
> I think the time is better spent on enhancing what pickaxe tries
> to do (currently it does very little), which I hinted in a
> separate message late last night.

Sure, pickaxe is cool, but as I said above, if you try to teach _it_
following around files, you'll hit the exact same problems as me. We're
just trying to build something using lego blocks with different stuff
inside but otherwise actually looking pretty much the same.

The thing with pickaxe is that frequently it would be simply more
laborous to dig for and construct the proper pickaxe string than just
firing up cg-log -s filename with greedy renames following and quickly
scanning through the results.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
