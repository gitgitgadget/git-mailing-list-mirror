From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH 1/4] Teach git mergetool to use custom commands defined at config time
Date: Sun, 17 Feb 2008 10:23:08 +0000
Message-ID: <b63a66ef2a97cd3e791476a74bdb7081bcd57637.1203242325.git.charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 17 11:23:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQggc-0004eg-PB
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 11:23:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754791AbYBQKXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 05:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754746AbYBQKXU
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 05:23:20 -0500
Received: from pih-relay05.plus.net ([212.159.14.132]:50091 "EHLO
	pih-relay05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754666AbYBQKXT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 05:23:19 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay05.plus.net with esmtp (Exim) id 1JQgg0-0001NO-GJ
	for git@vger.kernel.org; Sun, 17 Feb 2008 10:23:16 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m1HAN8UB022727
	for <git@vger.kernel.org>; Sun, 17 Feb 2008 10:23:08 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m1HAN82W022726
	for git@vger.kernel.org; Sun, 17 Feb 2008 10:23:08 GMT
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Plusnet-Relay: 9109b3acf6b9ffea7ee1d01b0154097a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74111>

Currently git mergetool is restricted to a set of commands defined
in the script. You can subvert the mergetool.<tool>.path to force
git mergetool to use a different command, but if you have a command
whose invocation syntax does not match one of the current tools then
you would have to write a wrapper script for it.

This patch adds three git config variable patterns which allow a more
flexible choice of merge tool.

If you run git mergetool with -t/--tool or the merge.tool config
variable set to an unrecognized tool then git mergetool will query the
mergetool.<tool>.cmd config variable. If this variable exists, then
git mergetool will treat the specified tool as a custom command and
will use a shell eval to run the command so that the appropriate shell
variables can be used to find the merge temporary files.

mergetool.<tool>.trustExitCode can be used to indicate that the exit
code of the custom command can be used to determine the success of the
merge. mergetool.<tool>.keepBackup can be used to specify whether the
original pre-merge file with conflict markers should be kept as a
'.orig' file after the merge tool completes.

Signed-off-by: Charles Bailey <charles@hashpling.org>
---

This series of patches are a cleaned and improved version of the
earlier RFC patch that I sent.

They are in decreasing order of how much I care about / like them, and
I'm happy to have them squashed or to submit a squashed set of 2,3 or 4
of the patches.

 Documentation/config.txt |   25 +++++++++++++++++++++++--
 git-mergetool.sh         |   29 +++++++++++++++++++++++++++--
 2 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f9bdb16..12d87d4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -689,8 +689,10 @@ merge.summary::
 
 merge.tool::
 	Controls which merge resolution program is used by
-	linkgit:git-mergetool[1].  Valid values are: "kdiff3", "tkdiff",
-	"meld", "xxdiff", "emerge", "vimdiff", "gvimdiff", and "opendiff".
+	linkgit:git-mergetool[1].  Valid built-in values are: "kdiff3",
+	"tkdiff", "meld", "xxdiff", "emerge", "vimdiff", "gvimdiff", and
+	"opendiff".  Any other value is treated is custom merge tool
+	and there must be a corresponing mergetool.<tool>.cmd option.
 
 merge.verbosity::
 	Controls the amount of output shown by the recursive merge
@@ -717,6 +719,25 @@ mergetool.<tool>.path::
 	Override the path for the given tool.  This is useful in case
 	your tool is not in the PATH.
 
+mergetool.<tool>.cmd::
+	Specify the command to invoke the specified merge tool.  The
+	specified command is evaluated in shell with the following
+	variables available: 'BASE' is the name of a temporary file
+	containing the common base of the files to be merged, if available;
+	'LOCAL' is the name of a temporary file containing the contents of
+	the file on the current branch; 'REMOTE' is the name of a temporary
+	file containing the contents of the file from the branch being
+	merged; 'path' contains the name of the file to which the merge
+	tool should write the results of a successful merge.
+
+mergetool.<tool>.trustExitCode::
+	For a custom merge command, specify whether the exit code of
+	the merge command can be used to determine whether the merge was
+	successful.  If this is not set to true then the merge target file
+	timestamp is checked and the merge assumed to have been successful
+	if the file has been updated, otherwise the user is prompted to
+	indicate the success of the merge.
+
 pack.window::
 	The size of the window used by linkgit:git-pack-objects[1] when no
 	window size is given on the command line. Defaults to 10.
diff --git a/git-mergetool.sh b/git-mergetool.sh
index cbbb707..cf30e21 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -271,6 +271,19 @@ merge_file () {
 	    status=$?
 	    save_backup
 	    ;;
+	*)
+	    if test -n "$merge_tool_cmd"; then
+		if test "$merge_tool_trust_exit_code" = "false"; then
+		    touch "$BACKUP"
+		    ( eval $merge_tool_cmd )
+		    check_unchanged
+		else
+		    ( eval $merge_tool_cmd )
+		    status=$?
+		fi
+		save_backup
+	    fi
+	    ;;
     esac
     if test "$status" -ne 0; then
 	echo "merge of $path failed" 1>&2
@@ -309,12 +322,20 @@ do
     shift
 done
 
+valid_custom_tool()
+{
+    merge_tool_cmd="$(git config mergetool.$1.cmd)"
+    test -n "$merge_tool_cmd"
+}
+
 valid_tool() {
 	case "$1" in
 		kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | ecmerge)
 			;; # happy
 		*)
-			return 1
+			if ! valid_custom_tool "$1"; then
+				return 1
+			fi
 			;;
 	esac
 }
@@ -380,10 +401,14 @@ else
 
     init_merge_tool_path "$merge_tool"
 
-    if ! type "$merge_tool_path" > /dev/null 2>&1; then
+    if test -z "$merge_tool_cmd" && ! type "$merge_tool_path" > /dev/null 2>&1; then
         echo "The merge tool $merge_tool is not available as '$merge_tool_path'"
         exit 1
     fi
+
+    if ! test -z "$merge_tool_cmd"; then
+        merge_tool_trust_exit_code="$(git config --bool mergetool.$merge_tool.trustExitCode || echo false)"
+    fi
 fi
 
 
-- 
1.5.4.1.34.g94bf
