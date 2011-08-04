From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 19/23] git-check-attr: Error out if no pathnames are specified
Date: Thu,  4 Aug 2011 06:36:29 +0200
Message-ID: <1312432593-9841-20-git-send-email-mhagger@alum.mit.edu>
References: <1312432593-9841-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 06:37:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qopgs-0005WA-Ob
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 06:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856Ab1HDEhn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 00:37:43 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:39681 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab1HDEhG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 00:37:06 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB339.dip.t-dialin.net [84.190.179.57])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p744agHx029203;
	Thu, 4 Aug 2011 06:37:03 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1312432593-9841-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178686>

If no pathnames are passed as command-line arguments and the --stdin
option is not specified, fail with the error message "No file
specified".  Add tests of this behavior.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/check-attr.c  |    9 +++++++--
 t/t0003-attributes.sh |    2 ++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index e9b827f..6cf6421 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -111,8 +111,13 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 	}
 
 	/* Check file argument(s): */
-	if (stdin_paths && filei < argc)
-		error_with_usage("Can't specify files with --stdin");
+	if (stdin_paths) {
+		if (filei < argc)
+			error_with_usage("Can't specify files with --stdin");
+	} else {
+		if (filei >= argc)
+			error_with_usage("No file specified");
+	}
 
 	check = xcalloc(cnt, sizeof(*check));
 	for (i = 0; i < cnt; i++) {
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index f1debeb..2254005 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -46,6 +46,8 @@ test_expect_success 'command line checks' '
 
 	test_must_fail git check-attr &&
 	test_must_fail git check-attr -- &&
+	test_must_fail git check-attr test &&
+	test_must_fail git check-attr test -- &&
 	test_must_fail git check-attr -- f &&
 	echo "f" | test_must_fail git check-attr --stdin &&
 	echo "f" | test_must_fail git check-attr --stdin -- f &&
-- 
1.7.6.8.gd2879
