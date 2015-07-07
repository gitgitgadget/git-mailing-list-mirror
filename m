From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 12/12] t3901: test git-am encoding conversion
Date: Tue,  7 Jul 2015 22:08:34 +0800
Message-ID: <1436278114-28057-13-git-send-email-pyokagan@gmail.com>
References: <1436278114-28057-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:09:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTZJ-000610-TP
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757820AbbGGOJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:09:30 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:33217 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757805AbbGGOJW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:09:22 -0400
Received: by pdbdz6 with SMTP id dz6so31804877pdb.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S1iERBje6OhCXwIBsRCmBrkP5SiXj9nkFqmQZIJ9MNw=;
        b=IqcRzbjSp2jr6fy7+8/Ss2rggqbIp3HxjmPaQp1SG30UC3U0G2/fJDkm4htnkZIM/l
         4WLW94Vfp3kLLb4NbnPIg8niEnzoo+IZRq2XHwrxmPKLrJ38e7wJzz3nzbTpai6XxzXz
         LuWs5nNQVLDiACX2p4+bQQ3KIrAvx9yT5HYZUPZ0h1ZP8cjYbBwJGM3zaozBevQL1msS
         rJdOQnRxPvUV2Ju0fBkzNuXX9hc4+sw7prjz/K93TcLqXi0MenY9Q7pk/5jb7LR1ylXe
         RsbaOdyovSgDD5gtXmp/WUgt2EeBjhJnL9uzi3aJ9Q0p7PSa2aPArqIUaXR7OARj1FOd
         /5hQ==
X-Received: by 10.68.136.3 with SMTP id pw3mr9459941pbb.10.1436278161774;
        Tue, 07 Jul 2015 07:09:21 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id im7sm22004766pbc.25.2015.07.07.07.09.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:09:20 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278114-28057-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273517>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07), git-am
supported the --utf8 and --no-utf8 options, and if set, would pass the
-u flag and the -k flag respectively.

git mailinfo -u will re-code the commit log message and authorship info
in the charset specified by i18n.commitencoding setting, while
git mailinfo -n will disable the re-coding.

Since d84029b (--utf8 is now default for 'git-am', 2007-01-08), --utf8
is set by default in git-am.

Add various encoding conversion tests to t3901 to test git-mailinfo's
encoding conversion. In addition, add a test for --no-utf8 to check that
no encoding conversion will occur if that option is set.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/t3901-i18n-patch.sh | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/t/t3901-i18n-patch.sh b/t/t3901-i18n-patch.sh
index 75cf3ff..b49bdb7 100755
--- a/t/t3901-i18n-patch.sh
+++ b/t/t3901-i18n-patch.sh
@@ -251,4 +251,66 @@ test_expect_success 'rebase --merge (L/U)' '
 	check_encoding 2 8859
 '
 
+test_expect_success 'am (U/U)' '
+	# Apply UTF-8 patches with UTF-8 commitencoding
+	git config i18n.commitencoding UTF-8 &&
+	. "$TEST_DIRECTORY"/t3901-utf8.txt &&
+
+	git reset --hard master &&
+	git am out-u1 out-u2 &&
+
+	check_encoding 2
+'
+
+test_expect_success 'am (L/L)' '
+	# Apply ISO-8859-1 patches with ISO-8859-1 commitencoding
+	git config i18n.commitencoding ISO8859-1 &&
+	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
+
+	git reset --hard master &&
+	git am out-l1 out-l2 &&
+
+	check_encoding 2 8859
+'
+
+test_expect_success 'am (U/L)' '
+	# Apply ISO-8859-1 patches with UTF-8 commitencoding
+	git config i18n.commitencoding UTF-8 &&
+	. "$TEST_DIRECTORY"/t3901-utf8.txt &&
+	git reset --hard master &&
+
+	# am specifies --utf8 by default.
+	git am out-l1 out-l2 &&
+
+	check_encoding 2
+'
+
+test_expect_success 'am --no-utf8 (U/L)' '
+	# Apply ISO-8859-1 patches with UTF-8 commitencoding
+	git config i18n.commitencoding UTF-8 &&
+	. "$TEST_DIRECTORY"/t3901-utf8.txt &&
+
+	git reset --hard master &&
+	git am --no-utf8 out-l1 out-l2 2>err &&
+
+	# commit-tree will warn that the commit message does not contain valid UTF-8
+	# as mailinfo did not convert it
+	grep "did not conform" err &&
+
+	check_encoding 2
+'
+
+test_expect_success !MINGW 'am (L/U)' '
+	# Apply UTF-8 patches with ISO-8859-1 commitencoding
+	git config i18n.commitencoding ISO8859-1 &&
+	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
+
+	git reset --hard master &&
+	# mailinfo will re-code the commit message to the charset specified by
+	# i18n.commitencoding
+	git am out-u1 out-u2 &&
+
+	check_encoding 2 8859
+'
+
 test_done
-- 
2.5.0.rc1.76.gf60a929
