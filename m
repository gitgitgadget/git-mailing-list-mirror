From: Linus Torvalds <torvalds@osdl.org>
Subject: Add "git grep" helper
Date: Mon, 12 Sep 2005 12:06:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509121203210.4098@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Sep 12 21:07:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEtdG-0006A8-PZ
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 21:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbVILTGU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 15:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbVILTGU
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 15:06:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46514 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932150AbVILTGT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 15:06:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8CJ6DBo011342
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Sep 2005 12:06:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8CJ6AxA012183;
	Mon, 12 Sep 2005 12:06:12 -0700
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8416>


Very convenient shorthand for

	git-ls-files [file-patterns] | xargs grep <pattern>

which I tend to do all the time.

Yes, it's trivial, but it's really nice. I can do

	git grep '\<some_variable\>' arch/i386 include/asm-i386

and it does exactly what you'd think it does. And since it just uses the 
normal git-ls-files file patterns, you can do things like

	git grep something 'include/*.h'

and it will search all header files under the include/ subdirectory.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -76,7 +76,7 @@ SCRIPT_SH = \
 	git-tag.sh git-verify-tag.sh git-whatchanged.sh git.sh \
 	git-applymbox.sh git-applypatch.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
-	git-merge-resolve.sh
+	git-merge-resolve.sh git-grep.sh
 
 SCRIPT_PERL = \
 	git-archimport.perl git-cvsimport.perl git-relink.perl \
diff --git a/git-grep.sh b/git-grep.sh
new file mode 100755
--- /dev/null
+++ b/git-grep.sh
@@ -0,0 +1,20 @@
+#!/bin/sh
+flags=
+while :; do
+  pattern="$1"
+  case "$pattern" in
+  -i|-I|-a|-E|-H|-h|-l)
+    flags="$flags $pattern"
+    shift
+    ;;
+  -*)
+    echo "unknown flag $pattern" >&2
+    exit 1
+    ;;
+  *)
+    break
+    ;;
+  esac
+done
+shift
+git-ls-files -z "$@" | xargs -0 grep $flags "$pattern"
