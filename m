From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 15/19] git-check-attr: Error out if no pathnames are specified
Date: Tue, 26 Jul 2011 16:12:58 +0200
Message-ID: <1311689582-3116-16-git-send-email-mhagger@alum.mit.edu>
References: <1311689582-3116-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 16:35:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlijJ-0006hz-3a
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 16:35:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424Ab1GZOfY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 10:35:24 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:40370 "EHLO
	homer.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753079Ab1GZOfW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 10:35:22 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1QliM6-0004aQ-Sl; Tue, 26 Jul 2011 16:11:30 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1311689582-3116-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177886>

If no pathnames are passed as command-line arguments and the --stdin
option is not specified, fail with the error message "No file
specified".  Add tests of this behavior.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

The documentation seems to require at least one pathname, and other
git commands seem to insist on pathname lists not being empty.  Add a
similar test to git-check-attr.  If it is considered likely that
people depend on the current behavior, I have no problem with skipping
this patch.

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
