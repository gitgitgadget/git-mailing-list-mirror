From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 19/21] completion: don't guard git executions with __gitdir()
Date: Thu, 25 Feb 2016 23:50:48 +0100
Message-ID: <1456440650-32623-20-git-send-email-szeder@ira.uka.de>
References: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 23:54:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ4nj-0007Jl-3h
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 23:54:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbcBYWyR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Feb 2016 17:54:17 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:35884 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750850AbcBYWyR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 17:54:17 -0500
Received: from x590cfbb6.dyn.telefonica.de ([89.12.251.182] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1aZ4nS-0007uU-SV; Thu, 25 Feb 2016 23:54:12 +0100
X-Mailer: git-send-email 2.7.2.410.g92cb358
In-Reply-To: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1456440852.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287469>

Three completion functions first run __gitdir() and check that the
path it outputs exists, i.e. that there is a git repository, and run a
git command only if there is one.

After the previous changes in this series there are no further uses of
__gitdir()'s output in these functions besides those checks.  And
those checks are unnecessary, because we can just execute those git
commands outside of a repository and let them error out.  We don't
perform such a check in other places either.

Remove this check and the __gitdir() call from these functions,
sparing the fork()+exec() overhead of the command substitution and the
potential 'git rev-parse' execution.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 32 +++++++++++---------------=
------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 2d0bd018701e..605ab84296a2 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -312,35 +312,25 @@ __git_ls_files_helper ()
 #    slash.
 __git_index_files ()
 {
-	local dir=3D"$(__gitdir)" root=3D"${2-.}" file
-
-	if [ -d "$dir" ]; then
-		__git_ls_files_helper "$root" "$1" |
-		while read -r file; do
-			case "$file" in
-			?*/*) echo "${file%%/*}" ;;
-			*) echo "$file" ;;
-			esac
-		done | sort | uniq
-	fi
+	local root=3D"${2-.}" file
+
+	__git_ls_files_helper "$root" "$1" |
+	while read -r file; do
+		case "$file" in
+		?*/*) echo "${file%%/*}" ;;
+		*) echo "$file" ;;
+		esac
+	done | sort | uniq
 }
=20
 __git_heads ()
 {
-	local dir=3D"$(__gitdir)"
-	if [ -d "$dir" ]; then
-		__git for-each-ref --format=3D'%(refname:short)' refs/heads
-		return
-	fi
+	__git for-each-ref --format=3D'%(refname:short)' refs/heads
 }
=20
 __git_tags ()
 {
-	local dir=3D"$(__gitdir)"
-	if [ -d "$dir" ]; then
-		__git for-each-ref --format=3D'%(refname:short)' refs/tags
-		return
-	fi
+	__git for-each-ref --format=3D'%(refname:short)' refs/tags
 }
=20
 # Lists refs from the local (by default) or from a remote repository.
--=20
2.7.2.410.g92cb358
