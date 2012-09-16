From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH v2 3/3] rebase -i: Add tests for "--edit-todo"
Date: Sun, 16 Sep 2012 11:17:03 -0400
Message-ID: <1347808623-1058-3-git-send-email-andrew.kw.w@gmail.com>
References: <7vwqzuxxmp.fsf@alter.siamese.dyndns.org>
 <1347808623-1058-1-git-send-email-andrew.kw.w@gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 16 18:19:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDHZ3-0005oH-Gg
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 18:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984Ab2IPQTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2012 12:19:15 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:32881 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675Ab2IPQTN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2012 12:19:13 -0400
Received: by mail-qc0-f174.google.com with SMTP id o28so3947818qcr.19
        for <git@vger.kernel.org>; Sun, 16 Sep 2012 09:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=6je5CREpRh3Jz6vNs6x7F4KvpAsHYoAVF/rqPAP0Jus=;
        b=aSDqoJdciBlsLs4X+eD6/9RTad+U731/hWpLomy2PYgQvW7hT0Xw1b+FdjkR2IrxMe
         WeHiKN9qIK5U0n/SvKCWI3/xGEyAJ+wGY70QjDGW45xlbGkehVY1eKdUrFYopYB94uAI
         GhOwxpHbAHiUMWFfDuRJ4+04pOMfd5mxwmIlMGzp9PnUjIngZAE7oHE4QNg7HqrIF+jg
         0nPVnjkjdHPhTAMcKZB/yZwEK7cw9N52Yahs0tDVZX4Tu5Q01eR57tfmunewyearpSSh
         9J05rU24CISedpCfoxPXGGlU8G9difMJd8llj5ArjgVoKOdUrC2bfErA8j0r4Tv1B2Pv
         WOgw==
Received: by 10.224.177.15 with SMTP id bg15mr21596772qab.85.1347812352825;
        Sun, 16 Sep 2012 09:19:12 -0700 (PDT)
Received: from localhost.localdomain ([69.165.255.59])
        by mx.google.com with ESMTPS id ha5sm11433393qab.1.2012.09.16.09.19.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 16 Sep 2012 09:19:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.318.g79683ba.dirty
In-Reply-To: <1347808623-1058-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205628>

Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
---
 t/t3404-rebase-interactive.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 7304b66..6eafb63 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -911,4 +911,22 @@ test_expect_success 'rebase -i --root fixup root commit' '
 	test 0 = $(git cat-file commit HEAD | grep -c ^parent\ )
 '
 
+test_expect_success 'rebase --edit-todo does not works on non-interactive rebase' '
+	git reset --hard &&
+	git checkout conflict-branch &&
+	test_must_fail git rebase --onto HEAD~2 HEAD~ &&
+	test_must_fail git rebase --edit-todo &&
+	git rebase --abort
+'
+
+test_expect_success 'rebase --edit-todo can be used to modify todo' '
+	git reset --hard &&
+	git checkout no-conflict-branch^0 &&
+	FAKE_LINES="edit 1 2 3" git rebase -i HEAD~3 &&
+	FAKE_LINES="2 1" git rebase --edit-todo &&
+	git rebase --continue
+	test M = $(git cat-file commit HEAD^ | sed -ne \$p) &&
+	test L = $(git cat-file commit HEAD | sed -ne \$p)
+'
+
 test_done
-- 
1.7.12.318.g79683ba.dirty
