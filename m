From: =?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] bash: fix long option with argument double completion
Date: Wed,  5 Mar 2008 20:07:49 +0100
Message-ID: <1204744069-27217-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, spearce@spearce.org,
	=?utf-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 05 20:10:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWyyc-0002CI-Gs
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 20:08:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbYCETHx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Mar 2008 14:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbYCETHx
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 14:07:53 -0500
Received: from francis.fzi.de ([141.21.7.5]:16606 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751147AbYCETHw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 14:07:52 -0500
Received: from fzi.de ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 5 Mar 2008 20:07:47 +0100
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <>
References: <>
X-OriginalArrivalTime: 05 Mar 2008 19:07:47.0728 (UTC) FILETIME=[33441900:01C87EF4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76249>

Pressing TAB right after 'git command --long-option=3D' results in
'git command --long-option=3D--long-option=3D' when the long option req=
uires
an argument, but we don't provide completion for its arguments (e.g.
commit --author=3D, apply --exclude=3D).  This patch detects these long
options and provides empty completion array for them.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index d890f16..18b4001 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -113,13 +113,21 @@ __gitcomp ()
 	if [ $# -gt 2 ]; then
 		cur=3D"$3"
 	fi
-	for c in $1; do
-		case "$c$4" in
-		--*=3D*) all=3D"$all$c$4$s" ;;
-		*.)    all=3D"$all$c$4$s" ;;
-		*)     all=3D"$all$c$4 $s" ;;
-		esac
-	done
+	case "$cur" in
+	--*=3D)
+		COMPREPLY=3D()
+		return
+		;;
+	*)
+		for c in $1; do
+			case "$c$4" in
+			--*=3D*) all=3D"$all$c$4$s" ;;
+			*.)    all=3D"$all$c$4$s" ;;
+			*)     all=3D"$all$c$4 $s" ;;
+			esac
+		done
+		;;
+	esac
 	IFS=3D$s
 	COMPREPLY=3D($(compgen -P "$2" -W "$all" -- "$cur"))
 	return
--=20
1.5.4.3

