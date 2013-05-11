From: Jeff King <peff@peff.net>
Subject: [PATCH 4/4] fetch: opportunistically update tracking refs
Date: Sat, 11 May 2013 18:16:52 +0200
Message-ID: <20130511161652.GD3270@sigill.intra.peff.net>
References: <20130511161320.GA14990@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 11 18:17:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbCTj-0003tL-Tk
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 18:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753264Ab3EKQQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 12:16:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:58773 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753213Ab3EKQQz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 12:16:55 -0400
Received: (qmail 9366 invoked by uid 102); 11 May 2013 16:17:20 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (213.221.117.228)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 11 May 2013 11:17:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 11 May 2013 18:16:52 +0200
Content-Disposition: inline
In-Reply-To: <20130511161320.GA14990@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223980>

When we run a regular "git fetch" without arguments, we
update the tracking refs according to the configured
refspec. However, when we run "git fetch origin master" (or
"git pull origin master"), we do not look at the configured
refspecs at all, and just update FETCH_HEAD.

We miss an opportunity to update "refs/remotes/origin/master"
(or whatever the user has configured). Some users find this
confusing, because they would want to do further comparisons
against the old state of the remote master, like:

  $ git pull origin master
  $ git log HEAD...origin/master

In the currnet code, they are comparing against whatever
commit happened to be in origin/master from the last time
they did a complete "git fetch".  This patch will update a
ref from the RHS of a configured refspec whenever we happen
to be fetching its LHS. That makes the case above work.

The downside is that any users who really care about whether
and when their tracking branches are updated may be
surprised.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/pull-fetch-param.txt |  2 +-
 builtin/fetch.c                    | 16 ++++++++++++++++
 t/t5510-fetch.sh                   |  8 ++++----
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index 6f5ca21..18cffc2 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -75,4 +75,4 @@ endif::git-pull[]
 * A parameter <ref> without a colon merges <ref> into the current
   branch,
 endif::git-pull[]
-  while not storing the branch anywhere locally.
+  and updates the remote-tracking branches (if any).
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 287cf4c..e41cc0d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -160,6 +160,8 @@ static struct ref *get_ref_map(struct transport *transport,
 	const struct ref *remote_refs = transport_get_remote_refs(transport);
 
 	if (ref_count || tags == TAGS_SET) {
+		struct ref **old_tail;
+
 		for (i = 0; i < ref_count; i++) {
 			get_fetch_map(remote_refs, &refs[i], &tail, 0);
 			if (refs[i].dst && refs[i].dst[0])
@@ -170,6 +172,20 @@ static struct ref *get_ref_map(struct transport *transport,
 			rm->fetch_head_status = FETCH_HEAD_MERGE;
 		if (tags == TAGS_SET)
 			get_fetch_map(remote_refs, tag_refspec, &tail, 0);
+
+		/*
+		 * For any refs that we happen to be fetching via command-line
+		 * arguments, take the opportunity to update their configured
+		 * counterparts. However, we do not want to mention these
+		 * entries in FETCH_HEAD at all, as they would simply be
+		 * duplicates of existing entries.
+		 */
+		old_tail = tail;
+		for (i = 0; i < transport->remote->fetch_refspec_nr; i++)
+			get_fetch_map(ref_map, &transport->remote->fetch[i],
+				      &tail, 0);
+		for (rm = *old_tail; rm; rm = rm->next)
+			rm->fetch_head_status = FETCH_HEAD_IGNORE;
 	} else {
 		/* Use the defaults */
 		struct remote *remote = transport->remote;
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 789c228..ff43e08 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -377,7 +377,7 @@ test_expect_success 'mark initial state of origin/master' '
 	)
 '
 
-test_expect_success 'explicit fetch should not update tracking' '
+test_expect_success 'explicit fetch should update tracking' '
 
 	cd "$D" &&
 	git branch -f side &&
@@ -387,12 +387,12 @@ test_expect_success 'explicit fetch should not update tracking' '
 		o=$(git rev-parse --verify refs/remotes/origin/master) &&
 		git fetch origin master &&
 		n=$(git rev-parse --verify refs/remotes/origin/master) &&
-		test "$o" = "$n" &&
+		test "$o" != "$n" &&
 		test_must_fail git rev-parse --verify refs/remotes/origin/side
 	)
 '
 
-test_expect_success 'explicit pull should not update tracking' '
+test_expect_success 'explicit pull should update tracking' '
 
 	cd "$D" &&
 	git branch -f side &&
@@ -402,7 +402,7 @@ test_expect_success 'explicit pull should not update tracking' '
 		o=$(git rev-parse --verify refs/remotes/origin/master) &&
 		git pull origin master &&
 		n=$(git rev-parse --verify refs/remotes/origin/master) &&
-		test "$o" = "$n" &&
+		test "$o" != "$n" &&
 		test_must_fail git rev-parse --verify refs/remotes/origin/side
 	)
 '
-- 
1.8.3.rc1.2.g12db477
