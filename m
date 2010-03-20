From: Mark Rada <marada@uwaterloo.ca>
Subject: [PATCHv3] gitweb: fill in missing parts of JavaScript minify support
Date: Sat, 20 Mar 2010 00:29:19 -0400
Message-ID: <4BA44F1F.9030008@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 20 05:29:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsqJX-0001s7-0S
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 05:29:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386Ab0CTE3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 00:29:24 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:41898 "EHLO
	mailchk-m05.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751033Ab0CTE3Y (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Mar 2010 00:29:24 -0400
Received: from bas1-toronto01-1177657629.dsl.bell.ca (bas1-toronto01-1177657629.dsl.bell.ca [70.49.161.29])
	(authenticated bits=0)
	by mailchk-m05.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id o2K4TJru013600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 20 Mar 2010 00:29:21 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
X-UUID: cd4d9513-2749-4171-8a4f-85fa79865dce
X-Miltered: at mailchk-m05 with ID 4BA44F20.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.2 at mailchk-m05
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m05.uwaterloo.ca [129.97.128.141]); Sat, 20 Mar 2010 00:29:22 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142680>


JavaScript minification was added to the git build system, but it was a
hidden away feature that did not play by all the rules.

This patch adds an ignore and clean rule to take care of minified
files belonging to gitweb. It also updates the gitweb INSTALL file to
mention the JavaScript usage and optional minification.

To make minification more accessible, a configure option is added to
enable minification without making the user edit the Makefiles directly.

Signed-off-by: Mark Rada <marada@uwaterloo.ca>

---

This patch was named "Add ignore and clean rules for gitweb.min.js"
previously, but now I've squashed other stuff into it.

Changes since previous versions:
	- Changed patch name and added a commit message
	- Made ignore and clean rule use globs to be more
	  future friendly (other minified files)
	- Added configure script support for JSMIN
	- Added gitweb/INSTALL updates related to gitweb.js
	- Compacted Makefile code related to gitweb building
	  specifically related to gitweb.min.js generation

Nothing related to gitweb or git-instaweb breaks for me with
JSMIN enabled or disabled, but I'm not sure if I broke portability
by taking things out of the root level Makefile, there just
seemed to be a lot of redundant information there that was
handled by the Makefile in the gitweb directory.


 .gitignore      |    1 +
 Makefile        |   11 ++---------
 configure.ac    |   10 ++++++++++
 gitweb/INSTALL  |   25 ++++++++++++++++---------
 gitweb/Makefile |   21 ++++++---------------
 5 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/.gitignore b/.gitignore
index 7b3acb7..4c24152 100644
--- a/.gitignore
+++ b/.gitignore
@@ -156,6 +156,7 @@
 /git-core-*/?*
 /gitk-git/gitk-wish
 /gitweb/gitweb.cgi
+/gitweb/gitweb.min.*
 /test-chmtime
 /test-ctype
 /test-date
diff --git a/Makefile b/Makefile
index f80b25e..58f2cc3 100644
--- a/Makefile
+++ b/Makefile
@@ -279,8 +279,6 @@ lib = lib
 # DESTDIR=
 pathsep = :
 
-# JavaScript minifier invocation that can function as filter
-JSMIN =
 
 export prefix bindir sharedir sysconfdir
 
@@ -1556,14 +1554,9 @@ else
 GITWEB_JS=gitweb/gitweb.js
 endif
 OTHER_PROGRAMS += gitweb/gitweb.cgi $(GITWEB_JS)
-gitweb/gitweb.cgi: gitweb/gitweb.perl $(GITWEB_PROGRAMS)
+gitweb/gitweb.cgi:
 	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) $(patsubst gitweb/%,%,$@)
 
-ifdef JSMIN
-gitweb/gitweb.min.js: gitweb/gitweb.js
-	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) $(patsubst gitweb/%,%,$@)
-endif # JSMIN
-
 
 git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css gitweb/gitweb.js
 	$(QUIET_GEN)$(RM) $@ $@+ && \
@@ -2077,7 +2070,7 @@ clean:
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
 	$(MAKE) -C Documentation/ clean
 ifndef NO_PERL
-	$(RM) gitweb/gitweb.cgi
+	$(RM) gitweb/{gitweb.cgi,gitweb.min.*}
 	$(MAKE) -C perl clean
 endif
 ifndef NO_PYTHON
diff --git a/configure.ac b/configure.ac
index 914ae57..59e7b9e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -179,6 +179,16 @@ fi],
    AC_MSG_NOTICE([Will try -pthread then -lpthread to enable POSIX Threads.])
 ])
 
+# Define option to enable JavaScript minification
+AC_ARG_ENABLE([jsmin],
+ [AS_HELP_STRING([--enable-jsmin=ARG],
+   [ARG is the value to pass to make to enable JavaScript minification.])],
+ [
+   JSMIN=$enableval;
+   AC_MSG_NOTICE([Setting JSMIN to '$JSMIN' to enable JavaScript minifying])
+   GIT_CONF_APPEND_LINE(JSMIN=$enableval);
+ ])
+
 ## Site configuration (override autodetection)
 ## --with-PACKAGE[=ARG] and --without-PACKAGE
 AC_MSG_NOTICE([CHECKS for site configuration])
diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index b76a0cf..8383106 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -2,11 +2,11 @@ GIT web Interface (gitweb) Installation
 =======================================
 
 First you have to generate gitweb.cgi from gitweb.perl using
-"make gitweb/gitweb.cgi", then copy appropriate files (gitweb.cgi,
-gitweb.css, git-logo.png and git-favicon.png) to their destination.
+"make gitweb", then copy appropriate files (gitweb.cgi, gitweb.js,
+gitweb.css, git-logo.png and git-favicon.png) to to their destination.
 For example if git was (or is) installed with /usr prefix, you can do
 
-	$ make prefix=/usr gitweb/gitweb.cgi  ;# as yourself
+	$ make prefix=/usr gitweb             ;# as yourself
 	# cp gitweb/git* /var/www/cgi-bin/    ;# as root
 
 Alternatively you can use autoconf generated ./configure script to
@@ -15,7 +15,7 @@ instead
 
 	$ make configure                     ;# as yourself
 	$ ./configure --prefix=/usr          ;# as yourself
-	$ make gitweb/gitweb.cgi             ;# as yourself
+	$ make gitweb                        ;# as yourself
 	# cp gitweb/git* /var/www/cgi-bin/   ;# as root
 
 The above example assumes that your web server is configured to run
@@ -61,10 +61,16 @@ file for gitweb (in gitweb/README).
   projectroot linking to projectname/.git (but it is just
   a suggestion).
 
-- You can control where gitweb tries to find its main CSS style file,
-  its favicon and logo with the GITWEB_CSS, GITWEB_FAVICON and GITWEB_LOGO
-  build configuration variables. By default gitweb tries to find them
-  in the same directory as gitweb.cgi script.
+- You can control where gitweb tries to find its main JavaScript file,
+  CSS file, favicon and logo with the GITWEB_JS, GITWEB_CSS,
+  GITWEB_FAVICON and GITWEB_LOGO build configuration variables. By default
+  gitweb tries to find them in the same directory as gitweb.cgi script.
+
+- You can generate a minified version of gitweb.js and at build
+  time by setting the JSMIN variable to the full path of a JavaScript
+  minifier or using the --enable-jsmin=/PATH/TO/MINIFIER configure script
+  flag. NOTE: substitue gitweb.min.js for all use of gitweb.js in this
+  INSTALL file if you choose to use this option.
 
 Build example
 ~~~~~~~~~~~~~
@@ -74,13 +80,14 @@ Build example
   we want to display are under /home/local/scm, you can do
 
 	make GITWEB_PROJECTROOT="/home/local/scm" \
+             GITWEB_JS="/gitweb/gitweb.js" \
 	     GITWEB_CSS="/gitweb/gitweb.css" \
 	     GITWEB_LOGO="/gitweb/git-logo.png" \
 	     GITWEB_FAVICON="/gitweb/git-favicon.png" \
 	     bindir=/usr/local/bin \
 	     gitweb/gitweb.cgi
 
-	cp -fv ~/git/gitweb/gitweb.{cgi,css} \
+	cp -fv ~/git/gitweb/gitweb.{.js,cgi,css} \
 	       ~/git/gitweb/git-{favicon,logo}.png \
 	     /var/www/cgi-bin/gitweb/
 
diff --git a/gitweb/Makefile b/gitweb/Makefile
index c9eb1ee..edff9fd 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -11,9 +11,6 @@ prefix ?= $(HOME)
 bindir ?= $(prefix)/bin
 RM ?= rm -f
 
-# JavaScript minifier invocation that can function as filter
-JSMIN ?=
-
 # default configuration for gitweb
 GITWEB_CONFIG = gitweb_config.perl
 GITWEB_CONFIG_SYSTEM = /etc/gitweb.conf
@@ -29,11 +26,7 @@ GITWEB_HOMETEXT = indextext.html
 GITWEB_CSS = gitweb.css
 GITWEB_LOGO = git-logo.png
 GITWEB_FAVICON = git-favicon.png
-ifdef JSMIN
-GITWEB_JS = gitweb.min.js
-else
 GITWEB_JS = gitweb.js
-endif
 GITWEB_SITE_HEADER =
 GITWEB_SITE_FOOTER =
 
@@ -84,15 +77,13 @@ endif
 
 all:: gitweb.cgi
 
+FILES=gitweb.cgi gitweb.min*
+
 ifdef JSMIN
-FILES=gitweb.cgi gitweb.min.js
-gitweb.cgi: gitweb.perl gitweb.min.js
-else # !JSMIN
-FILES=gitweb.cgi
-gitweb.cgi: gitweb.perl
-endif # JSMIN
+GITWEB_JS = gitweb.min.js
+endif
 
-gitweb.cgi:
+gitweb.cgi: gitweb.perl $(GITWEB_JS)
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|' \
 	    -e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
-- 
1.7.0.2.279.gf1ba1c
