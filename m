From: Maxim Bublis <satori@yandex-team.ru>
Subject: [PATCH v2 1/2] t9300: test filedelete command
Date: Fri, 29 Aug 2014 15:53:36 +0400
Message-ID: <1409313217-23198-2-git-send-email-satori@yandex-team.ru>
References: <1409313217-23198-1-git-send-email-satori@yandex-team.ru>
Cc: Junio C Hamano <gitster@pobox.com>,
	Maxim Bublis <satori@yandex-team.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 29 13:54:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNKkp-00072E-0y
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 13:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639AbaH2Lx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 07:53:56 -0400
Received: from 95.108.175.165-red.dhcp.yndx.net ([95.108.175.165]:60400 "EHLO
	95.108.175.165-red.dhcp.yndx.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752150AbaH2Lx4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Aug 2014 07:53:56 -0400
Received: by 95.108.175.165-red.dhcp.yndx.net (Postfix, from userid 1533206276)
	id 2C437205B399; Fri, 29 Aug 2014 15:53:52 +0400 (MSK)
X-Mailer: git-send-email 1.8.5.2 (Apple Git-48)
In-Reply-To: <1409313217-23198-1-git-send-email-satori@yandex-team.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256144>

Add new fast-import test series for filedelete command.

Signed-off-by: Maxim Bublis <satori@yandex-team.ru>
---
 t/t9300-fast-import.sh | 104 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 5fc9ef2..9cf5e45 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3017,4 +3017,108 @@ test_expect_success 'T: empty reset doesnt delete branch' '
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
+M 100644 inline good/night.txt
+data <<BLOB
+sleep well
+BLOB
+M 100644 inline good/bye.txt
+data <<BLOB
+au revoir
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
+delete good/night.txt
+COMMIT
+from refs/heads/U^0
+D good/night.txt
+
+INPUT_END
+
+test_expect_success 'U: filedelete file succeeds' '
+	git fast-import <input
+'
+
+cat >expect <<EOF
+:100644 000000 2907ebb4bf85d91bf0716bb3bd8a68ef48d6da76 0000000000000000000000000000000000000000 D	good/night.txt
+EOF
+
+git diff-tree -M -r U^1 U >actual
+
+test_expect_success 'U: validate file delete result' '
+	compare_diff_raw expect actual
+'
+
+cat >input <<INPUT_END
+commit refs/heads/U
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+delete good dir
+COMMIT
+from refs/heads/U^0
+D good
+
+INPUT_END
+
+test_expect_success 'U: filedelete directory succeeds' '
+	git fast-import <input
+'
+
+cat >expect <<EOF
+:100644 000000 69cb75792f55123d8389c156b0b41c2ff00ed507 0000000000000000000000000000000000000000 D	good/bye.txt
+EOF
+
+git diff-tree -M -r U^1 U >actual
+
+test_expect_success 'U: validate directory delete result' '
+	compare_diff_raw expect actual
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
+test_expect_failure 'U: filedelete root succeeds' '
+    git fast-import <input
+'
+
+cat >expect <<EOF
+:100644 000000 c18147dc648481eeb65dc5e66628429a64843327 0000000000000000000000000000000000000000 D	hello.c
+EOF
+
+git diff-tree -M -r U^1 U >actual
+
+test_expect_failure 'U: validate root delete result' '
+	compare_diff_raw expect actual
+'
+
 test_done
-- 
1.8.5.2 (Apple Git-48)
