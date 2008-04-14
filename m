From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH v2 11/13] Add option --first-parent
Date: Mon, 14 Apr 2008 02:21:07 +0200
Message-ID: <1208132469-26471-11-git-send-email-joerg@alea.gnuu.de>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org>
 <1208132469-26471-1-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-2-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-4-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-5-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-6-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-7-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-8-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-9-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-10-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	=?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 14 02:52:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlCwA-00049R-2y
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 02:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753564AbYDNAwE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Apr 2008 20:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753540AbYDNAwD
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 20:52:03 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:1637 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753565AbYDNAvz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 20:51:55 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 4FF074880A1; Mon, 14 Apr 2008 02:51:53 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JlCRa-0006IK-Up; Mon, 14 Apr 2008 02:21:11 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JlCRa-0006uM-Ed; Mon, 14 Apr 2008 02:21:10 +0200
X-Mailer: git-send-email 1.5.5
In-Reply-To: <1208132469-26471-10-git-send-email-joerg@alea.gnuu.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79432>

With this new option it's possible to narrow the list of commits in the
TODO list to only those commits you get following the first parent of
each merge, i.e. not those from the merged branches.

Signed-off-by: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
---
 Documentation/git-rebase.txt  |    7 ++++++-
 git-rebase--interactive.sh    |   15 +++++++++++----
 t/t3404-rebase-interactive.sh |   12 ++++++++++++
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.tx=
t
index e0412e0..9ebbb90 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 'git-rebase' [-i | --interactive] [-v | --verbose] [-m | --merge]
 	[-s <strategy> | --strategy=3D<strategy>]
 	[-C<n>] [ --whitespace=3D<option>] [-p | --preserve-merges]
-	[--onto <newbase>] <upstream> [<branch>]
+	[-f | --first-parent] [--onto <newbase>] <upstream> [<branch>]
 'git-rebase' --continue | --skip | --abort
=20
 DESCRIPTION
@@ -247,6 +247,11 @@ OPTIONS
 	Instead of ignoring merges, try to recreate them.  This option
 	only works in interactive mode.
=20
+-f, \--first-parent::
+	This option implies the option --preserve-merges, but instead of
+	showing all commits from the merged branches show only the
+	commits and merges following the first parent of each commit.
+
 include::merge-strategies.txt[]
=20
 NOTES
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index d3327a8..ea67942 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -10,8 +10,8 @@
 # The original idea comes from Eric W. Biederman, in
 # http://article.gmane.org/gmane.comp.version-control.git/22407
=20
-USAGE=3D'(--continue | --abort | --skip | [--preserve-merges] [--verbo=
se]
-	[--onto <branch>] <upstream> [<branch>])'
+USAGE=3D'(--continue | --abort | --skip | [--preserve-merges] [--first=
-parent]
+	[--verbose] [--onto <branch>] <upstream> [<branch>])'
=20
 OPTIONS_SPEC=3D
 . git-sh-setup
@@ -565,6 +565,10 @@ do
 	-p|--preserve-merges)
 		PRESERVE_MERGES=3Dt
 		;;
+	-f|--first-parent)
+		FIRST_PARENT=3Dt
+		PRESERVE_MERGES=3Dt
+		;;
 	-i|--interactive)
 		# yeah, we know
 		;;
@@ -621,10 +625,13 @@ do
 		SHORTONTO=3D$(git rev-parse --short=3D7 $ONTO)
 		common_rev_list_opts=3D"--abbrev-commit --abbrev=3D7
 			--left-right --cherry-pick $UPSTREAM...$HEAD"
-		if test t =3D "$PRESERVE_MERGES"
+		if test t =3D "$PRESERVE_MERGES" -o t =3D "${FIRST_PARENT:-f}"
 		then
+			opts=3D
+			test t =3D "${FIRST_PARENT:-f}" && \
+				opts=3D"$opts --first-parent"
 			git rev-list --pretty=3D'format:%h_%p_%s' --topo-order \
-				$common_rev_list_opts | \
+				$opts $common_rev_list_opts | \
 				grep -v ^commit | \
 				create_extended_todo_list
 		else
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index f919aaf..8da7829 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -294,6 +294,18 @@ test_expect_success 'rebase with preserve merge fo=
rth and back is a noop' '
 	test "$head" =3D "$(git rev-parse HEAD)"
 '
=20
+test_expect_success 'interactive --first-parent gives a linear list' '
+	head=3D$(git rev-parse HEAD) &&
+	EXPECT_COUNT=3D6 FAKE_LINES=3D"2 1 4 3 6 5" \
+		git rebase -i -f --onto dead-end master &&
+	test "$head" !=3D "$(git rev-parse HEAD)" &&
+	git rev-parse HEAD^^2 &&
+	test "$(git rev-parse HEAD~6)" =3D "$(git rev-parse dead-end)" &&
+	EXPECT_COUNT=3D6 FAKE_LINES=3D"2 1 4 3 6 5" \
+		git rebase -i -f --onto master dead-end &&
+	test "$head" =3D "$(git rev-parse HEAD)"
+'
+
 test_expect_success '--continue tries to commit' '
 	git checkout to-be-rebased &&
 	test_tick &&
--=20
1.5.5
