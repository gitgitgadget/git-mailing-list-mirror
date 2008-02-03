From: Jeff King <peff@peff.net>
Subject: [RFH] revision limiting sometimes ignored
Date: Sat, 2 Feb 2008 23:33:10 -0500
Message-ID: <20080203043310.GA5984@coredump.intra.peff.net>
References: <20080202122135.GA5783@code-monkey.de> <20080203030054.GA18654@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 03 05:34:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLWYP-0007tG-57
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 05:34:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755114AbYBCEdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 23:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754760AbYBCEdY
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 23:33:24 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1849 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754614AbYBCEdO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 23:33:14 -0500
Received: (qmail 17194 invoked by uid 111); 3 Feb 2008 04:33:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 02 Feb 2008 23:33:11 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 02 Feb 2008 23:33:10 -0500
Content-Disposition: inline
In-Reply-To: <20080203030054.GA18654@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72324>

On Sat, Feb 02, 2008 at 10:00:54PM -0500, Jeff King wrote:

> That being said, the commit in your 'master' branch _is_ part of
> 1dd567d5, and should be culled. So I'm not clear on why it shows up only
> when you ask to see both branches, and that may be a bug.

OK, there is definitely a bug here, but I'm having some trouble figuring
out the correct fix. It's in the revision walker, so I have cc'd those
who are more clueful than I.

You can recreate a problematic repo using this script:

-- >8 --
mkdir repo && cd repo
git init

touch file && git add file
commit() {
  echo $1 >file && git commit -a -m $1 && git tag $1
}

commit one
commit two
commit three
git checkout -b other two
commit alt-three
git checkout master
git merge other || true
commit merged
commit four
-- 8< --

So a fairly simple repo, but with the key element that it contains a
merge. Now try this:

  git log one --not four

You get the 'one' commit, even though it should be removed by "--not
four". But if you try this:

  git log one --not two

you correctly get no output.

It seems that in limit_list, we do two things:
  - first add the 'one' commit to the new list (since we process it
    before it gets marked uninteresting)
  - then traverse from 'four', marking commits and their parents as
    uninteresting as we go

However, the traversal seems to have trouble going over the merge. We
add the parents, but we end up marking them all as uninteresting, and
the everybody_uninteresting() optimization triggers, quitting the limit
before we have a chance to reach back to 'one' and mark it. The patch
below fixes it, but I'm very uncertain whether there is something else
going on that I'm missing that should be handling this case.

---
diff --git a/revision.c b/revision.c
index 6e85aaa..7d91ca1 100644
--- a/revision.c
+++ b/revision.c
@@ -579,8 +579,6 @@ static int limit_list(struct rev_info *revs)
 			return -1;
 		if (obj->flags & UNINTERESTING) {
 			mark_parents_uninteresting(commit);
-			if (everybody_uninteresting(list))
-				break;
 			continue;
 		}
 		if (revs->min_age != -1 && (commit->date > revs->min_age))
