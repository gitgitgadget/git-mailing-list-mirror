From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH 2/3] Add -n/--no-prompt option to mergetool
Date: Tue, 21 Oct 2008 11:13:18 +0100
Message-ID: <1224583999-26279-2-git-send-email-charles@hashpling.org>
References: <1224583999-26279-1-git-send-email-charles@hashpling.org>
Cc: Jeff King <peff@peff.net>,
	William Pursell <bill.pursell@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Theodore Ts'o" <tytso@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 12:14:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsEG9-0002PX-Hs
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 12:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621AbYJUKNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 06:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752630AbYJUKNb
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 06:13:31 -0400
Received: from pih-relay06.plus.net ([212.159.14.19]:52332 "EHLO
	pih-relay06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584AbYJUKN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 06:13:29 -0400
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay06.plus.net with esmtp (Exim) id 1KsEEr-0006yp-2K; Tue, 21 Oct 2008 11:13:21 +0100
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id m9LADK7M026307
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 21 Oct 2008 11:13:20 +0100
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id m9LADKDB026306;
	Tue, 21 Oct 2008 11:13:20 +0100
X-Mailer: git-send-email 1.6.0.2.534.g5ab59
In-Reply-To: <1224583999-26279-1-git-send-email-charles@hashpling.org>
X-Plusnet-Relay: 04a4eb4b3477c0f8b303d24ab052226f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98769>

This option lets git mergetool invoke the conflict resolution program
without waiting for a user response each time.

Also added a mergetool.prompt (default true) configuration variable
controlling the same behaviour.

Signed-off-by: Charles Bailey <charles@hashpling.org>
---
 Documentation/config.txt        |    3 +++
 Documentation/git-mergetool.txt |   11 ++++++++++-
 git-mergetool.sh                |   16 +++++++++++++---
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 29369d0..b4e4ee4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -976,6 +976,9 @@ mergetool.keepBackup::
 	is set to `false` then this file is not preserved.  Defaults to
 	`true` (i.e. keep the backup files).
 
+mergetool.prompt::
+	Prompt before each invocation of the merge resolution program.
+
 pack.window::
 	The size of the window used by linkgit:git-pack-objects[1] when no
 	window size is given on the command line. Defaults to 10.
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index e0b2703..6d6bfe0 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -7,7 +7,7 @@ git-mergetool - Run merge conflict resolution tools to resolve merge conflicts
 
 SYNOPSIS
 --------
-'git mergetool' [--tool=<tool>] [<file>]...
+'git mergetool' [--tool=<tool>] [-n|--no-prompt|--prompt] [<file>]...
 
 DESCRIPTION
 -----------
@@ -60,6 +60,15 @@ variable `mergetool.<tool>.trustExitCode` can be set to `true`.
 Otherwise, 'git-mergetool' will prompt the user to indicate the
 success of the resolution after the custom tool has exited.
 
+-n or --no-prompt::
+	Don't prompt before each invocation of the merge resolution
+	program.
+
+--prompt::
+	Prompt before each invocation of the merge resolution program.
+	This is the default behaviour; the option is provided to
+	override any configuration settings.
+
 Author
 ------
 Written by Theodore Y Ts'o <tytso@mit.edu>
diff --git a/git-mergetool.sh b/git-mergetool.sh
index e2da5fc..8bc5366 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -8,7 +8,7 @@
 # at the discretion of Junio C Hamano.
 #
 
-USAGE='[--tool=tool] [file to merge] ...'
+USAGE='[--tool=tool] [-n|--no-prompt|--prompt] [file to merge] ...'
 SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
 . git-sh-setup
@@ -176,8 +176,10 @@ merge_file () {
     echo "Normal merge conflict for '$MERGED':"
     describe_file "$local_mode" "local" "$LOCAL"
     describe_file "$remote_mode" "remote" "$REMOTE"
-    printf "Hit return to start merge resolution tool (%s): " "$merge_tool"
-    read ans
+    if "$prompt" = true; then
+	printf "Hit return to start merge resolution tool (%s): " "$merge_tool"
+	read ans
+    fi
 
     case "$merge_tool" in
 	kdiff3)
@@ -280,6 +282,8 @@ merge_file () {
     cleanup_temp_files
 }
 
+prompt=$(git config --bool mergetool.prompt || echo true)
+
 while test $# != 0
 do
     case "$1" in
@@ -295,6 +299,12 @@ do
 		    shift ;;
 	    esac
 	    ;;
+	-n|--no-prompt)
+	    prompt=false
+	    ;;
+	--prompt)
+	    prompt=true
+	    ;;
 	--)
 	    break
 	    ;;
-- 
1.6.0.2.534.g5ab59
