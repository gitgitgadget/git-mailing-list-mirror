From: benoit.person@ensimag.fr
Subject: [PATCH v7 3/7] git-remote-mediawiki: New git bin-wrapper for developement
Date: Wed,  3 Jul 2013 00:39:45 +0200
Message-ID: <1372804789-12732-4-git-send-email-benoit.person@ensimag.fr>
References: <1372804789-12732-1-git-send-email-benoit.person@ensimag.fr>
Cc: Celestin Matte <celestin.matte@ensimag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Benoit Person <benoit.person@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 03 00:52:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu9Qc-0000tX-Br
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 00:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755394Ab3GBWv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 18:51:57 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35570 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755056Ab3GBWlg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 18:41:36 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r62MfOTv001882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 3 Jul 2013 00:41:25 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r62MfRgN021154;
	Wed, 3 Jul 2013 00:41:27 +0200
Received: from localhost.localdomain (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r62MfMNd024530;
	Wed, 3 Jul 2013 00:41:27 +0200
X-Mailer: git-send-email 1.8.3.1.590.gc07d91b
In-Reply-To: <1372804789-12732-1-git-send-email-benoit.person@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 03 Jul 2013 00:41:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r62MfOTv001882
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: benoit.person@ensimag.fr
MailScanner-NULL-Check: 1373409685.48047@I8EOntUT2L+vsjkPaZY9Xg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229443>

From: Benoit Person <benoit.person@ensimag.fr>

The introduction of the Git::Mediawiki package makes it impossible to test,
without installation, git-remote-mediawiki and git-mw.

Using a git bin-wrapper enables us to define proper $GITPERLLIB to force the
use of the developement version of the Git::Mediawiki package, bypassing its
installed version if any.

An alternate solution was to 'install' all the files required at each build
but it pollutes the toplevel with untracked files.

Signed-off-by: Benoit Person <benoit.person@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/Makefile        |  6 ++++++
 contrib/mw-to-git/bin-wrapper/git | 14 ++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100755 contrib/mw-to-git/bin-wrapper/git

diff --git a/contrib/mw-to-git/Makefile b/contrib/mw-to-git/Makefile
index a6f8b24..c5e66df 100644
--- a/contrib/mw-to-git/Makefile
+++ b/contrib/mw-to-git/Makefile
@@ -2,6 +2,12 @@
 # Copyright (C) 2013
 #     Matthieu Moy <Matthieu.Moy@imag.fr>
 #
+# To build and test:
+#
+#   make:
+#     bin-wrapper/git mw preview Some_page.mw
+#     bin-wrapper/git clone mediawiki::http://example.com/wiki/
+#
 # To install, run Git's toplevel 'make install' then run:
 #
 #   make install
diff --git a/contrib/mw-to-git/bin-wrapper/git b/contrib/mw-to-git/bin-wrapper/git
new file mode 100755
index 0000000..1aa51f7
--- /dev/null
+++ b/contrib/mw-to-git/bin-wrapper/git
@@ -0,0 +1,14 @@
+#!/bin/sh
+
+# git executable wrapper script for Git-Mediawiki to run tests without
+# installing all the scripts and perl packages.
+
+GIT_ROOT_DIR=../../..
+GIT_EXEC_PATH=$(cd "$(dirname "$0")" && cd ${GIT_ROOT_DIR} && pwd)
+
+GITPERLLIB="$GIT_EXEC_PATH"'/contrib/mw-to-git:'"$GITPERLLIB"
+PATH="$GIT_EXEC_PATH"'/contrib/mw-to-git:'"$PATH"
+
+export GITPERLLIB PATH
+
+exec "${GIT_EXEC_PATH}/bin-wrappers/git" "$@"
-- 
1.8.3.1.590.gc07d91b
