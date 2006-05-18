From: Linus Torvalds <torvalds@osdl.org>
Subject: Remove old "git-add.sh" remnants
Date: Wed, 17 May 2006 21:21:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605172120160.10823@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu May 18 06:21:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fga0o-0007Nc-Pc
	for gcvg-git@gmane.org; Thu, 18 May 2006 06:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWEREVQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 00:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWEREVQ
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 00:21:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40125 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751087AbWEREVQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 May 2006 00:21:16 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4I4L6tH025661
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 17 May 2006 21:21:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4I4L4xm007033;
	Wed, 17 May 2006 21:21:05 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=-6 required=5 tests=PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20259>


Repeat after me: "It's now a built-in"

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

diff --git a/Makefile b/Makefile
index a1d2e08..3a28580 100644
--- a/Makefile
+++ b/Makefile
@@ -113,7 +113,7 @@ SPARSE_FLAGS = -D__BIG_ENDIAN__ -D__powe
 ### --- END CONFIGURATION SECTION ---
 
 SCRIPT_SH = \
-	git-add.sh git-bisect.sh git-branch.sh git-checkout.sh \
+	git-bisect.sh git-branch.sh git-checkout.sh \
 	git-cherry.sh git-clean.sh git-clone.sh git-commit.sh \
 	git-fetch.sh \
 	git-format-patch.sh git-ls-remote.sh \
@@ -170,7 +170,7 @@ PROGRAMS = \
 
 BUILT_INS = git-log$X git-whatchanged$X git-show$X \
 	git-count-objects$X git-diff$X git-push$X \
-	git-grep$X
+	git-grep$X git-add$X
 
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
diff --git a/git-add.sh b/git-add.sh
deleted file mode 100755
index d6a4bc7..0000000
--- a/git-add.sh
+++ /dev/null
@@ -1,56 +0,0 @@
-#!/bin/sh
-
-USAGE='[-n] [-v] <file>...'
-SUBDIRECTORY_OK='Yes'
-. git-sh-setup
-
-show_only=
-verbose=
-while : ; do
-  case "$1" in
-    -n)
-	show_only=true
-	;;
-    -v)
-	verbose=--verbose
-	;;
-    --)
-	shift
-	break
-	;;
-    -*)
-	usage
-	;;
-    *)
-	break
-	;;
-  esac
-  shift
-done
-
-# Check misspelled pathspec
-case "$#" in
-0)	;;
-*)
-	git-ls-files --error-unmatch --others --cached -- "$@" >/dev/null || {
-		echo >&2 "Maybe you misspelled it?"
-		exit 1
-	}
-	;;
-esac
-
-if test -f "$GIT_DIR/info/exclude"
-then
-	git-ls-files -z \
-	--exclude-from="$GIT_DIR/info/exclude" \
-	--others --exclude-per-directory=.gitignore -- "$@"
-else
-	git-ls-files -z \
-	--others --exclude-per-directory=.gitignore -- "$@"
-fi |
-case "$show_only" in
-true)
-	xargs -0 echo ;;
-*)
-	git-update-index --add $verbose -z --stdin ;;
-esac
