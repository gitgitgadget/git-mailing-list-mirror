From: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
Subject: [PATCH] Warnings before rebasing -i published history
Date: Thu,  7 Jun 2012 23:20:53 +0200
Message-ID: <1339104053-7782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Cc: Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 07 23:21:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sck8h-0005NV-QW
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 23:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128Ab2FGVVD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 17:21:03 -0400
Received: from mx1.imag.fr ([129.88.30.5]:40584 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756804Ab2FGVVB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 17:21:01 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q57LCBur004232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 7 Jun 2012 23:12:11 +0200
Received: from ensibm.imag.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q57LKsHj028573;
	Thu, 7 Jun 2012 23:20:54 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id q57LKs3Z007973;
	Thu, 7 Jun 2012 23:20:54 +0200
Received: (from konglu@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id q57LKrU3007972;
	Thu, 7 Jun 2012 23:20:53 +0200
X-Mailer: git-send-email 1.7.8
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 07 Jun 2012 23:12:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q57LCBur004232
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: lucien.kong@phelma.grenoble-inp.fr
MailScanner-NULL-Check: 1339708336.63761@lMBjSpZmG/Jz+I0cnjIk5A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199455>

"git rebase -i" can be very dangerous if used on an already published
history. This code detects that one is rewriting a commit that is an
ancestor of a remote-tracking branch, and warns the user through the
editor.

Signed-off-by: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
Signed-off-by: Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>
Signed-off-by: Franck Jonas <Franck.Jonas@ensimag.imag.fr>
Signed-off-by: Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
Signed-off-by: Huynh Khoi Nguyen Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---
For now, the code only warns the user; he can't revert back to his
original state. We agree with everyone that he should be given a
way to abort the rebase.

 git-rebase--interactive.sh    |   17 +++++++++++++++++
 t/t3404-rebase-interactive.sh |   26 ++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0c19b7c..67b5faf 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -684,6 +684,20 @@ rearrange_squash () {
 	rm -f "$1.sq" "$1.rearranged"
 }
 
+# Add a warning notification at the end of each pick or fixup/squash
+# line of the todo list, providing the picking commit is already
+# published.
+warn_published () {
+	cat "$1" | while read -r command sha1 message
+	do
+		test -n "$sha1" || break
+		if test -n "$(git branch -r --contains "$sha1")"
+		then
+			printf "%s\n" "$(sed -e "/"$sha1"/ s|$| [Published]|" "$1")" >"$1"
+		fi
+	done
+}
+
 case "$action" in
 continue)
 	# do we have anything to commit?
@@ -857,6 +871,7 @@ fi
 
 test -s "$todo" || echo noop >> "$todo"
 test -n "$autosquash" && rearrange_squash "$todo"
+warn_published "$todo"
 cat >> "$todo" << EOF
 
 # Rebase $shortrevisions onto $shortonto
@@ -869,6 +884,8 @@ cat >> "$todo" << EOF
 #  f, fixup = like "squash", but discard this commit's log message
 #  x, exec = run command (the rest of the line) using shell
 #
+# Warning: [Published] means that the commit has already been published
+#
 # These lines can be re-ordered; they are executed from top to bottom.
 #
 # If you remove a line here THAT COMMIT WILL BE LOST.
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 025c1c6..f7c31c1 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -755,4 +755,30 @@ test_expect_success 'rebase-i history with funny messages' '
 	test_cmp expect actual
 '
 
+test_expect_success 'warn before rewriting published history' '
+	test_when_finished "rm -rf git.git git" &&
+	git init git.git &&
+	git clone git &&
+	(
+		cd git &&
+		test_commit one_commit main.txt one_commit &&
+		test_commit two_commit main.txt two_commit &&
+		test_commit three_commit main.txt three_commit &&
+		git push --all &&
+		test_commit four_commit main.txt four_commit &&
+		FAKE_LINES="1 2 3" &&
+		export FAKE_LINES &&
+		tmp=$(git rebase -i HEAD~3 | sed -n 2,4p) &&
+		echo "$tmp" >actual &&
+		tmp=$(git cherry --abbrev=7 HEAD~3 | sed -e 's/+[[:space:]]//g') &&
+		two_sha1=$(echo "$tmp" | sed -n 1p) &&
+		three_sha1=$(echo "$tmp" | sed -n 2p) &&
+		four_sha1=$(echo "$tmp" | sed -n 3p) &&
+		echo "pick $two_sha1 two_commit [Published]" >expected &&
+		echo "pick $three_sha1 three_commit [Published]" >>expected &&
+		echo "pick $four_sha1 four_commit" >>expected &&
+		test_cmp expected actual
+	)
+'
+
 test_done
-- 
1.7.8
