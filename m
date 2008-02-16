From: Charles Bailey <charles@hashpling.org>
Subject: [RFC/PATCH] Teach git mergetool to use custom commands defined at config time
Date: Sat, 16 Feb 2008 18:53:49 +0000
Message-ID: <20080216185349.GA29177@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 16 19:54:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQSBR-0001iQ-9D
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 19:54:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753848AbYBPSyB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 13:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753388AbYBPSyB
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 13:54:01 -0500
Received: from pih-relay04.plus.net ([212.159.14.131]:54742 "EHLO
	pih-relay04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835AbYBPSx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 13:53:59 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay04.plus.net with esmtp (Exim) id 1JQSAh-0006GK-2t
	for git@vger.kernel.org; Sat, 16 Feb 2008 18:53:59 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m1GIrnkW029514
	for <git@vger.kernel.org>; Sat, 16 Feb 2008 18:53:49 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m1GIrndZ029513
	for git@vger.kernel.org; Sat, 16 Feb 2008 18:53:49 GMT
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Plusnet-Relay: f32eb1908447a8d98b6fa15f510a25e7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74059>

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
---

This is a preliminary patch which aims to make it easier to use
a.n.other 3-way merge tool with git-mergetool without either hacking
the source or writing a wrapper script for the tool.

It follows filter-branch's 'eval a user shell snippet' philosophy to
provide the flexibility and here in lies an ugliness. It exposes
git-mergetool.sh's private variables to the user script. The variables
are BASE, REMOTE, LOCAL and path.

My feeling is that we should give this consistent and documented
names, perhaps GIT_BASE, GIT_REMOTE, GIT_LOCAL, GIT_MERGED or similar.

Also, does anyone know of any reason why the temporary files should
not be cleaned up after an unsuccessful merge? As it is, every time
you abort a mergetool run you end up with another set of .$$.BASE
.$$.REMOTE and .$$.LOCAL files.

A further enhancement that I have thought about is providing a config
option like mergetool.<tool>.cmdNoBase for the case where there is no
base file, as in many cases it might be easier for the user to provide
a second command than to have shell conditionals in their config.

Just for reference I've tried this patch in the windows world with
things like:

git config --global mergetool.tortoise.cmd 'TortoiseMerge.exe \
/base:"$BASE" /theirs:"$REMOTE" /mine:"$LOCAL" /merged:"$path"'

git config --global mergetool.p4.cmd 'p4merge.exe "$BASE" "$REMOTE" \
"$LOCAL" "$path"'

git config --global mergetool.p4win.cmd 'P4WinMrg "$BASE" "$REMOTE" \
"$LOCAL" "$path"'

 Documentation/config.txt |   30 ++++++++++++++++++++++++++++--
 git-mergetool.sh         |   32 ++++++++++++++++++++++++++++++--
 2 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f9bdb16..e26c4b2 100644
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
@@ -717,6 +719,30 @@ mergetool.<tool>.path::
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
+mergetool.<tool>.keepBackup::
+	After performing a merge, the original file with conflict markers
+	can be saved as a file with a `.orig` extension.  If this variable
+	is set to `false` then this file is not preserved.
+
 pack.window::
 	The size of the window used by linkgit:git-pack-objects[1] when no
 	window size is given on the command line. Defaults to 10.
diff --git a/git-mergetool.sh b/git-mergetool.sh
index cbbb707..78c73ca 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -271,6 +271,21 @@ merge_file () {
 	    status=$?
 	    save_backup
 	    ;;
+	*)
+	    if test -n "$merge_tool_cmd"; then
+		touch "$BACKUP"
+		eval "$merge_tool_cmd"
+		status=$?
+		if test "$merge_tool_trust_exit_code" = "false"; then
+		    check_unchanged
+		fi
+		if test "$merge_tool_keep_backup" = "true"; then
+		    save_backup
+		else
+		    remove_backup
+		fi
+	    fi
+	    ;;
     esac
     if test "$status" -ne 0; then
 	echo "merge of $path failed" 1>&2
@@ -309,12 +324,20 @@ do
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
@@ -380,10 +403,15 @@ else
 
     init_merge_tool_path "$merge_tool"
 
-    if ! type "$merge_tool_path" > /dev/null 2>&1; then
+    if test -z "$merge_tool_cmd" && ! type "$merge_tool_path" > /dev/null 2>&1; then
         echo "The merge tool $merge_tool is not available as '$merge_tool_path'"
         exit 1
     fi
+
+    if ! test -z "$merge_tool_cmd"; then
+        merge_tool_trust_exit_code="$(git config --bool merge.$merge_tool.trustExitCode || echo false)"
+        merge_tool_keep_backup="$(git config --bool merge.$merge_tool.keepBackup || echo true)"
+    fi
 fi
 
 
-- 
1.5.4.1.144.gb4758f
