From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 2/3] git p4 test: should honor symlink in p4 client root
Date: Thu,  7 Mar 2013 18:19:16 -0500
Message-ID: <1362698357-7334-3-git-send-email-pw@padd.com>
References: <20130307091317.GY7738@serenity.lan>
 <1362698357-7334-1-git-send-email-pw@padd.com>
Cc: =?UTF-8?q?Mikl=C3=B3s=20Fazekas?= <mfazekas@szemafor.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 08 00:20:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDk6v-0004ED-K5
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 00:20:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759946Ab3CGXUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 18:20:01 -0500
Received: from honk.padd.com ([74.3.171.149]:58040 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755660Ab3CGXUA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 18:20:00 -0500
Received: from arf.padd.com (unknown [50.55.138.130])
	by honk.padd.com (Postfix) with ESMTPSA id 274135B67;
	Thu,  7 Mar 2013 15:20:00 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 08D7423D3B; Thu,  7 Mar 2013 18:19:57 -0500 (EST)
X-Mailer: git-send-email 1.8.2.rc2.64.g8335025
In-Reply-To: <1362698357-7334-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217628>

This test fails when the p4 client root includes
a symlink.  It complains:

    Path /vol/bar/projects/foo/... is not under client root /p/foo

and dumps a traceback.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9808-git-p4-chdir.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/t9808-git-p4-chdir.sh b/t/t9808-git-p4-chdir.sh
index 55c5e36..af8bd8a 100755
--- a/t/t9808-git-p4-chdir.sh
+++ b/t/t9808-git-p4-chdir.sh
@@ -56,6 +56,33 @@ test_expect_success 'p4 client root would be relative due to clone --dest' '
 	)
 '
 
+# When the p4 client Root is a symlink, make sure chdir() does not use
+# getcwd() to convert it to a physical path.
+test_expect_failure 'p4 client root symlink should stay symbolic' '
+	physical="$TRASH_DIRECTORY/physical" &&
+	symbolic="$TRASH_DIRECTORY/symbolic" &&
+	test_when_finished "rm -rf \"$physical\"" &&
+	test_when_finished "rm \"$symbolic\"" &&
+	mkdir -p "$physical" &&
+	ln -s "$physical" "$symbolic" &&
+	test_when_finished cleanup_git &&
+	(
+		P4CLIENT=client-sym &&
+		p4 client -i <<-EOF &&
+		Client: $P4CLIENT
+		Description: $P4CLIENT
+		Root: $symbolic
+		LineEnd: unix
+		View: //depot/... //$P4CLIENT/...
+		EOF
+		git p4 clone --dest="$git" //depot &&
+		cd "$git" &&
+		test_commit file2 &&
+		git config git-p4.skipSubmitEdit true &&
+		git p4 submit
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
1.8.2.rc2.64.g8335025
