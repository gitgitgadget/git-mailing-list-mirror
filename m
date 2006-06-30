From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH 14] autoconf: Added --with/--without for openssl, curl, expat to ./configure
Date: Fri, 30 Jun 2006 23:45:12 +0200
Message-ID: <200606302345.17045.jnareb@gmail.com>
References: <200606290301.51657.jnareb@gmail.com> <200606301708.19521.jnareb@gmail.com> <200606301711.39635.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jun 30 23:45:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwQnl-0000sV-EI
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 23:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWF3VpK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 17:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbWF3VpK
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 17:45:10 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:45149 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750778AbWF3VpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 17:45:09 -0400
Received: by nf-out-0910.google.com with SMTP id k26so9567nfc
        for <git@vger.kernel.org>; Fri, 30 Jun 2006 14:45:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=CUJgW8mKaaQxwJAEXnN5iayslmxwr1ecu1ab5Bf36znBzTpKNH57Wsi8AWDr2YhD10lNd5WvIhvEyxNEfBZdtmmQmQ4sdGVj0I4SzAsxfulv/alrHzTh5uxTiWsgouagps8E6w8NyuXyBwXWxlrpVOQq0wrmibZWu7TJ2tk7rjc=
Received: by 10.48.233.18 with SMTP id f18mr634558nfh;
        Fri, 30 Jun 2006 14:45:07 -0700 (PDT)
Received: from host-81-190-27-124.torun.mm.pl ( [81.190.27.124])
        by mx.gmail.com with ESMTP id n22sm1981301nfc.2006.06.30.14.45.06;
        Fri, 30 Jun 2006 14:45:07 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200606301711.39635.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23019>


Added --with-PACKAGE[=PATH] (where PATH is prefix for PACKAGE
libraries and includes) and --without-PACKAGE (--with-PACKAGE=no)
support for curl, openssl, expat to configure.ac

Signed-off-by: Jakub Narebski <jnareb@gmail.com>

---

I'm not autoconf/m4 expert: could anyone tell me how to uppercase
PACKAGE name, so one could write MY_PARSE_WITH(openssl)?

How to add [=PATH] to --with-PACKAGE option description in a way
which does not screw up AS_HELP_WITH calculations. I could use
@<:@=PATH@:>@ which transforms to [=PATH], but AS_HELP_WITH counts
number of characters in source I think.

 configure.ac |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index fcfc9ce..26d6f4d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -19,6 +19,22 @@ # Append LINE to file ${config_append}
 AC_DEFUN([MY_APPEND_LINE],
 [[echo "$1" >> "${config_append}"]])# MY_APPEND_LINE
 
+# MY_PARSE_WITH(PACKAGE)
+# ----------------------
+# For use in AC_ARG_WITH action-if-found, for packages default ON. 
+# * Set NO_PACKAGE=YesPlease  for --without-PACKAGE
+# * Set PACKAGEDIR=ARG for --with-PACKAGE=ARG
+# * Do nothing for --with-PACKAGE without ARG
+# PACKAGE option must be all uppercase
+AC_DEFUN([MY_PARSE_WITH],
+[[if test "$withval" = "no"; then \
+    MY_APPEND_LINE(NO_$1=YesPlease); \
+  elif test "$withval" != "yes"; then \
+    MY_APPEND_LINE($1DIR=$withval); \
+  fi; \
+]])# MY_PARSE_WITH
+
+
 # Checks for libraries.
 AC_MSG_NOTICE([CHECKS for libraries])
 AC_CHECK_LIB([crypto], [SHA1_Init],,MY_APPEND_LINE(NO_OPENSSL=YesPlease))
@@ -48,6 +64,24 @@ AC_CHECK_FUNC(strlcpy,,MY_APPEND_LINE(NO
 AC_CHECK_FUNC(setenv,,MY_APPEND_LINE(NO_SETENV=YesPlease))
 
 
+# Site configuration
+AC_MSG_NOTICE([CHECKS for site configuration])
+AC_ARG_WITH(curl, 
+AS_HELP_STRING([--with-curl],[support http(s):// transports (default is YES)])
+AS_HELP_STRING([],           [ARG can be also prefix for curl library and headers]),\
+MY_PARSE_WITH(CURL))
+
+AC_ARG_WITH(openssl,
+AS_HELP_STRING([--with-openssl],[use OpenSSL library (default is YES)])
+AS_HELP_STRING([],              [ARG can be prefix for openssl library and headers]),\
+MY_PARSE_WITH(OPENSSL))
+
+AC_ARG_WITH(expat,
+AS_HELP_STRING([--with-expat],[support git-push using http:// and https:// transports via WebDAV (default is YES)])
+AS_HELP_STRING([],            [ARG can be also prefix for expat library and headers]),\
+MY_PARSE_WITH(EXPAT))
+
+
 # Output files
 AC_CONFIG_FILES(["${config_file}":"${config_in}":"${config_append}"])
 AC_OUTPUT
-- 
1.4.0
