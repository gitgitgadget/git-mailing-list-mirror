From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] http-push.c: remove duplicated code
Date: Sat, 07 Jun 2008 11:39:20 -0700
Message-ID: <7vhcc5nl7r.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nick Hengeveld <nickh@reactrix.com>, Mike Hommey <mh@glandium.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 20:41:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K53MK-0001yy-Sk
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 20:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763959AbYFGSk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 14:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763954AbYFGSjs
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 14:39:48 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45184 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762228AbYFGSjg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 14:39:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 91F0A5A04;
	Sat,  7 Jun 2008 14:39:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8D27759F2; Sat,  7 Jun 2008 14:39:27 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 13C2E20E-34C1-11DD-A52F-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84223>

An earlier commit aa1dbc9 (Update http-push functionality, 2006-03-07)
borrowed some code from rev-list.c.

This copy and paste made sense back then, because mark_edges_uninteresting(),
and its helper mark_edge_parents_uninteresting(), accessed a file scope
static variable  "revs" in rev-list.c, and http-push.c did not have nor care
about such a variable.

But these days they are already properly libified and live in list-objects.c
and they take "revs" as as an argument.  Make use of them and lose 20 or
so lines.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Only compile tested.  I do not use http-push myself nor have a readily
   usable test environment for it, but the patch looks obvious enough.

   I cc'ed Nick, the original author, even though we haven't seen him here
   for quite some time...

 http-push.c |   29 +++--------------------------
 1 files changed, 3 insertions(+), 26 deletions(-)

diff --git a/http-push.c b/http-push.c
index c93e781..665712a 100644
--- a/http-push.c
+++ b/http-push.c
@@ -9,6 +9,7 @@
 #include "revision.h"
 #include "exec_cmd.h"
 #include "remote.h"
+#include "list-objects.h"
 
 #include <expat.h>
 
@@ -1878,31 +1879,6 @@ static int ref_newer(const unsigned char *new_sha1,
 	return found;
 }
 
-static void mark_edge_parents_uninteresting(struct commit *commit)
-{
-	struct commit_list *parents;
-
-	for (parents = commit->parents; parents; parents = parents->next) {
-		struct commit *parent = parents->item;
-		if (!(parent->object.flags & UNINTERESTING))
-			continue;
-		mark_tree_uninteresting(parent->tree);
-	}
-}
-
-static void mark_edges_uninteresting(struct commit_list *list)
-{
-	for ( ; list; list = list->next) {
-		struct commit *commit = list->item;
-
-		if (commit->object.flags & UNINTERESTING) {
-			mark_tree_uninteresting(commit->tree);
-			continue;
-		}
-		mark_edge_parents_uninteresting(commit);
-	}
-}
-
 static void add_remote_info_ref(struct remote_ls_ctx *ls)
 {
 	struct strbuf *buf = (struct strbuf *)ls->userData;
@@ -2408,6 +2384,7 @@ int main(int argc, char **argv)
 		}
 		init_revisions(&revs, setup_git_directory());
 		setup_revisions(commit_argc, commit_argv, &revs, NULL);
+		revs.edge_hint = 0; /* just in case */
 		free(new_sha1_hex);
 		if (old_sha1_hex) {
 			free(old_sha1_hex);
@@ -2418,7 +2395,7 @@ int main(int argc, char **argv)
 		pushing = 0;
 		if (prepare_revision_walk(&revs))
 			die("revision walk setup failed");
-		mark_edges_uninteresting(revs.commits);
+		mark_edges_uninteresting(revs.commits, &revs, NULL);
 		objects_to_send = get_delta(&revs, ref_lock);
 		finish_all_active_slots();
 
