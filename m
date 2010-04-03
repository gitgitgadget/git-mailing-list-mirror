From: Mark Rada <marada@uwaterloo.ca>
Subject: [PATCHv6 3/6] Gitweb: add autoconfigure support for minifiers
Date: Fri, 02 Apr 2010 20:35:54 -0400
Message-ID: <4BB68D6A.1000605@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 03 02:36:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxrLx-00087v-GU
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 02:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224Ab0DCAgl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 20:36:41 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:55279 "EHLO
	mailchk-m05.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752913Ab0DCAgj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Apr 2010 20:36:39 -0400
Received: from karakura.local (bas1-toronto01-1177657512.dsl.bell.ca [70.49.160.168])
	(authenticated bits=0)
	by mailchk-m05.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id o330Zstk017187
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 2 Apr 2010 20:35:55 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
X-UUID: 0b08465b-6e89-44e0-8dbb-31af61adfa66
X-Miltered: at mailchk-m05 with ID 4BB68D6A.002 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.2 at mailchk-m05
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m05.uwaterloo.ca [129.97.128.141]); Fri, 02 Apr 2010 20:35:57 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143872>

This will allow users to set a JavaScript/CSS minifier when/if they run
the autoconfigure script while building git.

Signed-off-by: Mark Rada <marada@uwaterloo.ca>

---

Changes since last revision:
	- Removed a sentence from the commit regarding the need to
	  edit the Makefiles manually

 Makefile        |    4 ----
 configure.ac    |   20 ++++++++++++++++++++
 gitweb/Makefile |   14 ++------------
 3 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/Makefile b/Makefile
index a48f42f..4a6bc62 100644
--- a/Makefile
+++ b/Makefile
@@ -282,10 +282,6 @@ lib = lib
 # DESTDIR=
 pathsep = :
 
-# JavaScript/CSS minifier invocation that can function as filter
-JSMIN =
-CSSMIN =
-
 export prefix bindir sharedir sysconfdir
 
 CC = gcc
diff --git a/configure.ac b/configure.ac
index 914ae57..f4d7372 100644
--- a/configure.ac
+++ b/configure.ac
@@ -179,6 +179,26 @@ fi],
    AC_MSG_NOTICE([Will try -pthread then -lpthread to enable POSIX Threads.])
 ])
 
+# Define option to enable JavaScript minification
+AC_ARG_ENABLE([jsmin],
+[AS_HELP_STRING([--enable-jsmin=PATH],
+  [PATH is the name of a JavaScript minifier or the absolute path to one.])],
+[
+  JSMIN=$enableval;
+  AC_MSG_NOTICE([Setting JSMIN to '$JSMIN' to enable JavaScript minifying])
+  GIT_CONF_APPEND_LINE(JSMIN=$enableval);
+])
+
+# Define option to enable CSS minification
+AC_ARG_ENABLE([cssmin],
+[AS_HELP_STRING([--enable-cssmin=PATH],
+  [PATH is the name of a CSS minifier or the absolute path to one.])],
+[
+  CSSMIN=$enableval;
+  AC_MSG_NOTICE([Setting CSSMIN to '$CSSMIN' to enable CSS minifying])
+  GIT_CONF_APPEND_LINE(CSSMIN=$enableval);
+])
+
 ## Site configuration (override autodetection)
 ## --with-PACKAGE[=ARG] and --without-PACKAGE
 AC_MSG_NOTICE([CHECKS for site configuration])
diff --git a/gitweb/Makefile b/gitweb/Makefile
index fffe700..ffee4bd 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -14,10 +14,6 @@ prefix ?= $(HOME)
 bindir ?= $(prefix)/bin
 RM ?= rm -f
 
-# JavaScript/CSS minifier invocation that can function as filter
-JSMIN ?=
-CSSMIN ?=
-
 # default configuration for gitweb
 GITWEB_CONFIG = gitweb_config.perl
 GITWEB_CONFIG_SYSTEM = /etc/gitweb.conf
@@ -30,18 +26,10 @@ GITWEB_STRICT_EXPORT =
 GITWEB_BASE_URL =
 GITWEB_LIST =
 GITWEB_HOMETEXT = indextext.html
-ifdef CSSMIN
-GITWEB_CSS = gitweb.min.css
-else
 GITWEB_CSS = gitweb.css
-endif
 GITWEB_LOGO = git-logo.png
 GITWEB_FAVICON = git-favicon.png
-ifdef JSMIN
-GITWEB_JS = gitweb.min.js
-else
 GITWEB_JS = gitweb.js
-endif
 GITWEB_SITE_HEADER =
 GITWEB_SITE_FOOTER =
 
@@ -95,9 +83,11 @@ all:: gitweb.cgi
 FILES = gitweb.cgi
 ifdef JSMIN
 FILES += gitweb.min.js
+GITWEB_JS = gitweb.min.js
 endif
 ifdef CSSMIN
 FILES += gitweb.min.css
+GITWEB_CSS = gitweb.min.css
 endif
 gitweb.cgi: gitweb.perl $(GITWEB_JS) $(GITWEB_CSS)
 
-- 
1.7.0.3.519.g7e0613
