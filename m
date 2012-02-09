From: Luke Diamand <luke@diamand.org>
Subject: [RFC/PATCHv2 1/2] git-p4: add test case for RCS keywords
Date: Thu,  9 Feb 2012 23:17:21 +0000
Message-ID: <1328829442-12550-2-git-send-email-luke@diamand.org>
References: <1328829442-12550-1-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Cc: Pete Wyckoff <pw@padd.com>, Eric Scouten <eric@scouten.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 00:17:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvdFA-0003pp-ER
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 00:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758497Ab2BIXR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 18:17:28 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33026 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758462Ab2BIXR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 18:17:26 -0500
Received: by mail-wi0-f174.google.com with SMTP id s10so1618287wic.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 15:17:26 -0800 (PST)
Received: by 10.180.87.8 with SMTP id t8mr35909363wiz.15.1328829446119;
        Thu, 09 Feb 2012 15:17:26 -0800 (PST)
Received: from ethel.cable.virginmedia.net (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id q7sm9809903wix.5.2012.02.09.15.17.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Feb 2012 15:17:25 -0800 (PST)
X-Mailer: git-send-email 1.7.9.rc2.128.gfce41.dirty
In-Reply-To: <1328829442-12550-1-git-send-email-luke@diamand.org>
X-Gm-Message-State: ALoCoQlQ1SCXQDEkQr0BkmXgGKtFSPL+PrTp4wZ6fbdJhoZ7+M5eV3mcy3aY3U6Wwr/yaboK6Ztf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190338>

RCS keywords cause problems for git-p4 as perforce always
expands them (if +k is set) and so when applying the patch,
git reports that the files have been modified by both sides,
when in fact they haven't.

This adds a failing test case to demonstrate the problem.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 t/t9810-git-p4-rcs.sh |   80 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 80 insertions(+), 0 deletions(-)
 create mode 100755 t/t9810-git-p4-rcs.sh

diff --git a/t/t9810-git-p4-rcs.sh b/t/t9810-git-p4-rcs.sh
new file mode 100755
index 0000000..c09f83d
--- /dev/null
+++ b/t/t9810-git-p4-rcs.sh
@@ -0,0 +1,80 @@
+#!/bin/sh
+
+test_description='git-p4 rcs keywords'
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+create_kw_file() {
+	cat <<\EOF >"$1"
+/* A file
+	Id: $Id$
+	Revision: $Revision$
+	File: $File$
+ */
+int main(int argc, const char **argv) {
+	return 0;
+}
+EOF
+}
+
+test_expect_success 'init depot' '
+	(
+		cd "$cli" &&
+		echo file1 >file1 &&
+		p4 add file1 &&
+		p4 submit -d "change 1" &&
+		create_kw_file kwfile1.c &&
+		p4 add kwfile1.c &&
+		p4 submit -d "Add rcw kw file" kwfile1.c
+	)
+'
+
+p4_append_to_file() {
+	f=$1 &&
+	p4 edit -t ktext "$f" &&
+	echo "/* $(date) */" >>"$f" &&
+	p4 submit -d "appending a line in p4"
+}
+
+# Create some files with RCS keywords. If they get modified
+# elsewhere then the version number gets bumped which then
+# results in a merge conflict if we touch the RCS kw lines,
+# even though the change itself would otherwise apply cleanly.
+test_expect_failure 'cope with rcs keyword expansion damage' '
+	"$GITP4" clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		(cd ../cli && p4_append_to_file kwfile1.c) &&
+		perl -n -i -e "print unless m/Revision:/" kwfile1.c &&
+		git add kwfile1.c &&
+		git commit -m "Zap an RCS kw line" &&
+		"$GITP4" submit &&
+		"$GITP4" rebase &&
+		git diff p4/master &&
+		"$GITP4" commit &&
+		echo "try modifying in both" &&
+		cd "$cli" &&
+		p4 edit kwfile1.c &&
+		echo "line from p4" >>kwfile1.c &&
+		p4 submit -d "add a line in p4" kwfile1.c &&
+		cd "$git" &&
+		echo "line from git at the top" | cat - kwfile1.c >kwfile1.c.new &&
+		mv kwfile1.c.new kwfile1.c &&
+		git commit -m "Add line in git at the top" kwfile1.c &&
+		"$GITP4" rebase &&
+		"$GITP4" submit
+	) &&
+	rm -rf "$git" && mkdir "$git"
+'
+
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
1.7.9.rc2.128.gfce41.dirty
