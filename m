From: Junio C Hamano <junkio@cox.net>
Subject: Re: Two crazy proposals for changing git's diff commands
Date: Thu, 09 Feb 2006 18:24:06 -0800
Message-ID: <7vfyms0x4p.fsf@assigned-by-dhcp.cox.net>
References: <87slqtcr2f.wl%cworth@cworth.org>
	<7vfymtl43b.fsf@assigned-by-dhcp.cox.net>
	<87bqxgxfl7.wl%cworth@cworth.org>
	<7vr76c5avd.fsf@assigned-by-dhcp.cox.net>
	<87fymst399.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 03:24:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7NxF-00086L-Fl
	for gcvg-git@gmane.org; Fri, 10 Feb 2006 03:24:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbWBJCYK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 21:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbWBJCYK
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 21:24:10 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:13010 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751008AbWBJCYI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 21:24:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060210022147.DSVD17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Feb 2006 21:21:47 -0500
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87fymst399.wl%cworth@cworth.org> (Carl Worth's message of "Thu,
	09 Feb 2006 17:24:18 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15858>

Carl Worth <cworth@cworth.org> writes:

> The more significant aspect of the above grouping is not "what
> workflow is supported" but whether the commands operate primarily on
> the index or on the files in the working directory. The distinction is
> significant to understanding and taking full advantage of git. And
> this aspect of git is something that is particularly unique to git
> (and hence some source of confusion to newcomers).

I think that is a wrong place to start from.  There is no such
thing as "file focused" operation in git.  Git _fundamentally_
works with index.  The reason "diff-index" without --cached is
there is to tell you what _would_ happen if you were to run
update-index on the path.  The same thing for "diff-files".  It
tells you what damage you would be inflicting on the index if
you were to update-index it with what you have in the working
tree.  They are simulations of what _would_ happen after you
place them in the index, and until you place them in the index
you obviously cannot write things out to a tree.

However much you want to make git pretend to be "file focused",
you cannot deny the fact that the interesting things happen only
after you place things in the index.

Now, from purely traditional SCM point of view, index may be
secondary.  People coming from index-less SCM background would
just want two entities: the last checkin and what you have in
the working tree.  If your goal is you would want to have an
alternative UI that completely hides index, that is a worthy
goal (I think Cogito attempts to do so and does a reasonably
good job), but that is something different from what git
barebone Porcelains would want to force on its users.

But I do not think that is what you are aiming for in this round
of your proposal.

> I agree. I think the current 'tutorial introduction to git' does a
> good job at demonstrating one work flow. I'm picky though, so the two
> changes I'd like to have in it are: 1) No command-line options
> necessary (rename "commit -a" somehow). 2) Provide an honest
> HEAD->files diff rather than the current "git diff" that just
> 'accidentally' happens to give the same answer in this case.

Again, (2) is "git status -v".  Simulation of what would happen
if I were to commit right now.  For (1), "git commit" to mean
"git commit -a" has already been rejected, but you could
introduce git-commit-all if you want.  I however do not think
that would fly well with general public; after already seeing
100+ commands adding one more would not be too much but I think
that would be an additional confusion, not simplification.

> For a taking-advantage-of-the-index workflow, I think the 'short git
> tutorial' does a poor job, (it makes the index notion just seem
> painful and in the way). But Linus' responses to me in the recent
> threads have helped me understand it better, so there's material for
> an improved tutorial there I think.

Thanks.  I take it to mean I can expect some updates to the
section from you ;-).

> Yes, I can do that personally, and I do agree it's a nice benefit of
> git. (Though some might see it as a defect if such scripting is
> perceived as being necessary before getting comfortable use out of the
> tool.)

As I already said, if enough people share the opinon that that
particular wrapper is a good thing, it would become established
BCP and eventually make it into a new command or a new option,
even replacing the existing one if the benefit outweighs the
transition cost.

I do not, unfortunately, see much merit in what you have said so
far, such as renaming "git diff --cached" and "git diff HEAD".
Running --cached and non --cached against something other than
HEAD _is_ useful [*1*], so you cannot remove the existing "git
diff --cached <commit-id>" or "git diff <commit-id>"; which
means you would need two extra command just for the common cases
to run "git diff --cached HEAD" and "git diff HEAD".  Certainly
that would be less typing for that particular case, but does
that justify two extra commands?  Along with the git-commit-all
that would be three extra commands.  I am not convinced.

I really feel I should slow down and stop responding for now,
and instead start spending some time on doing the git-status
updates.

Just so that I do not get misunderstood by the above statement.
I do not mean I will _ignore_ your arguments; what I mean is I
would stop talking, give your thought process time to go all the
way, and then revisit your proposal after you finished thinking.


[Footnote]

*1* Often I find myself doing that while rewriting messy
development history.  For example, I start doing some
work without knowing exactly where it leads, and end up with a
history like this:

            "master"
        o---o
             \                    "topic" 
              o---o---o---o---o---o

At this point, "topic" contains something I know I want, but it
contains two concepts that turned out to be completely
independent.  And often, one topic component is larger than the
other.  It may contain more than two topics.

In order to rewrite this mess to be more manageable, I would
first do "diff master topic", to extract the changes into a
single patch, start picking pieces from it to get logically
self-contained units, and start building on top of "master":

        $ git diff master..topic >P.diff
        $ git checkout -b topicA master
        ... pick and apply pieces from P.diff to build
        ... commits on topicA branch.
                      
              o---o---o
             /        "topicA"
        o---o"master"
             \                    "topic" 
              o---o---o---o---o---o

Before doing each commit on "topicA" HEAD, I run "diff HEAD"
before update-index the affected paths, or "diff --cached HEAD"
after.  Also I would run "diff --cached master" to make sure
that the changes are only the ones related to "topicA".  Usually
I do this for smaller topics first.

After that, I'd do the remainder of the original "topic", but
for that, I do not start from the patchfile I extracted by
comparing "master" and "topic" I used initially.  Still on
"topicA", I extract "diff topic", and use it to rebuild the
other topic:

        $ git diff -R topic >P.diff ;# --cached also would work fine
        $ git checkout -b topicB master
        ... pick and apply pieces from P.diff to build
        ... commits on topicB branch.

                                "topicB"
               o---o---o---o---o
              /
             /o---o---o
            |/        "topicA"
        o---o"master"
             \                    "topic" 
              o---o---o---o---o---o

After I am done, I'd try a pretend-merge between "topicA" and
"topicB" in order to make sure I have not missed anything:

        $ git pull . topicA ;# merge it into current "topicB"
        $ git diff topic
                                "topicB"
               o---o---o---o---o---* (pretend merge)
              /                   /
             /o---o---o----------'
            |/        "topicA"
        o---o"master"
             \                    "topic" 
              o---o---o---o---o---o

The last diff better not to show anything other than cleanups
for crufts.  Then I can finally clean things up:

        $ git branch -D topic
        $ git reset --hard HEAD^ ;# nuke pretend merge

                                "topicB"
               o---o---o---o---o
              / 
             /o---o---o
            |/        "topicA"
        o---o"master"
