From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] t9129: skip the last two tests if UTF-8 locale not available
Date: Tue, 23 Dec 2008 02:09:24 +0100
Message-ID: <1229994564-5153-1-git-send-email-vmiklos@frugalware.org>
References: <7vzliogcie.fsf@gitster.siamese.dyndns.org>
Cc: Peter van der Does <peter@ourvirtualhome.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 02:09:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEvlg-0007xh-30
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 02:09:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754167AbYLWBHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 20:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754036AbYLWBHo
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 20:07:44 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:50809 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753930AbYLWBHn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 20:07:43 -0500
Received: from vmobile.example.net (catv-80-98-230-81.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTPA id 2E3F3446CDE;
	Tue, 23 Dec 2008 02:07:41 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id B7D7519DBE1; Tue, 23 Dec 2008 02:09:24 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc1.35.gae26e.dirty
In-Reply-To: <7vzliogcie.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103797>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Mon, Dec 22, 2008 at 12:50:49PM -0800, Junio C Hamano <gitster@pobox.com> wrote:
> I think some tests play nicer than this one and skip tests that want
> UTF-8 locales; you may want to teach this script the same trick.

What about this?

Tesed on two Linux boxes (where I have / do not have UTF-8) and HP-UX
(where I do not have, either).

 t/t9129-git-svn-i18n-commitencoding.sh |   30 +++++++++++++++++-------------
 1 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/t/t9129-git-svn-i18n-commitencoding.sh b/t/t9129-git-svn-i18n-commitencoding.sh
index 938b7fe..8a9dde4 100755
--- a/t/t9129-git-svn-i18n-commitencoding.sh
+++ b/t/t9129-git-svn-i18n-commitencoding.sh
@@ -60,21 +60,25 @@ do
 	'
 done
 
-test_expect_success 'ISO-8859-1 should match UTF-8 in svn' '
-(
-	cd ISO-8859-1 &&
-	compare_svn_head_with "$TEST_DIRECTORY"/t3900/1-UTF-8.txt
-)
-'
-
-for H in EUCJP ISO-2022-JP
-do
-	test_expect_success '$H should match UTF-8 in svn' '
+if locale -a |grep -q en_US.utf8; then
+	test_expect_success 'ISO-8859-1 should match UTF-8 in svn' '
 	(
-		cd $H &&
-		compare_svn_head_with "$TEST_DIRECTORY"/t3900/2-UTF-8.txt
+		cd ISO-8859-1 &&
+		compare_svn_head_with "$TEST_DIRECTORY"/t3900/1-UTF-8.txt
 	)
 	'
-done
+
+	for H in EUCJP ISO-2022-JP
+	do
+		test_expect_success '$H should match UTF-8 in svn' '
+		(
+			cd $H &&
+			compare_svn_head_with "$TEST_DIRECTORY"/t3900/2-UTF-8.txt
+		)
+		'
+	done
+else
+	say "UTF-8 locale not available, test skipped"
+fi
 
 test_done
-- 
1.6.1.rc1.35.gae26e.dirty
