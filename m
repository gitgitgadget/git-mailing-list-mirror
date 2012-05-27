From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v6 2/9] submodule: document failure to detect invalid submodule URLs
Date: Sun, 27 May 2012 23:43:23 +1000
Message-ID: <1338126210-11517-3-git-send-email-jon.seymour@gmail.com>
References: <1338126210-11517-1-git-send-email-jon.seymour@gmail.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com, phil.hord@gmail.com,
	ramsay@ramsay1.demon.co.uk, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 15:43:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYdlC-0005oe-26
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 15:43:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378Ab2E0Nnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 May 2012 09:43:50 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38301 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894Ab2E0Nnt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2012 09:43:49 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so3101250dad.19
        for <git@vger.kernel.org>; Sun, 27 May 2012 06:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=zer/C454xpsBLPQp/ING7WDzfsCI7l2BPiQtFmRjwKo=;
        b=xTFCkB8ShqRbFrjkjz21rlAgmD5bRdOHjPLAVWWbzCYoZYtyDKt9lh8mjpAPQie1Ll
         yQVBfhCu76Pd5G599iLMJKXk457QWDTJTnsZRXx0hKL9FvpxIL3lNAPp8cqMMfNyzbZ4
         R8QAFXa/KHAFe3kX9pNPt7WN2WRs7EQpvbBIVNbBV80lUQfsqCDSiHQE4I4G9aQ4qkHJ
         /zqPygkK6Pps6sggRjMgSg6NfbBjvt6/aB4KO5ADWCXBLnhn2klo8L66iM6EaTjyYabX
         XNlkhWcQJQPLq5vuX2DyIHEio6wEPgVQ2qGpl45wPn2d+4LfsejuRjqhNHdnYqWnHBtm
         J88Q==
Received: by 10.68.192.5 with SMTP id hc5mr5829251pbc.49.1338126228886;
        Sun, 27 May 2012 06:43:48 -0700 (PDT)
Received: from ubuntu.ubuntu-domain (124-170-214-58.dyn.iinet.net.au. [124.170.214.58])
        by mx.google.com with ESMTPS id ru4sm15870005pbc.66.2012.05.27.06.43.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 May 2012 06:43:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.656.gb5a46db
In-Reply-To: <1338126210-11517-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198592>

These tests document failures to detect submodule URLs that backtrack
past the 'invariant' part of a superproject's origin URL.

For example: if the origin URL is ssh://hostname/repo, then currently
if a submodule URL is specified as ../../subrepo, then git will
construct a submodule url of the form ssh://subrepo/ without complaint.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t7400-submodule-basic.sh | 70 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 9428c7a..a758c63 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -543,10 +543,80 @@ test_expect_success '../subrepo works with helper URL- helper:://hostname/repo'
 	)
 '
 
+test_expect_failure '../../subrepo fails with URL - ssh://hostname/repo' "
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
+		git config remote.origin.url ssh://hostname/repo &&
+		git config -f .gitmodules submodule.sub.url ../../subrepo &&
+		echo cannot strip one component off url \'ssh://hostname/\' > expected &&
+		test_must_fail git submodule init 2>actual &&
+		#actual no failure, url configured as ssh://subrepo
+		test_cmp expected actual
+	)
+"
+
+test_expect_failure '../../subrepo fails with absolute local path - /repo' "
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
+		git config remote.origin.url /repo &&
+		git config -f .gitmodules submodule.sub.url ../../subrepo &&
+		echo cannot strip one component off url \'/\' > expected &&
+		test_must_fail git submodule init 2>actual &&
+		test_cmp expected actual
+	)
+"
+
+test_expect_failure '../../../subrepo fails with URL - ssh://hostname/repo' "
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
+		git config remote.origin.url ssh://hostname/repo &&
+		git config -f .gitmodules submodule.sub.url ../../../subrepo &&
+		echo cannot strip one component off url \'ssh://hostname/\' > expected &&
+		test_must_fail git submodule init 2>actual &&
+		#actual no failure, url configured as ssh:/subrepo
+		test_cmp expected actual
+	)
+"
+
+test_expect_failure '../../../../subrepo fails with with URL - ssh://hostname/repo' "
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
+		git config remote.origin.url ssh://hostname/repo &&
+		git config -f .gitmodules submodule.sub.url ../../../../subrepo &&
+		echo cannot strip one component off url \'ssh://hostname/\' > expected &&
+		test_must_fail git submodule init 2>actual &&
+		#actual no failure, url configured as ssh:/subrepo
+		test_cmp expected actual
+	)
+"
+
+test_expect_failure '../../../../../subrepo fails with URL - ssh://hostname/repo' "
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
+		git config remote.origin.url ssh://hostname/repo &&
+		git config -f .gitmodules submodule.sub.url ../../../../../subrepo &&
+		echo cannot strip one component off url \'ssh://hostname/\' > expected &&
+		test_must_fail git submodule init 2>actual &&
+		#actual cannot strip one component off url 'ssh'
+		test_cmp expected actual
+	)
+"
+
 test_expect_success '../subrepo works with scp-style URL - user@host:repo' '
 	(
 		cd reltest &&
 		cp pristine-.git-config .git/config &&
+		cp pristine-.gitmodules .gitmodules &&
 		git config remote.origin.url user@host:repo &&
 		git submodule init &&
 		test "$(git config submodule.sub.url)" = user@host:subrepo
-- 
1.7.10.2.656.gb5a46db
