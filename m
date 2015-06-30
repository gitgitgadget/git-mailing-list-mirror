From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/3] fixup! git rebase -i: warn about removed commits
Date: Tue, 30 Jun 2015 11:19:20 +0200
Message-ID: <1435655961-31263-3-git-send-email-Matthieu.Moy@imag.fr>
References: <1435609232-14232-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
 <1435655961-31263-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr, sunshine@sunshineco.com,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jun 30 11:29:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9rqu-0005DP-P2
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 11:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638AbbF3J3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 05:29:12 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50121 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752463AbbF3J3F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 05:29:05 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5U9SoXU031034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 Jun 2015 11:28:50 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5U9Sqla018308;
	Tue, 30 Jun 2015 11:28:52 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Z9rqV-0000VY-V4; Tue, 30 Jun 2015 11:28:51 +0200
X-Mailer: git-send-email 2.5.0.rc0.10.g7792c2a
In-Reply-To: <1435655961-31263-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 30 Jun 2015 11:28:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5U9SoXU031034
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1436261331.56948@FAN67Nsh4M0lwVmAHsBz4g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273038>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 git-rebase--interactive.sh | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 9041d15..0117791 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -156,8 +156,17 @@ Commands:
 
 These lines can be re-ordered; they are executed from top to bottom.
 
+EOF
+	if test $(get_missing_commit_check_level) = error
+	then
+		git stripspace --comment-lines >>"$todo" <<\EOF
+Do not remove any line. Use 'drop' explicitly to remove a commit.
+EOF
+	else
+		git stripspace --comment-lines >>"$todo" <<\EOF
 If you remove a line here THAT COMMIT WILL BE LOST.
 EOF
+	fi
 }
 
 make_patch () {
@@ -931,6 +940,13 @@ checkout_onto () {
 	git update-ref ORIG_HEAD $orig_head
 }
 
+get_missing_commit_check_level () {
+	check_level=$(git config --get rebase.missingCommitsCheck)
+	check_level=${check_level:-ignore}
+	# Don't be case sensitive
+	printf '%s' "$check_level" | tr 'A-Z' 'a-z'
+}
+
 # Check if the user dropped some commits by mistake
 # Behaviour determined by rebase.missingCommitsCheck.
 # Check if there is an unrecognized command or a
@@ -938,10 +954,7 @@ checkout_onto () {
 check_todo_list () {
 	raise_error=f
 
-	check_level=$(git config --get rebase.missingCommitsCheck)
-	check_level=${check_level:-ignore}
-	# Don't be case sensitive
-	check_level=$(printf '%s' "$check_level" | tr 'A-Z' 'a-z')
+	check_level=$(get_missing_commit_check_level)
 
 	case "$check_level" in
 	warn|error)
-- 
2.5.0.rc0.10.g7792c2a
