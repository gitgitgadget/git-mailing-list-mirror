From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v2 13/13] bash prompt: avoid command substitution when
 finalizing gitstring
Date: Tue, 18 Jun 2013 04:17:06 +0200
Message-ID: <1371521826-3225-14-git-send-email-szeder@ira.uka.de>
References: <1371521826-3225-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 18 04:18:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UolVY-0008Gd-Pf
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 04:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753964Ab3FRCSx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Jun 2013 22:18:53 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:50980 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952Ab3FRCSw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 22:18:52 -0400
Received: from localhost6.localdomain6 (f052037223.adsl.alicedsl.de [78.52.37.223])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0MJmWC-1UnfZh0apQ-0017Pf; Tue, 18 Jun 2013 04:18:45 +0200
X-Mailer: git-send-email 1.8.3.1.487.g8f4672d
In-Reply-To: <1371521826-3225-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:Y2NdsO3MoqJ5SfESYRaY1y1U3an1Ithx96gaGNfJrr/
 C3YbDX/4D2U2isZpIcFg8SHFzTp5PkRIJ5BrvOL3KL7sBIdCl0
 va2OgIqFQSTXxQrlxHoVSgXJM9JsXOeIW7lqaVko78Kyj0AFI/
 RLB0LeIHBp9Yym7exGwVcG90MwvoNxUqL64TnzpZotAyc9q0nT
 Irr7KyXOysAyQvqkPvEBaYvzPoN+RMzf7spRo7owhS+1CZBxwK
 ogG3+pejILXMUIWUJvIV7UK93MYaLxuAgRNxgh7yIe3YMvrJuo
 6VfONWFtH7kO0bs6e7y2Cn6qL0obaccY0aO6vSuFZlR0pVQqKF
 zDGeuc1f261+mVp1MrulhOFvH8Gcv+WJY+NYJGscIb5+pDdPBX
 1ehpITAYTh8MA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228146>

=46rom: SZEDER G=C3=A1bor <szeder@ira.uka.de>

Before setting $PS1, __git_ps1() uses a command substitution to
redirect the output from a printf into a variable.  Spare the overhead
of fork()ing a subshell by using 'printf -v <var>' to directly assign
the output to a variable.

zsh's printf doesn't support the '-v <var>' option, so stick with the
command substitution when under zsh.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-prompt.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-=
prompt.sh
index 77575b2d..a8e78f42 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -447,7 +447,11 @@ __git_ps1 ()
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
1.8.3.1.487.g8f4672d
