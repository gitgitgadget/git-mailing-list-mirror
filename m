From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] git-gui: Use shell to launch textconv filter in "blame"
Date: Thu,  5 Aug 2010 12:05:22 +0200
Message-ID: <1281002722-3042-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqlj8l2xd5.fsf@bauges.imag.fr>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Kirill Smelkov <kirr@landau.phys.spbu.ru>,
	=?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 05 12:06:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgxLf-0004LE-49
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 12:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760063Ab0HEKGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 06:06:46 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36053 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755601Ab0HEKGo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 06:06:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o75A3LH4002827
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 5 Aug 2010 12:03:21 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OgxKN-0007uE-Ig; Thu, 05 Aug 2010 12:05:31 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OgxKN-0000nh-HH; Thu, 05 Aug 2010 12:05:31 +0200
X-Mailer: git-send-email 1.7.2.1.30.g18195
In-Reply-To: <vpqlj8l2xd5.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 05 Aug 2010 12:03:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o75A3LH4002827
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1281607406.92744@Tnn2XgjXpZdHZfmHOcVKgA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152630>

This allows one to use textconv commands with arguments.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 git-gui/Makefile      |    1 +
 git-gui/git-gui.sh    |    6 ++++++
 git-gui/lib/blame.tcl |    4 +++-
 3 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/git-gui/Makefile b/git-gui/Makefile
index 197b55e..e22ba5c 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -215,6 +215,7 @@ endif
 $(GITGUI_MAIN): git-gui.sh GIT-VERSION-FILE GIT-GUI-VARS
 	$(QUIET_GEN)rm -f $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
+		-e 's|@@SHELL_PATH@@|$(SHELL_PATH_SQ)|' \
 		-e '1,30s|^ argv0=$$0| argv0=$(GITGUI_SCRIPT)|' \
 		-e '1,30s|^ exec wish | exec '\''$(TCLTK_PATH_SED)'\'' |' \
 		-e 's/@@GITGUI_VERSION@@/$(GITGUI_VERSION)/g' \
diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index bb10489..9049abf 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -128,6 +128,7 @@ set _githtmldir {}
 set _reponame {}
 set _iscygwin {}
 set _search_path {}
+set _shellpath {@@SHELL_PATH@@}
 
 set _trace [lsearch -exact $argv --trace]
 if {$_trace >= 0} {
@@ -137,6 +138,11 @@ if {$_trace >= 0} {
 	set _trace 0
 }
 
+proc shellpath {} {
+	global _shellpath
+	return $_shellpath
+}
+
 proc appname {} {
 	global _appname
 	return $_appname
diff --git a/git-gui/lib/blame.tcl b/git-gui/lib/blame.tcl
index 2137ec9..77656d3 100644
--- a/git-gui/lib/blame.tcl
+++ b/git-gui/lib/blame.tcl
@@ -460,7 +460,9 @@ method _load {jump} {
 	}
 	if {$commit eq {}} {
 		if {$do_textconv ne 0} {
-			set fd [open |[list $textconv $path] r]
+			# Run textconv with sh -c "..." to allow it to
+			# contain command + arguments.
+			set fd [open |[list [shellpath] -c "$textconv \"\$0\"" $path] r]
 		} else {
 			set fd [open $path r]
 		}
-- 
1.7.2.1.30.g18195
