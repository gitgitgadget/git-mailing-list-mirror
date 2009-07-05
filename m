From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Wrong file diff for merge conflict
Date: Sun, 5 Jul 2009 11:43:14 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907051113240.3210@localhost.localdomain>
References: <loom.20090704T072854-229@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Stefan Bucur <stefan.bucur@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 05 20:43:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNWgP-00037k-NU
	for gcvg-git-2@gmane.org; Sun, 05 Jul 2009 20:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbZGESnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2009 14:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752067AbZGESnO
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jul 2009 14:43:14 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36400 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751687AbZGESnN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jul 2009 14:43:13 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n65IhE4f012016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 5 Jul 2009 11:43:15 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n65IhEiV013226;
	Sun, 5 Jul 2009 11:43:14 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <loom.20090704T072854-229@post.gmane.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.467 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122746>



On Sat, 4 Jul 2009, Stefan Bucur wrote:
> 
> http://pastebin.ca/1483228
> 
> The problem is with the last diff in the file, where the left portion is empty,
> and the right portion contains code which already was marked as merged (common),
> right before the start of the diff. Therefore, the mark at line 127 should
> really have been before line 114.
> 
> Is this a bug or I am missing something?

I suspect (but without the origin files/history I can't verify) that what 
happens is that the "successfully merged" code was seen as a fully new 
snippet of code (probably due to getting re-indented?), and the other part 
of that action on that branch was the removal of the old code.

That _removal_ is then shown as a conflict against the other branch, which 
presumably didn't re-indent things (of course, it could be exactly the 
other way around too), and so now you end up having the "conflict" being 
seen as "one branch removes this code (empty conflict part), the other one 
presumably changed it some way".

Is that what you wanted? Obviously not. To you, the conflict makes no 
sense. You're a human, who tries to understand what wen't wrong, and to 
you, the end result of the conflict resolution makes no sense.

On the other hand, it probably _does_ make sense from the standpoint of a 
fairly stupid simple three-way merge that is also (on purpose) tuned to 
try to give minimal merge conflicts (the "XDL_MERGE_ZEALOUS" flag) that 
are often easier for humans to then correct because they have limited 
context.

And the thing is, that zealous merge conflict minimization generally does 
result in conflicts that are easier to work with, because you end up with 
a much smaller conflict - rather than having one huge conflict that in 
your case would probably have covered pretty much the whole 'realloc()' 
function, the zealous merge has tried to really zoom in on just the 
critical parts, and has turned it into three conflicts that are fairly 
small (one is just two trivial lines).

In this case, I can also guess at why you then end up with a very odd 
conflict: when one side has re-indented the code, the only lines that tend 
to match after the re-indentation are the trivial lines that have just a 
single closing brace, or perhaps a "} else {" that actually ends up 
matching the _wrong_ indentation level, but because it existed in both 
indentation levels, the stupid line-based merge logic picked it as a 
common feature - even though it very much is exactly the _wrong_ kind of 
common feature to pick.

So is it a bug? Nope. I can pretty much guarantee that it's not a bug. The 
whole zealous merge thing is very much a feature. The "take whitespace 
into account when comparing lines" is also a feature, even though it 
obviously matches up the wrong lines in re-indentation cases like this. I 
bet you've seen diffs (not just merges) that you think look "stupid", and 
they look stupid exactly for the same reason - diff matches the wrong 
closing braces across re-indentation.

Now, that said - it may not be a bug, but it's clearly not what you want, 
so how do you fix it?

There's a couple of things to do:

 - Try to make the merging smarter, and not do this mistake.

   I'd love to have that, but quite frankly, I don't think it's 
   reasonable. As mentioned, aggressively minimizing merge conflicts 
   really does do the right thing most of the time, and non-aggressive 
   merges - while obviously "safer" - are really irritating.

   So the merge is not hugely smart, and _despite_ it being pretty stupid 
   it's also pretty aggressive. Not generally a good combination, but so 
   far, the alternatives have always been way worse.

 - Tune the zealous merge a bit, and in particular try to avoid the cases 
   where this happens (as mentioned, in C code, it's often re-indentation 
   together with trivial lines that match after it).

   This is kind of what the "patience" diff algorithm tries to do: use 
   primarily non-trivial sequences as the anchors for similarity, and 
   ignore the trivial ones. We have a "--patience" switch to "git diff", 
   maybe we could tune the three-way merge somehow similarly.

   (We did already soem time ago add _some_ tuning, in the form of 
   ZEALOUS_ALNUM that only combines non-conflicting lines if they are 
   non-trivial in the sense that they have some alphanumeric characters. 
   But all that happens after the diff algorithm itself has generated the 
   chunks, so the empty '}' lines still do matter for merging. Also, it 
   still considers things like '} else {' to be "meaningful" by virtue of 
   having alphanumerics on it.)

 - Don't rely so heavily on just the traditional three-way merge result.

   This is what I personally do. The trivial 3-way merge result is 
   wondeful for the truly trivial merges, when it gives trivial results 
   that are easy to fix up. But let's face it, the traditional 3-way merge 
   result just sucks for anything more complicated. When you have an empty 
   side on one of the conflicts, is that because the other side added 
   everything, or is it because oen side removed it? Or is it, like in 
   this case, simply because trivially similar lines got the whole diff 
   confused about which parts didn't change at all?

   The good news is that git does have a few nice merge tools. One is 
   "git diff", which actually shows way more than the trivial three-way 
   end result, in that you can diff against either side, and by default it 
   does that fairly complex "diff against both sides" thing that is also 
   quite useful once you get used to it.

   Another is "gitk --merge [filename]" which is wonderful as a tool to 
   see what both sides actually did, to figure out what the intent of both 
   branches were when the three-way merge result is just noise.

The right answer is probably some combination of "all of the above". In 
the meantime, right now, only the last one is somethign git itself will 
help you with.

			Linus
