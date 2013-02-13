From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: [PATCH v2 3/3] t9903: add extra tests for bash.showDirtyState
Date: Wed, 13 Feb 2013 12:02:00 +0100
Message-ID: <1360753321-5002-3-git-send-email-martinerikwerner@gmail.com>
References: <1360753138.25490.10.camel@mas>
 <1360753321-5002-1-git-send-email-martinerikwerner@gmail.com>
Cc: git@vger.kernel.org, trsten@science-computing.de,
	Martin Erik Werner <martinerikwerner@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 13 12:03:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5a7D-0000wZ-Qg
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 12:03:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933795Ab3BMLCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 06:02:38 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:47456 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932451Ab3BMLCg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 06:02:36 -0500
Received: by mail-lb0-f177.google.com with SMTP id go11so849311lbb.36
        for <git@vger.kernel.org>; Wed, 13 Feb 2013 03:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=XA+JsPxNW5IBeEcxM+eydYZSQVEM2QdfIcT/7/yNsMw=;
        b=0vGVAhr3T5Hrc4D+qXYhQk1OHbgHhCkBjDBgw2iVEKFiV0vUo04dqH3i3iEPkKD5y5
         36Ksr+GaaFGKt/4C1XcA0sSbOybwY/cLJ954DuHpJdHRGeKZfJy2Jt725i+7O2Izh23I
         KjNc0VLWSWuQb7UZGoESAzwCUfWpWYHqfbkgFGu4TXa+6cidsJ8emsq8/7x/k5YoJKUz
         9hDDfpjdLgki2gLHrAvxaHqIb6FCTA7b/c7ggzf3fa8xyw94IsgF25MLTvEZ0borrCrP
         TK89o1NITQNCDEWUygz2F5ls1OD3AtGEVJJvATCMs+gtFpHIcUtZLj+qzZlkuDredivJ
         qwkA==
X-Received: by 10.152.47.97 with SMTP id c1mr842398lan.6.1360753354646;
        Wed, 13 Feb 2013 03:02:34 -0800 (PST)
Received: from mas (nl107-187-0.student.uu.se. [130.243.187.0])
        by mx.google.com with ESMTPS id xw14sm10005309lab.6.2013.02.13.03.02.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 13 Feb 2013 03:02:33 -0800 (PST)
Received: from arand by mas with local (Exim 4.80)
	(envelope-from <arand@mas>)
	id 1U5a6c-0001KD-N4; Wed, 13 Feb 2013 12:02:26 +0100
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1360753321-5002-1-git-send-email-martinerikwerner@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216248>

Added 3 extra tests for the bash.showDirtyState config option, tests
should now cover all combinations of the shell var being set/unset and
the config option being enabled/disabled, given a dirty file.

* Renamed test 'disabled by config' to 'shell variable set with config
  disabled' for consistency
---
 t/t9903-bash-prompt.sh |   38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index cb008e2..fa81b09 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -360,12 +360,48 @@ test_expect_success 'prompt - dirty status indicator - before root commit' '
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - dirty status indicator - disabled by config' '
+test_expect_success 'prompt - dirty status indicator - shell variable unset with config disabled' '
 	printf " (master)" > expected &&
 	echo "dirty" > file &&
 	test_when_finished "git reset --hard" &&
 	test_config bash.showDirtyState false &&
 	(
+		unset -v GIT_PS1_SHOWDIRTYSTATE &&
+		__git_ps1 > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - dirty status indicator - shell variable unset with config enabled' '
+	printf " (master)" > expected &&
+	echo "dirty" > file &&
+	test_when_finished "git reset --hard" &&
+	test_config bash.showDirtyState true &&
+	(
+		unset -v GIT_PS1_SHOWDIRTYSTATE &&
+		__git_ps1 > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - dirty status indicator - shell variable set with config disabled' '
+	printf " (master)" > expected &&
+	echo "dirty" > file &&
+	test_when_finished "git reset --hard" &&
+	test_config bash.showDirtyState false &&
+	(
+		GIT_PS1_SHOWDIRTYSTATE=y &&
+		__git_ps1 > "$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - dirty status indicator - shell variable set with config enabled' '
+	printf " (master *)" > expected &&
+	echo "dirty" > file &&
+	test_when_finished "git reset --hard" &&
+	test_config bash.showDirtyState true &&
+	(
 		GIT_PS1_SHOWDIRTYSTATE=y &&
 		__git_ps1 > "$actual"
 	) &&
-- 
1.7.10.4
