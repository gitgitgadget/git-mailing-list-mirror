From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 2/2] bash prompt: faster untracked status indicator with untracked directories
Date: Sun, 19 Jul 2015 13:28:06 +0200
Message-ID: <1437305286-23587-2-git-send-email-szeder@ira.uka.de>
References: <1437305286-23587-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 19 13:29:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGmmT-0007SL-2L
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 13:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174AbbGSL3N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Jul 2015 07:29:13 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:59592 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753071AbbGSL3M (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jul 2015 07:29:12 -0400
Received: from x4db1a734.dyn.telefonica.de ([77.177.167.52] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 25 
	iface 141.3.10.81 id 1ZGmmK-0008IM-9j; Sun, 19 Jul 2015 13:29:10 +0200
X-Mailer: git-send-email 2.5.0.rc2.15.gd82f7f6
In-Reply-To: <1437305286-23587-1-git-send-email-szeder@ira.uka.de>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1437305350.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274209>

If the untracked status indicator is enabled, __git_ps1() looks for
untracked files by running 'git ls-files'.  This can be perceptibly slo=
w
in case of an untracked directory containing lot of files, because it
lists all files found in the untracked directory only to be redirected
into /dev/null right away (this is the actual command run by __git_ps1(=
)):

  $ ls untracked-dir/ |wc -l
  100000
  $ time git ls-files --others --exclude-standard --error-unmatch \
    -- ':/*' >/dev/null 2>/dev/null

  real	0m0.955s
  user	0m0.936s
  sys	0m0.016s

Eliminate this delay by additionally passing the '--directory
--no-empty-directory' options to 'git ls-files' to show only the name o=
f
non-empty untracked directories instead of all their content:

  $ time git ls-files --others --exclude-standard --directory \
    --no-empty-directory --error-unmatch -- ':/*' >/dev/null 2>/dev/nul=
l

  real	0m0.010s
  user	0m0.008s
  sys	0m0.000s

This follows suit of ea95c7b8f5 (completion: improve untracked director=
y
filtering for filename completion, 2013-09-18).

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-prompt.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-=
prompt.sh
index 366f0bc1e9..07b52bedf1 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -491,7 +491,7 @@ __git_ps1 ()
=20
 		if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ] &&
 		   [ "$(git config --bool bash.showUntrackedFiles)" !=3D "false" ] &=
&
-		   git ls-files --others --exclude-standard --error-unmatch -- ':/*'=
 >/dev/null 2>/dev/null
+		   git ls-files --others --exclude-standard --directory --no-empty-d=
irectory --error-unmatch -- ':/*' >/dev/null 2>/dev/null
 		then
 			u=3D"%${ZSH_VERSION+%}"
 		fi
--=20
2.5.0.rc2.15.gd82f7f6
