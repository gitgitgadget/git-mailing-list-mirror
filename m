From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 1/3] t4150-am: demonstrate git-am's failure to handle some patch emails
Date: Thu,  6 Aug 2009 20:08:11 -0500
Message-ID: <COrzR9ThNBy5SQ7chsXyUOUuBmX-VWMCz3MUVwvBOlIZzlIXRRMP6EMS7BRy_6uJvxt5H-FbtdY@cipher.nrlssc.navy.mil>
References: <MEhvdM_GHnyaFj9ZU3lxKS47vmOk5BKslGm0FxkE_lg0SQT5Zx6KhA@cipher.nrlssc.navy.mil>
Cc: ni.s@laposte.net, giuseppe.bilotta@gmail.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 07 03:09:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZDxY-0004W5-BV
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 03:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754389AbZHGBJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 21:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754093AbZHGBJH
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 21:09:07 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:33965 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371AbZHGBJG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 21:09:06 -0400
Received: by mail.nrlssc.navy.mil id n7718wAd024792; Thu, 6 Aug 2009 20:08:59 -0500
In-Reply-To: <MEhvdM_GHnyaFj9ZU3lxKS47vmOk5BKslGm0FxkE_lg0SQT5Zx6KhA@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 07 Aug 2009 01:08:58.0876 (UTC) FILETIME=[A4AB1BC0:01CA16FB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125150>

From: Brandon Casey <drafnel@gmail.com>

Recently git-am gained the ability to detect and apply patches from some
foreign VCS's.  The detection of traditional patch emails though is somewhat
limited and will fail if a "From" field is not detected in the first three
lines of the email header.  Demonstrate the failure by supplying a
perfectly valid email to git-am which it formerly could successfully apply.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 t/t4150-am.sh |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index a12bf84..ad2a85f 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -77,6 +77,12 @@ test_expect_success setup '
 	git commit -s -F msg &&
 	git tag second &&
 	git format-patch --stdout first >patch1 &&
+	{
+		echo "X-Fake-Field: Line One" &&
+		echo "X-Fake-Field: Line Two" &&
+		echo "X-Fake-Field: Line Three" &&
+		git format-patch --stdout first | sed -e "1d"
+	} > patch1.eml &&
 	sed -n -e "3,\$p" msg >file &&
 	git add file &&
 	test_tick &&
@@ -108,6 +114,15 @@ test_expect_success 'am applies patch correctly' '
 	test "$(git rev-parse second^)" = "$(git rev-parse HEAD^)"
 '
 
+test_expect_failure 'am correctly applies patch from email lacking "From" in first 3 lines' '
+	git checkout first &&
+	git am patch1.eml &&
+	! test -d .git/rebase-apply &&
+	test -z "$(git diff second)" &&
+	test "$(git rev-parse second)" = "$(git rev-parse HEAD)" &&
+	test "$(git rev-parse second^)" = "$(git rev-parse HEAD^)"
+'
+
 GIT_AUTHOR_NAME="Another Thor"
 GIT_AUTHOR_EMAIL="a.thor@example.com"
 GIT_COMMITTER_NAME="Co M Miter"
-- 
1.6.4
