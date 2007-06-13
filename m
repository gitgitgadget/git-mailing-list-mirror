From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/3] git-svn: test for creating new directories over svn://
Date: Wed, 13 Jun 2007 02:37:04 -0700
Message-ID: <11817274282332-git-send-email-normalperson@yhbt.net>
References: <11817274254011-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 11:37:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyPIB-0001YO-RG
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 11:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756930AbXFMJhN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 05:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756819AbXFMJhM
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 05:37:12 -0400
Received: from hand.yhbt.net ([66.150.188.102]:49932 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756859AbXFMJhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 05:37:09 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 33F297DC0A6;
	Wed, 13 Jun 2007 02:37:08 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 13 Jun 2007 02:37:08 -0700
X-Mailer: git-send-email 1.5.2.1.243.gbe00
In-Reply-To: <11817274254011-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50039>

As reported by Matthieu Moy, this is causing svnserve to
terminate connections (because it segfaults) segfault.

This test is disabled by default and can be enabled by setting
SVNSERVE_PORT to an unbound (for 127.0.0.1) TCP port in the
environment (in addition to SVN_TESTS=1).  I'm not comfortable
with having a test start a daemon by default and take up a port
that could potentially stay running if the test failed.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 t/t9113-git-svn-dcommit-new-file.sh |   40 +++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)
 create mode 100755 t/t9113-git-svn-dcommit-new-file.sh

diff --git a/t/t9113-git-svn-dcommit-new-file.sh b/t/t9113-git-svn-dcommit-new-file.sh
new file mode 100755
index 0000000..9ef0db9
--- /dev/null
+++ b/t/t9113-git-svn-dcommit-new-file.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Eric Wong
+#
+
+# Don't run this test by default unless the user really wants it
+# I don't like the idea of taking a port and possibly leaving a
+# daemon running on a users system if the test fails.
+# Not all git users will need to interact with SVN.
+test -z "$SVNSERVE_PORT" && exit 0
+
+test_description='git-svn dcommit new files over svn:// test'
+
+. ./lib-git-svn.sh
+
+start_svnserve () {
+	svnserve --listen-port $SVNSERVE_PORT \
+	         --root $rawsvnrepo \
+	         --listen-once \
+	         --listen-host 127.0.0.1 &
+}
+
+test_expect_success 'start tracking an empty repo' "
+	svn mkdir -m 'empty dir' $svnrepo/empty-dir &&
+	echo anon-access = write >> $rawsvnrepo/conf/svnserve.conf &&
+	start_svnserve &&
+	git svn init svn://127.0.0.1:$SVNSERVE_PORT &&
+	git svn fetch
+	"
+
+test_expect_success 'create files in new directory with dcommit' "
+	mkdir git-new-dir &&
+	echo hello > git-new-dir/world &&
+	git update-index --add git-new-dir/world &&
+	git commit -m hello &&
+	start_svnserve &&
+	git svn dcommit
+	"
+
+test_done
-- 
1.5.2.1.243.gbe00
