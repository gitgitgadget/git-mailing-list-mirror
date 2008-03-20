From: Kevin Ballard <kevin@sb.org>
Subject: [PATCH resend 2/2] Don't try and percent-escape existing percent escapes in git-svn URIs
Date: Thu, 20 Mar 2008 16:08:49 -0400
Message-ID: <1206043729-61810-2-git-send-email-kevin@sb.org>
References: <1206043729-61810-1-git-send-email-kevin@sb.org>
Cc: Kevin Ballard <kevin@sb.org>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Mar 20 21:09:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcR51-0000Zq-HX
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 21:09:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755940AbYCTUIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 16:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755732AbYCTUIx
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 16:08:53 -0400
Received: from sd-green-bigip-81.dreamhost.com ([208.97.132.81]:39127 "EHLO
	randymail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754745AbYCTUIv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Mar 2008 16:08:51 -0400
Received: from localhost.localdomain (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a5.g.dreamhost.com (Postfix) with ESMTP id F40AD90C53;
	Thu, 20 Mar 2008 13:08:50 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.rc0.10.g0fd43
In-Reply-To: <1206043729-61810-1-git-send-email-kevin@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77685>

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
index bba22c1..0c2b791 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3665,7 +3665,7 @@ sub escape_uri_only {
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
1.5.5.rc0.10.g0fd43
