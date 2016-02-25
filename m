From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 08/21] completion: fix most spots not respecting 'git --git-dir=<path>'
Date: Thu, 25 Feb 2016 23:50:37 +0100
Message-ID: <1456440650-32623-9-git-send-email-szeder@ira.uka.de>
References: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 23:52:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ4m8-0006Fz-2P
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 23:52:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106AbcBYWwo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Feb 2016 17:52:44 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:35783 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751968AbcBYWwn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 17:52:43 -0500
Received: from x590cfbb6.dyn.telefonica.de ([89.12.251.182] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1aZ4lz-0007uU-T2; Thu, 25 Feb 2016 23:52:41 +0100
X-Mailer: git-send-email 2.7.2.410.g92cb358
In-Reply-To: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1456440761.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287457>

The completion script already respects the path to the repository
specified on the command line most of the time, here we add the
necessary '--git-dir=3D$(__gitdir)' options to most of the places where
git was executed without it.  The exceptions where said option is not
added are the git invocations:

  - in __git_refs() which are non-trivial and will be the subject of
    the following patch,

  - getting the list of git commands, merge strategies and archive
    formats, because these are independent from the repository and
    thus don't need it, and

  - the 'git rev-parse --git-dir' in __gitdir() itself.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 0ec988c0ee26..59dffe7f39c2 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -283,11 +283,13 @@ __gitcomp_file ()
 # argument, and using the options specified in the second argument.
 __git_ls_files_helper ()
 {
+	local dir=3D"$(__gitdir)"
+
 	if [ "$2" =3D=3D "--committable" ]; then
-		git -C "$1" diff-index --name-only --relative HEAD
+		git --git-dir=3D"$dir" -C "$1" diff-index --name-only --relative HEA=
D
 	else
 		# NOTE: $2 is not quoted in order to support multiple options
-		git -C "$1" ls-files --exclude-standard $2
+		git --git-dir=3D"$dir" -C "$1" ls-files --exclude-standard $2
 	fi 2>/dev/null
 }
=20
@@ -407,7 +409,7 @@ __git_refs2 ()
 __git_refs_remotes ()
 {
 	local i hash
-	git ls-remote "$1" 'refs/heads/*' 2>/dev/null | \
+	git --git-dir=3D"$(__gitdir)" ls-remote "$1" 'refs/heads/*' 2>/dev/nu=
ll | \
 	while read -r hash i; do
 		echo "$i:refs/remotes/$1/${i#refs/heads/}"
 	done
@@ -1138,7 +1140,7 @@ _git_commit ()
 		return
 	esac
=20
-	if git rev-parse --verify --quiet HEAD >/dev/null; then
+	if git --git-dir=3D"$(__gitdir)" rev-parse --verify --quiet HEAD >/de=
v/null; then
 		__git_complete_index_file "--committable"
 	else
 		# This is the first commit
@@ -1431,7 +1433,7 @@ _git_log ()
 {
 	__git_has_doubledash && return
=20
-	local g=3D"$(git rev-parse --git-dir 2>/dev/null)"
+	local g=3D"$(__gitdir)"
 	local merge=3D""
 	if [ -f "$g/MERGE_HEAD" ]; then
 		merge=3D"--merge"
--=20
2.7.2.410.g92cb358
