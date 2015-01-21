From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 11/19] fsck: Add a simple test for receive.fsck.*
Date: Wed, 21 Jan 2015 20:25:57 +0100
Organization: gmx
Message-ID: <f9acf7dd77008502e316795e37503d4c57c94f94.1421868116.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1421868116.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 21 20:26:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE0ui-0002mo-IK
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 20:26:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754149AbbAUT0B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 14:26:01 -0500
Received: from mout.gmx.net ([212.227.15.15]:54003 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752285AbbAUTZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 14:25:59 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MSMw7-1YJg4c2hFj-00TT5n; Wed, 21 Jan 2015 20:25:57
 +0100
In-Reply-To: <cover.1421868116.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:eA33E61nqaRbmKCElOU5v2ICCpFYdL7B38WP0eet38DkP20VhPh
 OBxwvzDRfmD7mbzOZ8Kujv7mdtyrL3+5ydWFf6LgIIYF41A+GdcmTKoREJUqlJAaFs9Ob0X
 AJ3gQBEyymegjsTASgEcr50AbAvW6hQRymBgDM4DufOsrk4KUXP8UpdsYHlYMeNIBjBx1UK
 0DyaQVGAxQCofAriLzSyg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262756>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5504-fetch-receive-strict.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 69ee13c..40c7557 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -115,4 +115,24 @@ test_expect_success 'push with transfer.fsckobjects' '
 	test_cmp exp act
 '
 
+cat >bogus-commit <<\EOF
+tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
+author Bugs Bunny 1234567890 +0000
+committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000
+
+This commit object intentionally broken
+EOF
+
+test_expect_success 'push with receive.fsck.warn = missing-email' '
+	commit="$(git hash-object -t commit -w --stdin < bogus-commit)" &&
+	git push . $commit:refs/heads/bogus &&
+	rm -rf dst &&
+	git init dst &&
+	git --git-dir=dst/.git config receive.fsckobjects true &&
+	test_must_fail git push --porcelain dst bogus &&
+	git --git-dir=dst/.git config receive.fsck.warn missing-email &&
+	git push --porcelain dst bogus >act 2>&1 &&
+	grep "missing-email" act
+'
+
 test_done
-- 
2.2.0.33.gc18b867
