From: Jeff King <peff@peff.net>
Subject: [PATCH v4 05/23] revision: allow setting custom limiter function
Date: Sat, 21 Dec 2013 08:59:43 -0500
Message-ID: <20131221135943.GE21145@sigill.intra.peff.net>
References: <20131221135651.GA20818@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 21 14:59:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VuN5q-0004wM-4H
	for gcvg-git-2@plane.gmane.org; Sat, 21 Dec 2013 14:59:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754904Ab3LUN7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Dec 2013 08:59:46 -0500
Received: from cloud.peff.net ([50.56.180.127]:48475 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754669Ab3LUN7p (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Dec 2013 08:59:45 -0500
Received: (qmail 7335 invoked by uid 102); 21 Dec 2013 13:59:44 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 21 Dec 2013 07:59:44 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Dec 2013 08:59:43 -0500
Content-Disposition: inline
In-Reply-To: <20131221135651.GA20818@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239598>

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
1.8.5.1.399.g900e7cd
