From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv4 5/5] git-p4: label import fails with multiple labels at the same changelist
Date: Thu, 19 Jan 2012 09:52:29 +0000
Message-ID: <1326966749-9077-6-git-send-email-luke@diamand.org>
References: <1326966749-9077-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Vitor Antunes <vitor.hda@gmail.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 10:53:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rnog9-0002C5-M7
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 10:53:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756585Ab2ASJw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 04:52:58 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:50038 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756431Ab2ASJwp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 04:52:45 -0500
Received: by mail-wi0-f174.google.com with SMTP id s10so212418wic.19
        for <git@vger.kernel.org>; Thu, 19 Jan 2012 01:52:45 -0800 (PST)
Received: by 10.180.19.138 with SMTP id f10mr52910410wie.3.1326966765253;
        Thu, 19 Jan 2012 01:52:45 -0800 (PST)
Received: from ethel.diamand (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id bj10sm27093411wib.9.2012.01.19.01.52.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Jan 2012 01:52:44 -0800 (PST)
X-Mailer: git-send-email 1.7.8.rc1.209.geac91.dirty
In-Reply-To: <1326966749-9077-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188804>

git-p4 has an array of changelists with one label per changelist.
But you can have multiple labels on a single changelist and so this
code fails.

Add a test case demonstrating the problem.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 t/t9804-git-p4-label.sh |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/t/t9804-git-p4-label.sh b/t/t9804-git-p4-label.sh
index 5fa2bcf..80d01ea 100755
--- a/t/t9804-git-p4-label.sh
+++ b/t/t9804-git-p4-label.sh
@@ -65,6 +65,47 @@ test_expect_success 'basic p4 labels' '
 	)
 '
 
+# Test some label corner cases:
+#
+# - two tags on the same file; both should be available
+# - a tag that is only on one file; this kind of tag
+#   cannot be imported (at least not easily).
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
+		p4 tag -l tag_f1_1 main/... &&
+		p4 tag -l tag_f1_2 main/... &&
+
+		p4 labels ... &&
+
+		"$GITP4" clone --dest="$git" --detect-labels //depot@all &&
+		cd "$git" &&
+
+		git tag | grep tag_f1 &&
+		git tag | grep -q tag_f1_1 &&
+		git tag | grep -q tag_f1_2 &&
+
+		cd main &&
+
+		git checkout tag_tag_f1_1 &&
+		ls &&
+		test -f f1 &&
+
+		git checkout tag_tag_f1_2 &&
+		ls &&
+		test -f f1
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
1.7.8.rc1.209.geac91.dirty
