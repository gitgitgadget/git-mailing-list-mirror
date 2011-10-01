From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 7/8] checkout: use leak_pending flag
Date: Sat, 01 Oct 2011 18:09:36 +0200
Message-ID: <4E873B40.7030409@lsrfire.ath.cx>
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
X-From: git-owner@vger.kernel.org Sat Oct 01 18:09:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RA28U-0000du-8O
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 18:09:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755274Ab1JAQJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Oct 2011 12:09:52 -0400
Received: from india601.server4you.de ([85.25.151.105]:55653 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754165Ab1JAQJu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2011 12:09:50 -0400
Received: from [192.168.2.104] (p4FFDAD66.dip.t-dialin.net [79.253.173.102])
	by india601.server4you.de (Postfix) with ESMTPSA id 3C7D32F803A;
	Sat,  1 Oct 2011 18:09:49 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0) Gecko/20110922 Thunderbird/7.0
In-Reply-To: <4E8731AF.2040305@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182562>

Instead of going through all the references again when we clear the
commit marks, do it like bisect and bundle and gain ownership of the
list of pending objects which we constructed from those references.

We simply copy the struct object_array that points to the list, set
the flag leak_pending and then prepare_revision_walk won't destroy
it and it's ours.  We use it to clear the marks and  free it at the
end.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin/checkout.c |   25 ++++++++++++-------------
 1 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 84e0cdc..cfd7e59 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -596,17 +596,6 @@ static int add_pending_uninteresting_ref(const char *refname,
 	return 0;
 }
 
-static int clear_commit_marks_from_one_ref(const char *refname,
-				      const unsigned char *sha1,
-				      int flags,
-				      void *cb_data)
-{
-	struct commit *commit = lookup_commit_reference_gently(sha1, 1);
-	if (commit)
-		clear_commit_marks(commit, -1);
-	return 0;
-}
-
 static void describe_one_orphan(struct strbuf *sb, struct commit *commit)
 {
 	parse_commit(commit);
@@ -674,6 +663,8 @@ static void orphaned_commit_warning(struct commit *commit)
 {
 	struct rev_info revs;
 	struct object *object = &commit->object;
+	struct object_array refs;
+	unsigned int i;
 
 	init_revisions(&revs, NULL);
 	setup_revisions(0, NULL, &revs, NULL);
@@ -683,6 +674,9 @@ static void orphaned_commit_warning(struct commit *commit)
 
 	for_each_ref(add_pending_uninteresting_ref, &revs);
 
+	refs = revs.pending;
+	revs.leak_pending = 1;
+
 	if (prepare_revision_walk(&revs))
 		die(_("internal error in revision walk"));
 	if (!(commit->object.flags & UNINTERESTING))
@@ -690,8 +684,13 @@ static void orphaned_commit_warning(struct commit *commit)
 	else
 		describe_detached_head(_("Previous HEAD position was"), commit);
 
-	clear_commit_marks(commit, -1);
-	for_each_ref(clear_commit_marks_from_one_ref, NULL);
+	for (i = 0; i < refs.nr; i++) {
+		struct object *o = refs.objects[i].item;
+		struct commit *c = lookup_commit_reference_gently(o->sha1, 1);
+		if (c)
+			clear_commit_marks(c, ALL_REV_FLAGS);
+	}
+	free(refs.objects);
 }
 
 static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
-- 
1.7.7
