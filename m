From: Linus Torvalds <torvalds@osdl.org>
Subject: Add a "git show" command to show a commit
Date: Sun, 5 Feb 2006 11:49:11 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602051144580.3854@g5.osdl.org>
References: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org>
 <e5bfff550602012325s7d0a799ct5bfabbce2c579449@mail.gmail.com>
 <Pine.LNX.4.64.0602012356131.21884@g5.osdl.org>
 <cc723f590602020007s43f89d10i4529d118ade7c764@mail.gmail.com>
 <Pine.LNX.4.64.0602020027400.21884@g5.osdl.org> <7v7j8erqjr.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602051141020.3854@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 05 20:49:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5pst-0000BN-Ia
	for gcvg-git@gmane.org; Sun, 05 Feb 2006 20:49:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWBETtR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Feb 2006 14:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbWBETtQ
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Feb 2006 14:49:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21725 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750704AbWBETtQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Feb 2006 14:49:16 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k15JnCDZ000676
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 5 Feb 2006 11:49:13 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k15JnB31011818;
	Sun, 5 Feb 2006 11:49:12 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0602051141020.3854@g5.osdl.org>
X-Spam-Status: No, hits=-6 required=5 tests=PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15634>


It's basically just "git-diff-tree" with pretty flags and a pager.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

This uses the "--always" flag, btw, so it depends on the previous patch I 
sent. If you disagree with that, just remove it.

This is actually something I do pretty often, and I've grown tired of 
doing

	git-diff-tree -p --pretty cmit-id | less -S

so this is really nothing but a fairly flexible replacement for that.

It tries to have the same logic as "git diff" for the flags. 

diff --git a/Makefile b/Makefile
index 2aa2385..473e58d 100644
--- a/Makefile
+++ b/Makefile
@@ -112,7 +112,7 @@ SCRIPT_SH = \
 	git-applymbox.sh git-applypatch.sh git-am.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
 	git-merge-resolve.sh git-merge-ours.sh git-grep.sh \
-	git-lost-found.sh
+	git-lost-found.sh git-show.sh
 
 SCRIPT_PERL = \
 	git-archimport.perl git-cvsimport.perl git-relink.perl \
diff --git a/git-show.sh b/git-show.sh
new file mode 100644
index 0000000..476bca4
--- /dev/null
+++ b/git-show.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+
+rev=$(git-rev-parse --verify --revs-only --no-flags --sq --default HEAD "$@") || exit
+flags=$(git-rev-parse --no-revs --flags --sq "$@")
+files=$(git-rev-parse --no-revs --no-flags --sq "$@")
+
+# Match the behaviour of "git diff":
+#  - if we do not have --name-status, --name-only nor -r, default to -p.
+#  - if we do not have -B nor -C, default to -M.
+case " $flags " in
+*" '--name-status' "* | *" '--name-only' "* | *" '-r' "* )
+	;;
+*)
+	flags="$flags'-p' " ;;
+esac
+case " $flags " in
+*" '-"[BCM]* | *" '--find-copies-harder' "*)
+	;; # something like -M50.
+*)
+	flags="$flags'-M' " ;;
+esac
+
+eval "git-diff-tree --always --cc --pretty $flags $rev -- $files" | LESS=-S ${PAGER:-less}
