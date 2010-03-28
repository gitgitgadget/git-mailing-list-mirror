From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] rebase -i: make post-rewrite work for 'edit'
Date: Sun, 28 Mar 2010 21:36:00 +0200
Message-ID: <7f2e78b2d598b811c028be438780cb9908aa516e.1269803338.git.trast@student.ethz.ch>
References: <7vd3yo2vno.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sverre Rabbelier <srabbelier@gmail.com>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 28 21:36:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvyHR-0005kq-KB
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 21:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755096Ab0C1TgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 15:36:09 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:31031 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755088Ab0C1TgH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 15:36:07 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sun, 28 Mar
 2010 21:36:03 +0200
Received: from localhost.localdomain (129.132.211.164) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sun, 28 Mar
 2010 21:36:02 +0200
X-Mailer: git-send-email 1.7.0.3.461.ga69fc
In-Reply-To: <7vd3yo2vno.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143419>

The post-rewrite support, in the form of the call to
'record_in_rewritten', was hidden in the arm where we have to record a
new commit for the user.  This meant that it was never invoked in the
case where the user has already amended the commit by herself.

[The test is designed to exercise both arms of the 'if' in question.]

Furthermore, recording the stopped-sha (the SHA1 of the commit before
the editing) suffered from a cut&paste error from die_with_patch and
used the wrong variable, hence it never recorded anything.

Noticed by Junio.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Junio C Hamano wrote:
> I am getting this:
> 
> /home/junio/g/Debian-5.0.4-x86_64/git-next/libexec/git-core/git-rebase--interactive: line 565: /git/.git/rebase-merge/rewritten-list: No such file or directory
> Successfully rebased and updated refs/heads/nd/setup.
> 
> This was after marking both commits in a two-patch series for "edit" in
> rebase -i, running "commit --amend; rebase --continue; commit --amend";
> saying "rebase --continue" at this point gave this error.

No need for question marks, this is not only a bug but also squarely
in the wtf-was-I-smoking department ;-)

I changed the test slightly from what you describe, to make it go
through both code paths (as indicated in the bracketed remark).


 git-rebase--interactive.sh   |    5 +++--
 t/t5407-post-rewrite-hook.sh |   16 ++++++++++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a57f043..1d116bf 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -475,7 +475,7 @@ do_next () {
 		mark_action_done
 		pick_one $sha1 ||
 			die_with_patch $sha1 "Could not apply $sha1... $rest"
-		echo "$1" > "$DOTEST"/stopped-sha
+		echo "$sha1" > "$DOTEST"/stopped-sha
 		make_patch $sha1
 		git rev-parse --verify HEAD > "$AMEND"
 		warn "Stopped at $sha1... $rest"
@@ -723,9 +723,10 @@ first and then run 'git rebase --continue' again."
 				test -n "$amend" && git reset --soft $amend
 				die "Could not commit staged changes."
 			}
-			record_in_rewritten "$(cat "$DOTEST"/stopped-sha)"
 		fi
 
+		record_in_rewritten "$(cat "$DOTEST"/stopped-sha)"
+
 		require_clean_work_tree
 		do_rest
 		;;
diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index f0f91f1..552da65 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -180,4 +180,20 @@ EOF
 	verify_hook_input
 '
 
+test_expect_success 'git rebase -i (double edit)' '
+	git reset --hard D &&
+	clear_hook_input &&
+	FAKE_LINES="edit 1 edit 2" git rebase -i B &&
+	git rebase --continue &&
+	echo something > foo &&
+	git add foo &&
+	git rebase --continue &&
+	echo rebase >expected.args &&
+	cat >expected.data <<EOF &&
+$(git rev-parse C) $(git rev-parse HEAD^)
+$(git rev-parse D) $(git rev-parse HEAD)
+EOF
+	verify_hook_input
+'
+
 test_done
-- 
1.7.0.3.461.ga69fc
