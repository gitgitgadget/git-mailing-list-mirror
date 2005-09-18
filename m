From: Linus Torvalds <torvalds@osdl.org>
Subject: Improved "git add"
Date: Sun, 18 Sep 2005 11:27:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509181119040.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Sep 18 20:28:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH3tJ-0006CS-Ii
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 20:27:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbVIRS1v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 14:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbVIRS1v
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 14:27:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12454 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932161AbVIRS1u (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Sep 2005 14:27:50 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8IIRjBo009356
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 18 Sep 2005 11:27:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8IIRj0N024411;
	Sun, 18 Sep 2005 11:27:45 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8804>


This fixes everybodys favourite complaint about "git add", namely that it 
doesn't take directories.

We use "git-ls-files --others" to generate an arbitrary list of filenames, 
and thus also automatically honor ignore-files while we're at it.

Side note: there's a lot of room for improvement here. In particular, if
we have a long list of filenames (importing a big archive), this will just
do a big stupid for-loop and add them one at a time. Maybe it should use

	generate-list | xargs -0 git-update-idex --add --

instead.

Also, I think we should have a default ignore list if we don't find a 
.git/info/exclude file. Ignoring "*.o" and ".*" by default would probably 
be the right thing to do.

But I think this is a good first step.

Use the "-n" flag to just show the list of files to be added without 
adding them. 

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

NOTE! This depends on the previous patch that added "--git-dir" to 
git-rev-parse

diff --git a/git-add.sh b/git-add.sh
--- a/git-add.sh
+++ b/git-add.sh
@@ -1,2 +1,32 @@
 #!/bin/sh
-git-update-index --add -- "$@"
+
+show_only=
+verbose=
+while : ; do
+  case "$1" in
+    -n)
+	show_only=true
+	verbose=true
+	;;
+    -v)
+	verbose=true
+	;;
+    *)
+	break
+	;;
+  esac
+  shift
+done
+
+GIT_DIR=$(git-rev-parse --git-dir) || exit
+global_exclude=
+if [ -f "$GIT_DIR/info/exclude" ]; then
+   global_exclude="--exclude-from=$GIT_DIR/info/exclude"
+fi
+for i in $(git-ls-files --others \
+	$global_exclude --exclude-per-directory=.gitignore \
+	"$@")
+do
+   [ "$verbose" ] && echo "  $i"
+   [ "$show_only" ] || git-update-index --add -- "$i" || exit
+done
