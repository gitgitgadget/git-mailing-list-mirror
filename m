From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/8] checkout: use add_pending_{object,sha1} in orphan check
Date: Sat, 01 Oct 2011 17:51:39 +0200
Message-ID: <4E87370B.4060908@lsrfire.ath.cx>
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
X-From: git-owner@vger.kernel.org Sat Oct 01 17:51:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RA1r4-00058Z-LE
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 17:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884Ab1JAPvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Oct 2011 11:51:54 -0400
Received: from india601.server4you.de ([85.25.151.105]:55626 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423Ab1JAPvx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2011 11:51:53 -0400
Received: from [192.168.2.104] (p4FFDAD66.dip.t-dialin.net [79.253.173.102])
	by india601.server4you.de (Postfix) with ESMTPSA id 129B42F803A;
	Sat,  1 Oct 2011 17:51:52 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0) Gecko/20110922 Thunderbird/7.0
In-Reply-To: <4E8731AF.2040305@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182558>

Instead of building a list of textual arguments for setup_revisions, use
add_pending_object and add_pending_sha1 to queue the objects directly.
This is both faster and simpler.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin/checkout.c |   39 ++++++++++++---------------------------
 1 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5e356a6..84e0cdc 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -588,24 +588,11 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 		report_tracking(new);
 }
 
-struct rev_list_args {
-	int argc;
-	int alloc;
-	const char **argv;
-};
-
-static void add_one_rev_list_arg(struct rev_list_args *args, const char *s)
-{
-	ALLOC_GROW(args->argv, args->argc + 1, args->alloc);
-	args->argv[args->argc++] = s;
-}
-
-static int add_one_ref_to_rev_list_arg(const char *refname,
-				       const unsigned char *sha1,
-				       int flags,
-				       void *cb_data)
+static int add_pending_uninteresting_ref(const char *refname,
+					 const unsigned char *sha1,
+					 int flags, void *cb_data)
 {
-	add_one_rev_list_arg(cb_data, refname);
+	add_pending_sha1(cb_data, refname, sha1, flags | UNINTERESTING);
 	return 0;
 }
 
@@ -685,19 +672,17 @@ static void suggest_reattach(struct commit *commit, struct rev_info *revs)
  */
 static void orphaned_commit_warning(struct commit *commit)
 {
-	struct rev_list_args args = { 0, 0, NULL };
 	struct rev_info revs;
-
-	add_one_rev_list_arg(&args, "(internal)");
-	add_one_rev_list_arg(&args, sha1_to_hex(commit->object.sha1));
-	add_one_rev_list_arg(&args, "--not");
-	for_each_ref(add_one_ref_to_rev_list_arg, &args);
-	add_one_rev_list_arg(&args, "--");
-	add_one_rev_list_arg(&args, NULL);
+	struct object *object = &commit->object;
 
 	init_revisions(&revs, NULL);
-	if (setup_revisions(args.argc - 1, args.argv, &revs, NULL) != 1)
-		die(_("internal error: only -- alone should have been left"));
+	setup_revisions(0, NULL, &revs, NULL);
+
+	object->flags &= ~UNINTERESTING;
+	add_pending_object(&revs, object, sha1_to_hex(object->sha1));
+
+	for_each_ref(add_pending_uninteresting_ref, &revs);
+
 	if (prepare_revision_walk(&revs))
 		die(_("internal error in revision walk"));
 	if (!(commit->object.flags & UNINTERESTING))
-- 
1.7.7
