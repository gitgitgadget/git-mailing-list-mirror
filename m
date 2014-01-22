From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 02/11] git p4 test: ensure p4 symlink parsing works
Date: Wed, 22 Jan 2014 17:47:20 -0500
Message-ID: <1390430849-11436-2-git-send-email-pw@padd.com>
References: <20140122224421.GB4047@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 22 23:47:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W66aS-0005T1-4x
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 23:47:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522AbaAVWrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 17:47:52 -0500
Received: from honk.padd.com ([74.3.171.149]:42253 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752808AbaAVWrw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 17:47:52 -0500
Received: from arf.padd.com (unknown [50.105.0.78])
	by honk.padd.com (Postfix) with ESMTPSA id CDD55712D;
	Wed, 22 Jan 2014 14:47:51 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 40E85200AB; Wed, 22 Jan 2014 17:47:49 -0500 (EST)
X-Mailer: git-send-email 1.8.5.2.364.g6ac45cd
In-Reply-To: <20140122224421.GB4047@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240873>

While this happens to work, there was no test to make sure
that the basic importing of a symlink from p4 to git functioned.

Add a simple test to create a symlink in p4 and import it into git,
then verify that the symlink exists and has the correct target.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9802-git-p4-filetype.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t9802-git-p4-filetype.sh b/t/t9802-git-p4-filetype.sh
index a82744b..94d7be9 100755
--- a/t/t9802-git-p4-filetype.sh
+++ b/t/t9802-git-p4-filetype.sh
@@ -250,6 +250,23 @@ test_expect_success 'ignore apple' '
 	)
 '
 
+test_expect_success SYMLINKS 'create p4 symlink' '
+	cd "$cli" &&
+	ln -s symlink-target symlink &&
+	p4 add symlink &&
+	p4 submit -d "add symlink"
+'
+
+test_expect_success SYMLINKS 'ensure p4 symlink parsed correctly' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot@all &&
+	(
+		cd "$git" &&
+		test -L symlink &&
+		test $(readlink symlink) = symlink-target
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
1.8.5.2.364.g6ac45cd
