From: Kevin Ballard <kevin@sb.org>
Subject: [PATCH] Don't try and percent-escape existing percent escapes in git-svn URIs
Date: Sat,  8 Mar 2008 18:20:47 -0500
Message-ID: <1205018447-18344-1-git-send-email-kevin@sb.org>
Cc: Kevin Ballard <kevin@sb.org>, git@vger.kernel.org
To: normalperson@yhbt.net
X-From: git-owner@vger.kernel.org Sun Mar 09 00:21:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY8M5-0004VX-1Z
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 00:21:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbYCHXUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 18:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbYCHXUu
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 18:20:50 -0500
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:34748 "EHLO
	randymail-a9.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751314AbYCHXUt (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Mar 2008 18:20:49 -0500
Received: from localhost.localdomain (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a9.g.dreamhost.com (Postfix) with ESMTP id B58B4EF344;
	Sat,  8 Mar 2008 15:20:48 -0800 (PST)
X-Mailer: git-send-email 1.5.4.3.487.g1eab2.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76616>

git-svn: project names are percent-escaped ever since f5530b.
Unfortunately this breaks the scenario where the user hands git-svn
an already-escaped URI. Fix the regexp to skip over what looks like
existing percent escapes, and test this scenario.

Signed-off-by: Kevin Ballard <kevin@sb.org>
---
 git-svn.perl                                  |    2 +-
 t/t9120-git-svn-clone-with-percent-escapes.sh |   31 +++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletions(-)
 create mode 100755 t/t9120-git-svn-clone-with-percent-escapes.sh

diff --git a/git-svn.perl b/git-svn.perl
index 9e2faf9..cec664f 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3658,7 +3658,7 @@ sub escape_uri_only {
 	my ($uri) = @_;
 	my @tmp;
 	foreach (split m{/}, $uri) {
-		s/([^\w.-])/sprintf("%%%02X",ord($1))/eg;
+		s/([^\w.%-]|%(?![a-fA-F0-9]{2}))/sprintf("%%%02X",ord($1))/eg;
 		push @tmp, $_;
 	}
 	join('/', @tmp);
diff --git a/t/t9120-git-svn-clone-with-percent-escapes.sh b/t/t9120-git-svn-clone-with-percent-escapes.sh
new file mode 100755
index 0000000..9a4eabe
--- /dev/null
+++ b/t/t9120-git-svn-clone-with-percent-escapes.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Kevin Ballard
+#
+
+test_description='git-svn clone with percent escapes'
+. ./lib-git-svn.sh
+
+test_expect_success 'setup svnrepo' "
+	mkdir project project/trunk project/branches project/tags &&
+	echo foo > project/trunk/foo &&
+	svn import -m '$test_description' project '$svnrepo/pr ject' &&
+	rm -rf project &&
+	start_httpd
+"
+
+if test "$SVN_HTTPD_PORT" = ""
+then
+	test_expect_failure 'test clone with percent escapes - needs SVN_HTTPD_PORT set' 'false'
+else
+	test_expect_success 'test clone with percent escapes' '
+		git svn clone "$svnrepo/pr%20ject" clone &&
+		cd clone &&
+			git rev-parse refs/remotes/git-svn &&
+		cd ..
+	'
+fi
+
+stop_httpd
+
+test_done
-- 
1.5.4.3.487.g1eab2.dirty

