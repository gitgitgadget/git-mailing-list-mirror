From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] "git checkout -- paths..." should signal error
Date: Wed, 28 May 2008 14:19:38 -0700
Message-ID: <7vtzgirus5.fsf_-_@gitster.siamese.dyndns.org>
References: <483AC2CE.7090801@gmail.com>
 <7vy75vvtxo.fsf@gitster.siamese.dyndns.org>
 <32541b130805280933r573d59d0mf9cdc09f5e5a6a17@mail.gmail.com>
 <7vfxs2uytm.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0805281326520.19665@iabervon.org>
 <7vskw2tgu2.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0805281455100.19665@iabervon.org>
 <7v7idetb1h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed May 28 23:20:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1T4f-0006SZ-38
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 23:20:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272AbYE1VTy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 17:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753271AbYE1VTx
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 17:19:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59834 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263AbYE1VTx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 17:19:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 649416F9B;
	Wed, 28 May 2008 17:19:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 7E1BC6F9A; Wed, 28 May 2008 17:19:45 -0400 (EDT)
In-Reply-To: <7v7idetb1h.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 28 May 2008 13:43:06 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CD50625A-2CFB-11DD-884C-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83136>

When "git checkout -- paths..." cannot update work tree for whatever
reason, checkout_entry() correctly issued an error message for the path to
the end user, but the command ignored the error, causing the entire
command to succeed.  This fixes it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Now that we detect this failure, post-checkout-hook _might_ want to
   know that what we have is an incomplete checkout.  Not calling the hook
   in such a case may be another option, but we always called the hook and
   that would be a change in behaviour.

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
