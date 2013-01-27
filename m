From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 05/21] git p4 test: avoid loop in client_view
Date: Sat, 26 Jan 2013 22:11:08 -0500
Message-ID: <1359256284-5660-6-git-send-email-pw@padd.com>
References: <1359256284-5660-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 27 04:13:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzIgU-0004vp-G0
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 04:13:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755486Ab3A0DNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 22:13:08 -0500
Received: from honk.padd.com ([74.3.171.149]:58700 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755415Ab3A0DNI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 22:13:08 -0500
Received: from arf.padd.com (unknown [50.52.174.88])
	by honk.padd.com (Postfix) with ESMTPSA id 40BC82F3F;
	Sat, 26 Jan 2013 19:13:07 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 5695122838; Sat, 26 Jan 2013 22:13:04 -0500 (EST)
X-Mailer: git-send-email 1.8.1.1.517.gf5c753f
In-Reply-To: <1359256284-5660-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214655>

The printf command re-interprets the format string as
long as there are arguments to consume.  Use this to
simplify a for loop in the client_view() library function.

This requires a fix to one of the client_view callers.
An errant \n in the string was converted into a harmless
newline in the input to "p4 client -i", but now shows up
as a literal \n as passed through by "%s".  Remove the \n.

Based-on-patch-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/lib-git-p4.sh               | 4 +---
 t/t9809-git-p4-client-view.sh | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 890ee60..b1dbded 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -121,8 +121,6 @@ client_view() {
 		Root: $cli
 		View:
 		EOF
-		for arg ; do
-			printf "\t$arg\n"
-		done
+		printf "\t%s\n" "$@"
 	) | p4 client -i
 }
diff --git a/t/t9809-git-p4-client-view.sh b/t/t9809-git-p4-client-view.sh
index 281be29..0b58fb9 100755
--- a/t/t9809-git-p4-client-view.sh
+++ b/t/t9809-git-p4-client-view.sh
@@ -196,7 +196,7 @@ test_expect_success 'exclusion single file' '
 
 test_expect_success 'overlay wildcard' '
 	client_view "//depot/dir1/... //client/cli/..." \
-		    "+//depot/dir2/... //client/cli/...\n" &&
+		    "+//depot/dir2/... //client/cli/..." &&
 	files="cli/file11 cli/file12 cli/file21 cli/file22" &&
 	client_verify $files &&
 	test_when_finished cleanup_git &&
-- 
1.8.1.1.460.g6fa8886
