From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] branch: do not attempt to track HEAD implicitly
Date: Tue, 14 Dec 2010 19:38:22 +0100
Message-ID: <6ee1f0174b757e25ab873d2d037545ac7db698ee.1292351886.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 14 19:38:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSZlf-0000uo-27
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 19:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758283Ab0LNSi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 13:38:26 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:52621 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757365Ab0LNSiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 13:38:25 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 14 Dec
 2010 19:38:17 +0100
Received: from localhost.localdomain (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 14 Dec
 2010 19:38:23 +0100
X-Mailer: git-send-email 1.7.3.3.797.g7a32f
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163660>

With branch.autosetupmerge=always, 'HEAD' becomes a valid target for
branch tracking.  This is a bit silly, and in fact the code already
guards against it when attempting it explicitly:

  $ git checkout HEAD^0
  $ g branch -t foo
  fatal: Cannot setup tracking information; starting point is not a branch.

Silently drop the HEAD candidate in the implicit (i.e. without -t
flag) case, so that the branch starts out without an upstream.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 branch.c          |    8 ++++++--
 t/t3200-branch.sh |    9 +++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/branch.c b/branch.c
index 93dc866..19310e4 100644
--- a/branch.c
+++ b/branch.c
@@ -176,8 +176,12 @@ void create_branch(const char *head,
 		break;
 	case 1:
 		/* Unique completion -- good, only if it is a real ref */
-		if (explicit_tracking && !strcmp(real_ref, "HEAD"))
-			die("Cannot setup tracking information; starting point is not a branch.");
+		if (!strcmp(real_ref, "HEAD")) {
+			if (explicit_tracking)
+				die("Cannot setup tracking information; starting point is not a branch.");
+			else
+				real_ref = NULL;
+		}
 		break;
 	default:
 		die("Ambiguous object name: '%s'.", start_name);
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index f308235..0fa5c91 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -488,6 +488,15 @@ test_expect_success 'autosetuprebase always on an untracked remote branch' '
 	test "z$(git config branch.myr20.rebase)" = z
 '
 
+test_expect_success 'autosetuprebase always on detached HEAD' '
+	git config branch.autosetupmerge always &&
+	test_when_finished git checkout master &&
+	git checkout HEAD^0 &&
+	git branch my11 &&
+	test -z "$(git config branch.my11.remote)" &&
+	test -z "$(git config branch.my11.merge)"
+'
+
 test_expect_success 'detect misconfigured autosetuprebase (bad value)' '
 	git config branch.autosetuprebase garbage &&
 	test_must_fail git branch
-- 
1.7.3.3.797.g7a32f
