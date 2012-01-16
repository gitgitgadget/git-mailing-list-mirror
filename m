From: Luke Diamand <luke@diamand.org>
Subject: [PATCH 4/4] git-p4: add test for p4 labels
Date: Mon, 16 Jan 2012 23:14:49 +0000
Message-ID: <1326755689-3344-5-git-send-email-luke@diamand.org>
References: <1326755689-3344-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 17 00:15:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rmvlt-0008II-3z
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 00:15:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482Ab2APXPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 18:15:10 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:47960 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067Ab2APXPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 18:15:09 -0500
Received: by wibhm6 with SMTP id hm6so974378wib.19
        for <git@vger.kernel.org>; Mon, 16 Jan 2012 15:15:08 -0800 (PST)
Received: by 10.180.106.202 with SMTP id gw10mr22934785wib.3.1326755708079;
        Mon, 16 Jan 2012 15:15:08 -0800 (PST)
Received: from ethel.diamand (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id hv1sm13727543wib.1.2012.01.16.15.15.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Jan 2012 15:15:07 -0800 (PST)
X-Mailer: git-send-email 1.7.8.rc1.209.geac91.dirty
In-Reply-To: <1326755689-3344-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188671>

Add basic test of p4 label import. Checks label import and
import with shell metachars; labels with different length
descriptions.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 t/t9804-git-p4-label.sh |   73 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 73 insertions(+), 0 deletions(-)
 create mode 100755 t/t9804-git-p4-label.sh

diff --git a/t/t9804-git-p4-label.sh b/t/t9804-git-p4-label.sh
new file mode 100755
index 0000000..eba3521
--- /dev/null
+++ b/t/t9804-git-p4-label.sh
@@ -0,0 +1,73 @@
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
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
1.7.8.rc1.209.geac91.dirty
