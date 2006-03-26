From: Junio C Hamano <junkio@cox.net>
Subject: Re: Following renames
Date: Sat, 25 Mar 2006 18:49:48 -0800
Message-ID: <7virq1sywj.fsf@assigned-by-dhcp.cox.net>
References: <20060326014946.GB18185@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 26 04:50:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNLKD-000085-M9
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 04:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWCZCtu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 21:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWCZCtu
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 21:49:50 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:8136 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751363AbWCZCtu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Mar 2006 21:49:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060326024949.SJYS26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 25 Mar 2006 21:49:49 -0500
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20060326014946.GB18185@pasky.or.cz> (Petr Baudis's message of
	"Sun, 26 Mar 2006 03:49:47 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18021>

Petr Baudis <pasky@ucw.cz> writes:

>   An obvious solution would be to have git-diff-tree --follow which
> updates its interesting path set based on seen renames, and now that
> I've written about non-linear history, it's obvious that it's incorrect.
> The other obvious way to go is then to add rename detection support to
> git-rev-list, and it's less obvious that this is a dead end too - I
> didn't inspect the code myself yet, but for now I trust Linus in [2]
> (I didn't quite understand the argument, I guess I need to sleep on it).

I'd have to sleep on how the core side can help Porcelains, but
I think it is a good thing that you, one of the most vocal
advocate on the list for doing rename recording, are thinking
about this issue and probably would look into rev-list.c soon.

Looking at the evolution of rev-list.c file itself was a good
exercise to realize that rename tracking (more specifically,
having whatchanged to follow renames) is not such a useful
thing (at least for me).

If I am interested in rev-list.c's evolution from "the set of
command line flags it supported" point of view, then whatchanged
to show the history of rev-list.c file itself would be a very
good way to show that to me.  rev-list_usage[] = "..." stayed
there almost from the beginning.

However, if I am interested in the way how it traverses the
commits has changed over time, I would need to start from
revision.c and switch to rev-list.c when that part of the code
was split out from it, because the current rev-list.c does not
have the main part of the traversal logic at all.

Another example.  Today's tar-tree updates have one interesting
function I think should belong to strbuf.c, and before merging
it to the mainline, I may move that function from tar-tree.c to
strbuf.c.  After that happens, if I run "whatchanged strbuf.c"
to see where that function came from, I would want it to notice
it came from tar-tree.c, although it is not a rename at all.
Just one function moved from a file to another.

What this suggests is that switching the set of paths to follow
while traversing ancestry chain needs to depend on which part of
the original file you are interested in.  Marking "this commit
renames (or copies) file A to file B" is not that useful -- for
that matter, detecting at runtime like we currently do is not
better either.  If a file A and file B were cleaned up and
merged into a single file C, which is in the tip of the tree,
which one you would want whatchanged to switch following depends
on which part of the C you were interested in.

Unless you are interested in the _entire_ contents of the file,
that is.  Then tracking or even recording renames becomes
useful, but that is a special case.

That is the reason I am not so enthused about recording renames.
I think the time is better spent on enhancing what pickaxe tries
to do (currently it does very little), which I hinted in a
separate message late last night.

But that does not have to stop you, and does not have to stop me
from thinking about ways to help you either.
