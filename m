From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: [PATCH 2/3] p7300: added performance tests for clean
Date: Mon,  6 Apr 2015 13:48:23 +0200
Message-ID: <1428320904-12366-3-git-send-email-erik.elfstrom@gmail.com>
References: <1428320904-12366-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 13:58:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yf5WM-0003QB-QB
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 13:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889AbbDFLsq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 07:48:46 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:36210 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752852AbbDFLsn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 07:48:43 -0400
Received: by lbbqq2 with SMTP id qq2so9438688lbb.3
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 04:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=cd0Ic7budwrKdNQLHS8hhnEs2EOEHoYgArpv8hqiKOg=;
        b=R5V6J2MlNmFH3oKaDihAafWJMv/gigeTi7RwvePNjy4vCNd8IXguOHbs4Gh82sZnDJ
         DdEAPqS+w7F4Jyda1UjE24L5rdQhntazIpAAvBEYIBr4mVPnGXAzerF3Ki/R+DK9UT3v
         LZhCqbh1HEfU0p+rm0VGlY2Gfq6w2wZseZ+JK2i4yZFenvo0Q4zw6/BlEhzkgvE9SgjK
         S/T1YWnBtB8yUd0GLhECc2kXfKIT6T5rmqYYYrwyDlQSXug2nOyVDdqkT0/sss1ymM4m
         KCtJw7Z6rkbpDoj6bhZx4bsVVXpJmJUcD/VVsE9fRvoQRN6A3iffOPOG5yyjnVmk3XaZ
         HkSw==
X-Received: by 10.112.26.106 with SMTP id k10mr13188511lbg.23.1428320921633;
        Mon, 06 Apr 2015 04:48:41 -0700 (PDT)
Received: from localhost.localdomain (h38n2-lk-d2.ias.bredband.telia.com. [78.72.191.38])
        by mx.google.com with ESMTPSA id pd1sm933083lbc.9.2015.04.06.04.48.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Apr 2015 04:48:40 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc0.37.ga3b75b3
In-Reply-To: <1428320904-12366-1-git-send-email-erik.elfstrom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266840>

Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
---
 t/perf/p7300-clean.sh | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100755 t/perf/p7300-clean.sh

diff --git a/t/perf/p7300-clean.sh b/t/perf/p7300-clean.sh
new file mode 100755
index 0000000..3f56fb2
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
+	for i in $(seq 1 500)
+	do
+		mkdir 500_sub_dirs/dir$i
+	done &&
+	for i in $(seq 1 100)
+	do
+		cp -r 500_sub_dirs 50000_sub_dirs/dir$i
+	done
+'
+
+test_perf 'clean many untracked sub dirs, check for nested git' '
+	rm -rf clean_test_dir/50000_sub_dirs_cpy &&
+	cp -r 50000_sub_dirs clean_test_dir/50000_sub_dirs_cpy &&
+	git clean -q -f -d  clean_test_dir/ &&
+	test 0 =3D $(ls -A clean_test_dir/ | wc -l)
+'
+
+test_perf 'clean many untracked sub dirs, ignore nested git' '
+	rm -rf clean_test_dir/50000_sub_dirs_cpy &&
+	cp -r 50000_sub_dirs clean_test_dir/50000_sub_dirs_cpy &&
+	git clean -q -f -f -d  clean_test_dir/ &&
+	test 0 =3D $(ls -A clean_test_dir/ | wc -l)
+'
+
+test_done
--=20
2.4.0.rc0.37.ga3b75b3
