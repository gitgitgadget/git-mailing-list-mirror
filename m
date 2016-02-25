From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 07/21] completion: ensure that the repository path given on the command line exists
Date: Thu, 25 Feb 2016 23:50:36 +0100
Message-ID: <1456440650-32623-8-git-send-email-szeder@ira.uka.de>
References: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 23:52:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ4m0-00069R-2N
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 23:52:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbcBYWwg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Feb 2016 17:52:36 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:35774 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751968AbcBYWwf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 17:52:35 -0500
Received: from x590cfbb6.dyn.telefonica.de ([89.12.251.182] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1aZ4lr-0007uU-Pb; Thu, 25 Feb 2016 23:52:33 +0100
X-Mailer: git-send-email 2.7.2.410.g92cb358
In-Reply-To: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1456440753.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287456>

The __gitdir() helper function stays silent and returns with error
when it can't find a repository or when the repository given via
$GIT_DIR doesn't exist.

This is not the case, however, when the path in $__git_dir, i.e. the
path to the repository specified on the command line as 'git
--git-dir=3D<path>', doesn't exist: __gitdir() still outputs it and
returns with success, making completion functions believe that they
operate on an existing repository.

Check that the path in $__git_dir exists and return with error if it
doesn't.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 1 +
 t/t9902-completion.sh                  | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 0e1fd778bfe8..0ec988c0ee26 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -40,6 +40,7 @@ __gitdir ()
 {
 	if [ -z "${1-}" ]; then
 		if [ -n "${__git_dir-}" ]; then
+			test -d "$__git_dir" || return 1
 			echo "$__git_dir"
 		elif [ -n "${GIT_DIR-}" ]; then
 			test -d "${GIT_DIR-}" || return 1
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 7ab398568594..809856110235 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -211,6 +211,14 @@ test_expect_success '__gitdir - $GIT_DIR set while=
 .git directory in parent' '
 	test_cmp expected "$actual"
 '
=20
+test_expect_success '__gitdir - non-existing path in $__git_dir' '
+	(
+		__git_dir=3D"non-existing" &&
+		test_must_fail __gitdir >"$actual"
+	) &&
+	test_must_be_empty "$actual"
+'
+
 test_expect_success '__gitdir - non-existing $GIT_DIR' '
 	(
 		GIT_DIR=3D"$ROOT/non-existing" &&
--=20
2.7.2.410.g92cb358
