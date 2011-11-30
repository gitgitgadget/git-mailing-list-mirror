From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 4/4] git-p4: add test for p4 labels
Date: Wed, 30 Nov 2011 09:03:37 +0000
Message-ID: <1322643817-13051-5-git-send-email-luke@diamand.org>
References: <1322643817-13051-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 10:04:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVg5u-0005LU-1R
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 10:04:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757422Ab1K3JEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 04:04:35 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54127 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757265Ab1K3JE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 04:04:29 -0500
Received: by mail-bw0-f46.google.com with SMTP id s6so570681bka.19
        for <git@vger.kernel.org>; Wed, 30 Nov 2011 01:04:29 -0800 (PST)
Received: by 10.204.148.4 with SMTP id n4mr1316296bkv.42.1322643868922;
        Wed, 30 Nov 2011 01:04:28 -0800 (PST)
Received: from ethel.cable.virginmedia.net (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id c4sm2565364bkk.13.2011.11.30.01.04.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Nov 2011 01:04:28 -0800 (PST)
X-Mailer: git-send-email 1.7.8.rc1.209.geac91.dirty
In-Reply-To: <1322643817-13051-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186120>

Add basic test of p4 label import. Checks label import and
import with shell metachars; labels with different length
descriptions.

Add failure test case for multiple labels.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 t/t9804-git-p4-label.sh |  114 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 114 insertions(+), 0 deletions(-)
 create mode 100755 t/t9804-git-p4-label.sh

diff --git a/t/t9804-git-p4-label.sh b/t/t9804-git-p4-label.sh
new file mode 100755
index 0000000..a46763f
--- /dev/null
+++ b/t/t9804-git-p4-label.sh
@@ -0,0 +1,114 @@
+test_description='git-p4 p4 label tests'
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+# Basic p4 label tests.
+#
+# Note: can't have more than one label per commit - others
+# are silently discarded.
+#
+test_expect_success 'basic p4 labels' '
+	test_when_finished cleanup_git &&
+	(
+		cd "$cli" &&
+		mkdir -p main &&
+
+		echo f1 >main/f1 &&
+		p4 add main/f1 &&
+		p4 submit -d "main/f1" &&
+
+		echo f2 >main/f2 &&
+		p4 add main/f2 &&
+		p4 submit -d "main/f2" &&
+
+		echo f3 >main/file_with_\$metachar &&
+		p4 add main/file_with_\$metachar &&
+		p4 submit -d "file with metachar" &&
+
+		p4 tag -l tag_f1_only main/f1 &&
+		p4 tag -l tag_with\$_shell_char main/... &&
+
+		echo f4 >main/f4 &&
+		p4 add main/f4 &&
+		p4 submit -d "main/f4" &&
+
+		p4 label -i <<-EOF &&
+		Label: long_label
+		Description:
+		   A Label first line
+		   A Label second line
+		View:	//depot/...
+		EOF
+
+		p4 tag -l long_label ... &&
+
+		p4 labels ... &&
+
+		cd "$git" &&
+		pwd &&
+		"$GITP4" clone --dest=. --detect-labels //depot@all &&
+
+		git tag &&
+		git tag >taglist &&
+		test_line_count = 3 taglist &&
+
+		cd main &&
+		git checkout tag_tag_f1_only &&
+		! test -f f2 &&
+		git checkout tag_tag_with\$_shell_char &&
+		test -f f1 && test -f f2 && test -f file_with_\$metachar &&
+
+		git show tag_long_label | grep -q "A Label second line"
+	)
+'
+
+# Test some label corner cases:
+#
+# - two tags on the same file; both should be available
+# - a tag that is only on one file; the other file should
+#   not be checked out on the tag.
+
+test_expect_failure 'two labels on the same changelist' '
+	test_when_finished cleanup_git &&
+	(
+		cd "$cli" &&
+		mkdir -p main &&
+
+		p4 edit main/f1 main/f2 &&
+		echo "hello world" >main/f1 &&
+		echo "not in the tag" >main/f2 &&
+		p4 submit -d "main/f[12]: testing two labels" &&
+
+		p4 tag -l tag_f1_1 main/f1 &&
+		p4 tag -l tag_f1_2 main/f1 &&
+
+		p4 labels ... &&
+
+		cd "$git" &&
+		pwd &&
+		"$GITP4" clone --dest=. --detect-labels //depot@all &&
+
+		git tag | grep -q tag_f1_1 &&
+		git tag | grep -q tag_f1_2 &&
+
+		cd main &&
+
+		git checkout tag_tag_f1_1 &&
+		test -f f1 &&
+
+		git checkout tag_tag_f1_1 &&
+		test -f f1 &&
+
+		! test -f f2
+	)
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
1.7.8.rc1.209.geac91.dirty
