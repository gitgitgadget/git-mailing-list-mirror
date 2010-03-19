From: Mark Rada <marada@uwaterloo.ca>
Subject: [PATCH] instaweb: use minified gitweb.js if available
Date: Fri, 19 Mar 2010 02:02:55 -0400
Message-ID: <4BA3138F.1010201@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 19 08:21:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsWWf-0000n0-JL
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 08:21:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353Ab0CSHVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 03:21:40 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:48972 "EHLO
	mailchk-m05.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751280Ab0CSHVk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Mar 2010 03:21:40 -0400
X-Greylist: delayed 3817 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Mar 2010 03:21:39 EDT
Received: from bas1-toronto01-1177657629.dsl.bell.ca (bas1-toronto01-1177657629.dsl.bell.ca [70.49.161.29])
	(authenticated bits=0)
	by mailchk-m05.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id o2J62tRs011662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 19 Mar 2010 02:03:02 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
X-UUID: 1a51a9fc-5ebb-42f5-9854-8a28c242c571
X-Miltered: at mailchk-m05 with ID 4BA3138F.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.2 at mailchk-m05
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m05.uwaterloo.ca [129.97.128.141]); Fri, 19 Mar 2010 02:03:03 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142564>

Makes git-instaweb use gitweb.min.js if it was generated.

Signed-off-by: Mark Rada <marada@uwaterloo.ca>

---
 Makefile        |   13 +++++++------
 git-instaweb.sh |    1 +
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 7c616f8..1677928 100644
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
@@ -1574,12 +1574,13 @@ git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css gitweb/gitweb.
 	    -e '/@@GITWEB_CGI@@/d' \
 	    -e '/@@GITWEB_CSS@@/r gitweb/gitweb.css' \
 	    -e '/@@GITWEB_CSS@@/d' \
-	    -e '/@@GITWEB_JS@@/r gitweb/gitweb.js' \
+	    -e '/@@GITWEB_JS@@/r $(GITWEB_JS)' \
 	    -e '/@@GITWEB_JS@@/d' \
 	    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
 	    $@.sh > $@+ && \
 	chmod +x $@+ && \
-	mv $@+ $@
+	mv $@+ $@ && \
+	sed -i '' -e 's/min\.js/js/' $@
 else # NO_PERL
 $(patsubst %.perl,%,$(SCRIPT_PERL)) git-instaweb: % : unimplemented.sh
 	$(QUIET_GEN)$(RM) $@ $@+ && \
diff --git a/git-instaweb.sh b/git-instaweb.sh
index 6a65f25..72f8c39 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -397,6 +397,7 @@ EOFGITWEB
 gitweb_js () {
 	cat > "$1" <<\EOFGITWEB
 @@GITWEB_JS@@
+
 EOFGITWEB
 }
 -- 1.7.0.1.300.gd855a
