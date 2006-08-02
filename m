From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/3] autoconf: Add support for setting PYTHON_PATH or NO_PYTHON
Date: Thu, 3 Aug 2006 00:40:40 +0200
Message-ID: <200608030040.40995.jnareb@gmail.com>
References: <200608030036.56298.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Aug 03 00:40:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8POB-000679-OK
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 00:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWHBWka (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 18:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbWHBWka
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 18:40:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:45880 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932291AbWHBWk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Aug 2006 18:40:28 -0400
Received: by nf-out-0910.google.com with SMTP id o25so783657nfa
        for <git@vger.kernel.org>; Wed, 02 Aug 2006 15:40:27 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=R0jm/nKL7VYAW/6StGxD9V9wpoUPwOJbYEKg1LUYKQg4wTgFXIDorU+zHVZxFW5+n5zP0DesSMO3QG+xgJZWduikELeQWW9N0HySKL022crD4ARb8fvUlxMnCQA6pYK43gVA+fzkoHkU6MT1U3eC85S1EY1B1viMz48GxBMk9DM=
Received: by 10.49.92.18 with SMTP id u18mr2985235nfl;
        Wed, 02 Aug 2006 15:40:26 -0700 (PDT)
Received: from host-81-190-31-92.torun.mm.pl ( [81.190.31.92])
        by mx.gmail.com with ESMTP id m15sm151205nfc.2006.08.02.15.40.26;
        Wed, 02 Aug 2006 15:40:26 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608030036.56298.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24697>

This patch adds support for setting either PYTHON_PATH or NO_PYTHON to
autoconf generated ./configure script via --with-python=PATH (sets
PYTHON_PATH) or --without-python (sets NO_PYTHON).  Autodetect
PYTHON_PATH via AC_PATH_PROGS.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Tweaked a little to remove accidental trailing whitespace.

 configure.ac |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+)

diff --git a/configure.ac b/configure.ac
index 73e12d3..0a54b44 100644
--- a/configure.ac
+++ b/configure.ac
@@ -103,6 +103,18 @@ AC_MSG_NOTICE([CHECKS for programs])
 #
 GIT_ARG_SET_PATH(shell)
 GIT_ARG_SET_PATH(perl)
+AC_ARG_WITH(python,[AS_HELP_STRING([--with-python=PATH], [provide PATH to python])
+AS_HELP_STRING([--no-python], [don't use python scripts])],
+ [if test "$withval" = "no"; then \
+    NO_PYTHON=YesPlease; \
+  elif test "$withval" != "yes"; then \
+    PYTHON_PATH=$withval; \
+  fi; \
+ ])
+AC_SUBST(NO_PYTHON)
+AC_SUBST(PYTHON_PATH)
+
+
 #
 # Define NO_PYTHON if you want to lose all benefits of the recursive merge.
 # Define PYTHON_PATH to provide path to Python.
@@ -110,6 +122,16 @@ AC_PROG_CC
 #AC_PROG_INSTALL		# needs install-sh or install.sh in sources
 AC_CHECK_TOOL(AR, ar, :)
 AC_CHECK_PROGS(TAR, [gtar tar])
+if test -z "$NO_PYTHON"; then
+	AC_PATH_PROGS(PYTHON_PATH, [python2.4 python2.3 python2 python])
+	if test -n "$PYTHON_PATH"; then
+		GIT_CONF_APPEND_LINE([PYTHON_PATH=@PYTHON_PATH@])
+	else
+		GIT_CONF_APPEND_LINE([NO_PYTHON=@NO_PYTHON@])
+	fi
+else
+	GIT_CONF_APPEND_LINE([NO_PYTHON=@NO_PYTHON@])
+fi
 
 
 ## Checks for libraries.
-- 
1.4.1.1
