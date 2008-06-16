From: Flavio Poletti <flavio@polettix.it>
Subject: [RFC/PATCH] git-instaweb: added logo and favicon
Date: Mon, 16 Jun 2008 04:46:31 +0200
Message-ID: <1213584391-29903-1-git-send-email-flavio@polettix.it>
Cc: normalperson@yhbt.net, Flavio Poletti <flavio@polettix.it>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 04:48:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K84lJ-0005aN-EH
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 04:48:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757955AbYFPCqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 22:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753927AbYFPCqq
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 22:46:46 -0400
Received: from [195.130.249.251] ([195.130.249.251]:40418 "HELO desantix.it"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with SMTP
	id S1757937AbYFPCqf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 22:46:35 -0400
Received: (qmail 25859 invoked by uid 511); 16 Jun 2008 03:00:01 -0000
Received: from localhost.localdomain (127.0.0.1)
  by localhost.localdomain with SMTP; 16 Jun 2008 03:00:01 -0000
X-Mailer: git-send-email 1.5.5.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85159>

Eye candy: logo and favicon are now included in the standard
deployments for git-instaweb.

Signed-off-by: Flavio Poletti <flavio@polettix.it>
---

I probably need a little help here to figure out how to make this
"portable". I've modified Makefile, but what when configure is
called by the end user instead of relying on this streamline
Makefile? I need some hints about where to look to make this
patch more robust regarding this.

Any suggestion is welcome, of course.

 Makefile        |   17 +++++++++++++++--
 git-instaweb.sh |   28 ++++++++++++++++++++++++++--
 2 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 1937507..1879a34 100644
--- a/Makefile
+++ b/Makefile
@@ -1104,8 +1104,16 @@ gitweb/gitweb.cgi: gitweb/gitweb.perl
 	chmod +x $@+ && \
 	mv $@+ $@
 
-git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css
-	$(QUIET_GEN)$(RM) $@ $@+ && \
+git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css gitweb/git-logo.png gitweb/git-favicon.png
+	$(QUIET_GEN)$(RM) $@ $@+ $@+logo $@+fav && \
+	'$(PERL_PATH_SQ)' <gitweb/git-logo.png >$@+logo -l \
+	    -e 'binmode STDIN;' \
+	    -e 'while(read(STDIN,$$x,16))' \
+	    -e '{print unpack"H*",$$x}' && \
+	'$(PERL_PATH_SQ)' <gitweb/git-favicon.png >$@+fav -l \
+	    -e 'binmode STDIN;' \
+	    -e 'while(read(STDIN,$$x,16))' \
+	    -e '{print unpack"H*",$$x}' && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
@@ -1113,8 +1121,13 @@ git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css
 	    -e '/@@GITWEB_CGI@@/d' \
 	    -e '/@@GITWEB_CSS@@/r gitweb/gitweb.css' \
 	    -e '/@@GITWEB_CSS@@/d' \
+	    -e '/@@GITWEB_LOGO@@/r $@+logo' \
+	    -e '/@@GITWEB_LOGO@@/d' \
+	    -e '/@@GITWEB_FAVICON@@/r $@+fav' \
+	    -e '/@@GITWEB_FAVICON@@/d' \
 	    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
 	    $@.sh > $@+ && \
+	rm $@+logo $@+fav && \
 	chmod +x $@+ && \
 	mv $@+ $@
 
diff --git a/git-instaweb.sh b/git-instaweb.sh
index af0fde5..782256c 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -268,8 +268,32 @@ gitweb_css () {
 EOFGITWEB
 }
 
-gitweb_cgi "$GIT_DIR/gitweb/gitweb.cgi"
-gitweb_css "$GIT_DIR/gitweb/gitweb.css"
+hex2bin () {
+   "$PERL" -e '
+      binmode STDOUT;
+      while (<STDIN>) {
+         chomp;
+         print pack "H*", $_;
+      }
+   '
+}
+
+gitweb_favicon () {
+   hex2bin > "$1" <<\EOFGITFAVICON
+@@GITWEB_FAVICON@@
+EOFGITFAVICON
+}
+
+gitweb_logo () {
+   hex2bin > "$1" <<\EOFGITLOGO
+@@GITWEB_LOGO@@
+EOFGITLOGO
+}
+
+gitweb_cgi     "$GIT_DIR/gitweb/gitweb.cgi"
+gitweb_css     "$GIT_DIR/gitweb/gitweb.css"
+gitweb_favicon "$GIT_DIR/gitweb/git-favicon.png"
+gitweb_logo    "$GIT_DIR/gitweb/git-logo.png"
 
 case "$httpd" in
 *lighttpd*)
-- 
1.5.5.4
