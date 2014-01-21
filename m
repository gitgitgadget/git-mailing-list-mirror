From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 08/11] git p4: handle files with wildcards when doing RCS scrubbing
Date: Tue, 21 Jan 2014 18:16:45 -0500
Message-ID: <1390346208-9207-9-git-send-email-pw@padd.com>
References: <1390346208-9207-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 22 00:19:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5kbX-0002Ey-HZ
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 00:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753519AbaAUXTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 18:19:32 -0500
Received: from honk.padd.com ([74.3.171.149]:36959 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752067AbaAUXTb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 18:19:31 -0500
Received: from arf.padd.com (unknown [50.105.0.78])
	by honk.padd.com (Postfix) with ESMTPSA id 451897112;
	Tue, 21 Jan 2014 15:19:31 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id B87CA200F7; Tue, 21 Jan 2014 18:19:28 -0500 (EST)
X-Mailer: git-send-email 1.8.5.2.364.g6ac45cd
In-Reply-To: <1390346208-9207-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240798>

Commit 9d7d446 (git p4: submit files with wildcards, 2012-04-29)
fixed problems with handling files that had p4 wildcard
characters, like "@" and "*".  But it missed one case, that of
RCS keyword scrubbing, which uses "p4 fstat" to extract type
information.  Fix it by calling wildcard_encode() on the raw
filename.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py                   |  4 ++--
 t/t9812-git-p4-wildcards.sh | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index a4414b5..26b874f 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -310,8 +310,8 @@ def split_p4_type(p4type):
 #
 # return the raw p4 type of a file (text, text+ko, etc)
 #
-def p4_type(file):
-    results = p4CmdList(["fstat", "-T", "headType", file])
+def p4_type(f):
+    results = p4CmdList(["fstat", "-T", "headType", wildcard_encode(f)])
     return results[0]['headType']
 
 #
diff --git a/t/t9812-git-p4-wildcards.sh b/t/t9812-git-p4-wildcards.sh
index f2ddbc5..c7472cb 100755
--- a/t/t9812-git-p4-wildcards.sh
+++ b/t/t9812-git-p4-wildcards.sh
@@ -188,6 +188,29 @@ test_expect_success 'p4 deleted a wildcard file' '
 	)
 '
 
+test_expect_success 'wildcard files requiring keyword scrub' '
+	(
+		cd "$cli" &&
+		cat <<-\EOF >scrub@wild &&
+		$Id$
+		line2
+		EOF
+		p4 add -t text+k -f scrub@wild &&
+		p4 submit -d "scrub at wild"
+	) &&
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		git config git-p4.attemptRCSCleanup true &&
+		sed "s/^line2/line2 edit/" <scrub@wild >scrub@wild.tmp &&
+		mv -f scrub@wild.tmp scrub@wild &&
+		git commit -m "scrub at wild line2 edit" scrub@wild &&
+		git p4 submit
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
1.8.5.2.320.g99957e5
