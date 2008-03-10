From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 2/2] bash: refactor searching for subcommands on the command line
Date: Mon, 10 Mar 2008 16:02:23 +0100
Message-ID: <1205161345-21120-2-git-send-email-szeder@ira.uka.de>
References: <1205161345-21120-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 10 16:04:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYjXD-0003YV-3K
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 16:03:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbYCJPC3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Mar 2008 11:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbYCJPC3
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 11:02:29 -0400
Received: from francis.fzi.de ([141.21.7.5]:44346 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751390AbYCJPC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 11:02:27 -0400
Received: from fzi.de ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 10 Mar 2008 16:02:24 +0100
X-Mailer: git-send-email 1.5.4.4.481.g5075
In-Reply-To: <1205161345-21120-1-git-send-email-szeder@ira.uka.de>
X-OriginalArrivalTime: 10 Mar 2008 15:02:24.0673 (UTC) FILETIME=[BFB4F110:01C882BF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76736>

This patch adds the __git_find_subcommand function, which takes one
argument: a string containing all subcommands separated by spaces.  The
function searches through the command line whether a subcommand is
already present.  The first found subcommand will be printed to standar=
d
output.

This enables us to remove code duplications from completion functions
for commands having subcommands.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |   71 ++++++++++++++----------=
-------
 1 files changed, 32 insertions(+), 39 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 39b2186..0feed97 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -436,6 +436,22 @@ __git_aliased_command ()
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
@@ -493,24 +509,14 @@ _git_add ()
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
-	if [ -z "$command" ]; then
-		__gitcomp "start bad good reset visualize replay log"
+	local subcommands=3D"start bad good reset visualize replay log"
+	local subcommand=3D"$(__git_find_subcommand "$subcommands")"
+	if [ -z "$subcommand" ]; then
+		__gitcomp "$subcommands"
 		return
 	fi
=20
-	case "$command" in
+	case "$subcommand" in
 	bad|good|reset)
 		__gitcomp "$(__git_refs)"
 		;;
@@ -1041,21 +1047,13 @@ _git_config ()
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
-	if [ -z "$command" ]; then
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
@@ -1129,28 +1127,23 @@ _git_show ()
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
-
-	if [ -z "$command" ]; then
+	local subcommands=3D"add status init update"
+	if [ -z "$(__git_find_subcommand "$subcommands")" ]; then
 		local cur=3D"${COMP_WORDS[COMP_CWORD]}"
 		case "$cur" in
 		--*)
 			__gitcomp "--quiet --cached"
 			;;
 		*)
-			__gitcomp "add status init update"
+			__gitcomp "$subcommands"
 			;;
 		esac
 		return
--=20
1.5.4.4.481.g5075
