From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 10/10] push: teach push to be quiet if local ref is strict subset of remote ref
Date: Sun, 28 Oct 2007 18:46:21 +0100
Message-ID: <11935935821192-git-send-email-prohaska@zib.de>
References: <1193593581312-git-send-email-prohaska@zib.de>
 <11935935812741-git-send-email-prohaska@zib.de>
 <1193593581114-git-send-email-prohaska@zib.de>
 <1193593581486-git-send-email-prohaska@zib.de>
 <11935935812185-git-send-email-prohaska@zib.de>
 <11935935822846-git-send-email-prohaska@zib.de>
 <11935935821136-git-send-email-prohaska@zib.de>
 <11935935823045-git-send-email-prohaska@zib.de>
 <11935935821800-git-send-email-prohaska@zib.de>
 <11935935823496-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 28 18:50:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImCH0-0000QQ-SL
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 18:50:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754951AbXJ1Rtw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 13:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754531AbXJ1Rtv
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 13:49:51 -0400
Received: from mailer.zib.de ([130.73.108.11]:63827 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752862AbXJ1Rtt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 13:49:49 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9SHkMFx016203
	for <git@vger.kernel.org>; Sun, 28 Oct 2007 18:49:47 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9SHkLse019730;
	Sun, 28 Oct 2007 18:46:22 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <11935935823496-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62577>

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

This commit teaches git push to be quiet for local refs that are
strict subsets of the matching remote refs and no refspec is
specified on the command line. If the --verbose flag is used a
"note" is printed instead of silently ignoring the refs.
If no notes have been printed the number of ignored refs will
be reported in the final summary.

If refs are ignored their matching remote tracking refs will not
be changed.

git push now allows you pushing a couple of branches that have
advanced, while ignoring all branches that have no local changes,
but are lagging behind their matching remote refs. This is done
without reporting errors.

Thanks to Junio C. Hamano <gitster@pobox.com> for suggesting to
report in the summary that refs have been ignored.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 send-pack.c           |   68 +++++++++++++++++++++++++++++++---------
 t/t5516-fetch-push.sh |   84 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+), 15 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 77acae1..68a4692 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -187,6 +187,7 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
 	int ask_for_status_report = 0;
 	int allow_deleting_refs = 0;
 	int expect_status_report = 0;
+	int ignored_refs = 0;
 
 	/* No funny business with the matcher */
 	remote_tail = get_remote_heads(in, &remote_refs, 0, NULL, REF_NORMAL);
@@ -259,24 +260,56 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
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
+				} else
+					ignored_refs++;
+				continue;
 			}
 		}
 		hashcpy(ref->new_sha1, ref->peer_ref->new_sha1);
@@ -335,6 +368,11 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
 			ret = -4;
 	}
 
+	if (ignored_refs)
+		fprintf(stderr,
+			"Ignored %d local refs that are strict subsets of matching remote ref. "
+			"Use --verbose for more details.\n",
+			ignored_refs);
 	if (!new_refs && ret == 0)
 		fprintf(stderr, "Everything up-to-date\n");
 	return ret;
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 6708ec1..1f740b2 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -56,6 +56,22 @@ check_push_result () {
 	)
 }
 
+check_local_result () {
+	(
+		it="$1" &&
+		shift
+		for ref in "$@"
+		do
+			r=$(git show-ref -s --verify refs/$ref) &&
+			test "z$r" = "z$it" || {
+				echo "Oops, refs/$ref is wrong"
+				exit 1
+			}
+		done &&
+		git fsck --full
+	)
+}
+
 test_expect_success setup '
 
 	: >path1 &&
@@ -345,4 +361,72 @@ test_expect_success 'push with dry-run' '
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
+	else
+		check_push_result $the_commit heads/foo
+	fi
+
+'
+
+test_expect_success 'push with local is strict subset (must not update remotes)' '
+
+	mk_test heads/foo &&
+	git push testrepo $the_commit:refs/heads/foo &&
+	git branch -f foo $old_commit &&
+	git fetch test &&
+	check_local_result $the_commit remotes/test/foo &&
+	if git push test 2>&1 | grep ^error
+	then
+		echo "Oops, should not report error"
+		false
+	else
+		check_push_result $the_commit heads/foo &&
+		check_local_result $the_commit remotes/test/foo
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
+	else
+		check_push_result $the_commit heads/foo
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
+	else
+		check_push_result $the_commit heads/foo
+	fi
+
+'
+
 test_done
-- 
1.5.3.4.439.ge8b49
