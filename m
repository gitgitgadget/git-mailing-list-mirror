From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] die_with_status: use "printf '%s\n'", not "echo"
Date: Tue,  6 Aug 2013 20:26:44 +0200
Message-ID: <1375813604-10565-1-git-send-email-Matthieu.Moy@imag.fr>
References: <7vwqnyg10v.fsf@alter.siamese.dyndns.org>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Aug 06 20:28:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6lzd-0002L1-3t
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 20:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756677Ab3HFS2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 14:28:06 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51384 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756339Ab3HFS2E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 14:28:04 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r76IQiJ0021343
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 6 Aug 2013 20:26:44 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1V6ly2-0000YW-Q3; Tue, 06 Aug 2013 20:26:46 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1V6ly2-0002l4-EF; Tue, 06 Aug 2013 20:26:46 +0200
X-Mailer: git-send-email 1.8.3.3.797.gb72c616
In-Reply-To: <7vwqnyg10v.fsf@alter.siamese.dyndns.org>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 06 Aug 2013 20:26:44 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r76IQiJ0021343
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1376418404.9873@kKxVLYi6WVuWX49V/Fixuw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231772>

At least GNU echo interprets backslashes in its arguments.

This triggered at least one bug: the error message of "rebase -i" was
turning \t in commit messages into actual tabulations. There may be
others.

Using "printf '%s\n'" instead avoids this bad behavior, and is the form
used by the "say" function.

Noticed-by: David Kastrup <dak@gnu.org>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 git-sh-setup.sh               |  2 +-
 t/t3404-rebase-interactive.sh | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 7a964ad..e15be51 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -53,7 +53,7 @@ die () {
 die_with_status () {
 	status=$1
 	shift
-	echo >&2 "$*"
+	printf >&2 '%s\n' "$*"
 	exit "$status"
 }
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 49ccb38..074deb1 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -976,4 +976,17 @@ test_expect_success 'rebase -i with --strategy and -X' '
 	test $(cat file1) = Z
 '
 
+test_expect_success 'rebase -i error on commits with \ in message' '
+	current_head=$(git rev-parse HEAD)
+	test_when_finished "git rebase --abort; git reset --hard $current_head; rm -f error" &&
+	test_commit TO-REMOVE will-conflict old-content &&
+	test_commit "\temp" will-conflict new-content dummy &&
+	(
+	EDITOR=true &&
+	export EDITOR &&
+	test_must_fail git rebase -i HEAD^ --onto HEAD^^ 2>error
+	) &&
+	grep -v "	" error
+'
+
 test_done
-- 
1.8.3.3.797.gb72c616
