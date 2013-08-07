From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2] die_with_status: use "printf '%s\n'", not "echo"
Date: Wed,  7 Aug 2013 11:26:05 +0200
Message-ID: <1375867565-21127-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqy58dj1ly.fsf@anie.imag.fr>
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 07 11:26:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V700e-0003Oe-EH
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 11:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757377Ab3HGJ0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 05:26:20 -0400
Received: from mx1.imag.fr ([129.88.30.5]:42685 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757362Ab3HGJ0T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 05:26:19 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r779Q6sD009239
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 7 Aug 2013 11:26:06 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1V700N-00054c-4I; Wed, 07 Aug 2013 11:26:07 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1V700M-0005Vf-PU; Wed, 07 Aug 2013 11:26:06 +0200
X-Mailer: git-send-email 1.8.3.3.797.gb72c616
In-Reply-To: <vpqy58dj1ly.fsf@anie.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 07 Aug 2013 11:26:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r779Q6sD009239
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1376472367.34369@KH4nZe9lxZYFQH4R2CS4hg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231816>

Some implementations of 'echo' (e.g. dash's built-in) interpret
backslash sequences in their arguments.

This triggered at least one bug: the error message of "rebase -i" was
turning \t in commit messages into actual tabulations. There may be
others.

Using "printf '%s\n'" instead avoids this bad behavior, and is the form
used by the "say" function.

Noticed-by: David Kastrup <dak@gnu.org>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Changed the "grep" function to be more accurate. The test still
catches the old failure and pass after the fix.

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
index 49ccb38..4dbeddb 100755
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
+	test_expect_code 1 grep  "	emp" error
+'
+
 test_done
-- 
1.8.3.3.797.gb72c616
