From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: [PATCH v8 4/5] p7300: add performance tests for clean
Date: Mon, 15 Jun 2015 21:39:54 +0200
Message-ID: <1434397195-1823-5-git-send-email-erik.elfstrom@gmail.com>
References: <1434397195-1823-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 15 21:40:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4aFU-0004EQ-DU
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 21:40:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756022AbbFOTkp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Jun 2015 15:40:45 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:34413 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756019AbbFOTkn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 15:40:43 -0400
Received: by labbc20 with SMTP id bc20so28558148lab.1
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 12:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/PaSv1qKuOMMMhoPbc3hh+F94dzmnMDH4g7CdL11a+A=;
        b=hKasHr8xSgCgWmb4sobOsBJXe61tTGDmdaB7IZVcLpZMg4MgrSp1WsnOgYPfoLUoc3
         JHm1cNZ+GvxN9UvjePMYNZf2bk9bw2SdSIzxWeVNWnjIuT/6DWMkg6iCK9+hnaC30LLq
         uXq+flWpmAQ/gSr3uRRrfT483EDx9JNvJ27Y0sybewtJ/q2JQhhKdRFQSlHqyu7xSU3T
         YHTwxGcrFsdq8OqrVWXsM76mWwMQ1e3eFrv4zIDtNPx+SvadQZEXl4b0IjLNN8llsPkK
         qyzQmoqcR/7kEiuBZc5BMFgxLmOAjsm/f1hJiPEAWdm6Ayl90Nd2OKwk8oPh+80oPboU
         kIAA==
X-Received: by 10.152.45.98 with SMTP id l2mr29222338lam.77.1434397242093;
        Mon, 15 Jun 2015 12:40:42 -0700 (PDT)
Received: from localhost.localdomain (h38n2-lk-d2.ias.bredband.telia.com. [78.72.191.38])
        by mx.google.com with ESMTPSA id a7sm2923526lbc.36.2015.06.15.12.40.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Jun 2015 12:40:40 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.373.gc496bfb.dirty
In-Reply-To: <1434397195-1823-1-git-send-email-erik.elfstrom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271715>

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
2.4.3.373.gc496bfb.dirty
