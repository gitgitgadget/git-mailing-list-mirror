From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: [PATCH v6 5/7] p7300: add performance tests for clean
Date: Sun, 10 May 2015 22:00:39 +0200
Message-ID: <1431288041-21077-6-git-send-email-erik.elfstrom@gmail.com>
References: <1431288041-21077-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 10 22:03:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrXRg-0005By-3Z
	for gcvg-git-2@plane.gmane.org; Sun, 10 May 2015 22:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbbEJUDY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 May 2015 16:03:24 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:35411 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbbEJUDX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2015 16:03:23 -0400
Received: by lbbuc2 with SMTP id uc2so81518708lbb.2
        for <git@vger.kernel.org>; Sun, 10 May 2015 13:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=rqclsFdGoOHqSL4pcApD/wWSuIops+L4I6mQmxMzxBM=;
        b=kQK9X6jKeRpQ8anqJIfvOZYpQuuqdZXYmTshp1rfY0WvalOsXi6EgRphVkRoNaAsCk
         cxYm79BrHlEd/2M9PQdL8bgx4yXynj1EJezQusw5+wygvseqSlhF4Sz1aeoBU7XESvpX
         fEEmZFLogDOXllpdp6CqRzav1RGbjwXcDU12+8IVgR01IYQxR3vxsDUYC9JGybAZyuFJ
         TB5CAB8NE/bFl5Ca8uCctfXhePE4aDDRgIsKYwcBld2axEqDEEkGKY8kbPWgjqMA8VtG
         T5dD08wuHwACFvJWTa/bbl/9yxZQHfE1AApXJ9Q8Ymy6GLBGdQGJ8XI9Iwzh6OK691uJ
         TOJw==
X-Received: by 10.152.28.73 with SMTP id z9mr5530947lag.93.1431288202203;
        Sun, 10 May 2015 13:03:22 -0700 (PDT)
Received: from localhost.localdomain (h38n2-lk-d2.ias.bredband.telia.com. [78.72.191.38])
        by mx.google.com with ESMTPSA id k15sm2586218laa.28.2015.05.10.13.03.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 10 May 2015 13:03:21 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.60.gf7143f7
In-Reply-To: <1431288041-21077-1-git-send-email-erik.elfstrom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268745>

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
2.4.0.60.gf7143f7
