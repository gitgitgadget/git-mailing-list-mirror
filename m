From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "Contributors never merge" and preserving history
Date: Mon, 25 Feb 2008 12:31:26 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802251202380.14934@woody.linux-foundation.org>
References: <slrnfs5pfh.lkc.jgoerzen@katherina.lan.complete.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: John Goerzen <jgoerzen@complete.org>
X-From: git-owner@vger.kernel.org Mon Feb 25 21:32:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTk0J-0002ip-As
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 21:32:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756543AbYBYUcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 15:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756441AbYBYUcN
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 15:32:13 -0500
Received: from smtp1.linux-foundation.org ([207.189.120.13]:47984 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756112AbYBYUcM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Feb 2008 15:32:12 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1PKVRLf015728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 25 Feb 2008 12:31:28 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1PKVQJG018136;
	Mon, 25 Feb 2008 12:31:27 -0800
In-Reply-To: <slrnfs5pfh.lkc.jgoerzen@katherina.lan.complete.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.065 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75064>



On Mon, 25 Feb 2008, John Goerzen wrote:
> 
> The canonical answer from #git seems to be "never pull", always use
> fetch and rebase when submitting patches upstream using
> git-format-patch.

If you're going to submit them as patches, that is the correct answer, 
because what you want to do is basically keep your patch-queue up-to-date 
(which is exactly what "git rebase" does).

And no, you must never mix merging and rebasing - not because it's 
technically impossible (it *can* make sense in some circumstances), but 
because the two flows really are very different. Either you keep history 
and submit it as such (git-to-git merges up and down the chain) or you 
work with a "set of patches" model. Mixing the two in the same tree just 
leads to insanity (although mixing the two int he same project among 
different repositories can be a very good way to handle things).

But "never pull" isn't quite true either. 

Basically, the way to think about development is to try to keep things in 
"topic branches", which git is really good at. And the rule really 
shouldn' be "never pull" as much as "try to keep those topic-branches 
separate".

So pulling generally by definition mixes different branches (that's the 
merge part) in a way that a rebase does not. That's *especially* true 
about pulling from "upstream", because - pretty much by definition - that 
upstream is generally not even a well-defined topic branch that you want 
to merge, but simply the sum of all the *other* topic branches that have 
been merged upstream.

So the reason you should generally pull from downstream rather than 
upstream is that it keeps your development branch "focused" or "on target" 
or whatever you want to call it. And that's always a good idea, because 
now anybody who works together with you knows what he is getting.

So think of it as a cleanliness issue - it may not matter all that much if 
the only person you expect to ever pull your tree is always that same 
upstream (so even if you pull from your upstream, your upstream isn't 
really getting any mixed-up new code when he in turn pulls from you), but 
one thign I personally hoped for as a "design" was that what git really 
allows you to do (and _should_ encourage) is to have a less than perfectly 
hierarchical development stream.

And yes, in practice, pretty much every project ends up being pretty 
hierarchical after all, and that may be because of how people work (they 
want clarity, they want a simple "which tree is in charge" kind of model), 
but I still suspect it's at least partly - and perhaps mostly - simply due 
to historical patterns that it's just really hard to break.

So if you think of different git repositories as different branches (and 
that's what they really are!), then the "avoid pulling from upstream" is 
really about that "keep the topic branch focused and clean!".

And quite frankly, as "the upstream" for the kernel, I really appreciate 
people who ask me to pull, and that keep their histories clean, so that 
when I do a "gitk ORIG_HEAD.." after a pull, I get something that just 
looks real and not too messy. IOW, I like seeing myself pulling clear and 
well-defined topic branches (even if the "topics" I pull tend to be pretty 
big-picture topics, ie they may encompass "everything networking" or 
similar).

BUT!

There's always a but. In some cases, I will literally _ask_ a downstream 
person to pull from me. Havign the downstream doing a merge makes sense if 
the merge is non-trivial, and then the conflicting changes in a topic 
branch should generally be resolved by the side that has (a) the knowledge 
to do so (obviously) but also (b) the one who has the more specific 
changes (ie the side that has less work, and more targeted knowledge, of 
the things that conflict).

IOW, in the case of non-trivial conflicts, suddenly downstream is usually 
the one that has more knowledge, and now they should do the merge. And 
quite often, downstream may well know that ahead of time and be proactive, 
and just do the pull the "wrong way" and when asking me as an upstream 
member to merge, they'll let me know that they've already resolved the 
conflicts with what was in my tree.

The latter case is also something where a really long-lived topic branch 
may simply be doing those pulls over time every once in a while to just 
make sure that the topic branch never gets *too* far out of sync. However, 
if that's the reason for doing a merge, I'd almost suggest not just doing 
a "git pull" from upstream, but fetching and then merging at 
well-specified points (ie releases or release candidates).

That way you can also make a better and more useful merge message: not 
just "merged with upstream", but actually make it be "Synchronized with 
release v1.7.9". Which now makes a whole lot of conceptual sense at a 
higher level.

To recap:

 - from a purely technical sense it doesn't make any difference 
   what-so-ever who pulls and who doesn't, although you don't want it to 
   be *too* rare so that the different branches diverge so far as to make 
   it technically hard to synchronize later!

 - from a cleanliness angle - and *especially* if you want to work not 
   just in strict "upstream" and "downstream" patterns, but expect to 
   maybe have multiple upstreams (think "stable branch" or "vendor X wants 
   to pull this too"), a clean and clear topic banch is a really really 
   good idea.

   For example, let's say that you're developing a driver. If you start at 
   some specific kernel version (say, 2.6.24) and you do *not* generally 
   merge from my development tree, now suddenly other people can happily 
   pull from your tree to get the driver, even if they are stable kernels 
   or vendor kernels that don't want all the development crud that is in 
   my tree!

   See? Keeping a clean history actually makes your tree more useful!

 - But there are cases where pulling from up-stream really makes sense. 
   There may be specific points at upstream that you simply want to 
   synchronize with, or there may be conflicts that you want to resolve 
   simply because others aren't as knowledgeable about your topic branch
   etc.

So don't believe in "never pull from upstream". But *do* believe in "try 
to keep your branches on topic, because it will make everybody happier, 
and you'll be more easily able to read your own history too!".

			Linus
