From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 11/19] bash prompt: use bash builtins to find out current
	branch
Date: Wed,  9 May 2012 02:44:42 +0200
Message-ID: <1336524290-30023-12-git-send-email-szeder@ira.uka.de>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 02:47:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRv3U-0005FO-Lh
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 02:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755706Ab2EIAqs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 20:46:48 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:54022 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755294Ab2EIAqs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 20:46:48 -0400
Received: from localhost6.localdomain6 (p5B130353.dip0.t-ipconnect.de [91.19.3.83])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0MCTBN-1SIoMh46fx-009F2u; Wed, 09 May 2012 02:46:47 +0200
X-Mailer: git-send-email 1.7.10.1.541.gb1be298
In-Reply-To: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:H8HWZLV/U9iAfF9AHRxT2VDGSZ4BgWV3YHLkS5ituBW
 oPJptRNRGtgdM5b3hpkcTSNUZm5iLtTsgXlalvnOE1CQSiOj5d
 yx2RJGFinHlzjfpDDnLIxur9GLlwRZ4BbEfbRFWJuwbZRA4Ao+
 YP+N9YjKC8aZ6jUcEJUHP4tC/rm/yM/bssg2ULWKHDJ5z72G4p
 fnL8UEU2Zodi4RAtLP468NHwS3c1OCzQuRJN8w7Y3fjEsw8aam
 8VWInN1j++46TR+zWqINaK1I/lwN759/1S+RJajw1ocFe3x3iY
 OBNeA807BI38G9Ry1xVGb43oPETrVBEwAeBZeS9UaAFPiQKfy2
 M2zfjg/9c7Fo3Dkd/3DNF3uNSy5YtAE4npP/RCVmhPcnkqLEMs
 EGT+GdFFKLOvQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197443>

__git_ps1() runs the '$(git symbolic-ref HEAD)' command substitution
to find out whether we are on a branch and to find out the name of
that branch.  This imposes the overhead of fork()ing a subshell and
fork()+exec()ing a git process.

Since HEAD is a single-line file and the symbolic ref format is quite
simple to recognize and parse, read and parse it using only bash
builtins, thereby sparing all that fork()+exec() overhead.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index dd69e56e..ed372c41 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -293,8 +293,11 @@ __git_ps1 ()
 			r=3D"|BISECTING"
 		fi
=20
-		b=3D"$(git symbolic-ref HEAD 2>/dev/null)" || {
-
+		local head=3D""
+		read head 2>/dev/null <"$__git_dir/HEAD" || return
+		# is it a symbolic ref?
+		b=3D"${head#ref: }"
+		if [ "$head" =3D "$b" ]; then
 			b=3D"$(
 			case "${GIT_PS1_DESCRIBE_STYLE-}" in
 			(contains)
@@ -310,7 +313,7 @@ __git_ps1 ()
 			b=3D"$(cut -c1-7 "$__git_dir/HEAD" 2>/dev/null)..." ||
 			return
 			b=3D"($b)"
-		}
+		fi
 	fi
=20
 	local w=3D""
--=20
1.7.10.1.541.gb1be298
