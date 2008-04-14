From: =?utf-8?q?J=C3=B6rg=20Sommer?= <joerg@alea.gnuu.de>
Subject: [PATCH v2 13/13] Add option --preserve-tags
Date: Mon, 14 Apr 2008 02:21:09 +0200
Message-ID: <1208132469-26471-13-git-send-email-joerg@alea.gnuu.de>
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
 <1208132469-26471-11-git-send-email-joerg@alea.gnuu.de>
 <1208132469-26471-12-git-send-email-joerg@alea.gnuu.de>
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
	id 1JlCw9-00049R-EW
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 02:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753854AbYDNAwC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Apr 2008 20:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753251AbYDNAwB
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 20:52:01 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:1635 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753540AbYDNAvz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 20:51:55 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id C39534880A0; Mon, 14 Apr 2008 02:51:53 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JlCRb-0006IG-9m; Mon, 14 Apr 2008 02:21:11 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JlCRa-0006uc-NK; Mon, 14 Apr 2008 02:21:10 +0200
X-Mailer: git-send-email 1.5.5
In-Reply-To: <1208132469-26471-12-git-send-email-joerg@alea.gnuu.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79433>

With this new option tags set on commits, they are part of a rebase, ar=
e
reset to the rebased commits. This way the tags on a branch are kept
across rebases.

Signed-off-by: J=C3=B6rg Sommer <joerg@alea.gnuu.de>
---
 Documentation/git-rebase.txt  |    6 ++++-
 git-rebase--interactive.sh    |   42 +++++++++++++++++++++++++++++++++=
+++++--
 t/t3404-rebase-interactive.sh |   10 +++++++++
 3 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.tx=
t
index 9ebbb90..cc4e94f 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -11,7 +11,8 @@ SYNOPSIS
 'git-rebase' [-i | --interactive] [-v | --verbose] [-m | --merge]
 	[-s <strategy> | --strategy=3D<strategy>]
 	[-C<n>] [ --whitespace=3D<option>] [-p | --preserve-merges]
-	[-f | --first-parent] [--onto <newbase>] <upstream> [<branch>]
+	[-f | --first-parent] [-t | --preserve-tags]
+	[--onto <newbase>] <upstream> [<branch>]
 'git-rebase' --continue | --skip | --abort
=20
 DESCRIPTION
@@ -252,6 +253,9 @@ OPTIONS
 	showing all commits from the merged branches show only the
 	commits and merges following the first parent of each commit.
=20
+-t, \--preserve-tags::
+	If one of the commits has a tag, reset it to the new commit object.
+
 include::merge-strategies.txt[]
=20
 NOTES
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index c601655..e874c31 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -11,7 +11,7 @@
 # http://article.gmane.org/gmane.comp.version-control.git/22407
=20
 USAGE=3D'(--continue | --abort | --skip | [--preserve-merges] [--first=
-parent]
-	[--verbose] [--onto <branch>] <upstream> [<branch>])'
+	[--preserve-tags] [--verbose] [--onto <branch>] <upstream> [<branch>]=
)'
=20
 OPTIONS_SPEC=3D
 . git-sh-setup
@@ -397,9 +397,31 @@ insert_value_at_key_into_list () {
=20
 create_extended_todo_list () {
 	(
+	if test t =3D "${PRESERVE_TAGS:-}"
+	then
+		tag_list=3D$(git show-ref --abbrev=3D7 --tags | \
+			(
+			while read sha1 tag
+			do
+				tag=3D${tag#refs/tags/}
+				if test ${last_sha1:-0000} =3D $sha1
+				then
+					saved_tags=3D"$saved_tags:$tag"
+				else
+					printf "%s" "${last_sha1:+ $last_sha1#$saved_tags}"
+					last_sha1=3D$sha1
+					saved_tags=3D$tag
+				fi
+			done
+			echo "${last_sha1:+ $last_sha1:$saved_tags}"
+			) )
+	else
+		tag_list=3D
+	fi
 	while IFS=3D_ read commit parents subject
 	do
-		if test "${last_parent:-$commit}" !=3D "$commit"
+		if test t =3D "$PRESERVE_MERGES" -a \
+			"${last_parent:-$commit}" !=3D "$commit"
 		then
 			if test t =3D "${delayed_mark:-f}"
 			then
@@ -416,6 +438,14 @@ create_extended_todo_list () {
 		get_value_from_list $commit "${marked_commits:-}" \
 			>/dev/null && echo mark
=20
+		if tmp=3D$(get_value_from_list $commit "$tag_list")
+		then
+			for t in $(echo $tmp | tr : ' ')
+			do
+				echo tag $t
+			done
+		fi
+
 		case "$parents" in
 		*' '*)
 			delayed_mark=3Dt
@@ -575,6 +605,9 @@ do
 		FIRST_PARENT=3Dt
 		PRESERVE_MERGES=3Dt
 		;;
+	-t|--preserve-tags)
+		PRESERVE_TAGS=3Dt
+		;;
 	-i|--interactive)
 		# yeah, we know
 		;;
@@ -631,11 +664,14 @@ do
 		SHORTONTO=3D$(git rev-parse --short=3D7 $ONTO)
 		common_rev_list_opts=3D"--abbrev-commit --abbrev=3D7
 			--left-right --cherry-pick $UPSTREAM...$HEAD"
-		if test t =3D "$PRESERVE_MERGES" -o t =3D "${FIRST_PARENT:-f}"
+		if test t =3D "$PRESERVE_MERGES" -o t =3D "${FIRST_PARENT:-f}" \
+			-o t =3D "${PRESERVE_TAGS:-}"
 		then
 			opts=3D
 			test t =3D "${FIRST_PARENT:-f}" && \
 				opts=3D"$opts --first-parent"
+			test t !=3D "$PRESERVE_MERGES" && \
+				opts=3D"$opts --no-merges"
 			git rev-list --pretty=3D'format:%h_%p_%s' --topo-order \
 				$opts $common_rev_list_opts | \
 				grep -v ^commit | \
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index 9901555..d20ed4f 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -319,6 +319,16 @@ test_expect_success 'tag sets tags' '
 		"$(git rev-parse HEAD^2~2 HEAD~2 HEAD~1 HEAD~1)"
 '
=20
+test_expect_success 'interactive -t preserves tags' '
+	git rebase -i -p -t --onto dead-end master &&
+	test "$(git rev-parse bb-tag1 bb-tag2 bb-tag3a bb-tag3b)" =3D \
+		"$(git rev-parse HEAD^2~2 HEAD~2 HEAD~1 HEAD~1)" &&
+	head=3D$(git rev-parse HEAD) &&
+	git rebase -i -t dead-end &&
+	test "$(git rev-parse bb-tag1 bb-tag2 bb-tag3a bb-tag3b)" =3D \
+		"$(git rev-parse HEAD~7 $head~2 HEAD~1 HEAD~1)"
+'
+
 test_expect_success '--continue tries to commit' '
 	git checkout to-be-rebased &&
 	test_tick &&
--=20
1.5.5
