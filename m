From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 11/21] completion: don't list 'HEAD' when trying refs completion outside of a repo
Date: Thu, 25 Feb 2016 23:50:40 +0100
Message-ID: <1456440650-32623-12-git-send-email-szeder@ira.uka.de>
References: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 23:53:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ4mh-0006Zu-E9
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 23:53:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbcBYWxP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Feb 2016 17:53:15 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:35810 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750717AbcBYWxO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 17:53:14 -0500
Received: from x590cfbb6.dyn.telefonica.de ([89.12.251.182] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1aZ4mR-0007uU-MD; Thu, 25 Feb 2016 23:53:08 +0100
X-Mailer: git-send-email 2.7.2.410.g92cb358
In-Reply-To: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1456440789.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287461>

When refs completion is attempted while not in a git repository, the
completion script offers 'HEAD' erroneously.

Check early in __git_refs() that there is either a repository or a
remote to work on, and exit early if neither is given.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 4 ++++
 t/t9902-completion.sh                  | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index b85ab27fb18a..f6ccfb708451 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -346,6 +346,10 @@ __git_refs ()
 	local from_local=3Dy remote=3D"${1-}"
 	local format refs
=20
+	if [ -z "$dir" ] && [ -z "$remote" ]; then
+		return
+	fi
+
 	if [ -n "$remote" ]; then
 		if __git_is_configured_remote "$remote"; then
 			# configured remote takes precedence over a
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 9f8be9ab1f3b..f42a9ba9058f 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -629,7 +629,7 @@ test_expect_success '__git_refs - unique remote bra=
nches for git checkout DWIMer
 	test_cmp expected "$actual"
 '
=20
-test_expect_failure '__git_refs - not in a git repository' '
+test_expect_success '__git_refs - not in a git repository' '
 	(
 		GIT_CEILING_DIRECTORIES=3D"$ROOT" &&
 		export GIT_CEILING_DIRECTORIES &&
--=20
2.7.2.410.g92cb358
