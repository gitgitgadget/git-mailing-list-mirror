From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: [PATCH v5 4/5] p7300: add performance tests for clean
Date: Sun, 26 Apr 2015 08:49:44 +0200
Message-ID: <1430030985-14499-5-git-send-email-erik.elfstrom@gmail.com>
References: <xmqqfv7nzf56.fsf@gitster.dls.corp.google.com>
 <1430030985-14499-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Apr 26 08:50:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmGOw-0007XS-HD
	for gcvg-git-2@plane.gmane.org; Sun, 26 Apr 2015 08:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbbDZGup convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Apr 2015 02:50:45 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:32832 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbbDZGup (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2015 02:50:45 -0400
Received: by layy10 with SMTP id y10so60225238lay.0
        for <git@vger.kernel.org>; Sat, 25 Apr 2015 23:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=PYOaHuLEBA/EYk6gqINtlVOANp2iwpgYNimYXdrPdl4=;
        b=ou234hdjAzBXvoZ4HtPMZ0WkYoOgHsjEqR1wt1DKHcSlfpXm9YfniSklz71X2+l3N1
         9AWEy+k3c1VNzGUklRVM/zlAAdl+OA/LcM9N/bJj20zX1vWQyV4dDcg1kK5VbqBEmS8k
         WVHQcGleINrPragXnqdFtnPzOs3NMSQ3x3A7Fw8v0hSMCYV3Wsocx6lZutURsJBor35C
         sTPfgh13gtFm8arpPfkuIqw2sR+H220PRF/hW+Lm6nynJ06aPaPMD3xF4jIxr9GXAInR
         FYjG1HqHmeAitUknbVH4B6yaneTTU/lAkL1rLoXlYu1aOtwiXkJ4BWdyBViEG+0PONdd
         wHOg==
X-Received: by 10.152.7.97 with SMTP id i1mr5113212laa.49.1430031043725;
        Sat, 25 Apr 2015 23:50:43 -0700 (PDT)
Received: from localhost.localdomain (h38n2-lk-d2.ias.bredband.telia.com. [78.72.191.38])
        by mx.google.com with ESMTPSA id x2sm3884938laj.8.2015.04.25.23.50.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Apr 2015 23:50:42 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc3.8.gbb31afb
In-Reply-To: <1430030985-14499-1-git-send-email-erik.elfstrom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267826>

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
2.4.0.rc3.8.gbb31afb
