From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 15/21] git p4 test: use test_chmod for cygwin
Date: Sat, 26 Jan 2013 22:11:18 -0500
Message-ID: <1359256284-5660-16-git-send-email-pw@padd.com>
References: <1359256284-5660-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 27 04:16:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzIjn-0006WT-Mo
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 04:16:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755583Ab3A0DQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 22:16:31 -0500
Received: from honk.padd.com ([74.3.171.149]:58743 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755574Ab3A0DQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 22:16:28 -0500
Received: from arf.padd.com (unknown [50.52.174.88])
	by honk.padd.com (Postfix) with ESMTPSA id 95D4F2F3F;
	Sat, 26 Jan 2013 19:16:27 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id D0E1022838; Sat, 26 Jan 2013 22:16:24 -0500 (EST)
X-Mailer: git-send-email 1.8.1.1.517.gf5c753f
In-Reply-To: <1359256284-5660-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214666>

This test does a commit that is a pure mode change, submits
it to p4 but causes the submit to fail.  It verifies that
the state in p4 as well as the client directory are both
unmodified after the failed submit.

On cygwin, "chmod +x" does nothing, so use the test_chmod
function to modify the index directly too.

Also on cygwin, the executable bit cannot be seen in the
filesystem, so avoid that part of the test.  The checks of
p4 state are still valid, though.

Thanks-to: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9815-git-p4-submit-fail.sh | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/t/t9815-git-p4-submit-fail.sh b/t/t9815-git-p4-submit-fail.sh
index d2b7b3d..1243d96 100755
--- a/t/t9815-git-p4-submit-fail.sh
+++ b/t/t9815-git-p4-submit-fail.sh
@@ -405,8 +405,8 @@ test_expect_success 'cleanup chmod after submit cancel' '
 	git p4 clone --dest="$git" //depot &&
 	(
 		cd "$git" &&
-		chmod u+x text &&
-		chmod u-x text+x &&
+		test_chmod +x text &&
+		test_chmod -x text+x &&
 		git add text text+x &&
 		git commit -m "chmod texts" &&
 		echo n | test_expect_code 1 git p4 submit
@@ -415,10 +415,13 @@ test_expect_success 'cleanup chmod after submit cancel' '
 		cd "$cli" &&
 		test_path_is_file text &&
 		! p4 fstat -T action text &&
-		stat --format=%A text | egrep ^-r-- &&
 		test_path_is_file text+x &&
 		! p4 fstat -T action text+x &&
-		stat --format=%A text+x | egrep ^-r-x
+		if test_have_prereq NOT_CYGWIN
+		then
+			stat --format=%A text | egrep ^-r-- &&
+			stat --format=%A text+x | egrep ^-r-x
+		fi
 	)
 '
 
-- 
1.8.1.1.460.g6fa8886
