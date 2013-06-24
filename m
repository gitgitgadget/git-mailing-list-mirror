From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCHv3 15/16] bash prompt: avoid command substitution when
 finalizing gitstring
Date: Mon, 24 Jun 2013 18:39:25 +0200
Message-ID: <1372091966-19315-16-git-send-email-szeder@ira.uka.de>
References: <1372091966-19315-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eduardo D'Avila <erdavila@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 24 18:45:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur9ts-0004vY-Ob
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 18:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195Ab3FXQpx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Jun 2013 12:45:53 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:55209 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079Ab3FXQpw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 12:45:52 -0400
Received: from localhost6.localdomain6 (f050230012.adsl.alicedsl.de [78.50.230.12])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0M5c8C-1U2cbf2Ee0-00xPes; Mon, 24 Jun 2013 18:45:51 +0200
X-Mailer: git-send-email 1.8.3.1.599.gbe80ec9
In-Reply-To: <1372091966-19315-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:WY9uXpuWoTVXxPeCgdGCiyzKF9qHHy22q5TQVTRW2yH
 DWYAo4VDy3NUI9/hgGsC5Vw0/wKq37GTzQDLrAUm844vR7Htuj
 fRZ4124nRdZaQw12Cv1E0BnTEGcE9bZN6MCGTNnLElQlqVE+RG
 7NMh1YGHNAEu+98m9J6TDfBgJdllbSfcw9s15KVMx2cjoIyoSy
 QX8Q0jmXjiPZs6fNzFhb9Et2a7CTHpuPhIo9z1HQrOLi2cmCqG
 8d5fln8C11TPofK+sPxMn+TdBXELOS55ns2ZJpG+vK4Ci2TrGj
 RUI1Xa3Jgn7yTyrGMdBHEeZCUfmWoaqEWPqAJY/GJH9ZaCME9x
 PxF0IMAXouFTJYz/P06gqu3v0G1+ocfbKpKF+qSFZtZC5CEsGQ
 lNfSzyF2mEV5A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228867>

Before setting $PS1, __git_ps1() uses a command substitution to
redirect the output from a printf into a variable.  Spare the overhead
of fork()ing a subshell by using 'printf -v <var>' to directly assign
the output to that variable.

zsh's printf doesn't support the '-v <var>' option, so stick with the
command substitution when under zsh.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-prompt.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-=
prompt.sh
index 5ea6a68b..7152ae49 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -461,7 +461,11 @@ __git_ps1 ()
 		else
 			gitstring=3D"$c${b##refs/heads/}${f:+$z$f}$r$p"
 		fi
-		gitstring=3D$(printf -- "$printf_format" "$gitstring")
+		if [[ -n ${ZSH_VERSION-} ]]; then
+			gitstring=3D$(printf -- "$printf_format" "$gitstring")
+		else
+			printf -v gitstring -- "$printf_format" "$gitstring"
+		fi
 		PS1=3D"$ps1pc_start$gitstring$ps1pc_end"
 	else
 		# NO color option unless in PROMPT_COMMAND mode
--=20
1.8.3.1.599.g4459181
