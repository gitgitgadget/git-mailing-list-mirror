From: Linus Torvalds <torvalds@osdl.org>
Subject: Remove old "git-grep.sh" remnants
Date: Tue, 16 May 2006 16:46:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605161644380.16475@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed May 17 01:46:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fg9FY-0006Hc-BC
	for gcvg-git@gmane.org; Wed, 17 May 2006 01:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWEPXqp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 19:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWEPXqp
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 19:46:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17894 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932293AbWEPXqo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 May 2006 19:46:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4GNkatH025047
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 16 May 2006 16:46:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4GNkVNH028107;
	Tue, 16 May 2006 16:46:31 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=-6 required=5 tests=PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20151>


It's built-in now.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
----

diff --git a/Makefile b/Makefile
index 93779b0..9ba608c 100644
--- a/Makefile
+++ b/Makefile
@@ -124,7 +124,7 @@ SCRIPT_SH = \
 	git-tag.sh git-verify-tag.sh \
 	git-applymbox.sh git-applypatch.sh git-am.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
-	git-merge-resolve.sh git-merge-ours.sh git-grep.sh \
+	git-merge-resolve.sh git-merge-ours.sh \
 	git-lost-found.sh
 
 SCRIPT_PERL = \
@@ -169,7 +169,8 @@ PROGRAMS = \
 	git-describe$X git-merge-tree$X git-blame$X git-imap-send$X
 
 BUILT_INS = git-log$X git-whatchanged$X git-show$X \
-	git-count-objects$X git-diff$X git-push$X
+	git-count-objects$X git-diff$X git-push$X \
+	git-grep$X
 
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
diff --git a/git-grep.sh b/git-grep.sh
deleted file mode 100755
index ad4f2fe..0000000
--- a/git-grep.sh
+++ /dev/null
@@ -1,62 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) Linus Torvalds, 2005
-#
-
-USAGE='[<option>...] [-e] <pattern> [<path>...]'
-SUBDIRECTORY_OK='Yes'
-. git-sh-setup
-
-got_pattern () {
-	if [ -z "$no_more_patterns" ]
-	then
-		pattern="$1" no_more_patterns=yes
-	else
-		die "git-grep: do not specify more than one pattern"
-	fi
-}
-
-no_more_patterns=
-pattern=
-flags=()
-git_flags=()
-while : ; do
-	case "$1" in
-	-o|--cached|--deleted|--others|--killed|\
-	--ignored|--modified|--exclude=*|\
-	--exclude-from=*|\--exclude-per-directory=*)
-		git_flags=("${git_flags[@]}" "$1")
-		;;
-	-e)
-		got_pattern "$2"
-		shift
-		;;
-	-A|-B|-C|-D|-d|-f|-m)
-		flags=("${flags[@]}" "$1" "$2")
-		shift
-		;;
-	--)
-		# The rest are git-ls-files paths
-		shift
-		break
-		;;
-	-*)
-		flags=("${flags[@]}" "$1")
-		;;
-	*)
-		if [ -z "$no_more_patterns" ]
-		then
-			got_pattern "$1"
-			shift
-		fi
-		[ "$1" = -- ] && shift
-		break
-		;;
-	esac
-	shift
-done
-[ "$pattern" ] || {
-	usage
-}
-git-ls-files -z "${git_flags[@]}" -- "$@" |
-	xargs -0 grep "${flags[@]}" -e "$pattern" --
