X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-show --stat on first commit
Date: Tue, 21 Nov 2006 11:31:25 -0800
Message-ID: <7v64d8y4tu.fsf@assigned-by-dhcp.cox.net>
References: <200611211341.48862.andyparkins@gmail.com>
	<8aa486160611210609h1c2d229ekf0b5e8aeb4f21f11@mail.gmail.com>
	<slrnem694k.4lm.Peter.B.Baumann@xp.machine.xx>
	<Pine.LNX.4.64.0611210820100.3338@woody.osdl.org>
	<20061121180643.GC7201@pasky.or.cz> <ejvfng$cj6$1@sea.gmane.org>
	<20061121182135.GD7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 21 Nov 2006 19:31:51 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061121182135.GD7201@pasky.or.cz> (Petr Baudis's message of
	"Tue, 21 Nov 2006 19:21:35 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32026>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmbL9-0005sG-Ro for gcvg-git@gmane.org; Tue, 21 Nov
 2006 20:31:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031332AbWKUTb2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 14:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031333AbWKUTb2
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 14:31:28 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:32483 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S1031332AbWKUTb1
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 14:31:27 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061121193126.PUQH5465.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>; Tue, 21
 Nov 2006 14:31:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id pXXZ1V00c1kojtg0000000; Tue, 21 Nov 2006
 14:31:34 -0500
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> On Tue, Nov 21, 2006 at 07:16:44PM CET, Jakub Narebski wrote:
>..
>> git repo-config show.difftree --root
>> git repo-config whatchanged.difftree --root
>
> That means extra pointless setup and is besides the point anyway, I was
> asking about empty commits, not default command settings.

I agree with you.  Personally, I think:

 - show is where the user is asking for _that_ particular
   commit, so it can safely default to --root, always.  No
   option is needed.

 - what we want for log and underlying rev-list is majorly
   dependent of the nature of the root commit.  Per repository
   (or even per root) option which defaults to "on" (I was
   going to say "off" to be backward compatible and convenient
   for "me", but even Linus says "on" so I am playing along)
   would make sense.

So just "core.showroot = yes | no" would be the only thing we
would need, I think.  Unless we do fancier "core.hideroot =
SHA1-1 SHA1-2 ..."  to say "these root should not be shown",
that is.

> BTW, the other frequent reason why empty commits come up so frequently
> is a FAQ "how do I create an unrelated branch in my repository" - their
> idea is that they will create a new branch starting with an empty commit
> (of course noone would think of anything like that in inferior VCSes
> because replacing the checked out trees would took forever; how cool Git
> is!).

I wrote something about this after reading #git log several days
ago where somebody named Insount (sp?) was talking about
"elegant idea" of the empty initial commit, but did not send it
and kept silent about it.  As Linus said in an earlier message,
I've thought about this and am personally happy about the
current way of not having it, and here is why.

Interestingly, I already talked about "show --root" in the
message that I did not send -- I think you made this the right
thread to post it in ;-)

-- >8 --
Subject: empty initial commit

Don't do it.  It is stupid.

	I'm imitating somebody who says "I am so right that it
        hurts".  Don't worry, I'll come back to my usual self
        and talk about what is wrong with our current tools and
        what needs to be fixed shortly ;-).

(1) Your claim that it is elegant because it removes a special
    case is bogus, because you are not removing special cases
    anyway.

The initial commit _is_ special.  The first real example in
"everyday" document begins by creating the initial commit out of
an extracted tarball.  You would _actively_ want to special case
that commit.  Its diff from nothingness is so uninteresting
while inspecting the development history of the project that we
do not even show it in "git log -p" output unless explicitly
asked with "--root" option, for example [side note: we might
want to default to --root for "git show", which clearly
indicates that the user is interested in that particular one
commit].  If you introduce the fake "epoch" commit, then you
have to move that special case logic elsewhere and squelch the
output when the parent is a commit with an empty tree, instead
of the current logic which is to omit it when it is the root
commit.  You have to have special case either way.

(2) A branch yet to be born (i.e. a freshly initialized
    repository whose HEAD points at refs/heads/master that does
    not exist yet) and a branch whose tip points at a fake
    "epoch" commit are fundamentally different.

Let's remember our GIT 101.  Two commits that happen to have the
same tree are not equivalent, because a commit represents both
the then-current state when it was made _and_ the development
history that led to it.  The development history is represented
by chains of commits.

Earlier Linus and I updated git-pull to allow pulling into a
branch yet to be born because a branch yet to be born _is_ an
ancestor of any commit and can be fast-forwarded.  There was no
branch and there was no earlier history.

You cannot say the same thing for a branch that points at a root
commit that has an empty tree.  For one thing it would record
authorship information and stuff so it won't be "THE universal
void".  You can have infinite (well, bounded by 2^160 because we
use SHA-1 to name objects) such root commits, and they are not
equivalent.  Does that mean a true root commit (not your fake
commit) can be a child of 2^160 empty parents that are all
alike?  Which one of them do you choose to record as its parent
and why?

If you start two branches with your scheme, they will have two
different fake root commits -- when merging these two branches
that were independently born, should these fake root commits be
treated as equivalents for merge-base computation?  If so that
introduces a very special case that we currently do not need in
a very deep place.  But we can already do a merge without common
ancestor just fine (I've done one myself and Linus did two), so
these 2^160 empty fake commits are not adding value to the
system.

Of course, you could use "THE truly universal void" commit that is
by convention created in every git repository that has some
agreed-upon author/committer/log information as that fake root
and uniformly use it everywhere to solve the above, to emulate
what we already do.  But we have been doing fine without such a
fake commit, thank you.

So it's stupid to introduce such a fake commit.  Don't do it.

Now, back to my usual self.

I suspect that an independent branch creation inside an existing
repository is not an everyday event, and your complaint is
primarily coming from the fact that you somehow wanted to do
that recently and there was not a canned way to do so, not
because you need to do that very often and the tool is lacking.
But for the moment, let's say it is an everyday event and making
it easy to do so adds to the general value of our toolset.

I think the real shortcoming of the current set of tools is that
while it allows you to be initially on a yet-to-be-born branch,
it does not offer you a way to be on another yet-to-be-born
branch once you created the first branch.

The command "git branch $newbranch" wants a commit to begin the
newly created branch at.  Another, "git checkout -b $newbranch",
has the same property.  If you do not give the starting commit,
they conveniently defaults to HEAD, which is inconvenient for
what you want.

So it _is_ cumbersome to create (or, "not to create") and be on
a yet-to-be-born branch, and as a consequence, it is not
possible unless you go down to bare plumbing level to start two
unrelated histories in one repository.  We do not give you a
direct way to do that.  An obvious workaround is to create a new
repository to start a separate history afresh and fetch that
branch in, but if an independent branch creation had a valid
purpose and were an everyday event, it certainly is merely a
workaround and shows that the toolset is lacking.

Maybe a new option "git checkout --void $newbranchname", which
does a rough equivalent of:

	new="refs/heads/$newbranchname"
	git show-ref -q --verify "$new" &&
                die "branch $newbranchname already exists"
	# git ls-files -z | xargs -0 rm -f
        rm -f .git/index
        git symbolic-ref HEAD "$new"

is what you would want to add.  I am undecided about the
commented out part to remove everything from the working tree,
though.  On one hand, if you are running "git init-db" in a
directory full of files from an extracted tarball, we would not
touch any existing files, but on the other hand, since we are
interested in creating a totally unrelated history, losing
tracked files feels more like the right thing to do.

In any case, I suspect you need to have a bit more convincing
and persuasive argument why creating and maintaining more than
one, totally unrelated histories in a single repository is
necessary.

And "git.git has more than one roots and it looks kinda cool" is
not a convincing argument at all.  For one thing, these roots
were not created in a single repository.  The true git root was
done in Linus's dircache project back when there was no multiple
branches, gitk, git-tools and gitweb were all done in their own
separate repositories and later merged in to be part of the
current tip of the master.

Todo, html and man roots all come from their own separate
repositories and because they are not part of the history of the
git development they are still independent.  

The real reason I have "todo" in git.git was because the parent
directory /pub/scm/git/ was not writable to me at kernel.org and
I was too lazy to ask for ownership/permission changed when I
took over /pub/scm/git/git.git; I otherwise would have created a
separate git-todo.git next to git.git there.

And the reason html and man roots are in git.git is because
having "todo" in git.git turned out to be not-so-disastrous as I
feared when I first did so, and it seemed like an interesting
way to experiment on the "central place to distribute unrelated
stuff" idea.  But they come from their own separate
repositories.

By the way, I would solve B1..B100 merge issue without special
casing by:

	git checkout -b merged B$(pick-randomly 1 100)
        i=1
        while test $i -le 100
        do
        	git pull . B$i
                i=$(($i + 1))
	done

Starting from a randomly picked parent and starting from an void
(created with "git checkout --void" we discussed above) would
give you exactly the same result because pulling B$i on top of
B$i (or something that already has merged B$i) is a fast
forward.

