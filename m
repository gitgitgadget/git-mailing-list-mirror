From: Jan Krueger <jk@jk.gs>
Subject: Re: [PYRITE] Status update and call for information.
Date: Sun, 25 May 2008 11:23:32 +0200
Message-ID: <20080525112332.52de8270@perceptron>
References: <5d46db230805222318j25657c10t2955fbdf1aa5c003@mail.gmail.com>
	<m34p8o4ijg.fsf@localhost.localdomain>
	<5d46db230805232216p7936e5dex3aa3ff0e1e0dce06@mail.gmail.com>
	<m3r6bs2ixn.fsf@localhost.localdomain>
	<5d46db230805241043u7222be34w7dd8cfcb188ef005@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Govind Salinas" <blix@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Sun May 25 11:25:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0CTf-0007Cu-4M
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 11:25:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702AbYEYJYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2008 05:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754562AbYEYJYK
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 05:24:10 -0400
Received: from zoidberg.org ([213.133.99.5]:43808 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754513AbYEYJYI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2008 05:24:08 -0400
Received: from perceptron (p54BB8755.dip0.t-ipconnect.de [::ffff:84.187.135.85])
  (AUTH: LOGIN jast, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by cthulhu.zoidberg.org with esmtp; Sun, 25 May 2008 11:24:04 +0200
  id 0015B434.48393034.00000D0D
In-Reply-To: <5d46db230805241043u7222be34w7dd8cfcb188ef005@mail.gmail.com>
X-Mailer: Claws Mail 3.3.1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82859>

Hi,

allow me to play the devil's advocate here.

Your approach is to combine different concepts that are similar and can
be used to do the same thing but in completely different ways. Wouldn't
this actually create more confusion than keeping these concepts
separate? Examples follow.

> The idea is that there should be one fairly obvious way to do
> something. If you have that then there is less confusion, especially
> when someone asks for help.  Plus, if there is one fairly obvious way
> to do something, then people will need to ask for help less often.

If people didn't ask things like "how do I delete a file", I'd be more
inclined to believe that. ;)

Now, on to the fun part.

> * commit = commit + push + stash + init
>           push:  This is here because it fits the traditional notion
> of what a commit does, which is to send a commit to the central
>                     server.  I think of it as "I am committing my
> changes to the remote repository.

The problem I see there is that it will be difficult to include the
part of push that sends several commits at once. It is a very common
workflow to create a series of local commits, test them, possibly
rewrite them in several ways, and finally push the entire set. To have
your combined command do that, you'd need something like "pyt commit
--to-remote --use-new-local-commits". Is that better than "pyt
push" (and does describing this as "committing" actually make sense)? I
think not. It's sacrificing convenience and sense for reducing the
visible number of commands.

>           stash:  What is stash but a temporary commit (not on the
> branch)?

This is correct, but only technically. In fact, a commit is something
that you'll typically share with others, whereas a stash is not. This
makes me doubt it's helpful to combine both.

> * checkout = checkout + clone + branch + remote

Checkout already has a doubtful duality: it can either switch branches
or check out a specific version of a single file. I don't think
capitalizing on the 'switch branches' concept while keeping the other
function is a good idea. At the very least, consider splitting "fetch
other version of this file" into a separate command.

I can see another source of confusion here: with this, checkout can
either create a new repo or a new branch in the same repo. In other
words, what it does depends on the context you call it in. This is a
no-no in interface design.

Finally, "remote" could just as well go with pull or push (which is
what it's actually used for in practice). The act of defining or
removing a remote is misplaced here since it has nothing to do with
checking anything out.

>   gc = clean + gc + prune + repack

See Jakub's comment about that. I strongly agree with him.

> * pull = pull, fetch, merge

Unlike what Jakub says, I can imagine this working well in the
distributed case. It could be a command that does both fetch and merge
by default and you can switch off either. It would make little sense
when merging a number of local branches, however.

>   revert = reset + reflog

Keep in mind that you need to stick git-revert somewhere, too.

> (still revert)
>           I was thinking of calling this command "recover" instead of
>           revert, which I still think might describe what I want to do
>           and might tell you why I think that reflog is something to
>           combine here.  "revert --what-can-i-revert-to" would show
>           the output of reflog.

Another source of confusion, since I almost never use the reflog for
git-reset. I almost always use a commit ID or something like HEAD^, or
no argument at all (mostly for reset --hard).

> * track = add/addremove

That would only make sense if you hide the index completely. I think
that's a bad idea, because the index is a really powerful thing. At the
very least, add -i gets impossible if there's no way of influencing the
index directly.

It would be a lot better to keep commit -a (and perhaps hint at it if
commit is called with an unchanged index) and define something like the
following:

* stage (or record, take, use) -- same as git-add.
* remove (rm) -- same as git-rm. Probably good to rename --cached.
* unstage (or unrecord) -- revert index to version in last commit.

> They are useful for a different purpose.  If I say master~5 today it
> probably won't yield the same commit tomorrow.  while 6450:master
> would.

That's right, but keep in mind that revision numbers will probably make
people think revision numbers are global, e.g. "hey Bill, check out
revision 3488 I committed today" (and Bill gets it as 3754). The
background of either CVS or SVN would encourage this.

Also, 6450:master, as a syntax, doesn't cut it. What if in the past of
master, a merge commit with seven parents happened? It's impossible to
figure out which parent to follow. You'd have to write something like
45;1:357,4:774 (go back 45 commits, take parent 1, go back 357 commits,
etc.). Just numbering all commits in master's past according to
depth-first search, on the other hand, will just make revision numbers
very confusing.

Something else to consider is that revision numbers are hardly better
to remember than (abbreviated) commit IDs. Consider KDE's SVN repository
with (currently) 812270 revisions...

> I just put this in because I have seen several people ask for it on
> the mailing list recently.  I thought to myself, that they COULD have
> it if they really wanted.

But with a number of important disadvantages. Sometimes it really is
better not to have everything you want.

In conclusion, your goal is a good one, but it's something that
requires a lot of very careful consideration. To name just one thing,
you need to make it consistent, clean, and still powerful enough to not
stand in the way of moderately (un)common tasks.

I believe there is a bit of a tendency in your approach to emulate
commands of other VCS, and that's not the right way to go if you ask me.
If I did something like pyt (and I won't lie, I have put some thought
into it, including writing down a couple of ideas), I would start with a
clean slate and design something that really makes sense (which neither
the current git nor any other existing interface stacked on top of it
can really deliver). David Roundy did this well for darcs, I think: a
great number of commands have different names than in the classic VCS,
but they all make a lot of sense. Still, again, darcs's commands
wouldn't work that well for git; both systems are just too different.

Something else that's worth considering is that an interface to git is
not just about reshuffling commands; it's also about behaviour. For
example, submodules as they currently are are a bit hard to use
correctly (from what I've read on IRC; I haven't used them myself yet),
and refspecs are rather non-intuitive to use (especially push :foo).

It'll be interesting to see how the various existing alternative
interfaces to git will address all these problems.

-- 
Best regards
Jan Krueger
Aachen, Germany
