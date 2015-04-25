From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: [PATCH v4 4/5] p7300: add performance tests for clean
Date: Sat, 25 Apr 2015 11:06:40 +0200
Message-ID: <1429952801-2646-5-git-send-email-erik.elfstrom@gmail.com>
References: <1429952801-2646-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 25 11:07:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ylw3i-0005NE-Ap
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 11:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758757AbbDYJHa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Apr 2015 05:07:30 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:32871 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757787AbbDYJH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2015 05:07:28 -0400
Received: by lbbzk7 with SMTP id zk7so52060669lbb.0
        for <git@vger.kernel.org>; Sat, 25 Apr 2015 02:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=WgnFYVMfAI3DxxLzIXHddcBO3mvZGCwANg0NasRKkf4=;
        b=hVJyvywShqyGrZuerHf7NW5ae4qcrbA9fvyWk74M5alPbHAEtJYt9Om/IPCTA391Nt
         Zzj7/WkTbOAPo2WuiII97bHpswnDeOW/Jg7iH03Y3S5bmX1AB0EkHa8892VsgqI+gbko
         6TVUPRf1myD+ZCpKUOQR63GJC0hkUB3l8Bs/u5mcgNAocMr7xaihm41wPhtIHxY9iOm+
         +jnYw8c8Xwrz4AsWxP28gFxVkPtKkQ1Tr+5pPZ50eD6w+K/Cbhq8X610GN7sh+M4fX/H
         n/rLoJ4oEd8LlVH1yOS42BFO/XnYhpJwc69esWlf9trLf7q7sTaWzDyq5Mp10UuAlzCV
         Zsyw==
X-Received: by 10.152.29.6 with SMTP id f6mr2046058lah.85.1429952846691;
        Sat, 25 Apr 2015 02:07:26 -0700 (PDT)
Received: from localhost.localdomain (h38n2-lk-d2.ias.bredband.telia.com. [78.72.191.38])
        by mx.google.com with ESMTPSA id r6sm3249243lbw.10.2015.04.25.02.07.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Apr 2015 02:07:25 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc3.8.g86acfbd
In-Reply-To: <1429952801-2646-1-git-send-email-erik.elfstrom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267786>

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
index 0000000..6ae55ec
--- /dev/null
+++ b/t/perf/p7300-clean.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+
+test_description=3D"Test git-clean performance"
+
+. ./perf-lib.sh
+
+test_perf_large_repo
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
2.4.0.rc3.8.g4ebd28d
