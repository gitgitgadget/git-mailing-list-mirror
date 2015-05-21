From: Jeff King <peff@peff.net>
Subject: [PATCH v3 02/14] remote.c: refactor setup of branch->merge list
Date: Thu, 21 May 2015 00:45:09 -0400
Message-ID: <20150521044509.GB23409@peff.net>
References: <20150521044429.GA5857@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 06:45:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvIMB-0008Jx-7y
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 06:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753167AbbEUEpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 00:45:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:33666 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752988AbbEUEpM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 00:45:12 -0400
Received: (qmail 2258 invoked by uid 102); 21 May 2015 04:45:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 May 2015 23:45:12 -0500
Received: (qmail 31137 invoked by uid 107); 21 May 2015 04:45:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 May 2015 00:45:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 May 2015 00:45:09 -0400
Content-Disposition: inline
In-Reply-To: <20150521044429.GA5857@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269543>

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
2.4.1.528.g00591e3
