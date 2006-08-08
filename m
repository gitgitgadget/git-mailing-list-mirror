From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/4] autoconf: Improvements in NO_PYTHON/PYTHON_PATH handling
Date: Tue, 8 Aug 2006 18:38:06 +0200
Message-ID: <200608081838.06311.jnareb@gmail.com>
References: <200608081834.09271.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Aug 08 18:38:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAUal-00039f-35
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 18:38:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbWHHQiA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Aug 2006 12:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbWHHQiA
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 12:38:00 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:26239 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964983AbWHHQh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Aug 2006 12:37:57 -0400
Received: by nf-out-0910.google.com with SMTP id q29so224642nfc
        for <git@vger.kernel.org>; Tue, 08 Aug 2006 09:37:55 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QFt3jXSgH6NSZF2Ckhf4tl8jLfBF35ekWqqXGrhpMHAPqXvvCwCVXT3YH2/Cky3FM9HEm9VXyt1rLPvVUnSTbYY8cWglXOiEn6+/2OI5Z5+NPGLRpAJVrP/IuG3ixThRwNI8T2XskyBiybm2D2ZSSZCgy1mE9yaKyJDwN/09v4k=
Received: by 10.49.41.12 with SMTP id t12mr499335nfj;
        Tue, 08 Aug 2006 09:37:55 -0700 (PDT)
Received: from host-81-190-31-92.torun.mm.pl ( [81.190.31.92])
        by mx.gmail.com with ESMTP id l32sm1002171nfa.2006.08.08.09.37.55;
        Tue, 08 Aug 2006 09:37:55 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608081834.09271.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25075>

Unset NO_PYTHON for --with-python without arguments, and when
PYTHON_PATH is set.  Do not check for PYTHON_PATH if it is set
via --with-python=PYTHON_PATH.  Prefer python to python2.4 etc.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
What might be unexpected is the fact that even for --with-python
(but only without setting PYTHON_PATH) autodetection might set NO_PYTHON

 configure.ac |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/configure.ac b/configure.ac
index c2ddd9b..c27a994 100644
--- a/configure.ac
+++ b/configure.ac
@@ -105,7 +105,10 @@ AC_ARG_WITH(python,[AS_HELP_STRING([--wi
 AS_HELP_STRING([--no-python], [don't use python scripts])],
  [if test "$withval" = "no"; then \
     NO_PYTHON=YesPlease; \
-  elif test "$withval" != "yes"; then \
+  elif test "$withval" = "yes"; then \
+    NO_PYTHON=; \
+  else \
+    NO_PYTHON=; \
     PYTHON_PATH=$withval; \
   fi; \
  ])
@@ -138,15 +141,15 @@ #
 # Define NO_PYTHON if you want to lose all benefits of the recursive merge.
 # Define PYTHON_PATH to provide path to Python.
 if test -z "$NO_PYTHON"; then
-	AC_PATH_PROGS(PYTHON_PATH, [python2.4 python2.3 python2 python])
+	if test -z "$PYTHON_PATH"; then
+		AC_PATH_PROGS(PYTHON_PATH, [python python2.4 python2.3 python2])
+	fi
 	if test -n "$PYTHON_PATH"; then
 		GIT_CONF_APPEND_LINE([PYTHON_PATH=@PYTHON_PATH@])
-	else
-		GIT_CONF_APPEND_LINE([NO_PYTHON=@NO_PYTHON@])
+		NO_PYTHON=""
 	fi
-else
-	GIT_CONF_APPEND_LINE([NO_PYTHON=@NO_PYTHON@])
 fi
+GIT_CONF_APPEND_LINE([NO_PYTHON=@NO_PYTHON@])
 
 
 ## Checks for libraries.
-- 
1.4.1.1
