From: Jeff King <peff@peff.net>
Subject: [PATCHv2] tests: handle NO_PYTHON setting
Date: Mon, 7 Dec 2009 00:32:50 -0500
Message-ID: <20091207053250.GA32262@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 06:33:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHWDt-0006Ax-NM
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 06:33:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766AbZLGFcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 00:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752168AbZLGFcw
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 00:32:52 -0500
Received: from peff.net ([208.65.91.99]:39791 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751520AbZLGFcp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 00:32:45 -0500
Received: (qmail 812 invoked by uid 107); 7 Dec 2009 05:37:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 07 Dec 2009 00:37:22 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Dec 2009 00:32:50 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134713>

Without this, test-lib checks that the git_remote_helpers
directory has been built. However, if we are building
without python, we will not have done anything at all in
that directory, and test-lib's sanity check will fail.

We bump the inclusion of GIT-BUILD-OPTIONS further up in
test-lib; it contains configuration, and as such should be
read before we do any checks (and in this particular case,
we need its value to do our check properly).

Signed-off-by: Jeff King <peff@peff.net>
Looks-fine-to-me-by: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Acked-by: Johan Herland <johan@herland.net>
---
On top of sr/vcs-helper.

Just a repost with acks, as the original seems to have been forgotten in
the ensuing discussion of directory structure.

 Makefile      |    1 +
 t/test-lib.sh |    6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 42744a4..443565e 100644
--- a/Makefile
+++ b/Makefile
@@ -1743,6 +1743,7 @@ GIT-BUILD-OPTIONS: .FORCE-GIT-BUILD-OPTIONS
 	@echo TAR=\''$(subst ','\'',$(subst ','\'',$(TAR)))'\' >>$@
 	@echo NO_CURL=\''$(subst ','\'',$(subst ','\'',$(NO_CURL)))'\' >>$@
 	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@
+	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@
 
 ### Detect Tck/Tk interpreter path changes
 ifndef NO_TCLTK
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4a40520..2d523fe 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -632,13 +632,15 @@ GIT_CONFIG_NOSYSTEM=1
 GIT_CONFIG_NOGLOBAL=1
 export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_CONFIG_NOGLOBAL
 
+. ../GIT-BUILD-OPTIONS
+
 GITPERLLIB=$(pwd)/../perl/blib/lib:$(pwd)/../perl/blib/arch/auto/Git
 export GITPERLLIB
 test -d ../templates/blt || {
 	error "You haven't built things yet, have you?"
 }
 
-if test -z "$GIT_TEST_INSTALLED"
+if test -z "$GIT_TEST_INSTALLED" && test -z "$NO_PYTHON"
 then
 	GITPYTHONLIB="$(pwd)/../git_remote_helpers/build/lib"
 	export GITPYTHONLIB
@@ -653,8 +655,6 @@ if ! test -x ../test-chmtime; then
 	exit 1
 fi
 
-. ../GIT-BUILD-OPTIONS
-
 # Test repository
 test="trash directory.$(basename "$0" .sh)"
 test -n "$root" && test="$root/$test"
-- 
1.6.6.rc1.292.gd8fe.dirty
