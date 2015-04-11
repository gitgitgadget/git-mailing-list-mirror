From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: [PATCH v2 2/3] p7300: add performance tests for clean
Date: Sat, 11 Apr 2015 18:43:06 +0200
Message-ID: <1428770587-9674-4-git-send-email-erik.elfstrom@gmail.com>
References: <1428770587-9674-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 11 18:44:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YgyVn-0005ik-RJ
	for gcvg-git-2@plane.gmane.org; Sat, 11 Apr 2015 18:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841AbbDKQni convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Apr 2015 12:43:38 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:36068 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754651AbbDKQnb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2015 12:43:31 -0400
Received: by lagv1 with SMTP id v1so31957182lag.3
        for <git@vger.kernel.org>; Sat, 11 Apr 2015 09:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=j5jw2HGduPHHymxdoEkqAjdkQyhkuwF8gNBl/CDz+5Y=;
        b=vlRVe9/uLLJOi753o/kZ/glbpU94dghBIymyTFoQzavRkEkmJqz+V88Bhpr2Kzewsk
         JNeed0MyGru8y9Vw6GoAJfuputhFvdCTXHqUupGJO0ruFSHY+fujZWjNNfyf7nbU2jDM
         3nKOZG510PdbdvU1QVeTvFEEAlzhRPLhWZgHKoHbCoNBmomMwcISr7QsjKwbC3jTtMyq
         0tKBkbo9BSumGKkWezbsgttX0FjW0kiWsnhMnVqJFndsojWYxfQNUDILOa5SX/2zTftj
         C7NsVB6hbhEkkIkn3Zzv31qcuy9OdIwc9arlN1T2YYyR5G4ykc3CDV2DFdwdI9dXaOOx
         86Tg==
X-Received: by 10.153.4.43 with SMTP id cb11mr6233514lad.122.1428770610214;
        Sat, 11 Apr 2015 09:43:30 -0700 (PDT)
Received: from localhost.localdomain (h38n2-lk-d2.ias.bredband.telia.com. [78.72.191.38])
        by mx.google.com with ESMTPSA id kx8sm501395lbc.3.2015.04.11.09.43.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 11 Apr 2015 09:43:29 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc0.37.ga3b75b3
In-Reply-To: <1428770587-9674-1-git-send-email-erik.elfstrom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267027>

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
2.4.0.rc0.37.ga3b75b3
