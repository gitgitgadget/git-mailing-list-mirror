From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: [PATCH/RFC v3 3/4] p7300: add performance tests for clean
Date: Sat, 18 Apr 2015 22:41:11 +0200
Message-ID: <1429389672-30209-4-git-send-email-erik.elfstrom@gmail.com>
References: <1429389672-30209-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 18 22:41:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjZYs-0005nC-VZ
	for gcvg-git-2@plane.gmane.org; Sat, 18 Apr 2015 22:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754280AbbDRUlw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Apr 2015 16:41:52 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:34133 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754159AbbDRUlt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2015 16:41:49 -0400
Received: by lbcga7 with SMTP id ga7so105597935lbc.1
        for <git@vger.kernel.org>; Sat, 18 Apr 2015 13:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=kaqWz0FUqpWhsqbzDQ6vpjhpX5dXtHPH2oFdF5faqnw=;
        b=gQRD1n5NufIA4YjpYYvZ40oFraBqT0BRvv4tHRfj8aREoZAvmJl8i6F2W9KMitnJjE
         SbfuKkK+ruvWeAIudQTNjANpi2jXfsvaZLrG4o77xlIgNP0aIdZwqxj/IUSljQ4pa3vr
         S+fEhdup7Du07ulmIUknoOh85AlA7hAITG8Bjybzy7mJpL4r2p5XX5QobEXkNuNEflj8
         +kMvC5lEIdnHxhq+s6eyhUQU/50rJJZ1PsGkRSynRzV5qRX5HyvhWMFjMSdbeT+qH+6B
         BLTfWGORt1BmJYeoNUoEA5wjBhtuWUbOIxhN3kDLmoAjDVtWMrbCMsGdH3pWlz3CRlk4
         JHxg==
X-Received: by 10.152.6.197 with SMTP id d5mr9643693laa.121.1429389708226;
        Sat, 18 Apr 2015 13:41:48 -0700 (PDT)
Received: from localhost.localdomain (h38n2-lk-d2.ias.bredband.telia.com. [78.72.191.38])
        by mx.google.com with ESMTPSA id sh6sm3249256lbb.31.2015.04.18.13.41.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Apr 2015 13:41:47 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc2.5.g2871d5e
In-Reply-To: <1429389672-30209-1-git-send-email-erik.elfstrom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267426>

Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
---
 t/perf/p7300-clean.sh | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100755 t/perf/p7300-clean.sh

diff --git a/t/perf/p7300-clean.sh b/t/perf/p7300-clean.sh
new file mode 100755
index 0000000..af50d5d
--- /dev/null
+++ b/t/perf/p7300-clean.sh
@@ -0,0 +1,37 @@
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
+	rm -rf 500_sub_dirs 50000_sub_dirs clean_test_dir &&
+	mkdir 500_sub_dirs 50000_sub_dirs clean_test_dir &&
+	for i in $(test_seq 1 500)
+	do
+		mkdir 500_sub_dirs/dir$i || return $?
+	done &&
+	for i in $(test_seq 1 100)
+	do
+		cp -r 500_sub_dirs 50000_sub_dirs/dir$i || return $?
+	done
+'
+
+test_perf 'clean many untracked sub dirs, check for nested git' '
+	rm -rf clean_test_dir/50000_sub_dirs_cpy &&
+	cp -r 50000_sub_dirs clean_test_dir/50000_sub_dirs_cpy &&
+	git clean -q -f -d  clean_test_dir/ &&
+	test_dir_is_empty clean_test_dir
+'
+
+test_perf 'clean many untracked sub dirs, ignore nested git' '
+	rm -rf clean_test_dir/50000_sub_dirs_cpy &&
+	cp -r 50000_sub_dirs clean_test_dir/50000_sub_dirs_cpy &&
+	git clean -q -f -f -d  clean_test_dir/ &&
+	test_dir_is_empty clean_test_dir
+'
+
+test_done
--=20
2.4.0.rc2.5.g2871d5e
