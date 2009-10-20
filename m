From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] pull: refuse complete src:dst fetchspec arguments
Date: Tue, 20 Oct 2009 20:23:06 +0200
Message-ID: <d561e70f0aa802ceb96eba16d3bb2316134d69c8.1256062808.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 20 20:24:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0JN8-0007zx-AJ
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 20:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbZJTSXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 14:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbZJTSXh
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 14:23:37 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:28566 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751137AbZJTSXh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 14:23:37 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Tue, 20 Oct
 2009 20:23:40 +0200
Received: from localhost.localdomain (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Tue, 20 Oct
 2009 20:23:40 +0200
X-Mailer: git-send-email 1.6.5.1.144.g40216
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130822>

git-pull has historically accepted full fetchspecs, meaning that you
could do

  git pull $repo A:B

which would simultaneously fetch the remote branch A into the local
branch B and merge B into HEAD.  This got especially confusing if B
was checked out.  New users variously mistook pull for fetch or read
that command as "merge the remote A into my B", neither of which is
correct.

Since the above usage should be very rare and can be done with
separate calls to fetch and merge, we just disallow full fetchspecs in
git-pull.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

This actually came up on IRC *twice* this week.


 git-pull.sh     |   19 +++++++++++++++++++
 t/t5520-pull.sh |   12 ------------
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index fc78592..8f06491 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -131,6 +131,25 @@ error_on_no_merge_candidates () {
 	exit 1
 }
 
+check_full_fetchspec () {
+	shift	# discard remote argument, if any
+	for arg in "$@"
+	do
+		case "$arg" in
+		*:*)
+			echo "$arg"
+			return
+			;;
+		esac
+	done
+}
+
+full_fetchspec=$(check_full_fetchspec "$@")
+if test -n "$full_fetchspec"
+then
+	die "full fetchspec '$full_fetchspec' not allowed"
+fi
+
 test true = "$rebase" && {
 	if ! git rev-parse -q --verify HEAD >/dev/null
 	then
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index dd2ee84..a566a99 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -29,18 +29,6 @@ test_expect_success 'checking the results' '
 	diff file cloned/file
 '
 
-test_expect_success 'pulling into void using master:master' '
-	mkdir cloned-uho &&
-	(
-		cd cloned-uho &&
-		git init &&
-		git pull .. master:master
-	) &&
-	test -f file &&
-	test -f cloned-uho/file &&
-	test_cmp file cloned-uho/file
-'
-
 test_expect_success 'test . as a remote' '
 
 	git branch copy master &&
-- 
1.6.5.1.144.g40216
