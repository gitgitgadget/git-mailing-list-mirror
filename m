From: Jeff King <peff@peff.net>
Subject: [PATCH v2 07/25] reachable: reuse revision.c "add all reflogs" code
Date: Wed, 15 Oct 2014 18:38:31 -0400
Message-ID: <20141015223831.GG25630@peff.net>
References: <20141015223244.GA25368@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 00:38:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeXDK-0006I3-4P
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 00:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbaJOWie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 18:38:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:58945 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750721AbaJOWid (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 18:38:33 -0400
Received: (qmail 2286 invoked by uid 102); 15 Oct 2014 22:38:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 17:38:33 -0500
Received: (qmail 27967 invoked by uid 107); 15 Oct 2014 22:38:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Oct 2014 18:38:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Oct 2014 18:38:31 -0400
Content-Disposition: inline
In-Reply-To: <20141015223244.GA25368@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We want to add all reflog entries as tips for finding
reachable objects. The revision machinery can already do
this (to support "rev-list --reflog"); we can reuse that
code.

Signed-off-by: Jeff King <peff@peff.net>
---
This one is not strictly necessary, but it seems like a nice cleanup.
Note that the big difference in the revision.c code is that it will
print a warning for broken reflogs, but I think that's fine (and perhaps
even desirable) here.

 reachable.c | 24 +-----------------------
 revision.c  |  4 ++--
 revision.h  |  1 +
 3 files changed, 4 insertions(+), 25 deletions(-)

diff --git a/reachable.c b/reachable.c
index 02bf6c2..4e68cfa 100644
--- a/reachable.c
+++ b/reachable.c
@@ -22,22 +22,6 @@ static void update_progress(struct connectivity_progress *cp)
 		display_progress(cp->progress, cp->count);
 }
 
-static int add_one_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
-		const char *email, unsigned long timestamp, int tz,
-		const char *message, void *cb_data)
-{
-	struct object *object;
-	struct rev_info *revs = (struct rev_info *)cb_data;
-
-	object = parse_object(osha1);
-	if (object)
-		add_pending_object(revs, object, "");
-	object = parse_object(nsha1);
-	if (object)
-		add_pending_object(revs, object, "");
-	return 0;
-}
-
 static int add_one_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
 {
 	struct object *object = parse_object_or_die(sha1, path);
@@ -48,12 +32,6 @@ static int add_one_ref(const char *path, const unsigned char *sha1, int flag, vo
 	return 0;
 }
 
-static int add_one_reflog(const char *path, const unsigned char *sha1, int flag, void *cb_data)
-{
-	for_each_reflog_ent(path, add_one_reflog_ent, cb_data);
-	return 0;
-}
-
 static void add_one_tree(const unsigned char *sha1, struct rev_info *revs)
 {
 	struct tree *tree = lookup_tree(sha1);
@@ -138,7 +116,7 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 
 	/* Add all reflog info */
 	if (mark_reflog)
-		for_each_reflog(add_one_reflog, revs);
+		add_reflogs_to_pending(revs, 0);
 
 	cp.progress = progress;
 	cp.count = 0;
diff --git a/revision.c b/revision.c
index 01cc276..b8e02e2 100644
--- a/revision.c
+++ b/revision.c
@@ -1275,7 +1275,7 @@ static int handle_one_reflog(const char *path, const unsigned char *sha1, int fl
 	return 0;
 }
 
-static void handle_reflog(struct rev_info *revs, unsigned flags)
+void add_reflogs_to_pending(struct rev_info *revs, unsigned flags)
 {
 	struct all_refs_cb cb;
 	cb.all_revs = revs;
@@ -2061,7 +2061,7 @@ static int handle_revision_pseudo_opt(const char *submodule,
 		for_each_glob_ref_in(handle_one_ref, arg + 10, "refs/remotes/", &cb);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--reflog")) {
-		handle_reflog(revs, *flags);
+		add_reflogs_to_pending(revs, *flags);
 	} else if (!strcmp(arg, "--not")) {
 		*flags ^= UNINTERESTING | BOTTOM;
 	} else if (!strcmp(arg, "--no-walk")) {
diff --git a/revision.h b/revision.h
index a620530..e644044 100644
--- a/revision.h
+++ b/revision.h
@@ -276,6 +276,7 @@ extern void add_pending_sha1(struct rev_info *revs,
 			     unsigned int flags);
 
 extern void add_head_to_pending(struct rev_info *);
+extern void add_reflogs_to_pending(struct rev_info *, unsigned int flags);
 
 enum commit_action {
 	commit_ignore,
-- 
2.1.2.596.g7379948
