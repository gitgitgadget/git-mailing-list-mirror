From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [RFC PATCH 18/19] bash prompt: avoid command substitution when
	checking for untracked files
Date: Wed,  9 May 2012 02:44:49 +0200
Message-ID: <1336524290-30023-19-git-send-email-szeder@ira.uka.de>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 02:47:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRv4M-0005dk-KM
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 02:47:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757297Ab2EIArs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 20:47:48 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:50728 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753746Ab2EIArp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 20:47:45 -0400
Received: from localhost6.localdomain6 (p5B130353.dip0.t-ipconnect.de [91.19.3.83])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0McLz9-1SkxNz10kh-00IzTo; Wed, 09 May 2012 02:47:40 +0200
X-Mailer: git-send-email 1.7.10.1.541.gb1be298
In-Reply-To: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:xe2/KotqJqTbwc6dKW6aN8QbqLmXmxkgyV7RDVxyyKC
 lZrlXquQUeLZ44mym0ppMf4jzvyHg3SxtyNEqlPLQo5mJ2JDqj
 Bwxtfxbsuf4I/FOUCn4FsM+ZgdQqxCOI0TaUKA0cGwDkdULQQe
 3wqYnbkcd9YWU8K+PmSLT9Kw0Oqk2zX0D6+YmQ2YhivlhEKDm1
 eSQvgwE2PNYyMH1I5i+A/O9cav36wofAAUORlnMVH3zI0Obqz7
 nC75pGlUVYyYFYpPcQzriZB92iDbHyvW9WC3GzX/+/HTx/6I3W
 98OdKPj+IzbbjvOtGTc0t2kwBLggAC6YTTsyHRebUfj1NTyGSU
 97z+EJcAJgS3CPalhopkq7by0zjNL9Ykx5kj3lRR2+maPR6Df+
 X1DKf/mKkrI7Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197451>

When enabled, the bash prompt can indicate the presence of untracked
files with a '%' sign.  __git_ps1() checks for untracked files by runni=
ng the
'$(git ls-files --others --exclude-standard)' command substitution,
and displays the indicator when there is no output.

Avoid this command substitution by additionally passing
'--error-unmatch *', and checking the command's return value.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

This seems to do the right thing, but I'm not quite sure, so I would
appreciate a pair of expert eyeballs on it.

 contrib/completion/git-completion.bash | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index c4feab68..5ea19018 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -348,9 +348,8 @@ __git_ps1 ()
 			fi
=20
 			if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ]; then
-				if [ -n "$(git ls-files --others --exclude-standard)" ]; then
-					u=3D"%"
-				fi
+				git ls-files --others --exclude-standard --error-unmatch -- '*' >/=
dev/null 2>/dev/null &&
+				u=3D"%"
 			fi
 		fi
 	fi
--=20
1.7.10.1.541.gb1be298
