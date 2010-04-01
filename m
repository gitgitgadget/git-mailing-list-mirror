From: Mark Rada <marada@uwaterloo.ca>
Subject: [PATCHv5 2/6] Gitweb: add support for minifying gitweb.css
Date: Thu, 01 Apr 2010 01:36:03 -0400
Message-ID: <4BB430C3.9030000@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 01 07:36:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxD4z-0002yK-UX
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 07:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752861Ab0DAFg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 01:36:29 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:35395 "EHLO
	mailchk-m05.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752824Ab0DAFg1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Apr 2010 01:36:27 -0400
Received: from karakura.local (bas1-toronto01-1177657512.dsl.bell.ca [70.49.160.168])
	(authenticated bits=0)
	by mailchk-m05.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id o315a399006993
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 1 Apr 2010 01:36:04 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
X-UUID: 14b6ebc0-ff1d-49a7-a3e4-cecddf58a53c
X-Miltered: at mailchk-m05 with ID 4BB430C3.002 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.2 at mailchk-m05
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m05.uwaterloo.ca [129.97.128.141]); Thu, 01 Apr 2010 01:36:05 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143710>

The build system added support minifying gitweb.js through a
JavaScript minifier, but most minifiers come with support to
minify CSS files as well, so we should use it if we can.

This patch will add the same facilities to gitweb.css that
gitweb.js has for minification. That does not mean that they
will use the same minifier though, as it is not safe to assume
that all JavaScript minifiers will also minify CSS files.

Though the bandwidth savings will not be as dramatic as with
the JavaScript minifier, every byte saved is important.

Signed-off-by: Mark Rada <marada@uwaterloo.ca>

---

Changes since v4:
	- Reworded some of the comments and documentation


 Makefile        |   21 +++++++++++++++------
 gitweb/INSTALL  |    5 +++++
 gitweb/Makefile |   28 +++++++++++++++++++++-------
 gitweb/README   |    3 ++-
 4 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/Makefile b/Makefile
index 5384d33..450e4df 100644
--- a/Makefile
+++ b/Makefile
@@ -203,6 +203,9 @@ all::
 # Define JSMIN to point to JavaScript minifier that functions as
 # a filter to have gitweb.js minified.
 #
+# Define CSSMIN to point to a CSS minifier in order to generate a minified
+# version of gitweb.css
+#
 # Define DEFAULT_PAGER to a sensible pager command (defaults to "less") if
 # you want to use something different.  The value will be interpreted by the
 # shell at runtime when it is used.
@@ -279,8 +282,9 @@ lib = lib
 # DESTDIR=
 pathsep = :
 
-# JavaScript minifier invocation that can function as filter
+# JavaScript/CSS minifier invocation that can function as filter
 JSMIN =
+CSSMIN =
 
 export prefix bindir sharedir sysconfdir
 
@@ -1564,18 +1568,23 @@ gitweb:
 	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) all
 
 ifdef JSMIN
-OTHER_PROGRAMS += gitweb/gitweb.cgi   gitweb/gitweb.min.js
-gitweb/gitweb.cgi: gitweb/gitweb.perl gitweb/gitweb.min.js
-else
-OTHER_PROGRAMS += gitweb/gitweb.cgi
-gitweb/gitweb.cgi: gitweb/gitweb.perl
+GITWEB_PROGRAMS += gitweb/gitweb.min.js
 endif
+ifdef CSSMIN
+GITWEB_PROGRAMS += gitweb/gitweb.min.css
+endif
+OTHER_PROGRAMS +=  gitweb/gitweb.cgi  $(GITWEB_PROGRAMS)
+gitweb/gitweb.cgi: gitweb/gitweb.perl $(GITWEB_PROGRAMS)
 	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) $(patsubst gitweb/%,%,$@)
 
 ifdef JSMIN
 gitweb/gitweb.min.js: gitweb/gitweb.js
 	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) $(patsubst gitweb/%,%,$@)
 endif # JSMIN
+ifdef CSSMIN
+gitweb/gitweb.min.css: gitweb/gitweb.css
+	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) $(patsubst gitweb/%,%,$@)
+endif # CSSMIN
 
 
 git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css gitweb/gitweb.js
diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index b76a0cf..b75a90b 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -66,6 +66,11 @@ file for gitweb (in gitweb/README).
   build configuration variables. By default gitweb tries to find them
   in the same directory as gitweb.cgi script.
 
+- You can optionally generate a minified version of gitweb.css by defining
+  the CSSMIN build configuration variable. By default the non-minified
+  version of gitweb.css will be used. NOTE: if you enable this option,
+  substitute gitweb.min.css for all uses of gitweb.css in the help files.
+
 Build example
 ~~~~~~~~~~~~~
 
diff --git a/gitweb/Makefile b/gitweb/Makefile
index c9eb1ee..fffe700 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -6,13 +6,17 @@ all::
 # Define JSMIN to point to JavaScript minifier that functions as
 # a filter to have gitweb.js minified.
 #
+# Define CSSMIN to point to a CSS minifier in order to generate a minified
+# version of gitweb.css
+#
 
 prefix ?= $(HOME)
 bindir ?= $(prefix)/bin
 RM ?= rm -f
 
-# JavaScript minifier invocation that can function as filter
+# JavaScript/CSS minifier invocation that can function as filter
 JSMIN ?=
+CSSMIN ?=
 
 # default configuration for gitweb
 GITWEB_CONFIG = gitweb_config.perl
@@ -26,7 +30,11 @@ GITWEB_STRICT_EXPORT =
 GITWEB_BASE_URL =
 GITWEB_LIST =
 GITWEB_HOMETEXT = indextext.html
+ifdef CSSMIN
+GITWEB_CSS = gitweb.min.css
+else
 GITWEB_CSS = gitweb.css
+endif
 GITWEB_LOGO = git-logo.png
 GITWEB_FAVICON = git-favicon.png
 ifdef JSMIN
@@ -84,13 +92,14 @@ endif
 
 all:: gitweb.cgi
 
+FILES = gitweb.cgi
 ifdef JSMIN
-FILES=gitweb.cgi gitweb.min.js
-gitweb.cgi: gitweb.perl gitweb.min.js
-else # !JSMIN
-FILES=gitweb.cgi
-gitweb.cgi: gitweb.perl
-endif # JSMIN
+FILES += gitweb.min.js
+endif
+ifdef CSSMIN
+FILES += gitweb.min.css
+endif
+gitweb.cgi: gitweb.perl $(GITWEB_JS) $(GITWEB_CSS)
 
 gitweb.cgi:
 	$(QUIET_GEN)$(RM) $@ $@+ && \
@@ -123,6 +132,11 @@ gitweb.min.js: gitweb.js
 	$(QUIET_GEN)$(JSMIN) <$< >$@
 endif # JSMIN
 
+ifdef CSSMIN
+gitweb.min.css: gitweb.css
+	$(QUIET_GEN)$(CSSMIN) <$ >$@
+endif
+
 clean:
 	$(RM) $(FILES)
 
diff --git a/gitweb/README b/gitweb/README
index ad6a04c..71742b3 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -80,7 +80,8 @@ You can specify the following configuration variables when building GIT:
    Points to the location where you put gitweb.css on your web server
    (or to be more generic, the URI of gitweb stylesheet).  Relative to the
    base URI of gitweb.  Note that you can setup multiple stylesheets from
-   the gitweb config file.  [Default: gitweb.css]
+   the gitweb config file.  [Default: gitweb.css (or gitweb.min.css if the
+   CSSMIN variable is defined / CSS minifier is used)]
  * GITWEB_LOGO
    Points to the location where you put git-logo.png on your web server
    (or to be more generic URI of logo, 72x27 size, displayed in top right
-- 
1.7.0.3.519.g7e0613
