From: Mark Rada <marada@uwaterloo.ca>
Subject: Subject: [PATCH 4/6] instaweb: add minification awareness
Date: Fri, 02 Apr 2010 20:36:23 -0400
Message-ID: <4BB68D87.5070100@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 03 02:36:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxrLm-00084t-H0
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 02:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754019Ab0DCAgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 20:36:31 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:37844 "EHLO
	mailchk-m04.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753918Ab0DCAg2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Apr 2010 20:36:28 -0400
Received: from karakura.local (bas1-toronto01-1177657512.dsl.bell.ca [70.49.160.168])
	(authenticated bits=0)
	by mailchk-m04.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id o330aN56000680
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 2 Apr 2010 20:36:24 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
X-UUID: e4202ca1-d8cf-469e-993f-aa9ca9037797
X-Miltered: at mailchk-m04 with ID 4BB68D87.001 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.2 at mailchk-m04
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m04.uwaterloo.ca [129.97.128.141]); Fri, 02 Apr 2010 20:36:26 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143871>

This patch will cause git-instaweb to use the minified version of gitweb
support files (e.g. CSS and JavaScript) if they were generated.

Without minification awareness, generating the minified version of
gitweb's support files will generate a broken instaweb script since the
copy of gitweb.cgi will look for gitweb.min.* which will not exist.

Signed-off-by: Mark Rada <marada@uwaterloo.ca>

---

	No changes since last revision.


 Makefile        |   12 ++++++++++--
 git-instaweb.sh |    6 ++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 4a6bc62..af597f7 100644
--- a/Makefile
+++ b/Makefile
@@ -1567,9 +1567,15 @@ gitweb:
 
 ifdef JSMIN
 GITWEB_PROGRAMS += gitweb/gitweb.min.js
+GITWEB_JS = gitweb/gitweb.min.js
+else
+GITWEB_JS = gitweb/gitweb.js
 endif
 ifdef CSSMIN
 GITWEB_PROGRAMS += gitweb/gitweb.min.css
+GITWEB_CSS = gitweb/gitweb.min.css
+else
+GITWEB_CSS = gitweb/gitweb.css
 endif
 OTHER_PROGRAMS +=  gitweb/gitweb.cgi  $(GITWEB_PROGRAMS)
 gitweb/gitweb.cgi: gitweb/gitweb.perl $(GITWEB_PROGRAMS)
@@ -1592,11 +1598,13 @@ git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css gitweb/gitweb.
 	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
 	    -e '/@@GITWEB_CGI@@/r gitweb/gitweb.cgi' \
 	    -e '/@@GITWEB_CGI@@/d' \
-	    -e '/@@GITWEB_CSS@@/r gitweb/gitweb.css' \
+	    -e '/@@GITWEB_CSS@@/r $(GITWEB_CSS)' \
 	    -e '/@@GITWEB_CSS@@/d' \
-	    -e '/@@GITWEB_JS@@/r gitweb/gitweb.js' \
+	    -e '/@@GITWEB_JS@@/r $(GITWEB_JS)' \
 	    -e '/@@GITWEB_JS@@/d' \
 	    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
+            -e 's|@@GITWEB_CSS_NAME@@|$(GITWEB_CSS)|' \
+            -e 's|@@GITWEB_JS_NAME@@|$(GITWEB_JS)|' \
 	    $@.sh > $@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
diff --git a/git-instaweb.sh b/git-instaweb.sh
index 6a65f25..d4941a9 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -391,18 +391,20 @@ EOFGITWEB
 gitweb_css () {
 	cat > "$1" <<\EOFGITWEB
 @@GITWEB_CSS@@
+
 EOFGITWEB
 }
 
 gitweb_js () {
 	cat > "$1" <<\EOFGITWEB
 @@GITWEB_JS@@
+
 EOFGITWEB
 }
 
 gitweb_cgi "$GIT_DIR/gitweb/gitweb.cgi"
-gitweb_css "$GIT_DIR/gitweb/gitweb.css"
-gitweb_js  "$GIT_DIR/gitweb/gitweb.js"
+gitweb_css "$GIT_DIR/@@GITWEB_CSS_NAME@@"
+gitweb_js  "$GIT_DIR/@@GITWEB_JS_NAME@@"
 
 case "$httpd" in
 *lighttpd*)
-- 
1.7.0.3.519.g7e0613
