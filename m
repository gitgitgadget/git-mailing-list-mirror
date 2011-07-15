From: Jeff King <peff@peff.net>
Subject: Re: Git commit generation numbers
Date: Fri, 15 Jul 2011 03:46:56 -0400
Message-ID: <20110715074656.GA31301@sigill.intra.peff.net>
References: <CA+55aFxZq1e8u7kXu1rNDy2UPgP3uOyC5y2j7idKSZ_4eL=bWw@mail.gmail.com>
 <20110714183710.GA26820@sigill.intra.peff.net>
 <CA+55aFwuK+krTA4OcnYhLXtKM5HQ1yuPK+J_vC-5R7AthrHWbg@mail.gmail.com>
 <20110714190844.GA26918@sigill.intra.peff.net>
 <CA+55aFx=ACnVBGU8_9wa=9xTbxVoOWKnsqfmBvzq7qzOeMGSNA@mail.gmail.com>
 <20110714200144.GE26918@sigill.intra.peff.net>
 <69e0ad24-32b7-4e14-9492-6d0c3d653adf@email.android.com>
 <20110714203141.GA28548@sigill.intra.peff.net>
 <CA+55aFyDzr+SfgSzWMr9pQuQUXTw9mcjZ-00NZof74PKZzbGPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jul 15 09:47:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qhd73-0005AF-JC
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 09:47:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754938Ab1GOHq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 03:46:59 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40879
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754094Ab1GOHq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 03:46:58 -0400
Received: (qmail 15215 invoked by uid 107); 15 Jul 2011 07:47:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 15 Jul 2011 03:47:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jul 2011 03:46:56 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFyDzr+SfgSzWMr9pQuQUXTw9mcjZ-00NZof74PKZzbGPA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177191>

On Thu, Jul 14, 2011 at 06:19:30PM -0700, Linus Torvalds wrote:

> Yes.
> 
> And until I saw the patches trying to add generation numbers, I didn't
> really try to push adding generation numbers to commits (although it
> actually came up as early as July 2005, so the "let's use generation
> numbers in commits" thing is *really* old).
> 
> In other words, I do agree that we should strive for minimal required
> information.
> 
> But dammit, if you start using generation numbers, then they *are*
> required information. The fact that you then hide them in some
> unarchitected random file doesn't change anything! It just makes it
> ugly and random, for chrissake!

So you don't see a difference between storing the information directly
in the commit object, where it affects the sha1 of the commit, and
calculating and storing it somewhere else? That is what seems ungit to
me. You aren't adding new information to the DAG (note I said "DAG" and
not commit) that is not already there, but you are changing the ids of
commits in the DAG.

I'm not saying that's a reason to ultimately reject the idea of putting
generation numbers in commit objects. But it is a reason to give us
pause and figure out if there are other solutions, because it will be
the first time such redundant information has been added. And that's
what I've been trying to do during this discussion with you: work out
what the options are and evaluate them.

> I really don't understand your logic that says that the cache is
> somehow cleaner. It's a random hack! It's saying "we don't have it in
> the main data structure, so let's add it to some other one instead,
> and now we have a consistency and cache generation problem instead".

Are packfiles unclean, or a random hack? How about pack indices? What
about Nico's and Shawn's ideas for a packv4 that would gain efficiency
by storing objects not in their whole format, but in a way that would
make tree examination faster (but would be able to restore the whole
objects byte for byte)?

Those things rely on the idea that the git DAG is a data model that we
present to the user, but that we're allowed to do things behind the
scenes to make things faster. We're allowed to make an index of offsets
of objects in the packfile for faster lookup. Why are we not allowed to
use an index for other object data if it will speed up our local
algorithms?

Again, I'm not saying that the patches I posted are necessarily the
answer. Maybe my cache implementation sucks. Maybe the value should go
into a pack index instead. Maybe the whole idea is stupid. But I don't
think it's worth rejecting out-of-hand the idea that the generation
number might be stored outside of the commit object. I do think it's
worth talking about what the actual downsides are, as compared to other
options.

For example, you mentioned there a consistency problem in the paragraph
above. What is it?

If you mean the problem with refs/replace, then yes, that is an open
problem to be solved (though not a hard one, as I already mentioned a
solution elsewhere). But is that problem better or worse with this
solution versus an embedded generation number? It seems to me that an
embedded generation number is even worse.

> Just look at the size of the patches in question. Your caching patches
> are bigger and more complicated. Sure, part of it is that your series
> adds the code to _use_ the generation number, but look purely at the
> code to maintain them.

It's 300 lines of code. That can also be used to store arbitrary
meta-information for commits. I've already achieved significant speedups
in some workflows by caching patch-id calculations, which would reuse
this code.  And I certainly don't think _that_ should go into the commit
object.

Yes, it's more complex than simply adding a generation number to the
commit header. But simply adding a generation number does not actually
give the 100-fold speedup I'm seeing. So again, I'm not interested in
rejecting solutions out of hand; I'm interested in things like: is the
complexity of the cache worth this speedup? What other options do we
have, and what speedup do they provide? Do we care enough about this
speedup to even bother?

> Why do you think the odd separate cache is somehow better than just
> doing it right? Seriously? If we require the generation numbers, then
> they have *become* that minimal information that we should save!

What do you do when generation numbers don't match the DAG represented
by the parent pointers? Are you proposing to just ignore it? I'm not
asking that question adversarially; ignoring may be the sane thing to
do, and we say "generation numbers are to be trusted, even if they don't
match parent pointers".

> Now, six years later, you clearly are saying that we need the
> generation numbers, but then you go off and try to say that they
> should be in some secondary non-architected random collection of data
> structures that isn't covered by the security and maintenance
> guarantees that the core git objects are.

I don't think I said we clearly need them. I said we can get speedups by
using them, and I showed some patches. I _also_ posted patches showing
how to accomplish similar speedups using timestamps. Note that all of my
patches started with "RFC". I am trying to figure out which is the best
way to proceed.

And why _would_ they need to be covered by the security and maintenance
guarantees of core objects? You can trivially calculate them from the
core objects. Are pack indices also a "secondary non-architected random
collection of data structures"?

> Dammit, one of the things that makes git special is that the data
> structures are NOT random odd ad-hoc files. There is a design to them.

There is just as much documentation and design for the new file format I
added as there is for pack indices (in fact, they're quite similar in
design). I really see them at the same level: something we calculate to
speed up some algorithms, but something we could regenerate at any time
if we felt like.

> > And so that seems a bit hack-ish to me.
> 
> Um? If you feel that way, then why the hell are you pushing your EVEN
> MORE HACKISH CACHE PATCHES?

Please, there is really no need to shout. And I find it quite silly that
you would refer to me as "pushing" these patches when they have been
clearly listed as RFC, and everything I have posted in the nearby
threads has been about comparing different strategies (with patches and
timings for some of those other strategies!).

> We don't do caches in git, because we don't NEED to. Sure, gitk has
> it's hacky cache, but that's not core functionality.

I'm sorry to tell you that there is already a cache for external
conversion of diffs for blobs. And that I have a patch series which
makes "git cherry" much more pleasant to use by caching patch ids.

Do we "need" those? No, of course not. Git works just fine without them,
albeit a bit slower. But is it sometimes worth making a space-time
tradeoff to make some algorithms faster? I think it sometimes is,
depending on the space and time factors, and the complexity of the
storage (e.g., consistency problems with caching).

> I think it's a sign of good design that we can do a "find .git" and
> explain every single file, and show that it's all core functionality
> (again, with the exception of "gitk.cache", and I suspect that's
> because gitk is a script, not because of any really fundamental data
> issues), and explain it.

Would it make you happier if we stored the generation data in the pack
index when we index the packs?

> I think the *cache* is a hell of a lot more hacky than just doing it right.

You still haven't explained how we would "do it right" and get the same
speedups. When I responded to your initial email, your answers were
along the lines of "we could cache fewer things". If your position is to
damn the speedup, the cache is not worth the complexity, I can buy that.
If your position is that the complexity is not worth it, and we are
better off to keep using timestamps, I can buy that. If your position is
that you can find a clever way, using only the generation numbers in
newly created commits, to get similar speedups in "git {tag,branch}
--contains", I'd love to hear it.

> > I liken it somewhat to the "don't store renames" debate.
> 
> That's total and utter bullshit.
> 
> Storing renames is *wrong*. I've explained a million times why it's
> wrong. Doing it is a disaster. I know. I've used systems that did it.
> It's crap. It's fundamentally information that is actively misleading
> and WRONG. It's not even that you can do rename detection at run-time,
> it's that you *HAVE* to do rename detection at run-time, because doing
> it at commit time is simply utterly and fundamentally *wrong*.

Yes, I am well aware that stored renames are wrong for merging. The
problem is that they not a function of a tree state (which is what a
commit stores), but rather of the difference between two states. So when
you diff the commit's state with some other arbitrary merge-base, any
renames recorded at commit time would be worthless.

But consider another case. Each time I run "git log -M --raw", I compute
the same renames over and over. Let's say I have a case in which this is
annoyingly slow, and want to speed it up. The state of a particular
commit and the state of its parents are invariants for a particular sha1
commit id; this is a fundamental property of git, as you well know. So
for a given rename-detection algorithm (and any parameters it has), the
set of renames between the states will also be an invariant.

Now imagine I create a persistent cache mapping the commit sha1 for some
sane default set of rename algorithm parameters to a set of rename
pairs. My annoyingly slow "log -M" is now faster, and I'm happier.

I think you encounter a similar set of questions here as you do with the
concept of a generation header. If the information is an invariant for a
particular commit sha1, can we and should we store it in the commit
object? Is the speedup worth the complexity of a cache? What are the
circumstances under which the cache is not applicable, and how often do
they come up? Can we accurately detect when the cache is not applicable?

And that is why I compared it to the idea of storing renames. Please
note that I did _not_ say they were exactly the same situation, or that
the answers to one set of questions were the same as the answers to
another.

-Peff
