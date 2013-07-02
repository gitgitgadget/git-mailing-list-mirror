From: Arnaud Fontaine <arnau@debian.org>
Subject: [PATCH] Do not ignore merge options in interactive rebase
Date: Tue, 02 Jul 2013 17:05:48 +0900
Organization: Debian
Message-ID: <87r4fh2xpf.fsf@duckcorp.org>
References: <87bo70dokb.fsf@duckcorp.org>
	<7vr4fvkxew.fsf@alter.siamese.dyndns.org>
	<87bo6wyn0z.fsf@duckcorp.org> <87ppvcx84r.fsf@duckcorp.org>
	<7v61x23yv9.fsf@alter.siamese.dyndns.org>
	<7v61x22av9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 10:06:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Utvb9-00055H-Tn
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 10:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209Ab3GBIF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 04:05:57 -0400
Received: from Orfeo.duckcorp.org ([193.17.192.211]:56248 "EHLO
	mx1.duckcorp.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932152Ab3GBIFy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 04:05:54 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mx1.duckcorp.org (Postfix) with ESMTPSA id 3bkygg6dm9z2J4q;
	Tue,  2 Jul 2013 10:05:51 +0200 (CEST)
X-URL: http://www.debian.org
X-Operating-System: Debian GNU/Linux
X-GnuPG-KeyID: 5E3619D3
X-PGP-Fingerprint: D792 B8A5 A567 B001 C342  2613 BDF2 A220 5E36 19D3
In-Reply-To: <7v61x22av9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 25 Jun 2013 13:28:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229374>

Merge strategy and its options can be specified in `git rebase`,
but with `--interactive`, they were completely ignored.

Signed-off-by: Arnaud Fontaine <arnau@debian.org>
---
 git-rebase--interactive.sh    | 21 ++++++++++++++++-----
 t/t3404-rebase-interactive.sh | 11 +++++++++++
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 169e876..157690b 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -80,6 +80,18 @@ amend="$state_dir"/amend
 rewritten_list="$state_dir"/rewritten-list
 rewritten_pending="$state_dir"/rewritten-pending
 
+strategy_args=
+if test -n "$do_merge"
+then
+	strategy_args=${strategy:+--strategy=$strategy}
+	eval '
+		for strategy_opt in '"$strategy_opts"'
+		do
+			strategy_args="$strategy_args -X$(git rev-parse --sq-quote "${strategy_opt#--}")"
+		done
+	'
+fi
+
 GIT_CHERRY_PICK_HELP="$resolvemsg"
 export GIT_CHERRY_PICK_HELP
 
@@ -239,7 +251,7 @@ pick_one () {
 
 	test -d "$rewritten" &&
 		pick_one_preserving_merges "$@" && return
-	output git cherry-pick $empty_args $ff "$@"
+	output eval git cherry-pick "$strategy_args" $empty_args $ff "$@"
 }
 
 pick_one_preserving_merges () {
@@ -340,9 +352,8 @@ pick_one_preserving_merges () {
 			msg_content="$(commit_message $sha1)"
 			# No point in merging the first parent, that's HEAD
 			new_parents=${new_parents# $first_parent}
-			if ! do_with_author output \
-				git merge --no-ff ${strategy:+-s $strategy} -m \
-					"$msg_content" $new_parents
+			if ! do_with_author output eval \
+			'git merge --no-ff $strategy_args -m "$msg_content" $new_parents'
 			then
 				printf "%s\n" "$msg_content" > "$GIT_DIR"/MERGE_MSG
 				die_with_patch $sha1 "Error redoing merge $sha1"
@@ -350,7 +361,7 @@ pick_one_preserving_merges () {
 			echo "$sha1 $(git rev-parse HEAD^0)" >> "$rewritten_list"
 			;;
 		*)
-			output git cherry-pick "$@" ||
+			output eval git cherry-pick "$strategy_args" "$@" ||
 				die_with_patch $sha1 "Could not pick $sha1"
 			;;
 		esac
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index d6b4143..8a6ec03 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -950,4 +950,15 @@ test_expect_success 'rebase -i, with <onto> and <upstream> specified as :/quuxer
 	git checkout branch1
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
