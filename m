From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 12/12] t3901: test git-am encoding conversion
Date: Fri,  3 Jul 2015 02:16:40 +0800
Message-ID: <1435861000-25278-13-git-send-email-pyokagan@gmail.com>
References: <1435861000-25278-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 20:18:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAj3h-0006ce-GL
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 20:18:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931AbbGBSR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 14:17:56 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:36635 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076AbbGBSRm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 14:17:42 -0400
Received: by pdcu2 with SMTP id u2so49999632pdc.3
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 11:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wlLfZuUXhtqvq7GrKHnNwAROqHWi4B2JfdfaMb7STiw=;
        b=IeUqhnQMUkd/N6iVqrpxrH0xI1um1ZJXWZsOqkgMeMF8dm5Nz/nleuBlkabwiMPgji
         gqWJHHfw/NXdKn5NR8XSzoJzCiEldacSG0t/Sgx4TntjwLsOd4uoocVUFf5+M7ywgWGj
         s0CtxWhSMH+ezK4XpZcn36VOlshTfE/UgIv2rffeHG49bUA1sHt/Bq7MEFu8lSFeWpOr
         bHgNMnNIHsG6htS/iS1K6TpXGjQHW2d5YNmUs/t8L8bYIsHoFOz4FyvSiNd9dRi9MVGO
         EbYuw5hFjgmloXx4UzO5RukACteYw6G2CpgjvgLjf6LjxWEGTF/G02/QuF6jFX4h4gmV
         y5fw==
X-Received: by 10.70.101.3 with SMTP id fc3mr69267327pdb.167.1435861061796;
        Thu, 02 Jul 2015 11:17:41 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id pr4sm6412670pbb.30.2015.07.02.11.17.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jul 2015 11:17:40 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.81.gfe77482
In-Reply-To: <1435861000-25278-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273266>

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

Cc: Junio C Hamano <gitster@pobox.com>
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
2.5.0.rc1.81.gfe77482
