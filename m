From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] t5543, atomic pushes: test deleting and renaming branches
Date: Thu, 15 Jan 2015 12:45:20 -0800
Message-ID: <1421354720-13312-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alumn.mit.edu
X-From: git-owner@vger.kernel.org Thu Jan 15 21:45:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBrIL-0005tJ-2m
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 21:45:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752941AbbAOUp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 15:45:28 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:58154 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164AbbAOUp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 15:45:27 -0500
Received: by mail-ie0-f181.google.com with SMTP id rl12so17165331iec.12
        for <git@vger.kernel.org>; Thu, 15 Jan 2015 12:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=XmeDPVI0QV0DkUKQrtEB/7UX2otE3vDZS9IJWK4Cm8Q=;
        b=HQHGvgtgBo3lalRfzFelnOZsZ1NhOo39Ap2cJ2V8m73O6LtFJosPKG8Tg9veLJyDDX
         ZPdhNTCV4BsjCw36BV69YbZ4/iIPFZ9EelaZN8JN/9QpQ9h1mjD7ksfZP5xzVpwPEfua
         nv8oF77ci9VidOcPydv5Zd6xzGvb4zPH2XYvqtN1MOLtNL+Pd7t+zQzSaKFy/5k/VIkM
         NvI5tHybGx6+UblUeKLzZdgfjtF0si0PYDlTinZzdjT0XT/274fOZUJymzoks76kHAbb
         AAdvk6z3e926J2JJ4MLQo1VHyod4svfkkDXZIN63yZ21VuIUfp84j93361IR6KM84R34
         IV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XmeDPVI0QV0DkUKQrtEB/7UX2otE3vDZS9IJWK4Cm8Q=;
        b=NXug5KJbYSECxCbl6LYroRFrlvxu2KMXPcQGRgQPdUklKkRpS8c5gLjB8T1AZnPetO
         ya1MPAGK3P6W7zpxez8AZwdB5tPGY3ZWZwweDmXTYq0XmJO672cn20QcqD58eKUhjEX9
         zrHtvjndg9nM0I6+Z9nCuuD6F4wcHPMFi7V9b+1SKJKrth0CIYmm3wSWJPtLZrMBnrBE
         9ijEtWorHz2q0BprDCgzvogrRyNqt/sfQjhPAUtoAEK2az5K7dhCTkcHtAW+KwMrDKhx
         vgnh+q984yUFBadV/Guq2MclkWr/X9y67EsONmzBxbhJvNG4hTFS0ODiwHkBbR0t0AVb
         Resg==
X-Gm-Message-State: ALoCoQl62l62agNgTEhJZe8LKSbosW9GKgjqT0siBg0lvGvATC9i6ctkgpgjZVhfqvwVKDY3/In5
X-Received: by 10.107.169.34 with SMTP id s34mr4212905ioe.34.1421354726810;
        Thu, 15 Jan 2015 12:45:26 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:159a:d413:24c9:471f])
        by mx.google.com with ESMTPSA id qj6sm198438igc.1.2015.01.15.12.45.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 Jan 2015 12:45:26 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262510>

Add more test coverage to the atomic push option. It turns out there is a
breakage when renaming branches within an atomic push. The breakage occurs
because it cannot lock the refs v/v as well as x.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t5543-atomic-push.sh | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/t/t5543-atomic-push.sh b/t/t5543-atomic-push.sh
index 3480b33..96a106b 100755
--- a/t/t5543-atomic-push.sh
+++ b/t/t5543-atomic-push.sh
@@ -191,4 +191,53 @@ test_expect_success 'atomic push is not advertised if configured' '
 	test_refs master HEAD@{1}
 '
 
+test_expect_success 'atomic push handles deletes gracefully' '
+	mk_repo_pair &&
+	(
+		cd workbench &&
+		git checkout -b todelete &&
+		test_commit one &&
+		git push --mirror up
+	) &&
+	(
+		cd workbench &&
+		git checkout -b anotherbranch &&
+		git branch -D todelete &&
+		git push --mirror --atomic up
+	)
+'
+
+test_expect_failure 'atomic push handles renames gracefully' '
+	# First push to upstream having the following branches:
+	# v, x/x, x/y and y/z. Now rename them and push atomically:
+	# v   -> v/v (1)
+	# x/x -> x   (2)
+	# x/y -> y   (3)
+	# y/z -> z   (4)
+	# (1) and (2) test (directory/file) conflicts on the branch itself. (3)
+	# is testing the (D/F) conflict with another branch involved which is
+	# freed in (4)
+	mk_repo_pair &&
+	(
+		cd workbench &&
+		git checkout -b v &&
+		test_commit one &&
+		git checkout -b x/x &&
+		test_commit two &&
+		git checkout -b x/y &&
+		test_commit three &&
+		git checkout -b y/z &&
+		test_commit four &&
+		git push --mirror up
+	) &&
+	(
+		cd workbench &&
+		git branch -m y/z z &&
+		git branch -m x/y y &&
+		git branch -m x/x x &&
+		git branch -m v v/v &&
+		git push --atomic up :v :x/x :x/y :y/z v/v x y z
+	)
+'
+
 test_done
-- 
2.2.1.62.g3f15098
