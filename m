From: benoit.person@ensimag.fr
Subject: [PATCH v4 2/5] git-remote-mediawiki: new git bin-wrapper for developement
Date: Thu, 20 Jun 2013 09:16:30 +0200
Message-ID: <1371712593-6210-3-git-send-email-benoit.person@ensimag.fr>
References: <1371712593-6210-1-git-send-email-benoit.person@ensimag.fr>
Cc: Celestin Matte <celestin.matte@ensimag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Benoit Person <benoit.person@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 20 09:17:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpZ7T-0001NZ-W9
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 09:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754020Ab3FTHRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 03:17:20 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45970 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751921Ab3FTHRS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 03:17:18 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5K7HGLx020720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 20 Jun 2013 09:17:16 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5K7HGZF008348;
	Thu, 20 Jun 2013 09:17:16 +0200
Received: from localhost.localdomain (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5K7H093011528;
	Thu, 20 Jun 2013 09:17:16 +0200
X-Mailer: git-send-email 1.8.3.GIT
In-Reply-To: <1371712593-6210-1-git-send-email-benoit.person@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 20 Jun 2013 09:17:16 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228440>

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
 contrib/mw-to-git/git | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100755 contrib/mw-to-git/git

diff --git a/contrib/mw-to-git/git b/contrib/mw-to-git/git
new file mode 100755
index 0000000..25b60ad
--- /dev/null
+++ b/contrib/mw-to-git/git
@@ -0,0 +1,25 @@
+#!/bin/sh
+
+# git executable wrapper script for Git-Mediawiki to run tests without
+# installing all the scripts and perl packages.
+
+# based on $GIT_ROOT_DIR/wrap-for-bin.sh
+
+
+GIT_ROOT_DIR=../..
+GIT_EXEC_PATH=$(cd "$(dirname "$0")" && cd ${GIT_ROOT_DIR} && pwd)
+
+if test -n "$NO_SET_GIT_TEMPLATE_DIR"
+then
+	unset GIT_TEMPLATE_DIR
+else
+	GIT_TEMPLATE_DIR="$GIT_EXEC_PATH"'/templates/blt'
+	export GIT_TEMPLATE_DIR
+fi
+# Hack to make the `use lib` call works with multiple paths
+GITPERLLIB="$GIT_EXEC_PATH"'/contrib/mw-to-git:'"$GIT_EXEC_PATH"'/perl/blib/lib'
+GIT_TEXTDOMAINDIR="$GIT_EXEC_PATH"'/po/build/locale'
+PATH="$GIT_EXEC_PATH"'/contrib/mw-to-git:'"$GIT_EXEC_PATH"'/bin-wrappers:'"$PATH"
+export GIT_EXEC_PATH GITPERLLIB PATH GIT_TEXTDOMAINDIR
+
+exec "${GIT_EXEC_PATH}/git" "$@"
\ No newline at end of file
-- 
1.8.3.GIT
