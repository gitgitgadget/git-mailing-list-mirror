From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 5/8] t5520: test --rebase with multiple branches
Date: Fri, 29 May 2015 19:44:42 +0800
Message-ID: <1432899885-25143-6-git-send-email-pyokagan@gmail.com>
References: <1432899885-25143-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 29 13:45:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyIj2-0003w7-RE
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 13:45:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755436AbbE2LpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 07:45:14 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35039 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755350AbbE2LpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 07:45:09 -0400
Received: by pacrp13 with SMTP id rp13so9526434pac.2
        for <git@vger.kernel.org>; Fri, 29 May 2015 04:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=govES8XhwrMSCQIk6tTHXATiR4f+5385PLo7NyxOUU0=;
        b=yLUuSzymCXrS4tYeodArtMeRsg0nd59uAzknnPa79nMUO7pkFdW60XgR6PY6FAYRA+
         OiMgoTKH0jmgycy1OrmcMsLRBEz0AhG4tCGlyX83vRoiKq713767VfaLewy4VX/ohAVV
         lb0wYMeofRW21qpeWSQl43vcFCeWlFVfQXIyeMrjtqwQdJUpbgIlgTww5gnYwy0OEuH5
         Vl2FkgV+bcjdwxKadQkYAhuiowsyJRJ2ZVAQlYyP+hhrwN1ln5W0gLuARPoQkZixYFL4
         csGMaBuGdavsdSezcxfyQTATdC9MwdzoD4x9xuqYsXjqLKaYhfO2Ubd6ojuGZ7hsfQIM
         PhCw==
X-Received: by 10.66.102.103 with SMTP id fn7mr14323089pab.85.1432899908774;
        Fri, 29 May 2015 04:45:08 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qg5sm5392460pdb.13.2015.05.29.04.45.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 May 2015 04:45:07 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1432899885-25143-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270234>

Since rebasing on top of multiple upstream branches does not make sense,
since 51b2ead (disallow providing multiple upstream branches to rebase,
pull --rebase, 2009-02-18), git-pull explicitly disallowed specifying
multiple branches in the rebase case.

Implement tests to ensure that git-pull fails and prints out the
user-friendly error message in such a case.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

 t/t5520-pull.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 872d765..90728e0 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -217,6 +217,15 @@ test_expect_success '--rebase' '
 	test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)" &&
 	test new = "$(git show HEAD:file2)"
 '
+
+test_expect_success '--rebase fails with multiple branches' '
+	git reset --hard before-rebase &&
+	test_must_fail git pull --rebase . copy master 2>err &&
+	test "$(git rev-parse HEAD)" = "$(git rev-parse before-rebase)" &&
+	test_i18ngrep "Cannot rebase onto multiple branches" err &&
+	test modified = "$(git show HEAD:file)"
+'
+
 test_expect_success 'pull.rebase' '
 	git reset --hard before-rebase &&
 	test_config pull.rebase true &&
-- 
2.1.4
