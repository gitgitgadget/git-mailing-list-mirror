From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: [PATCH v7 4/5] p7300: add performance tests for clean
Date: Tue,  9 Jun 2015 20:24:38 +0200
Message-ID: <1433874279-30720-5-git-send-email-erik.elfstrom@gmail.com>
References: <1433874279-30720-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 20:25:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2ODa-0005AN-7I
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 20:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbbFISZl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2015 14:25:41 -0400
Received: from mail-la0-f67.google.com ([209.85.215.67]:34994 "EHLO
	mail-la0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932507AbbFISZk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 14:25:40 -0400
Received: by lams18 with SMTP id s18so2683890lam.2
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 11:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=7ZIARyPQeN0cMW6AJe82dR2+mfJSwokr+fMDd8Qso1E=;
        b=dk4xfDFbzOZjqNsN64mbhLngwjp2DMyg9P8x1zBHX1+reE5/GgmZlERFnWJZJ+DZCA
         MzNSFZZmwOsyoHxMmtkQwpuK4Isjy3eIRXR4Vaav8QWZ/6wHZttM3+uY0JuJt3PKmwUU
         hq47ACiF2y/hDiy9vBDvSFHW1cKsQN0eiH+jVb6oGhgqRwZ9szoC2gY15Jzp6L4d60mA
         sfbEaOfOnmAhdXJRKZ2HhvaLjY8BcApb0qIdLDQDIWxKBbboQ9i7YEpND8p6zh3AJp+A
         hnHoaPaSgH/QuouGe3CHM+q/5oW4sseLgj6IiZCAJi5OyvkFaIkPO8cZvyMZfqBgOYCO
         MfjQ==
X-Received: by 10.152.6.105 with SMTP id z9mr23338492laz.98.1433874336380;
        Tue, 09 Jun 2015 11:25:36 -0700 (PDT)
Received: from localhost.localdomain (h38n2-lk-d2.ias.bredband.telia.com. [78.72.191.38])
        by mx.google.com with ESMTPSA id bm5sm285250lbc.45.2015.06.09.11.25.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Jun 2015 11:25:35 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.373.gc496bfb
In-Reply-To: <1433874279-30720-1-git-send-email-erik.elfstrom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271219>

The tests are run in dry-run mode to avoid having to restore the test
directories for each timed iteration. Using dry-run is an acceptable
compromise since we are mostly interested in the initial computation
of what to clean and not so much in the cleaning it self.

Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
---
 t/perf/p7300-clean.sh | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100755 t/perf/p7300-clean.sh

diff --git a/t/perf/p7300-clean.sh b/t/perf/p7300-clean.sh
new file mode 100755
index 0000000..ec94cdd
--- /dev/null
+++ b/t/perf/p7300-clean.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+
+test_description=3D"Test git-clean performance"
+
+. ./perf-lib.sh
+
+test_perf_default_repo
+test_checkout_worktree
+
+test_expect_success 'setup untracked directory with many sub dirs' '
+	rm -rf 500_sub_dirs 100000_sub_dirs clean_test_dir &&
+	mkdir 500_sub_dirs 100000_sub_dirs clean_test_dir &&
+	for i in $(test_seq 1 500)
+	do
+		mkdir 500_sub_dirs/dir$i || return $?
+	done &&
+	for i in $(test_seq 1 200)
+	do
+		cp -r 500_sub_dirs 100000_sub_dirs/dir$i || return $?
+	done
+'
+
+test_perf 'clean many untracked sub dirs, check for nested git' '
+	git clean -n -q -f -d 100000_sub_dirs/
+'
+
+test_perf 'clean many untracked sub dirs, ignore nested git' '
+	git clean -n -q -f -f -d 100000_sub_dirs/
+'
+
+test_done
--=20
2.4.3.373.gc496bfb
