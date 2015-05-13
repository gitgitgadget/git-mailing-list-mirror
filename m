From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 7/9] t5520: test --rebase failure on unborn branch with index
Date: Wed, 13 May 2015 17:08:54 +0800
Message-ID: <1431508136-15313-8-git-send-email-pyokagan@gmail.com>
References: <1431508136-15313-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 11:09:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsSfm-0003Ls-AH
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 11:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933130AbbEMJJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 05:09:47 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:34473 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932638AbbEMJJo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 05:09:44 -0400
Received: by pdbqa5 with SMTP id qa5so45430561pdb.1
        for <git@vger.kernel.org>; Wed, 13 May 2015 02:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oS0c0qbuPV6zILgn50Ud3Qo+Mon9zaC6c7hNcXaDVj0=;
        b=DkVujcu15vKZgiAUGeGKQ3eFySMHs+j0lDctGOw3IZeM1Yx3FCY3PMwM3pZhWEXWKM
         t2jaLX3r/kJXLGGTo/k4NxNbYAeu4Dvi5RDUfJx0q0eDc+WHW72rqXtk1cqz498cwduw
         D4YHp6A0iA7o/2egfDIBZDniWpMePOBGXNHYZqZ+kgqctm4lzYxI5A/ogFVNgtRFfkxE
         pK6t7SMKMGkoFjAdUwCvmMDaqFnSVnYajpAubZeZgUhQt9DSQXze7mkeMuKQQ9NEy8AN
         dg46M5NSUHdPPJPwcEKGi7aSpehbIBufoQ4MyU8M6e761Muu1p5WhG59ZOVJWAZa3+VB
         rX8A==
X-Received: by 10.68.131.196 with SMTP id oo4mr35235532pbb.119.1431508183668;
        Wed, 13 May 2015 02:09:43 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id df7sm18645685pdb.32.2015.05.13.02.09.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 May 2015 02:09:42 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431508136-15313-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268956>

Commit 19a7fcb (allow pull --rebase on branch yet to be born,
2009-08-11) special cases git-pull on an unborn branch in a different
code path such that git-pull --rebase is still valid even though there
is no HEAD yet.

This code path still ensures that there is no index in order not to lose
any staged changes. Implement a test to ensure that this check is
triggered.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

* Renamed "out" to "err"

* Quoted command substitution and file content comparisons.

 t/t5520-pull.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index e957368..96d2e7c 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -413,6 +413,21 @@ test_expect_success 'pull --rebase works on branch yet to be born' '
 	test_cmp expect actual
 '
 
+test_expect_success 'pull --rebase fails on unborn branch with staged changes' '
+	test_when_finished "rm -rf empty_repo2" &&
+	git init empty_repo2 &&
+	(
+		cd empty_repo2 &&
+		echo staged-file >staged-file &&
+		git add staged-file &&
+		verbose test "$(git ls-files)" = staged-file &&
+		test_must_fail git pull --rebase .. master 2>../err &&
+		verbose test "$(git ls-files)" = staged-file &&
+		verbose test "$(git show :staged-file)" = staged-file
+	) &&
+	test_i18ngrep "unborn branch with changes added to the index" err
+'
+
 test_expect_success 'setup for detecting upstreamed changes' '
 	mkdir src &&
 	(cd src &&
-- 
2.1.4
