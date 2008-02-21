From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH 3/4] Teach git mergetool to use custom commands defined at config time
Date: Thu, 21 Feb 2008 23:31:12 +0000
Message-ID: <0e0179231be0e23cc83fb72269def2f3de3ba420.1203636096.git.charles@hashpling.org>
References: <e6d984bbbb5d4dab54c38caa5c0c71b060d69156.1203636096.git.charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 00:33:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSKuV-0007TL-PT
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 00:33:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935444AbYBUXcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 18:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762994AbYBUXcS
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 18:32:18 -0500
Received: from pih-relay08.plus.net ([212.159.14.134]:42628 "EHLO
	pih-relay08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935403AbYBUXcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 18:32:16 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay08.plus.net with esmtp (Exim) id 1JSKtf-0003Ea-3P; Thu, 21 Feb 2008 23:32:11 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m1LNVDIA012200;
	Thu, 21 Feb 2008 23:31:13 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m1LNVDCx012199;
	Thu, 21 Feb 2008 23:31:13 GMT
Content-Disposition: inline
In-Reply-To: <e6d984bbbb5d4dab54c38caa5c0c71b060d69156.1203636096.git.charles@hashpling.org>
User-Agent: Mutt/1.4.2.1i
X-Plusnet-Relay: 363b3d64a2904ef8b09f7e65e5fbf144
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74680>

Currently git mergetool is restricted to a set of commands defined
in the script. You can subvert the mergetool.<tool>.path to force
git mergetool to use a different command, but if you have a command
whose invocation syntax does not match one of the current tools then
you would have to write a wrapper script for it.

This patch adds two git config variable patterns which allow a more
flexible choice of merge tool.

If you run git mergetool with -t/--tool or the merge.tool config
variable set to an unrecognized tool then git mergetool will query the
mergetool.<tool>.cmd config variable. If this variable exists, then git
mergetool will treat the specified tool as a custom command and will use
a shell eval to run the command with the documented shell variables set.

mergetool.<tool>.trustExitCode can be used to indicate that the exit
code of the custom command can be used to determine the success of the
merge.

Signed-off-by: Charles Bailey <charles@hashpling.org>
---
 Documentation/config.txt |   25 +++++++++++++++++++++++--
 git-mergetool.sh         |   28 ++++++++++++++++++++++++++--
 2 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4e17fd2..33b7ce9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -741,8 +741,10 @@ merge.summary::
 
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
@@ -769,6 +771,25 @@ mergetool.<tool>.path::
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
+	merged; 'MERGED' contains the name of the file to which the merge
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
 mergetool.keepBackup::
 	After performing a merge, the original file with conflict markers
 	can be saved as a file with a `.orig` extension.  If this variable
diff --git a/git-mergetool.sh b/git-mergetool.sh
index d3dd7f8..d12bedf 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -263,6 +263,18 @@ merge_file () {
 	    fi
 	    status=$?
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
+	    fi
+	    ;;
     esac
     if test "$status" -ne 0; then
 	echo "merge of $MERGED failed" 1>&2
@@ -308,12 +320,20 @@ do
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
@@ -381,10 +401,14 @@ else
 
     merge_keep_backup="$(git config --bool merge.keepBackup || echo true)"
 
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
1.5.4.2.133.g3d51e


-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
