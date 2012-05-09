From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 15/19] bash prompt: use bash builtins to get detached HEAD
	abbrev. object name
Date: Wed,  9 May 2012 02:44:46 +0200
Message-ID: <1336524290-30023-16-git-send-email-szeder@ira.uka.de>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 02:47:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRv3r-0005NI-1h
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 02:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756681Ab2EIArT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 20:47:19 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:61251 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755812Ab2EIArS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 20:47:18 -0400
Received: from localhost6.localdomain6 (p5B130353.dip0.t-ipconnect.de [91.19.3.83])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0LjweT-1Rq6Ky1EHx-00bnYV; Wed, 09 May 2012 02:47:17 +0200
X-Mailer: git-send-email 1.7.10.1.541.gb1be298
In-Reply-To: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:70SX4wMgptgHpPD9rIKllvsuIynrbg261AH3oTtaApF
 ggwqEWSNt2liH8q/NisdHQksl6yssjyviOPj96e7TuyS3WO4wT
 9Ciin9Y0W2S1hgSKrrc8Xs7UPjn8cNAPlxucbikzBcME7h3llo
 eIwyoJUwda4AxBqcvpSkBCAM09zbUMRwLkK60WDqI/v3PbLDxg
 t9aVwB8x+PmPoeFcXbpEnJH418QHT6PG6auAf96KjPqRibGaB1
 MaIDDwzueDlGYYSCc9QBD/ZHww085yw2GofNlheHhKkjW46+73
 lCyBP1LI+EsWDvE2gg/q2KWkns28YkkCXNqXfBg9g3P2nMohba
 Si+fC8MMVDyF2BK8IzCS5HSuqDuuX326wNEoZ5pLh3QEbkTYst
 SkNwMdlDvyzYA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197446>

When describing a detached HEAD according to the $GIT_PS1_DESCRIBE
environment variable fails, __git_ps1() runs the '$(cut -c1-7
=2Egit/HEAD)' command substitution to put the 7 hexdigits abbreviated
commit object name in the prompt.  This imposes the overhead of
fork()ing a subshell and fork(+exec()ing 'cut'.

Thanks to an earlier commit in this series the contents of HEAD is
already read into a local variable, so we can get the 7 hexdigits
using only parameter expansions, sparing the fork()+exec() overhead.

Since zsh doesn't implement substring expansion we can't just use
${head:0:7}, hence the "remove everything except the first 7 chars"
parameter expansion combination.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 671032bf..2346962d 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -310,8 +310,8 @@ __git_ps1 ()
 				git describe --tags --exact-match HEAD ;;
 			esac 2>/dev/null)" ||
=20
-			b=3D"$(cut -c1-7 "$__git_dir/HEAD" 2>/dev/null)..." ||
-			return
+			# detached head abbreviated object name
+			b=3D"${head%${head#???????}}..."
 			b=3D"($b)"
 		fi
 	fi
--=20
1.7.10.1.541.gb1be298
