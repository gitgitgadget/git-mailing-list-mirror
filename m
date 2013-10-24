From: Jeff King <peff@peff.net>
Subject: [PATCH 05/19] revision: allow setting custom limiter function
Date: Thu, 24 Oct 2013 14:01:41 -0400
Message-ID: <20131024180141.GE24180@sigill.intra.peff.net>
References: <20131024175915.GA23398@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent Marti <vicent@github.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 24 20:01:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZPEB-0004DO-Pp
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 20:01:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755922Ab3JXSBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 14:01:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:54872 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755295Ab3JXSBn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 14:01:43 -0400
Received: (qmail 602 invoked by uid 102); 24 Oct 2013 18:01:43 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Oct 2013 13:01:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Oct 2013 14:01:41 -0400
Content-Disposition: inline
In-Reply-To: <20131024175915.GA23398@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236592>

From: Vicent Marti <tanoku@gmail.com>

This commit enables users of `struct rev_info` to peform custom limiting
during a revision walk (i.e. `get_revision`).

If the field `include_check` has been set to a callback, this callback
will be issued once for each commit before it is added to the "pending"
list of the revwalk. If the include check returns 0, the commit will be
marked as added but won't be pushed to the pending list, effectively
limiting the walk.

Signed-off-by: Vicent Marti <tanoku@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 revision.c | 4 ++++
 revision.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/revision.c b/revision.c
index 0173e01..cddd605 100644
--- a/revision.c
+++ b/revision.c
@@ -779,6 +779,10 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
 		return 0;
 	commit->object.flags |= ADDED;
 
+	if (revs->include_check &&
+	    !revs->include_check(commit, revs->include_check_data))
+		return 0;
+
 	/*
 	 * If the commit is uninteresting, don't try to
 	 * prune parents - we want the maximal uninteresting
diff --git a/revision.h b/revision.h
index e7f1d21..9957f3c 100644
--- a/revision.h
+++ b/revision.h
@@ -168,6 +168,8 @@ struct rev_info {
 	unsigned long min_age;
 	int min_parents;
 	int max_parents;
+	int (*include_check)(struct commit *, void *);
+	void *include_check_data;
 
 	/* diff info for patches and for paths limiting */
 	struct diff_options diffopt;
-- 
1.8.4.1.898.g8bf8a41.dirty
