From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 02/12] remote.c: drop "remote" pointer from "struct
 branch"
Date: Thu, 7 May 2015 05:33:34 -0400
Message-ID: <20150507093333.GA14524@peff.net>
References: <20150501224414.GA25551@peff.net>
 <20150501224515.GB1534@peff.net>
 <CAPig+cQny16Jei9AtDWVY3ADbPGshFw7CYofD_TnyA+GL58AOg@mail.gmail.com>
 <20150505193105.GE10463@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu May 07 11:33:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqIBa-00032l-T8
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 11:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbbEGJdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 05:33:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:55096 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751023AbbEGJdg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 05:33:36 -0400
Received: (qmail 11723 invoked by uid 102); 7 May 2015 09:33:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 07 May 2015 04:33:36 -0500
Received: (qmail 7484 invoked by uid 107); 7 May 2015 09:34:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 07 May 2015 05:34:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 May 2015 05:33:34 -0400
Content-Disposition: inline
In-Reply-To: <20150505193105.GE10463@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268526>

On Tue, May 05, 2015 at 03:31:05PM -0400, Jeff King wrote:

> One thing I did notice while looking at this is that it seems like we
> may leak if you call branch_get multiple times. The make_branch()
> function may sometimes return a brand-new branch and sometimes return a
> cached version from the "branches" array. In the latter case, we
> continue to update the "remote" pointer (which is wasteful but at least
> does not leak because the remotes themselves are part of a cached list).
> But then we will repeatedly re-allocate the ret->merge array. We
> probably should make sure it is NULL before trying to fill it in.
> 
> I'll see if I can insert a cleanup patch in this part of the series.

Here's what I came up with. I'm sending it separately in case you have
any early comments, but it will be part of the next re-roll (just before
the existing patch 2 we're discussing here).

-- >8 --
Subject: remote.c: refactor setup of branch->merge list

When we call branch_get() to lookup or create a "struct
branch", we make sure the "merge" field is filled in so that
callers can access it. But the conditions under which we do
so are a little confusing, and can lead to two funny
situations:

  1. If there's no branch.*.remote config, we cannot provide
     branch->merge (because it is really just an application
     of branch.*.merge to our remote's refspecs). But
     branch->merge_nr may be non-zero, leading callers to be
     believe they can access branch->merge (e.g., in
     branch_merge_matches and elsewhere).

     It doesn't look like this can cause a segfault in
     practice, as most code paths dealing with merge config
     will bail early if there is no remote defined. But it's
     a bit of a dangerous construct.

     We can fix this by setting merge_nr to "0" explicitly
     when we realize that we have no merge config. Note that
     merge_nr also counts the "merge_name" fields (which we
     _do_ have; that's how merge_nr got incremented), so we
     will "lose" access to them, in the sense that we forget
     how many we had. But no callers actually care; we use
     merge_name only while iteratively reading the config,
     and then convert it to the final "merge" form the first
     time somebody calls branch_get().

  2. We set up the "merge" field every time branch_get is
     called, even if it has already been done. This leaks
     memory.

     It's not a big deal in practice, since most code paths
     will access only one branch, or perhaps each branch
     only one time. But if you want to be pathological, you
     can leak arbitrary memory with:

       yes @{upstream} | head -1000 | git rev-list --stdin

     We can fix this by skipping setup when branch->merge is
     already non-NULL.

In addition to those two fixes, this patch pushes the "do we
need to setup merge?" logic down into set_merge, where it is
a bit easier to follow.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/remote.c b/remote.c
index bec8b31..ac17e66 100644
--- a/remote.c
+++ b/remote.c
@@ -1636,6 +1636,19 @@ static void set_merge(struct branch *ret)
 	unsigned char sha1[20];
 	int i;
 
+	if (!ret)
+		return; /* no branch */
+	if (ret->merge)
+		return; /* already run */
+	if (!ret->remote_name || !ret->merge_nr) {
+		/*
+		 * no merge config; let's make sure we don't confuse callers
+		 * with a non-zero merge_nr but a NULL merge
+		 */
+		ret->merge_nr = 0;
+		return;
+	}
+
 	ret->merge = xcalloc(ret->merge_nr, sizeof(*ret->merge));
 	for (i = 0; i < ret->merge_nr; i++) {
 		ret->merge[i] = xcalloc(1, sizeof(**ret->merge));
@@ -1660,11 +1673,9 @@ struct branch *branch_get(const char *name)
 		ret = current_branch;
 	else
 		ret = make_branch(name, 0);
-	if (ret && ret->remote_name) {
+	if (ret && ret->remote_name)
 		ret->remote = remote_get(ret->remote_name);
-		if (ret->merge_nr)
-			set_merge(ret);
-	}
+	set_merge(ret);
 	return ret;
 }
 
-- 
2.4.0.488.gf55b16a
