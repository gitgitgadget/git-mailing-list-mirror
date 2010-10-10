From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] bash: support more 'git notes' subcommands and their options
Date: Sun, 10 Oct 2010 23:43:33 +0200
Message-ID: <1286747013-8325-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Oct 10 23:43:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P53gG-0004V6-5v
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 23:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837Ab0JJVnh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Oct 2010 17:43:37 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:52470 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab0JJVnh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 17:43:37 -0400
Received: from [127.0.1.1] (p5B130D54.dip0.t-ipconnect.de [91.19.13.84])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MbtgI-1PNHJh1n6M-00IlLI; Sun, 10 Oct 2010 23:43:36 +0200
X-Mailer: git-send-email 1.7.3.1.148.g2fffa
X-Provags-ID: V02:K0:JnbPiZfkT8FrTQ/lQAC5/7Mb8J24MDQefq6KvRVsW/9
 UodlNgItNC0iPVC0zmTOWhhh3gX2KkPj/Rkw7fsXmJHtOV/bAi
 zDZ++O0k1RPRI81pd6UuzidMdhRdIVRNmB5RhMGVMb+Jja7kH3
 RkeWNuRsn8cXaxR0XAOgKQyNu4Dj4sYsn/2XwnzSeOPiC+MjxC
 X27vUd45qIHa5fOp8dEpA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158716>

The current completion function for 'git notes' only supported the
'edit' and 'show' subcommands and none of their options.  This patch
adds support for all missing subcommands, options, and their arguments
(files or refs), if any.

The code responsible for completing subcommand looks different
compared to the completion functions of other git commands with
subcommands.  This is because of the '--ref <notes-ref>' option which
comes before the subcommand (i.e. git notes --ref <notes-ref> add).

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |   50 ++++++++++++++++++++++++=
++------
 1 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 6756990..d57316c 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1468,18 +1468,50 @@ _git_name_rev ()
=20
 _git_notes ()
 {
-	local subcommands=3D"edit show"
-	if [ -z "$(__git_find_on_cmdline "$subcommands")" ]; then
-		__gitcomp "$subcommands"
-		return
-	fi
+	local subcommands=3D'add append copy edit list prune remove show'
+	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
+	local cur=3D"${COMP_WORDS[COMP_CWORD]}"
=20
-	case "${COMP_WORDS[COMP_CWORD-1]}" in
-	-m|-F)
-		COMPREPLY=3D()
+	case "$subcommand,$cur" in
+	,--*)
+		__gitcomp '--ref'
+		;;
+	,*)
+		case "${COMP_WORDS[COMP_CWORD-1]}" in
+		--ref)
+			__gitcomp "$(__git_refs)"
+			;;
+		*)
+			__gitcomp "$subcommands --ref"
+			;;
+		esac
+		;;
+	add,--reuse-message=3D*|append,--reuse-message=3D*)
+		__gitcomp "$(__git_refs)" "" "${cur##--reuse-message=3D}"
+		;;
+	add,--reedit-message=3D*|append,--reedit-message=3D*)
+		__gitcomp "$(__git_refs)" "" "${cur##--reedit-message=3D}"
+		;;
+	add,--*|append,--*)
+		__gitcomp '--file=3D --message=3D --reedit-message=3D
+				--reuse-message=3D'
+		;;
+	copy,--*)
+		__gitcomp '--stdin'
+		;;
+	prune,--*)
+		__gitcomp '--dry-run --verbose'
+		;;
+	prune,*)
 		;;
 	*)
-		__gitcomp "$(__git_refs)"
+		case "${COMP_WORDS[COMP_CWORD-1]}" in
+		-m|-F)
+			;;
+		*)
+			__gitcomp "$(__git_refs)"
+			;;
+		esac
 		;;
 	esac
 }
--=20
1.7.3.1.148.g2fffa
