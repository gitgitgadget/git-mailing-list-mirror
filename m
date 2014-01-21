From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 04/11] git p4 test: explicitly check p4 wildcard delete
Date: Tue, 21 Jan 2014 18:16:41 -0500
Message-ID: <1390346208-9207-5-git-send-email-pw@padd.com>
References: <1390346208-9207-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 22 00:18:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5kaG-0001jq-5l
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 00:18:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506AbaAUXSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 18:18:12 -0500
Received: from honk.padd.com ([74.3.171.149]:46541 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753373AbaAUXSL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 18:18:11 -0500
Received: from arf.padd.com (unknown [50.105.0.78])
	by honk.padd.com (Postfix) with ESMTPSA id 2B78C7112;
	Tue, 21 Jan 2014 15:18:11 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 92DBD200F7; Tue, 21 Jan 2014 18:18:08 -0500 (EST)
X-Mailer: git-send-email 1.8.5.2.364.g6ac45cd
In-Reply-To: <1390346208-9207-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240794>

There was no test where p4 deleted a file with a wildcard
character.  Make sure git p4 applies the wildcard decoding
properly when importing a delete that includes a wildcard.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9812-git-p4-wildcards.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/t9812-git-p4-wildcards.sh b/t/t9812-git-p4-wildcards.sh
index 6763325..f2ddbc5 100755
--- a/t/t9812-git-p4-wildcards.sh
+++ b/t/t9812-git-p4-wildcards.sh
@@ -161,6 +161,33 @@ test_expect_success 'wildcard files submit back to p4, delete' '
 	)
 '
 
+test_expect_success 'p4 deleted a wildcard file' '
+	(
+		cd "$cli" &&
+		echo "wild delete test" >wild@delete &&
+		p4 add -f wild@delete &&
+		p4 submit -d "add wild@delete"
+	) &&
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		test_path_is_file wild@delete
+	) &&
+	(
+		cd "$cli" &&
+		# must use its encoded name
+		p4 delete wild%40delete &&
+		p4 submit -d "delete wild@delete"
+	) &&
+	(
+		cd "$git" &&
+		git p4 sync &&
+		git merge --ff-only p4/master &&
+		test_path_is_missing wild@delete
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
1.8.5.2.320.g99957e5
