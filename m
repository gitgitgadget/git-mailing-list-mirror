From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 17/19] bash prompt: use bash builtins to check stash state
Date: Wed,  9 May 2012 02:44:48 +0200
Message-ID: <1336524290-30023-18-git-send-email-szeder@ira.uka.de>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 02:47:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRv4C-0005YD-Fu
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 02:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756714Ab2EIArj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 20:47:39 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:57170 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753746Ab2EIAri (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 20:47:38 -0400
Received: from localhost6.localdomain6 (p5B130353.dip0.t-ipconnect.de [91.19.3.83])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0LodLS-1RvJ0h16le-00gmx8; Wed, 09 May 2012 02:47:33 +0200
X-Mailer: git-send-email 1.7.10.1.541.gb1be298
In-Reply-To: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:Yv2Wq3OlcThq6Itt805wROl5UqpWgjH/K20ZbSWEyov
 guEMCKEsgJ1fSKBOGYrGtHS68dG3WUWrRp2wz1j4PLYf6uXwUc
 l+U/SaSST3kvCe/M+AVOj9fBDccksHz8vNZ7EstQMT+5nml+WO
 erS493XFxirRElQeo36KPUALNitDj4ng0Av36EBXpLe01rl99Y
 Bn7zOzTfEQhfg2ZI/5sehjNdOK9qj/ipMMDOMUOURhVJ5RA1Bv
 P1RZIjlPTbjXhtkzYqy4jgPmYpJXjOdfX3/5Ih8HDc9eublCMY
 2o3tc/F0BxGtagAPfejFUWHyO0cTKSoG+RlBwMfNCNaumBOoi6
 SgZglXL26N2WD9Jo4VMDIMiNkRB8GwedlsIGqdsN4WIqX4V3Zk
 Ej3SCOZnlDuPg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197449>

When the environment variable $GIT_PS1_SHOWSTASHSTATE is set
__git_ps1() checks the presence of stashes by running 'git rev-parse
--verify refs/stash'.  This command not only checks that the
'refs/stash' ref exists but also, well, verifies that it's a valid
ref.

However, we don't need to be that thorough for the bash prompt.  We
can omit that verification and only check whether 'refs/stash' exists
or not.  Since 'git pack-refs' never packs 'refs/stash', it's a matter
of checking the existence of a ref file.  Perform this check using
only bash builtins to spare the overhead of fork()+exec()ing a git
process.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 64207e3c..c4feab68 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -356,7 +356,9 @@ __git_ps1 ()
 	fi
=20
 	if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ]; then
-	        git rev-parse --verify refs/stash >/dev/null 2>&1 && s=3D"$"
+		if [ -r "$__git_dir/refs/stash" ]; then
+			s=3D"$"
+		fi
 	fi
=20
 	if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
--=20
1.7.10.1.541.gb1be298
