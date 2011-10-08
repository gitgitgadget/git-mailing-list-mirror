From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 5/9] completion: support full refs from remote repositories
Date: Sat,  8 Oct 2011 16:54:39 +0200
Message-ID: <1318085683-29830-6-git-send-email-szeder@ira.uka.de>
References: <1318085683-29830-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 08 16:56:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCYK8-0000in-6N
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 16:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408Ab1JHO4T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Oct 2011 10:56:19 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:58796 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391Ab1JHO4S (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2011 10:56:18 -0400
Received: from localhost6.localdomain6 (p5B130863.dip0.t-ipconnect.de [91.19.8.99])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0LqpKo-1QZf4I35hi-00edR5; Sat, 08 Oct 2011 16:56:05 +0200
X-Mailer: git-send-email 1.7.7.187.ga41de
In-Reply-To: <1318085683-29830-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:sT2J3mZKHyJoXN3ZTKQhwbmd3S1UnCeQnL38CrTs2uk
 jWWFBBfow4i4oisO6eTVrv4WTBMjZ4mI+IckzDA/rH6ynHvxbx
 l0isbACzPf2zc7JIbqchPiJR0i9NAV1qgonY1idOuSN2qSb9sV
 X2pzlqZOcpZKJkPCcrqGsJNEzsZz0wJqvtqn6nB7Pov71oez7q
 QpHsGNPKf52AW4r/agUuEMoexKTmgCPQjS19YY3WPV/Gf5A8Yg
 S/VMReutdhWV99YXubIApiUiOeihGmXDVUk0ec3ehQweeyyCbK
 v0xQUBhBtLnAPWla9D1go0X0k0bHX4xa4ld7yzu+MyCSdazG5u
 GSDb/xyv6O0adeY+54tn8m5G0Zy978zzGVdI0r1MA++bcZVCu5
 kFx23jiRBD/6A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183149>

When the __git_refs() completion helper function lists refs from a
local repository, it usually lists the refs' short name, except when
it needs to provide completion for words starting with refs, because
in that case it lists full ref names, see 608efb87 (bash: complete
full refs, 2008-11-28).

Add the same functionality to the code path dealing with remote
repositories, too.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |   29 +++++++++++++++++++++---=
-----
 1 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index c6ab742d..a8d3597e 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -615,14 +615,27 @@ __git_refs ()
 		fi
 		return
 	fi
-	git ls-remote "$dir" HEAD ORIG_HEAD 'refs/tags/*' 'refs/heads/*' 'ref=
s/remotes/*' 2>/dev/null | \
-	while read hash i; do
-		case "$i" in
-		*^{}) ;;
-		refs/*) echo "${i#refs/*/}" ;;
-		*) echo "$i" ;;
-		esac
-	done
+	case "$cur" in
+	refs|refs/*)
+		git ls-remote "$dir" "$cur*" 2>/dev/null | \
+		while read hash i; do
+			case "$i" in
+			*^{}) ;;
+			*) echo "$i" ;;
+			esac
+		done
+		;;
+	*)
+		git ls-remote "$dir" HEAD ORIG_HEAD 'refs/tags/*' 'refs/heads/*' 're=
fs/remotes/*' 2>/dev/null | \
+		while read hash i; do
+			case "$i" in
+			*^{}) ;;
+			refs/*) echo "${i#refs/*/}" ;;
+			*) echo "$i" ;;
+			esac
+		done
+		;;
+	esac
 }
=20
 # __git_refs2 requires 1 argument (to pass to __git_refs)
--=20
1.7.7.187.ga41de
