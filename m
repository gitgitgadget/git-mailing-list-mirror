From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] cg-help: dynamically list commands
Date: Sat, 11 Jun 2005 14:37:42 +0200
Message-ID: <20050611123742.GA1477@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 11 14:33:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dh5BP-0000tZ-UE
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 14:33:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVFKMiC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Jun 2005 08:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbVFKMiC
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jun 2005 08:38:02 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:40695 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261357AbVFKMhq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Jun 2005 08:37:46 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 270F96E1B4B; Sat, 11 Jun 2005 14:36:55 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 866896E0CFD; Sat, 11 Jun 2005 14:36:52 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 03D2E61FE0; Sat, 11 Jun 2005 14:37:42 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Use code from the make-cogito-asciidoc script to make the command
listing dynamic and hopefully always up-to-date by grepping the
USAGE strings.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

 cg-commit |    2 +-
 cg-help   |   47 +++++++++++++++++++++--------------------------
 2 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/cg-commit b/cg-commit
--- a/cg-commit
+++ b/cg-commit
@@ -72,7 +72,7 @@
 # EDITOR::
 #	The editor used for entering revision log information.
 
-USAGE="cg-commit [-mMESSAGE]... [-C] [-e | -E] [FILE]..."
+USAGE="cg-commit [-mMESSAGE]... [-C] [-e | -E] [FILE]... < MESSAGE"
 
 . ${COGITO_LIB}cg-Xlib
 
diff --git a/cg-help b/cg-help
--- a/cg-help
+++ b/cg-help
@@ -25,6 +25,25 @@ if [ "$1" ]; then
 	exit 1
 fi
 
+bin_path="$(dirname $0)"
+
+REGULAR_COMMANDS="$(ls $bin_path/cg-* | grep -v cg-admin- | grep -v cg-X)"
+ADVANCED_COMMANDS="$(ls $bin_path/cg-admin-*)"
+
+print_command_listing()
+{
+	for command in "$@"; do
+		cmdname=$(basename $command)
+
+		usage=$(sed -n '/^USAGE=/,0s/.*\(cg-.*\)"/\1/p' < $command)
+		# Some minimal sanity check that we didn't pick up some
+		# random binary named cg-*
+		[ "$usage" ] || continue
+		usage=$(echo "$usage" | sed 's/cg-[^ ]*//')
+		printf "	%-17s %s\n" "$cmdname" "$usage"
+	done
+}
+
 
 cat <<__END__
 The Cogito version control system  $(cg-version)
@@ -32,34 +51,10 @@ The Cogito version control system  $(cg-
 Usage: cg-COMMAND [ARG]...
 
 Available commands:
-	cg-add		FILE...
-	cg-branch-add	BNAME SOURCE_LOC
-	cg-branch-ls
-	cg-cancel
-	cg-clone	[-s] SOURCE_LOC [DESTDIR]
-	cg-commit	[-m"Commit message"]... [-e | -E] [FILE]... < log message
-	cg-diff		[-c] [-m] [-p] [-r FROM_ID[:TO_ID]] [FILE]...
-	cg-export	DEST [TREE_ID]
-	cg-help		[COMMAND]
-	cg-init
-	cg-log		[-c] [-f] [-m] [-r FROM_ID[:TO_ID]] [FILE]...
-	cg-merge	[-c] [-b BASE_ID] FROM_ID
-	cg-mkpatch	[-m] [-s] [-r FROM_ID[:TO_ID]]
-	cg-patch			< patch on stdin
-	cg-pull		[BNAME]
-	cg-restore	[FILE]...
-	cg-rm		FILE...
-	cg-seek		[COMMIT_ID]
-	cg-status
-	cg-tag		TNAME [COMMIT_ID]
-	cg-tag-ls
-	cg-update	[BNAME]
-	cg-version
+$(print_command_listing $REGULAR_COMMANDS)
 
 Advanced (low-level or dangerous) commands:
-	cg-admin-ls	[-t TREE_ID] [PATH]
-	cg-admin-lsobj	[OBJTYPE]
-	cg-admin-uncommit [-t] [COMMIT_ID]
+$(print_command_listing $ADVANCED_COMMANDS)
 
 These expressions can be used interchangably as "ID"s:
 	empty string, "this" or "HEAD" (current HEAD)
-- 
Jonas Fonseca
