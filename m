From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 1/2] bash: add helper function to get config variables for
	completion
Date: Thu, 14 Oct 2010 10:58:46 +0200
Message-ID: <1287046727-22509-1-git-send-email-szeder@ira.uka.de>
References: <20101014085538.GB838@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 14 10:59:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6Jee-0006l8-EI
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 10:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755085Ab0JNI7J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Oct 2010 04:59:09 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:64481 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755074Ab0JNI7I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Oct 2010 04:59:08 -0400
Received: from [127.0.1.1] (p5B130B36.dip0.t-ipconnect.de [91.19.11.54])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0MBZzS-1OvtWt2Uys-00AA0T; Thu, 14 Oct 2010 10:58:54 +0200
X-Mailer: git-send-email 1.7.3.1.151.g3779c
In-Reply-To: <20101014085538.GB838@neumann>
X-Provags-ID: V02:K0:P5wFQxvm7ovXXIWuTREbQ81JJIM/SAnywQ0BdCryqlM
 QS38du3bH2ofZsE7WRQSCQCN/1h7LskZfR0Tv+4SIa2Op6fPZV
 e5lmuZfnAQv0vl8bqlXHvJPvq1xJCmY+PN7HLR/sXKxGJ4H00Z
 IVXAiIiWI2vwo7qexlgV0Ms0fP46Ib5l9WHs+UCzhCTyZgq0lj
 peXStremTTZyW/Mx8dY9g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159032>

Currently there are three completion functions that perform similar
queries to 'git config' to get config variable names.  These are the
completion of aliases, remotes, and remote groups for 'git remote
update'.  Since the following patch is about to add yet another
similar 'git config'-querying completion function to support pretty
aliases, it's time to introduce a unified helper function first to
avoid redundant code.

We took care that the resulting helper function still copes well with
newlines in config variable values and that it works with 'set -u'
(see commits e0d7805 (completion: fix alias listings with newlines,
2009-10-08) and 25a31f8 (bash-completion: Support running when set -u
is enabled, 2009-01-15) for details).

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |   28 +++++++++++-------------=
----
 1 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index f83f019..97a3d8c 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -451,10 +451,7 @@ __git_remotes ()
 		echo ${i#$d/remotes/}
 	done
 	[ "$ngoff" ] && shopt -u nullglob
-	for i in $(git --git-dir=3D"$d" config --get-regexp 'remote\..*\.url'=
 2>/dev/null); do
-		i=3D"${i#remote.}"
-		echo "${i/.url*/}"
-	done
+	__git_get_config_variables "remote" "url"
 }
=20
 __git_list_merge_strategies ()
@@ -750,14 +747,16 @@ __git_compute_porcelain_commands ()
 	: ${__git_porcelain_commands:=3D$(__git_list_porcelain_commands)}
 }
=20
-__git_aliases ()
+# returns all config variables within a given section with an optional
+# suffix, with both the section name and the suffix removed
+__git_get_config_variables ()
 {
-	local i IFS=3D$'\n'
-	for i in $(git --git-dir=3D"$(__gitdir)" config --get-regexp "alias\.=
=2E*" 2>/dev/null); do
+	local section=3D"$1" suffix=3D"${2-}" i IFS=3D$'\n'
+	for i in $(git --git-dir=3D"$(__gitdir)" config --get-regexp "$sectio=
n\..*${suffix:+\.$suffix}" 2>/dev/null); do
 		case "$i" in
-		alias.*)
-			i=3D"${i#alias.}"
-			echo "${i/ */}"
+		$section.*)
+			i=3D"${i#$section.}"
+			echo "${i/${suffix:+.$suffix} */}"
 			;;
 		esac
 	done
@@ -2017,12 +2016,7 @@ _git_remote ()
 		__gitcomp "$(__git_remotes)"
 		;;
 	update)
-		local i c=3D'' IFS=3D$'\n'
-		for i in $(git --git-dir=3D"$(__gitdir)" config --get-regexp "remote=
s\..*" 2>/dev/null); do
-			i=3D"${i#remotes.}"
-			c=3D"$c ${i/ */}"
-		done
-		__gitcomp "$c"
+		__gitcomp "$(__git_get_config_variables "remotes")"
 		;;
 	*)
 		COMPREPLY=3D()
@@ -2366,7 +2360,7 @@ _git ()
 			"
 			;;
 		*)     __git_compute_porcelain_commands
-		       __gitcomp "$__git_porcelain_commands $(__git_aliases)" ;;
+		       __gitcomp "$__git_porcelain_commands $(__git_get_config_varia=
bles "alias")" ;;
 		esac
 		return
 	fi
--=20
1.7.3.1.151.g3779c
