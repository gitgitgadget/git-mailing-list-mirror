From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 8/8] push: teach push to be quiet if local ref is strict subset of remote ref
Date: Sat, 27 Oct 2007 18:50:07 +0200
Message-ID: <11935038083335-git-send-email-prohaska@zib.de>
References: <119350380778-git-send-email-prohaska@zib.de>
 <11935038081211-git-send-email-prohaska@zib.de>
 <11935038081650-git-send-email-prohaska@zib.de>
 <1193503808519-git-send-email-prohaska@zib.de>
 <11935038083369-git-send-email-prohaska@zib.de>
 <11935038084055-git-send-email-prohaska@zib.de>
 <11935038084130-git-send-email-prohaska@zib.de>
 <11935038083116-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 27 18:51:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlosK-0004eP-Qi
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 18:51:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754385AbXJ0QuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 12:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754062AbXJ0QuU
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 12:50:20 -0400
Received: from mailer.zib.de ([130.73.108.11]:49615 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754122AbXJ0QuL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 12:50:11 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9RGo9Re023490
	for <git@vger.kernel.org>; Sat, 27 Oct 2007 18:50:09 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9RGo7oO028374;
	Sat, 27 Oct 2007 18:50:08 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <11935038083116-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62499>

git push reports errors if a remote ref is not a strict subset
of a local ref. The push wouldn't be a fast-forward and is
therefore refused. This is in general a good idea.

But these messages can be annoying if you work with a shared
remote repository. Branches at the remote may have advanced and
you haven't pulled to all of your local branches. In this
situation, local branches may be strict subsets of the remote
heads. Pushing such branches wouldn't add any information to the
remote. It would only reset the remote to an ancestor. A merge
between the remote and the local branch is not very interested
either because it would just be a fast forward of the local
branch. In these cases you're not interested in the error
message.

This commit teaches git push to be quiet if the local is a strict
subset of the remote and no refspec is explicitly specified on
the command line. If the --verbose flag is used a "note:" is
printed for each ignored branch.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 send-pack.c           |   61 +++++++++++++++++++++++++++++++++++++------------
 t/t5516-fetch-push.sh |   44 +++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+), 15 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 77acae1..b95bed9 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -259,24 +259,55 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
 		    !will_delete_ref &&
 		    !is_null_sha1(ref->old_sha1) &&
 		    !ref->force) {
-			if (!has_sha1_file(ref->old_sha1) ||
-			    !ref_newer(ref->peer_ref->new_sha1,
-				       ref->old_sha1)) {
-				/* We do not have the remote ref, or
-				 * we know that the remote ref is not
-				 * an ancestor of what we are trying to
-				 * push.  Either way this can be losing
-				 * commits at the remote end and likely
-				 * we were not up to date to begin with.
+			if (!has_sha1_file(ref->old_sha1)) {
+				/* We do not have the remote ref.
+				 * This can be losing commits at
+				 * the remote end.
 				 */
-				error("remote '%s' is not a strict "
-				      "subset of local ref '%s'. "
-				      "maybe you are not up-to-date and "
-				      "need to pull first?",
-				      ref->name,
-				      ref->peer_ref->name);
+				error("You don't have the commit"
+				      "for the remote ref '%s'."
+				      "This may cause losing commits"
+				      "that cannot be recovered.",
+				      ref->name);
 				ret = -2;
 				continue;
+			} else if (!ref_newer(ref->peer_ref->new_sha1,
+			                      ref->old_sha1)) {
+				/* We know that the remote ref is not
+				 * an ancestor of what we are trying to
+				 * push. This can be losing commits at
+				 * the remote end and likely we were not
+				 * up to date to begin with.
+				 *
+				 * Therefore, we don't push.
+				 *
+				 * If no explicit refspec was passed on the
+				 * commandline, then we only report an error
+				 * if the local is not a strict subset of the
+				 * remote.  If the local is a strict subset we
+				 * don't have new commits for the remote.
+				 * Pulling and pushing wouldn't add anything to
+				 * the remote.
+				 *
+				 */
+				if (nr_refspec ||
+				    !ref_newer(ref->old_sha1, ref->peer_ref->new_sha1)) {
+					error("remote '%s' is not a strict "
+					      "subset of local ref '%s'. "
+					      "maybe you are not up-to-date and "
+					      "need to pull first?",
+					      ref->name,
+					      ref->peer_ref->name);
+					ret = -2;
+				} else if (verbose) {
+					fprintf(stderr,
+					        "note: ignoring local ref '%s' "
+					        "because it is a strict "
+					        "subset of remote '%s'.\n",
+					        ref->peer_ref->name,
+					        ref->name);
+				}
+				continue;
 			}
 		}
 		hashcpy(ref->new_sha1, ref->peer_ref->new_sha1);
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 9ec8216..c8493f9 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -331,4 +331,48 @@ test_expect_success 'push with dry-run' '
 	check_push_result $old_commit heads/master
 '
 
+test_expect_success 'push with local is strict subset (must not report error)' '
+
+	mk_test heads/foo &&
+	git push testrepo $the_commit:refs/heads/foo &&
+	git branch -f foo $old_commit &&
+	if git push testrepo 2>&1 | grep ^error
+	then
+		echo "Oops, should not report error"
+		false
+	fi
+
+'
+
+test_expect_success 'push with explicit refname, local is strict subset (must report error)' '
+
+	mk_test heads/foo &&
+	git push testrepo $the_commit:refs/heads/foo &&
+	git branch -f foo $old_commit &&
+	if ! git push testrepo foo 2>&1 | grep ^error
+	then
+		echo "Oops, should have reported error"
+		false
+	fi
+
+'
+
+test_expect_success 'push with neither local nor remote is strict subset (must report error)' '
+
+	mk_test heads/foo &&
+	git push testrepo $the_commit:refs/heads/foo &&
+	git branch -f foo $old_commit &&
+	git checkout foo &&
+	: >path3 &&
+	git add path3 &&
+	test_tick &&
+	git commit -a -m branched &&
+	if ! git push testrepo 2>&1 | grep ^error
+	then
+		echo "Oops, should have reported error"
+		false
+	fi
+
+'
+
 test_done
-- 
1.5.3.4.1261.g626eb
