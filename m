From: Linus Torvalds <torvalds@osdl.org>
Subject: Improve "git grep" flags handling
Date: Mon, 12 Sep 2005 15:22:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509121519310.3266@g5.osdl.org>
References: <Pine.LNX.4.58.0509121203210.4098@g5.osdl.org>
 <7vbr2y7yfd.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0509121500400.3266@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 13 00:25:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEwhS-0005Vc-P1
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 00:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbVILWWw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 18:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbVILWWw
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 18:22:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52879 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932310AbVILWWv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 18:22:51 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8CMMlBo026321
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Sep 2005 15:22:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8CMMiO6024201;
	Mon, 12 Sep 2005 15:22:46 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.58.0509121500400.3266@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8443>


This allows any arbitrary flags to "grep", and knows about the few special 
grep flags that take an argument too.

It also allows some flags for git-ls-files, although their usefulness is 
questionable.

With this, something line

	git grep -w -1 pattern

works, without the script enumerating every possible flag.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

On Mon, 12 Sep 2005, Linus Torvalds wrote:
> 
> We also need special casing for grep flags that take an argument.  So the
> end result might be something like the following..

diff --git a/git-grep.sh b/git-grep.sh
--- a/git-grep.sh
+++ b/git-grep.sh
@@ -1,25 +1,38 @@
 #!/bin/sh
 flags=
+git_flags=
 while :; do
   pattern="$1"
   case "$pattern" in
-  -i|-I|-a|-E|-H|-h|-l)
-    flags="$flags $pattern"
-    shift
-    ;;
+  # git-ls-file specific flags
+  --others|--exclude=*|--exclude-from=*|--exclude-per-directory=*)
+      git_flags="$git_flags $pattern"
+      shift
+      ;;
+
+  # grep flags with an argument
+  -B|-C|-m)
+      flags="$flags $pattern $2"
+      shift
+      shift
+      ;;
+
+  # grep 'pattern' argument
   -e)
-    pattern="$2"
-    shift
-    break
-    ;;
+      pattern="$2"
+      shift
+      break
+      ;;
+
+  # We assume everything else is a regular grep pattern
   -*)
-    echo "unknown flag $pattern" >&2
-    exit 1
-    ;;
+      flags="$flags $pattern"
+      shift
+      ;;
   *)
     break
     ;;
   esac
 done
 shift
-git-ls-files -z "$@" | xargs -0 grep $flags -e "$pattern"
+git-ls-files -z $git_flags "$@" | xargs -0 grep $flags -e "$pattern"
