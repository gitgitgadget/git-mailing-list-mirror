From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 12/12] t3901: test git-am encoding conversion
Date: Sun, 19 Jul 2015 23:49:18 +0800
Message-ID: <1437320958-11192-13-git-send-email-pyokagan@gmail.com>
References: <1437320958-11192-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 19 17:50:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGqqz-0005rO-PV
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 17:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753900AbbGSPuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 11:50:06 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:35938 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753863AbbGSPuE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 11:50:04 -0400
Received: by pdjr16 with SMTP id r16so91182475pdj.3
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 08:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lAcAW8vwEgnNohhhbkhcR4llxjBaBrlxIu0DzHNaJ+M=;
        b=z1GlwulkxO/+PNHfl+d8AzyRWgkiiDbJxRgZ6df+apSKY6l/XlbU6ZwXTkUpPMj24O
         u6tStN9LWdIXeoYxQDqg3AKnO/xR+4DDmovzwXgQ1kywKxumG+8i8aPT22KbaSxhPZK7
         3Muoq7T3vKWx1iFasYQLSygiRRIjaqA39uOgd8X0FEWnldM59WOpspeViB4T9EiEHGC2
         +bd92FT3nkV5c9kjOzR0CeaDLuI73EhRI/nN1C7Xxfi0eUhs8Z73z1F0M0GkPpWKQMeK
         G2j7Wz/FmbDcd/rgkflARzgD8TBO8+HtKfbn9rOJmM07UMo4z1tL7/Ey+j5yUYSPZn3I
         vvWQ==
X-Received: by 10.69.17.130 with SMTP id ge2mr48781806pbd.75.1437321003346;
        Sun, 19 Jul 2015 08:50:03 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by smtp.gmail.com with ESMTPSA id j9sm17216516pdl.65.2015.07.19.08.50.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 08:50:02 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.110.gf2a5fc6
In-Reply-To: <1437320958-11192-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274224>

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

Helped-by: Johannes Sixt <j6t@kdbg.org>
Reviewed-by: Stefan Beller <sbeller@google.com>
Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v3
    
    * Added !MINGW prereq for the other test case that uses ISO-8859-1
      encoded environment vars

 t/t3901-i18n-patch.sh | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/t/t3901-i18n-patch.sh b/t/t3901-i18n-patch.sh
index 75cf3ff..509084e 100755
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
+test_expect_success !MINGW 'am (L/L)' '
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
2.5.0.rc2.110.gf2a5fc6
