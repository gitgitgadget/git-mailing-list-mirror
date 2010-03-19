From: Mark Rada <marada@uwaterloo.ca>
Subject: [PATCHv2] instaweb: use minified gitweb.js if available
Date: Fri, 19 Mar 2010 15:16:04 -0400
Message-ID: <4BA3CD74.4050603@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 19 20:16:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NshgW-0000Z6-LF
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 20:16:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065Ab0CSTQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 15:16:35 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:60561 "EHLO
	mailchk-m05.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750966Ab0CSTQe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Mar 2010 15:16:34 -0400
Received: from karakura.local (static-66-225-153-161.ptr.terago.net [66.225.153.161])
	(authenticated bits=0)
	by mailchk-m05.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id o2JJG5Cs025371
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 19 Mar 2010 15:16:06 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
X-UUID: d4ab888a-c849-4369-80f6-8838f39f9c7c
X-Miltered: at mailchk-m05 with ID 4BA3CD75.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.2 at mailchk-m05
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m05.uwaterloo.ca [129.97.128.141]); Fri, 19 Mar 2010 15:16:08 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142636>

Makes git-instaweb use gitweb.min.js if it was generated.

Signed-off-by: Mark Rada <marada@uwaterloo.ca>

---

Changes since v1:
	- Updates name of javascript file instaweb creates
	  instead of changing the the copy of gitweb.cgi
	  that embeds.


 Makefile        |   11 ++++++-----
 git-instaweb.sh |    3 ++-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 7c616f8..f80b25e 100644
--- a/Makefile
+++ b/Makefile
@@ -1551,12 +1551,12 @@ gitweb:
 	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) all
 
 ifdef JSMIN
-OTHER_PROGRAMS += gitweb/gitweb.cgi   gitweb/gitweb.min.js
-gitweb/gitweb.cgi: gitweb/gitweb.perl gitweb/gitweb.min.js
+GITWEB_JS=gitweb/gitweb.min.js
 else
-OTHER_PROGRAMS += gitweb/gitweb.cgi
-gitweb/gitweb.cgi: gitweb/gitweb.perl
+GITWEB_JS=gitweb/gitweb.js
 endif
+OTHER_PROGRAMS += gitweb/gitweb.cgi $(GITWEB_JS)
+gitweb/gitweb.cgi: gitweb/gitweb.perl $(GITWEB_PROGRAMS)
 	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) $(patsubst gitweb/%,%,$@)
 
 ifdef JSMIN
@@ -1574,8 +1574,9 @@ git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css gitweb/gitweb.
 	    -e '/@@GITWEB_CGI@@/d' \
 	    -e '/@@GITWEB_CSS@@/r gitweb/gitweb.css' \
 	    -e '/@@GITWEB_CSS@@/d' \
-	    -e '/@@GITWEB_JS@@/r gitweb/gitweb.js' \
+	    -e '/@@GITWEB_JS@@/r $(GITWEB_JS)' \
 	    -e '/@@GITWEB_JS@@/d' \
+	    -e 's|@@GITWEB_JS_NAME@@|$(GITWEB_JS)|' \
 	    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
 	    $@.sh > $@+ && \
 	chmod +x $@+ && \
diff --git a/git-instaweb.sh b/git-instaweb.sh
index 6a65f25..b2fb7f0 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -397,12 +397,13 @@ EOFGITWEB
 gitweb_js () {
 	cat > "$1" <<\EOFGITWEB
 @@GITWEB_JS@@
+
 EOFGITWEB
 }
 
 gitweb_cgi "$GIT_DIR/gitweb/gitweb.cgi"
 gitweb_css "$GIT_DIR/gitweb/gitweb.css"
-gitweb_js  "$GIT_DIR/gitweb/gitweb.js"
+gitweb_js  "$GIT_DIR/@@GITWEB_JS_NAME@@"
 
 case "$httpd" in
 *lighttpd*)
-- 
1.7.0.2.279.gf1ba1c
