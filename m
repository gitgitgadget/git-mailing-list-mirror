From: Arnaud Fontaine <arnau@debian.org>
Subject: [PATCH] Do not ignore merge options in interactive rebase
Date: Mon, 24 Jun 2013 16:47:32 +0900
Organization: Debian
Message-ID: <87ppvcx84r.fsf@duckcorp.org>
References: <87bo70dokb.fsf@duckcorp.org>
	<7vr4fvkxew.fsf@alter.siamese.dyndns.org>
	<87bo6wyn0z.fsf@duckcorp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 24 09:47:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur1V0-0007lA-4D
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 09:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753074Ab3FXHrh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 03:47:37 -0400
Received: from Orfeo.duckcorp.org ([193.17.192.211]:40028 "EHLO
	mx1.duckcorp.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824Ab3FXHrh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 03:47:37 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mx1.duckcorp.org (Postfix) with ESMTPSA id 3bf2fG6n22z2J50;
	Mon, 24 Jun 2013 09:47:34 +0200 (CEST)
X-URL: http://www.debian.org
X-Operating-System: Debian GNU/Linux
X-GnuPG-KeyID: 5E3619D3
X-PGP-Fingerprint: D792 B8A5 A567 B001 C342  2613 BDF2 A220 5E36 19D3
In-Reply-To: <87bo6wyn0z.fsf@duckcorp.org> (Arnaud Fontaine's message of "Mon,
	24 Jun 2013 16:40:28 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228787>

Fix inconsistency where `--strategy` and/or `--strategy-option` can be
specified in git rebase, but with `--interactive` argument only there
were completely ignored.

Signed-off-by: Arnaud Fontaine <arnau@debian.org>
---
 git-rebase--interactive.sh    | 13 ++++++++++---
 t/t3404-rebase-interactive.sh | 11 +++++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index f953d8d..e558397 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -80,6 +80,13 @@ amend="$state_dir"/amend
 rewritten_list="$state_dir"/rewritten-list
 rewritten_pending="$state_dir"/rewritten-pending
 
+strategy_args=
+if test -n "$do_merge"
+then
+	strategy_args="${strategy+--strategy=$strategy}
+ $(echo $strategy_opts | sed "s/'--\([^']*\)'/-X\1/g")"
+fi
+
 GIT_CHERRY_PICK_HELP="$resolvemsg"
 export GIT_CHERRY_PICK_HELP
 
@@ -239,7 +246,7 @@ pick_one () {
 
 	test -d "$rewritten" &&
 		pick_one_preserving_merges "$@" && return
-	output git cherry-pick $empty_args $ff "$@"
+	output git cherry-pick $strategy_args $empty_args $ff "$@"
 }
 
 pick_one_preserving_merges () {
@@ -341,7 +348,7 @@ pick_one_preserving_merges () {
 			# No point in merging the first parent, that's HEAD
 			new_parents=${new_parents# $first_parent}
 			if ! do_with_author output \
-				git merge --no-ff ${strategy:+-s $strategy} -m \
+				git merge --no-ff $strategy_args -m \
 					"$msg_content" $new_parents
 			then
 				printf "%s\n" "$msg_content" > "$GIT_DIR"/MERGE_MSG
@@ -350,7 +357,7 @@ pick_one_preserving_merges () {
 			echo "$sha1 $(git rev-parse HEAD^0)" >> "$rewritten_list"
 			;;
 		*)
-			output git cherry-pick "$@" ||
+			output git cherry-pick $strategy_args "$@" ||
 				die_with_patch $sha1 "Could not pick $sha1"
 			;;
 		esac
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 79e8d3c..8b6a36f 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -947,4 +947,15 @@ test_expect_success 'rebase -i respects core.commentchar' '
 	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
 '
 
+test_expect_success 'rebase -i with --strategy and -X' '
+	git checkout -b conflict-merge-use-theirs conflict-branch &&
+	git reset --hard HEAD^ &&
+	echo five >conflict &&
+	echo Z >file1 &&
+	git commit -a -m "one file conflict" &&
+	EDITOR=true git rebase -i --strategy=recursive -Xours conflict-branch &&
+	test $(git show conflict-branch:conflict) = $(cat conflict) &&
+	test $(cat file1) = Z
+'
+
 test_done
-- 
1.8.3.GIT
