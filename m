From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] bash: __git_find_subcommand function
Date: Thu,  6 Mar 2008 15:58:32 +0100
Message-ID: <1204815512-18128-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spearce@spearce.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 06 15:59:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXHYw-0007fK-5t
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 15:59:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758709AbYCFO6f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Mar 2008 09:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758676AbYCFO6f
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 09:58:35 -0500
Received: from francis.fzi.de ([141.21.7.5]:58743 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757927AbYCFO6e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 09:58:34 -0500
Received: from fzi.de ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 6 Mar 2008 15:58:32 +0100
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <>
References: <>
X-OriginalArrivalTime: 06 Mar 2008 14:58:32.0138 (UTC) FILETIME=[8B73EAA0:01C87F9A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76393>

This function takes one argument: a string containing all subcommands
separated by spaces.  The function searches through the command line
whether a subcommand is already present.  If a subcommand is found, it
will be printed to standard output.

This enables us to remove code duplications from completion
functions for commands having subcommands.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
This function does not return the index of the subcommand found on the
command line, which was in the $c variable previously.  However, $c was
only used in if statements, like:
	if [ $c -eq $COMP_CWORD -a -z "$command" ]; then
		__gitcomp "cmd1 cmd2 cmd3"
	fi
To my understanding the only(?) purpose of those if statements was to
prevent subcommands appearing again on the list of possible completions=
,
when there was one already on the command line.  But [ -z $command ] is
sufficient to detect those cases, so we can actually omit
[ $c -eq $COMP_CWORD ].  Is it right, or am I missing something?

Note, that some of the patches I sent out yesterday are in conflict wit=
h
these changes, namely:
* [PATCH 1/2] bash: add missing 'git stash save' subcommand
  is in conflict,
* [PATCH 2/2] bash: complete 'git stash' subcommands only once
  should be dropped,
* [PATCH 1/2] bash: add 'git svn' subcommands
  should be updated, and
* [PATCH 2/2] bash: add 'git svn' options
  should be updated (depends on the previous one).
I think that if this patch will get merged, then it should be merged
before those mentioned above.  It just doesn't make much sense e.g. to
merge 'complete 'git stash' subcommands only once' and then basically
revert it.  In this case, of course, I will send the updated patches.

 contrib/completion/git-completion.bash |   70 ++++++++++++++----------=
--------
 1 files changed, 31 insertions(+), 39 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 49e6df0..f9e29be 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -420,6 +420,22 @@ __git_aliased_command ()
 	done
 }
=20
+__git_find_subcommand ()
+{
+	local word subcommand c=3D1
+
+	while [ $c -lt $COMP_CWORD ]; do
+		word=3D"${COMP_WORDS[c]}"
+		for subcommand in $1; do
+			if [ "$subcommand" =3D "$word" ]; then
+				echo "$subcommand"
+				return
+			fi
+		done
+		c=3D$((++c))
+	done
+}
+
 __git_whitespacelist=3D"nowarn warn error error-all strip"
=20
 _git_am ()
@@ -477,24 +493,13 @@ _git_add ()
=20
 _git_bisect ()
 {
-	local i c=3D1 command
-	while [ $c -lt $COMP_CWORD ]; do
-		i=3D"${COMP_WORDS[c]}"
-		case "$i" in
-		start|bad|good|reset|visualize|replay|log)
-			command=3D"$i"
-			break
-			;;
-		esac
-		c=3D$((++c))
-	done
-
-	if [ $c -eq $COMP_CWORD -a -z "$command" ]; then
-		__gitcomp "start bad good reset visualize replay log"
+	local subcommands=3D"start bad good reset visualize replay log"
+	local subcommand=3D"$(__git_find_subcommand "$subcommands")"
+	if [ -z "$subcommand" ]; then
 		return
 	fi
=20
-	case "$command" in
+	case "$subcommand" in
 	bad|good|reset)
 		__gitcomp "$(__git_refs)"
 		;;
@@ -1025,21 +1030,13 @@ _git_config ()
=20
 _git_remote ()
 {
-	local i c=3D1 command
-	while [ $c -lt $COMP_CWORD ]; do
-		i=3D"${COMP_WORDS[c]}"
-		case "$i" in
-		add|rm|show|prune|update) command=3D"$i"; break ;;
-		esac
-		c=3D$((++c))
-	done
-
-	if [ $c -eq $COMP_CWORD -a -z "$command" ]; then
-		__gitcomp "add rm show prune update"
+	local subcommands=3D"add rm show prune update"
+	local subcommand=3D"$(__git_find_subcommand "$subcommands")"
+	if [ -z "$subcommand" ]; then
 		return
 	fi
=20
-	case "$command" in
+	case "$subcommand" in
 	rm|show|prune)
 		__gitcomp "$(__git_remotes)"
 		;;
@@ -1113,28 +1110,23 @@ _git_show ()
=20
 _git_stash ()
 {
-	__gitcomp 'list show apply clear'
+	local subcommands=3D'list show apply clear'
+	if [ -z "$(__git_find_subcommand "$subcommands")" ]; then
+		__gitcomp "$subcommands"
+	fi
 }
=20
 _git_submodule ()
 {
-	local i c=3D1 command
-	while [ $c -lt $COMP_CWORD ]; do
-		i=3D"${COMP_WORDS[c]}"
-		case "$i" in
-		add|status|init|update) command=3D"$i"; break ;;
-		esac
-		c=3D$((++c))
-	done
