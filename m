From: Mark Rada <marada@uwaterloo.ca>
Subject: [PATCH] gitweb: simplify gitweb.min.* generation and clean-up rules
Date: Wed, 14 Apr 2010 23:37:35 -0400
Message-ID: <4BC689FF.9080308@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Charles Bailey <charles@hashpling.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 15 05:38:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2FuB-00006g-Ea
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 05:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756778Ab0DODiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 23:38:07 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:37498 "EHLO
	mailchk-m05.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756730Ab0DODiF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Apr 2010 23:38:05 -0400
Received: from [192.168.26.20] (bas1-toronto01-1177657813.dsl.bell.ca [70.49.161.213])
	(authenticated bits=0)
	by mailchk-m05.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id o3F3bZpM016393
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 14 Apr 2010 23:37:37 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
X-UUID: d1cac5ae-1e89-4c62-9561-564f27ef4fd9
X-Miltered: at mailchk-m05 with ID 4BC689FF.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.2 at mailchk-m05
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m05.uwaterloo.ca [129.97.128.141]); Wed, 14 Apr 2010 23:37:38 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144943>

GITWEB_CSS and GITWEB_JS are meant to be "what URI should the installed
cgi script use to refer to the stylesheet and JavaScript", never "this
is the name of the file we are building".

Lose incorrect assignment to them.

While we are at it, lose FILES that is used only for "clean" target in a
misguided way.  "make clean" should try to remove all the potential
build artifacts regardless of a minor configuration change.  Instead of
trying to remove only the build product "make clean" would have created
if it were run without "clean", explicitly list the three potential build
products for removal.

In addition, this patch tries to make sure that the scripts are
regenerated whenever the replacement variables are modified.  For a good
measure, if you used different JSMIN/CSSMIN since the last time you
produced minified version of these files, they are regenerated.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Tested-by: Mark Rada <marada@uwaterloo.ca>


---

I gave this a test run:
	With just jsmin enabled
	With just cssmin enabled
	With neither enabled
	With both enabled
	Overriding GITWEB_JS
	Overriding GITWEB_JS and jsmin enabled

Instaweb will still generate what it needs to the first time around,
but if you change GITWEB_JS or the JSMIN (or css equivalents) then you
have to regenerate gitweb first manually before instaweb. I'm not sure
if it would be best to swallow up instaweb into this same patch or to
fix it separately (also, I still don't quite understand how this patch
works).


 config.mak.in   |    2 +
 gitweb/Makefile |   75 ++++++++++++++++++++++++++++---------------------------
 2 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/config.mak.in b/config.mak.in
index 6008ac9..bb828fe 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -57,3 +57,5 @@ FREAD_READS_DIRECTORIES=@FREAD_READS_DIRECTORIES@
 SNPRINTF_RETURNS_BOGUS=@SNPRINTF_RETURNS_BOGUS@
 NO_PTHREADS=@NO_PTHREADS@
 PTHREAD_LIBS=@PTHREAD_LIBS@
+GITWEB_JS=/home/ferrous/gitweb.js
+
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
