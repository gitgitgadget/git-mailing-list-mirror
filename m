From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/2] rebase -i: demonstrate incorrect behavior of post-rewrite hook with exec
Date: Thu, 21 May 2015 20:13:01 +0200
Message-ID: <1432231982-31314-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1432231982-31314-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	remi.lespinet@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 21 20:13:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvUyK-0004SV-1X
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 20:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755883AbbEUSNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 14:13:24 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53043 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755652AbbEUSNX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 14:13:23 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t4LIDFBX013577
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 May 2015 20:13:15 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4LIDHU0011283;
	Thu, 21 May 2015 20:13:17 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1YvUy5-0008F8-Mj; Thu, 21 May 2015 20:13:17 +0200
X-Mailer: git-send-email 2.4.1.171.g060e6ae.dirty
In-Reply-To: <1432231982-31314-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 21 May 2015 20:13:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4LIDFBX013577
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1432836796.4857@PE60c3mpkhQHWuWP3OC0TA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269634>

The 'exec' command is sending the current commit to stopped-sha, which is
supposed to contain the original commit (before rebase). As a result, if
an 'exec' command fails, the next 'git rebase --continue' will send the
current commit as <old-sha1> to the post-rewrite hook.

The test currently fails with :

--- expected.data       2015-05-21 17:55:29.000000000 +0000
+++ [...]post-rewrite.data      2015-05-21 17:55:29.000000000 +0000
@@ -1,2 +1,3 @@
 2362ae8e1b1b865e6161e6f0e165ffb974abf018 488028e9fac0b598b70cbeb594258a917e3f6fab
+488028e9fac0b598b70cbeb594258a917e3f6fab 488028e9fac0b598b70cbeb594258a917e3f6fab
 babc8a4c7470895886fc129f1a015c486d05a351 8edffcc4e69a4e696a1d4bab047df450caf99507

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 t/t5407-post-rewrite-hook.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index ea2e0d4..ecef820 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -212,4 +212,21 @@ EOF
 	verify_hook_input
 '
 
+test_expect_failure 'git rebase -i (exec)' '
+	git reset --hard D &&
+	clear_hook_input &&
+	FAKE_LINES="edit 1 exec_false 2" git rebase -i B
+	echo something >bar &&
+	git add bar &&
+	# Fail because of exec false
+	test_must_fail git rebase --continue &&
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
2.4.1.171.g060e6ae.dirty
