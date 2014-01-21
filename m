From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 02/11] git p4 test: ensure p4 symlink parsing works
Date: Tue, 21 Jan 2014 18:16:39 -0500
Message-ID: <1390346208-9207-3-git-send-email-pw@padd.com>
References: <1390346208-9207-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 22 00:17:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5kZb-0001XP-I1
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 00:17:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382AbaAUXRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 18:17:32 -0500
Received: from honk.padd.com ([74.3.171.149]:46535 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752308AbaAUXRb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 18:17:31 -0500
Received: from arf.padd.com (unknown [50.105.0.78])
	by honk.padd.com (Postfix) with ESMTPSA id 317767112;
	Tue, 21 Jan 2014 15:17:31 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 81BBC200F7; Tue, 21 Jan 2014 18:17:28 -0500 (EST)
X-Mailer: git-send-email 1.8.5.2.364.g6ac45cd
In-Reply-To: <1390346208-9207-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240792>

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
1.8.5.2.320.g99957e5
