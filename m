From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 08/11] git p4: handle files with wildcards when doing RCS scrubbing
Date: Wed, 22 Jan 2014 17:47:26 -0500
Message-ID: <1390430849-11436-8-git-send-email-pw@padd.com>
References: <20140122224421.GB4047@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 22 23:49:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W66cP-0006FE-4B
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 23:49:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756089AbaAVWtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 17:49:53 -0500
Received: from honk.padd.com ([74.3.171.149]:41862 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755234AbaAVWtw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 17:49:52 -0500
Received: from arf.padd.com (unknown [50.105.0.78])
	by honk.padd.com (Postfix) with ESMTPSA id 3D49C712D;
	Wed, 22 Jan 2014 14:49:52 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id A3FF0200AB; Wed, 22 Jan 2014 17:49:49 -0500 (EST)
X-Mailer: git-send-email 1.8.5.2.364.g6ac45cd
In-Reply-To: <20140122224421.GB4047@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240879>

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
index f0a327d..39a0fa0 100755
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
1.8.5.2.364.g6ac45cd
