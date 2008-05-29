From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] "git checkout -- paths..." should error out when paths
 cannot be written
Date: Wed, 28 May 2008 17:17:21 -0700
Message-ID: <1212020246-26480-2-git-send-email-gitster@pobox.com>
References: <1212020246-26480-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 02:18:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1Vqk-0004Dn-TF
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 02:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696AbYE2ARl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 20:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752676AbYE2ARl
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 20:17:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52623 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487AbYE2ARk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 20:17:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 877D024F7
	for <git@vger.kernel.org>; Wed, 28 May 2008 20:17:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id CE1AB24F6 for <git@vger.kernel.org>; Wed, 28 May 2008 20:17:38 -0400
 (EDT)
X-Mailer: git-send-email 1.5.6.rc0.43.g823ea
In-Reply-To: <1212020246-26480-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A5CF8B2A-2D14-11DD-8979-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83156>

When "git checkout -- paths..." cannot update work tree for whatever
reason, checkout_entry() correctly issued an error message for the path to
the end user, but the command ignored the error, causing the entire
command to succeed.  This fixes it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-checkout.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 1ea017f..00dc8ca 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -84,6 +84,7 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec)
 	unsigned char rev[20];
 	int flag;
 	struct commit *head;
+	int errs = 0;
 
 	int newfd;
 	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
@@ -106,13 +107,14 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec)
 	if (report_path_error(ps_matched, pathspec, 0))
 		return 1;
 
+	/* Now we are committed to check them out */
 	memset(&state, 0, sizeof(state));
 	state.force = 1;
 	state.refresh_cache = 1;
 	for (pos = 0; pos < active_nr; pos++) {
 		struct cache_entry *ce = active_cache[pos];
 		if (pathspec_match(pathspec, NULL, ce->name, 0)) {
-			checkout_entry(ce, &state, NULL);
+			errs |= checkout_entry(ce, &state, NULL);
 		}
 	}
 
@@ -123,7 +125,8 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec)
 	resolve_ref("HEAD", rev, 0, &flag);
 	head = lookup_commit_reference_gently(rev, 1);
 
-	return post_checkout_hook(head, head, 0);
+	errs |= post_checkout_hook(head, head, 0);
+	return errs;
 }
 
 static void show_local_changes(struct object *head)
-- 
1.5.6.rc0.43.g823ea
