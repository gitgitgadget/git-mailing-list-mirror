From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv3 5/8] t9500: Add test for handling incomplete lines in diff by gitweb
Date: Mon, 31 Oct 2011 00:36:24 +0100
Message-ID: <1320017787-18048-6-git-send-email-jnareb@gmail.com>
References: <1320017787-18048-1-git-send-email-jnareb@gmail.com>
Cc: Kato Kazuyoshi <kato.kazuyoshi@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 00:43:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKf25-0006lu-LE
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 00:43:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755Ab1J3XnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Oct 2011 19:43:13 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39759 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491Ab1J3XnM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2011 19:43:12 -0400
Received: by mail-fx0-f46.google.com with SMTP id n17so5069535faa.19
        for <git@vger.kernel.org>; Sun, 30 Oct 2011 16:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jlXwmpJeQqYt6lBsSFv4FqFKInK1W+DX5G/mTQ0QohI=;
        b=saObELlypUAeGClIDnzFkjeHw9JlhKPXIHRKcgwoRTwYy6RyHWJUt+lsrJ9i4c7m90
         qKaeSstcXC5HGmL8iCxi2vEbvCphv7erIiLU2/SIeHjI0O4WE6odzUBqVFQ+zuXnlEjr
         45gFnQAcYfxNhTUeqU5Hv4yG66c6mtVi+3nBk=
Received: by 10.223.14.140 with SMTP id g12mr24775600faa.34.1320018191554;
        Sun, 30 Oct 2011 16:43:11 -0700 (PDT)
Received: from localhost.localdomain (aeho24.neoplus.adsl.tpnet.pl. [79.186.196.24])
        by mx.google.com with ESMTPS id a26sm19652514fac.2.2011.10.30.16.43.10
        (version=SSLv3 cipher=OTHER);
        Sun, 30 Oct 2011 16:43:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1320017787-18048-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184484>

Check that "commitdiff" action in gitweb can handle (without errors)
incomplete lines as added and removed lines, and as context lines.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
New in this series, and independent on side-by-side stuff.

 t/t9500-gitweb-standalone-no-errors.sh |   47 ++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 5329715..c731507 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -274,6 +274,53 @@ test_expect_success \
 	'gitweb_run "p=.git;a=commitdiff;hp=foo-becomes-a-directory;h=foo-symlinked-to-bar"'
 
 # ----------------------------------------------------------------------
+# commitdiff testing (incomplete lines)
+
+test_expect_success 'setup incomplete lines' '
+	cat >file<<-\EOF &&
+	Dominus regit me,
+	et nihil mihi deerit.
+	In loco pascuae ibi me collocavit,
+	super aquam refectionis educavit me;
+	animam meam convertit,
+	deduxit me super semitas jusitiae,
+	propter nomen suum.
+	CHANGE_ME
+	EOF
+	git commit -a -m "Preparing for incomplete lines" &&
+	echo "incomplete" | tr -d "\\012" >>file &&
+	git commit -a -m "Add incomplete line" &&
+	git tag incomplete_lines_add &&
+	sed -e s/CHANGE_ME/change_me/ <file >file+ &&
+	mv -f file+ file &&
+	git commit -a -m "Incomplete context line" &&
+	git tag incomplete_lines_ctx &&
+	echo "Dominus regit me," >file &&
+	echo "incomplete line" | tr -d "\\012" >>file &&
+	git commit -a -m "Change incomplete line" &&
+	git tag incomplete_lines_chg
+	echo "Dominus regit me," >file &&
+	git commit -a -m "Remove incomplete line" &&
+	git tag incomplete_lines_rem
+'
+
+test_expect_success 'commitdiff(1): addition of incomplete line' '
+	gitweb_run "p=.git;a=commitdiff;h=incomplete_lines_add"
+'
+
+test_expect_success 'commitdiff(1): incomplete line as context line' '
+	gitweb_run "p=.git;a=commitdiff;h=incomplete_lines_ctx"
+'
+
+test_expect_success 'commitdiff(1): change incomplete line' '
+	gitweb_run "p=.git;a=commitdiff;h=incomplete_lines_chg"
+'
+
+test_expect_success 'commitdiff(1): removal of incomplete line' '
+	gitweb_run "p=.git;a=commitdiff;h=incomplete_lines_rem"
+'
+
+# ----------------------------------------------------------------------
 # commit, commitdiff: merge, large
 test_expect_success \
 	'Create a merge' \
-- 
1.7.6
