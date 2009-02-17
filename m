From: Keith Cascio <keith@cs.ucla.edu>
Subject: [PATCH] Fix neglect of diff_setup()/diff_setup_done() symmetry.
Date: Mon, 16 Feb 2009 18:59:00 -0800
Message-ID: <1234839540-3787-1-git-send-email-keith@cs.ucla.edu>
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 04:00:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZGCL-0004i8-00
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 04:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbZBQC7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 21:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751912AbZBQC7J
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 21:59:09 -0500
Received: from Sensitivity.CS.UCLA.EDU ([131.179.176.150]:40740 "EHLO
	sensitivity.cs.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbZBQC7I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 21:59:08 -0500
Received: from sensitivity.cs.ucla.edu (localhost.localdomain [127.0.0.1])
	by sensitivity.cs.ucla.edu (8.13.8/8.13.8) with ESMTP id n1H2x0Go003815;
	Mon, 16 Feb 2009 18:59:00 -0800
Received: (from keith@localhost)
	by sensitivity.cs.ucla.edu (8.13.8/8.13.8/Submit) id n1H2x0lB003814;
	Mon, 16 Feb 2009 18:59:00 -0800
X-Mailer: git-send-email 1.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110302>

Code that calls diff_setup(), including via init_revisions(), should later call
diff_setup_done(), possibly via setup_revisions(). Failure to do so could cause
errors, especially in the future when we add responsibilities to
diff_setup_done(). This instance causes no known errors with the present code.
But it resulted in an error with an experimental patch.
---
 builtin-checkout.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 20b34ce..c315f63 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -291,14 +291,16 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec,
 static void show_local_changes(struct object *head)
 {
 	struct rev_info rev;
 	/* I think we want full paths, even if we're in a subdirectory. */
 	init_revisions(&rev, NULL);
 	rev.abbrev = 0;
 	rev.diffopt.output_format |= DIFF_FORMAT_NAME_STATUS;
+	if (diff_setup_done(&rev.diffopt) < 0)
+		die("diff_setup_done failed");
 	add_pending_object(&rev, head, NULL);
 	run_diff_index(&rev, 0);
 }
 
 static void describe_detached_head(char *msg, struct commit *commit)
 {
 	struct strbuf sb = STRBUF_INIT;
-- 
1.6.1
