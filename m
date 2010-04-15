From: Mark Rada <marada@uwaterloo.ca>
Subject: [PATCHv2] gitweb: simplify gitweb.min.* generation and clean-up rules
Date: Thu, 15 Apr 2010 08:57:18 -0400
Message-ID: <4BC70D2E.6040508@mailservices.uwaterloo.ca>
References: <4BC689FF.9080308@mailservices.uwaterloo.ca> <201004150811.55627.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mark Rada <marada@uwaterloo.ca>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Charles Bailey <charles@hashpling.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 14:58:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2Odw-0005FK-14
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 14:58:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435Ab0DOM55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 08:57:57 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:33637 "EHLO
	mailchk-m05.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752297Ab0DOM54 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Apr 2010 08:57:56 -0400
Received: from [192.168.26.20] (bas1-toronto01-1177646445.dsl.bell.ca [70.49.117.109])
	(authenticated bits=0)
	by mailchk-m05.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id o3FCvIM7031758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 15 Apr 2010 08:57:19 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <201004150811.55627.jnareb@gmail.com>
X-UUID: 9ed2ccfa-e6ae-4ac9-b449-5205b15f284a
X-Miltered: at mailchk-m05 with ID 4BC70D2E.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.2 at mailchk-m05
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m05.uwaterloo.ca [129.97.128.141]); Thu, 15 Apr 2010 08:57:21 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144980>

GITWEB_CSS and GITWEB_JS are meant to be "what URI should the installed
cgi script use to refer to the stylesheet and JavaScript", never "this
is the name of the file we are building".

Lose incorrect assignment to them.

While we are at it, lose FILES that is used only for "clean" target in a
misguided way.  "make clean" should try to remove all the potential
build artifacts regardless of a minor configuration change. Instead of
trying to remove only the build product "make clean" would have created
if it were run without "clean", explicitly list the three potential build
products for removal.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Tested-by: Mark Rada <marada@uwaterloo.co>

---

	Changes since v1:
		- Removed extra crap that was not supposed to be part of
		  the patch


 gitweb/Makefile |   75 ++++++++++++++++++++++++++++---------------------------
 1 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index ffee4bd..f2e1d92 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -80,54 +80,55 @@ endif
 
 all:: gitweb.cgi
 
-FILES = gitweb.cgi
 ifdef JSMIN
-FILES += gitweb.min.js
 GITWEB_JS = gitweb.min.js
+all:: gitweb.min.js
+gitweb.min.js: gitweb.js GITWEB-BUILD-OPTIONS
+	$(QUIET_GEN)$(JSMIN) <$< >$@
 endif
+
 ifdef CSSMIN
-FILES += gitweb.min.css
 GITWEB_CSS = gitweb.min.css
+all:: gitweb.min.css
+gitweb.min.css: gitweb.css GITWEB-BUILD-OPTIONS
+	$(QUIET_GEN)$(CSSMIN) <$ >$@
 endif
-gitweb.cgi: gitweb.perl $(GITWEB_JS) $(GITWEB_CSS)
 
-gitweb.cgi:
+GITWEB_REPLACE = \
+	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
+	-e 's|++GIT_BINDIR++|$(bindir)|g' \
+	-e 's|++GITWEB_CONFIG++|$(GITWEB_CONFIG)|g' \
+	-e 's|++GITWEB_CONFIG_SYSTEM++|$(GITWEB_CONFIG_SYSTEM)|g' \
+	-e 's|++GITWEB_HOME_LINK_STR++|$(GITWEB_HOME_LINK_STR)|g' \
+	-e 's|++GITWEB_SITENAME++|$(GITWEB_SITENAME)|g' \
+	-e 's|++GITWEB_PROJECTROOT++|$(GITWEB_PROJECTROOT)|g' \
+	-e 's|"++GITWEB_PROJECT_MAXDEPTH++"|$(GITWEB_PROJECT_MAXDEPTH)|g' \
+	-e 's|++GITWEB_EXPORT_OK++|$(GITWEB_EXPORT_OK)|g' \
+	-e 's|++GITWEB_STRICT_EXPORT++|$(GITWEB_STRICT_EXPORT)|g' \
+	-e 's|++GITWEB_BASE_URL++|$(GITWEB_BASE_URL)|g' \
+	-e 's|++GITWEB_LIST++|$(GITWEB_LIST)|g' \
+	-e 's|++GITWEB_HOMETEXT++|$(GITWEB_HOMETEXT)|g' \
+	-e 's|++GITWEB_CSS++|$(GITWEB_CSS)|g' \
+	-e 's|++GITWEB_LOGO++|$(GITWEB_LOGO)|g' \
+	-e 's|++GITWEB_FAVICON++|$(GITWEB_FAVICON)|g' \
+	-e 's|++GITWEB_JS++|$(GITWEB_JS)|g' \
+	-e 's|++GITWEB_SITE_HEADER++|$(GITWEB_SITE_HEADER)|g' \
+	-e 's|++GITWEB_SITE_FOOTER++|$(GITWEB_SITE_FOOTER)|g'
+
+GITWEB-BUILD-OPTIONS: FORCE
+	@rm -f $@+
+	@echo "x" '$(PERL_PATH_SQ)' $(GITWEB_REPLACE) "$(JSMIN)|$(CSSMIN)" >$@+
+	@cmp -s $@+ $@ && rm -f $@+ || mv -f $@+ $@
+
+gitweb.cgi: gitweb.perl GITWEB-BUILD-OPTIONS
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|' \
-	    -e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
-	    -e 's|++GIT_BINDIR++|$(bindir)|g' \
-	    -e 's|++GITWEB_CONFIG++|$(GITWEB_CONFIG)|g' \
-	    -e 's|++GITWEB_CONFIG_SYSTEM++|$(GITWEB_CONFIG_SYSTEM)|g' \
-	    -e 's|++GITWEB_HOME_LINK_STR++|$(GITWEB_HOME_LINK_STR)|g' \
-	    -e 's|++GITWEB_SITENAME++|$(GITWEB_SITENAME)|g' \
-	    -e 's|++GITWEB_PROJECTROOT++|$(GITWEB_PROJECTROOT)|g' \
-	    -e 's|"++GITWEB_PROJECT_MAXDEPTH++"|$(GITWEB_PROJECT_MAXDEPTH)|g' \
-	    -e 's|++GITWEB_EXPORT_OK++|$(GITWEB_EXPORT_OK)|g' \
-	    -e 's|++GITWEB_STRICT_EXPORT++|$(GITWEB_STRICT_EXPORT)|g' \
-	    -e 's|++GITWEB_BASE_URL++|$(GITWEB_BASE_URL)|g' \
-	    -e 's|++GITWEB_LIST++|$(GITWEB_LIST)|g' \
-	    -e 's|++GITWEB_HOMETEXT++|$(GITWEB_HOMETEXT)|g' \
-	    -e 's|++GITWEB_CSS++|$(GITWEB_CSS)|g' \
-	    -e 's|++GITWEB_LOGO++|$(GITWEB_LOGO)|g' \
-	    -e 's|++GITWEB_FAVICON++|$(GITWEB_FAVICON)|g' \
-	    -e 's|++GITWEB_JS++|$(GITWEB_JS)|g' \
-	    -e 's|++GITWEB_SITE_HEADER++|$(GITWEB_SITE_HEADER)|g' \
-	    -e 's|++GITWEB_SITE_FOOTER++|$(GITWEB_SITE_FOOTER)|g' \
-	    $< >$@+ && \
+		$(GITWEB_REPLACE) $< >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
 
-ifdef JSMIN
-gitweb.min.js: gitweb.js
-	$(QUIET_GEN)$(JSMIN) <$< >$@
-endif # JSMIN
-
-ifdef CSSMIN
-gitweb.min.css: gitweb.css
-	$(QUIET_GEN)$(CSSMIN) <$ >$@
-endif
-
 clean:
-	$(RM) $(FILES)
+	$(RM) gitweb.cgi gitweb.min.js gitweb.min.css GITWEB-BUILD-OPTIONS
+
+.PHONY: all clean .FORCE-GIT-VERSION-FILE FORCE
 
-.PHONY: all clean .FORCE-GIT-VERSION-FILE
-- 
1.7.1.rc1.237.ge1730
