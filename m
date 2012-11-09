From: Jeff King <peff@peff.net>
Subject: Re: Rename edge case...
Date: Fri, 9 Nov 2012 11:09:26 -0500
Message-ID: <20121109160925.GA19725@sigill.intra.peff.net>
References: <CAEBDL5U+OSTCAqgWoApE_m21Nef24Wqvt78oB6qqV4oEvU0vXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Fri Nov 09 17:09:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWr9Q-0006Jf-7E
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 17:09:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866Ab2KIQJf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 11:09:35 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40116 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751565Ab2KIQJe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 11:09:34 -0500
Received: (qmail 7914 invoked by uid 107); 9 Nov 2012 16:10:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 09 Nov 2012 11:10:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Nov 2012 11:09:26 -0500
Content-Disposition: inline
In-Reply-To: <CAEBDL5U+OSTCAqgWoApE_m21Nef24Wqvt78oB6qqV4oEvU0vXQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209225>

On Fri, Nov 09, 2012 at 04:10:31AM -0500, John Szakmeister wrote:

> I've been browsing StackOverflow answering git-related questions, and
> ran across this one:
>     <http://stackoverflow.com/questions/13300675/git-merge-rename-conflict>
> 
> It's a bit of an interesting situation.  The user did a couple of
> renames in a branch:
>     foo.txt => fooOld.txt
>     fooNew.txt => foo.txt
> 
> Meanwhile, master had an update to fooNew.txt.  When the user tried to
> merge master to the branch, it gave a merge conflict saying fooNew.txt
> was deleted, but master tried to update it.
> 
> I was a bit surprised that git didn't follow the rename here, though I
> do understand why: git only sees it as a rename if the source
> disappears completely.

Right. If the source didn't go away, it would be a copy. We can do copy
detection, but it is not quite as obvious what a merge should do with a
copy (apply the change to the original? To the copy? In both places? You
would really want hunk-level copy detection for it to make any sense).

Usually git deals with this double-rename case through the use of
"break" or "rewrite" detection. We notice that the old "foo.txt" and the
new "foo.txt" do not look very much like each other, and break the
modification apart into an add and a delete. That makes each side
eligible for rename detection, and we can end up finding the pairs of
renames above.

So in theory it just as simple as a one-liner to turn on break-detection
in merge-recursive. Sadly, that only reveals more issues with how
merge-recursive handles renames. See this thread, which has pointers to
the breakages at the end:

  http://thread.gmane.org/gmane.comp.version-control.git/169944

I've become convinced that the best way forward with merge-recursive is
to scrap and rewrite it. It tries to do things in a muddled order, which
makes it very brittle to changes like this. I think it needs to have an
internal representation of the tree that can represent all of the
conflicts, and then follow a few simple phases:

  1. "structural" 3-way merge handling renames, breaks, typechanges,
     etc. Each path in tree might show things like D/F conflicts, or it
     might show content-level merges that still need to happen, even if
     the content from those merges is not coming from the same paths in
     the source trees.

  2. Resolve content-level 3-way merges at each path.

  3. Compare the proposed tree to the working tree and list any problems
     (e.g., untracked files or local modifications that will be
     overwritten).

Right now it tries to do these things interleaved as it processes paths,
and as a result we've had many bugs (e.g., the content-level merge
conflating the content originally at a path and something that was
renamed into place, and missing corner cases where we actually overwrite
untracked files that should be considered precious).

But that is just off the top of my head. I haven't looked at the topic
in quite a while (and I haven't even started working on any such
rewrite).

> So I played locally with a few ideas, and was surprised to find out
> that even breaking up the two renames into two separate commits git
> still didn't follow it.

Right, because the merge only looks at the end points. Try doing a
"diff -M" between your endpoints with and without "-B". We do not have
any double-renames in git.git, but you can find "-B" helping a similar
case: most of a file's content is moved elsewhere, but some small amount
remains. For example, try this in git.git, with and without -B:

  git show -M --stat --summary --patch 043a449

It finds the rename only with "-B", which would help a merge (it also
makes the diff shorter and more readable, as you can see what was
changed as the content migrated to the new file).

-Peff
