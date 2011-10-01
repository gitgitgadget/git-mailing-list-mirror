From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 8/8] commit: factor out clear_commit_marks_for_object_array
Date: Sat, 01 Oct 2011 18:16:08 +0200
Message-ID: <4E873CC8.6060100@lsrfire.ath.cx>
References: <4DF6A8B6.9030301@op5.se> <7c0105c6cca7dd0aa336522f90617fe4@quantumfyre.co.uk> <4E84B89F.4060304@lsrfire.ath.cx> <201109291411.06733.mfick@codeaurora.org> <4E8587E8.9070606@lsrfire.ath.cx> <7vfwjeotv1.fsf@alter.siamese.dyndns.org> <4E8607B6.2040800@lsrfire.ath.cx> <4E8731AF.2040305@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Fick <mfick@codeaurora.org>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sat Oct 01 18:16:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RA2El-0002GO-W6
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 18:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755230Ab1JAQQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Oct 2011 12:16:24 -0400
Received: from india601.server4you.de ([85.25.151.105]:55660 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813Ab1JAQQX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2011 12:16:23 -0400
Received: from [192.168.2.104] (p4FFD8E7C.dip.t-dialin.net [79.253.142.124])
	by india601.server4you.de (Postfix) with ESMTPSA id 7CC522F803A;
	Sat,  1 Oct 2011 18:16:21 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0) Gecko/20110922 Thunderbird/7.0
In-Reply-To: <4E8731AF.2040305@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182563>

Factor out the code to clear the commit marks for a whole struct
object_array from builtin/checkout.c into its own exported function
clear_commit_marks_for_object_array and use it in bisect and bundle
as well.  It handles tags and commits and ignores objects of any
other type.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 bisect.c           |    7 ++-----
 builtin/checkout.c |    8 +-------
 bundle.c           |    3 +--
 commit.c           |   14 ++++++++++++++
 commit.h           |    1 +
 5 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/bisect.c b/bisect.c
index a05504f..b4547b9 100644
--- a/bisect.c
+++ b/bisect.c
@@ -826,7 +826,7 @@ static int check_ancestors(const char *prefix)
 {
 	struct rev_info revs;
 	struct object_array pending_copy;
-	int i, res;
+	int res;
 
 	bisect_rev_setup(&revs, prefix, "^%s", "%s", 0);
 
@@ -843,10 +843,7 @@ static int check_ancestors(const char *prefix)
 	res = (revs.commits != NULL);
 
 	/* Clean up objects used, as they will be reused. */
-	for (i = 0; i < pending_copy.nr; i++) {
-		struct object *o = pending_copy.objects[i].item;
-		clear_commit_marks((struct commit *)o, ALL_REV_FLAGS);
-	}
+	clear_commit_marks_for_object_array(&pending_copy, ALL_REV_FLAGS);
 	free(pending_copy.objects);
 
 	return res;
diff --git a/builtin/checkout.c b/builtin/checkout.c
index cfd7e59..683819b 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -664,7 +664,6 @@ static void orphaned_commit_warning(struct commit *commit)
 	struct rev_info revs;
 	struct object *object = &commit->object;
 	struct object_array refs;
-	unsigned int i;
 
 	init_revisions(&revs, NULL);
 	setup_revisions(0, NULL, &revs, NULL);
@@ -684,12 +683,7 @@ static void orphaned_commit_warning(struct commit *commit)
 	else
 		describe_detached_head(_("Previous HEAD position was"), commit);
 
-	for (i = 0; i < refs.nr; i++) {
-		struct object *o = refs.objects[i].item;
-		struct commit *c = lookup_commit_reference_gently(o->sha1, 1);
-		if (c)
-			clear_commit_marks(c, ALL_REV_FLAGS);
-	}
+	clear_commit_marks_for_object_array(&refs, ALL_REV_FLAGS);
 	free(refs.objects);
 }
 
diff --git a/bundle.c b/bundle.c
index 26cc9ab..a8ea918 100644
--- a/bundle.c
+++ b/bundle.c
@@ -141,8 +141,7 @@ int verify_bundle(struct bundle_header *header, int verbose)
 				refs.objects[i].name);
 		}
 
-	for (i = 0; i < refs.nr; i++)
-		clear_commit_marks((struct commit *)refs.objects[i].item, -1);
+	clear_commit_marks_for_object_array(&refs, ALL_REV_FLAGS);
 	free(refs.objects);
 
 	if (verbose) {
diff --git a/commit.c b/commit.c
index 97b4327..50af007 100644
--- a/commit.c
+++ b/commit.c
@@ -430,6 +430,20 @@ void clear_commit_marks(struct commit *commit, unsigned int mark)
 	}
 }
 
+void clear_commit_marks_for_object_array(struct object_array *a, unsigned mark)
+{
+	struct object *object;
+	struct commit *commit;
+	unsigned int i;
+
+	for (i = 0; i < a->nr; i++) {
+		object = a->objects[i].item;
+		commit = lookup_commit_reference_gently(object->sha1, 1);
+		if (commit)
+			clear_commit_marks(commit, mark);
+	}
+}
+
 struct commit *pop_commit(struct commit_list **stack)
 {
 	struct commit_list *top = *stack;
diff --git a/commit.h b/commit.h
index 12d100b..0a4c730 100644
--- a/commit.h
+++ b/commit.h
@@ -126,6 +126,7 @@ struct commit *pop_most_recent_commit(struct commit_list **list,
 struct commit *pop_commit(struct commit_list **stack);
 
 void clear_commit_marks(struct commit *commit, unsigned int mark);
+void clear_commit_marks_for_object_array(struct object_array *a, unsigned mark);
 
 /*
  * Performs an in-place topological sort of list supplied.
-- 
1.7.7
