From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 10/21] completion: list refs from remote when remote's name matches a directory
Date: Thu, 25 Feb 2016 23:50:39 +0100
Message-ID: <1456440650-32623-11-git-send-email-szeder@ira.uka.de>
References: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 23:53:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ4mS-0006Tk-Tv
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 23:53:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbcBYWxF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Feb 2016 17:53:05 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:35801 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750717AbcBYWxE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 17:53:04 -0500
Received: from x590cfbb6.dyn.telefonica.de ([89.12.251.182] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1aZ4mH-0007uU-Pg; Thu, 25 Feb 2016 23:52:59 +0100
X-Mailer: git-send-email 2.7.2.410.g92cb358
In-Reply-To: <1456440650-32623-1-git-send-email-szeder@ira.uka.de>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1456440780.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287459>

If the remote given to __git_refs() happens to match both the name of
a configured remote and the name of a directory in the current working
directory, then that directory is assumed to be a git repository, and
listing refs from that directory will be attempted.  This is wrong,
because in such a situation git commands (e.g. 'git fetch|pull|push
<remote>' whom these refs will eventually be passed to) give
precedence to the configured remote.  Therefore, __git_refs() should
list refs from the configured remote as well.

Add the helper function __git_is_configured_remote() that checks
whether its argument matches the name of a configured remote.  Use
this helper to decide how to handle the remote passed to __git_refs().

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 28 +++++++++++++++++++++++---=
--
 t/t9902-completion.sh                  | 11 ++++++++++-
 2 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index adc968acea9d..b85ab27fb18a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -347,12 +347,18 @@ __git_refs ()
 	local format refs
=20
 	if [ -n "$remote" ]; then
-		if [ -d "$remote/.git" ]; then
-			dir=3D"$remote/.git"
-		elif [ -d "$remote" ]; then
-			dir=3D"$remote"
-		else
+		if __git_is_configured_remote "$remote"; then
+			# configured remote takes precedence over a
+			# local directory with the same name
 			from_local=3Dn
+		else
+			if [ -d "$remote/.git" ]; then
+				dir=3D"$remote/.git"
+			elif [ -d "$remote" ]; then
+				dir=3D"$remote"
+			else
+				from_local=3Dn
+			fi
 		fi
 	fi
=20
@@ -434,6 +440,18 @@ __git_remotes ()
 	git --git-dir=3D"$d" remote
 }
=20
+# Returns true if $1 matches the name of a configured remote, false ot=
herwise.
+__git_is_configured_remote ()
+{
+	local remote
+	for remote in $(__git_remotes); do
+		if [ "$remote" =3D "$1" ]; then
+			return 0
+		fi
+	done
+	return 1
+}
+
 __git_list_merge_strategies ()
 {
 	git merge -s help 2>&1 |
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index f9993d2c005a..9f8be9ab1f3b 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -378,6 +378,15 @@ test_expect_success '__git_remotes - list remotes =
from $GIT_DIR/remotes and from
 	test_cmp expect actual
 '
=20
+test_expect_success '__git_is_configured_remote' '
+	test_when_finished "git remote remove remote_1" &&
+	git remote add remote_1 git://remote_1 &&
+	test_when_finished "git remote remove remote_2" &&
+	git remote add remote_2 git://remote_2 &&
+	verbose __git_is_configured_remote remote_2 &&
+	test_must_fail __git_is_configured_remote non-existent
+'
+
 test_expect_success 'setup for ref completion' '
 	echo content >file1 &&
 	echo more >file2 &&
@@ -519,7 +528,7 @@ test_expect_success '__git_refs - configured remote=
 - full refs - repo given on
 	test_cmp expected "$actual"
 '
=20
-test_expect_failure '__git_refs - configured remote - remote name matc=
hes a directory' '
+test_expect_success '__git_refs - configured remote - remote name matc=
hes a directory' '
 	cat >expected <<-EOF &&
 	HEAD
 	branch
--=20
2.7.2.410.g92cb358
