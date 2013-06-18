From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v2 11/13] bash prompt: use bash builtins to check stash state
Date: Tue, 18 Jun 2013 04:17:04 +0200
Message-ID: <1371521826-3225-12-git-send-email-szeder@ira.uka.de>
References: <1371521826-3225-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 18 04:18:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UolVG-0007Y3-GJ
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 04:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753764Ab3FRCSe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Jun 2013 22:18:34 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:57268 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836Ab3FRCSd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 22:18:33 -0400
Received: from localhost6.localdomain6 (f052037223.adsl.alicedsl.de [78.52.37.223])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0MORHR-1Uj0jl0885-006REQ; Tue, 18 Jun 2013 04:18:32 +0200
X-Mailer: git-send-email 1.8.3.1.487.g8f4672d
In-Reply-To: <1371521826-3225-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:WNeKXiZaZpDb4L9nzVfq81BV4c9OXdb1WCY74qKsLCq
 d1IcIeGVIFpp8LfYb4e5/bAZn9CZBkPayzV9tzGtu2Rv7B/2R4
 TFqHfXSTLkxCIcaE/jsW4wZnMVuo8Zw5mnShqLABDMEJZVqzw/
 KOPzxZXN5a02+uZ0HMUR7ReT6Q3OK7hC3jdOu8I9uFr8uKXm86
 xS2AmFvoTA7RENxpL+0dukhPTf1UXtBzUXOQhqickDlRqD95yj
 Cz023wRwpZGNWa/4zncSrHVZYe/sS0R0nLB9qSHnHoB/1cyd4Z
 WOIBvP7oxNp+9V4WViil9Jkvjn0ALAzGj0UTuPBjwIz+5Q/s9K
 OyCmGOuh5PG+6pTY8upjtpnLbYIp6ugrbjFSGmP2UlH76Mavxa
 KWxoInzLdLqSw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228143>

=46rom: SZEDER G=C3=A1bor <szeder@ira.uka.de>

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
 contrib/completion/git-prompt.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-=
prompt.sh
index b73cebf7..208e2ec7 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -421,8 +421,9 @@ __git_ps1 ()
 				i=3D"#"
 			fi
 		fi
-		if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ]; then
-			git rev-parse --verify refs/stash >/dev/null 2>&1 && s=3D"$"
+		if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ] &&
+		   [ -r "$g/refs/stash" ]; then
+			s=3D"$"
 		fi
=20
 		if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ] &&
--=20
1.8.3.1.487.g8f4672d
