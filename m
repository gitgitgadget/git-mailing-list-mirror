From: Maxim Bublis <satori@yandex-team.ru>
Subject: [PATCH 1/2] t9300: test filedelete root
Date: Thu, 28 Aug 2014 18:54:33 +0400
Message-ID: <1409237674-74185-2-git-send-email-satori@yandex-team.ru>
References: <1409237674-74185-1-git-send-email-satori@yandex-team.ru>
Cc: Maxim Bublis <satori@yandex-team.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 16:55:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN16c-0005uJ-Cj
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 16:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbaH1Oy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 10:54:57 -0400
Received: from 95.108.175.165-red.dhcp.yndx.net ([95.108.175.165]:55955 "EHLO
	95.108.175.165-red.dhcp.yndx.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750892AbaH1Oy4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Aug 2014 10:54:56 -0400
Received: by 95.108.175.165-red.dhcp.yndx.net (Postfix, from userid 1533206276)
	id 8869D2046B20; Thu, 28 Aug 2014 18:54:56 +0400 (MSK)
X-Mailer: git-send-email 1.8.5.2 (Apple Git-48)
In-Reply-To: <1409237674-74185-1-git-send-email-satori@yandex-team.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256094>

Add new fast-import test series for filedelete command.

Signed-off-by: Maxim Bublis <satori@yandex-team.ru>
---
 t/t9300-fast-import.sh | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 5fc9ef2..3d557b3 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3017,4 +3017,50 @@ test_expect_success 'T: empty reset doesnt delete branch' '
 	git rev-parse --verify refs/heads/not-to-delete
 '
 
+###
+### series U (filedelete)
+###
+
+cat >input <<INPUT_END
+commit refs/heads/U
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+test setup
+COMMIT
+M 100644 inline hello.c
+data <<BLOB
+blob 1
+BLOB
+
+INPUT_END
+
+test_expect_success 'U: initialize for U tests' '
+	git fast-import <input
+'
+
+cat >input <<INPUT_END
+commit refs/heads/U
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+must succeed
+COMMIT
+from refs/heads/U^0
+D ""
+
+INPUT_END
+
+test_expect_success 'U: filedelete root succeeds' '
+    git fast-import <input
+'
+
+cat >expect <<EOF
+:100644 000000 c18147dc648481eeb65dc5e66628429a64843327 0000000000000000000000000000000000000000 D	hello.c
+EOF
+
+git diff-tree -M -r U^1 U >actual
+
+test_expect_success 'U: validate filedelete result' '
+	compare_diff_raw expect actual
+'
+
 test_done
-- 
1.8.5.2 (Apple Git-48)
