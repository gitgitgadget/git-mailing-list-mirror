From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v2 09/13] bash prompt: use bash builtins to get detached HEAD
 abbrev. object name
Date: Tue, 18 Jun 2013 04:17:02 +0200
Message-ID: <1371521826-3225-10-git-send-email-szeder@ira.uka.de>
References: <1371521826-3225-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 18 04:18:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UolV4-00075l-3i
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 04:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753945Ab3FRCSW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Jun 2013 22:18:22 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:59819 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753901Ab3FRCSV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 22:18:21 -0400
Received: from localhost6.localdomain6 (f052037223.adsl.alicedsl.de [78.52.37.223])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MfBqk-1UzAXu0tdC-00OCcf; Tue, 18 Jun 2013 04:18:20 +0200
X-Mailer: git-send-email 1.8.3.1.487.g8f4672d
In-Reply-To: <1371521826-3225-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:0E+GUgkaEuFsTYi7HPYaY8Bmg6gwKQxtp5V8q3Gywhz
 I/JzrSPQXyqT/KRBVi2h4Gs+PlkXZKA8AeQrIH2AfEsNmU1TP5
 NUbvR9WLPXY7LoVH1QmcsR/pKfaaio4VrL6oMH5vX0YdWFTihk
 5zCZdekrFxUOWv36w5sLSsg6hoU0sic3bajeQG6oauGY5I6INE
 BNm/k0EhWes1qI0cvADEEPWP1YkbW0pzbEHpD2XoiZADi1lB3Z
 UcSVXzTpBGleAIn/3bI2d/QkfFkCzRACD8mgCVxmJT6eOM9YsC
 uvh7lMtwbJAUcSNNhjqC1x+7VP30BZWgvdsrmM3nsriz0Cssqp
 2sKlmpM18rMBH/WIiv4tRaf1jMDiiWCRC06f5Oai2G4NZ3UPvF
 40p5tmdrk9f3g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228142>

=46rom: SZEDER G=C3=A1bor <szeder@ira.uka.de>

When describing a detached HEAD according to the $GIT_PS1_DESCRIBE
environment variable fails, __git_ps1() runs the '$(cut -c1-7
=2Egit/HEAD)' command substitution to put the 7 hexdigits abbreviated
commit object name in the prompt.  This imposes the overhead of
fork()ing a subshell and fork()+exec()ing 'cut'.

Thanks to the previous patch at this point the contents of HEAD has
already been read into a variable, so we can get the 7 hexdigits using
only parameter expansions, sparing the fork()+exec() overhead.

Since zsh doesn't implement substring expansion we can't just use
${head:0:7}, hence the "remove everything except the first 7 chars"
parameter expansion combination.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-prompt.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-=
prompt.sh
index 4e5c8efa..10ec6902 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -378,9 +378,8 @@ __git_ps1 ()
 				(* | default)
 					git describe --tags --exact-match HEAD ;;
 				esac 2>/dev/null)" ||
-
-				b=3D"$(cut -c1-7 "$g/HEAD" 2>/dev/null)..." ||
-				b=3D"unknown"
+				# detached head abbreviated object name
+				b=3D"${head%${head#???????}}..."
 				b=3D"($b)"
 			fi
 		fi
--=20
1.8.3.1.487.g8f4672d
