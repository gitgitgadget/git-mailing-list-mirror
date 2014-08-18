From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v3 23/27] rebase -i: teach do_pick the option --reset-author
Date: Mon, 18 Aug 2014 23:23:06 +0200
Message-ID: <fafd51bd06a21956dc349c89726d8b2820b4bb2d.1408396036.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1408396036.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 23:24:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJUPs-0000iP-Gv
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 23:24:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423AbaHRVYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 17:24:25 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:62951 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418AbaHRVYX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 17:24:23 -0400
Received: by mail-lb0-f182.google.com with SMTP id z11so4742890lbi.13
        for <git@vger.kernel.org>; Mon, 18 Aug 2014 14:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+Kg4U5Mt6yBUGayr7phGBdU+01T94OV0DvJdPeIe5Wk=;
        b=cUtsJwlu3oCMyKXzRSE1XUwSO8dSiBYqSh7AXQXifJV0oeqiz8RvYp9pnq4x4a+vUI
         JvThZ4e45EveOZoPq6xY880+WDmvGgwLzFF0k6ICXigVNbYVAdVXprQ/TAFJS6SKloLJ
         XvB7Gg4Dyji4zWDl7DwuQE4ZT5pF/DYD7gUZh58ZfCmlAXWQRZ3BJZD5EvUMXffCSG7D
         nJx2AXB0VLzoZFnhXMSvJL5BhgUc2rZcq+aA3ZhaWTNHZVCo92UWU0lOwCniddxvF6KC
         WGamqlUp3QSfz38nMBIL+Sb9CXSsVxSXQFWr5rlhU67xgACQpB1vLNyZ/SoDhw/W1BUE
         VIeA==
X-Received: by 10.152.3.65 with SMTP id a1mr32294286laa.76.1408397062353;
        Mon, 18 Aug 2014 14:24:22 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id m9sm28852273lbd.28.2014.08.18.14.24.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Aug 2014 14:24:21 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1408396036.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255425>

`do_pick` is the git-cherry-pick wrapper in git-rebase--interactive
that is used to implement many of the to-do list commands.
Eventually, the complete `do_pick` interface will be exposed to the
user in some form or another and those commands will become simple
aliases for the `do_pick` options now used to implement them.

Add the git-commit option `--reset-author` to the options pool of
`do_pick`. It rewrites the author date and name of the picked commit
to match the committer date and name.

If `--reset-author` is passed to `do_pick`, set the `rewrite` flag
and relay the option to the git-commit command line which creates the
final commit. If `--amend` is not passed as well, the fresh
authorship effect is achieved by the mere fact that we are creating a
new commit. Do not even source the ident information in that case
because the user shell might have already exported the respective
environment variables.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 8b39f2d..6c75bc5 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -464,10 +464,18 @@ record_in_rewritten() {
 
 # Apply the changes introduced by the given commit to the current head.
 #
-# do_pick [--amend] [--file <file>] [--edit] <commit>
+# do_pick [--reset-author] [--amend] [--file <file>] [--edit] <commit>
 #
 # Wrapper around git-cherry-pick.
 #
+# --reset-author
+#     Pretend the changes were made for the first time. Declare that the
+#     authorship of the resulting commit now belongs to the committer.
+#     This also renews the author timestamp. This creates a fresh
+#     commit.
+#
+#     _This is not a git-cherry-pick option._
+#
 # --amend
 #     After picking <commit>, replace the current head commit with a new
 #     commit that also introduces the changes of <commit>.
@@ -496,12 +504,17 @@ record_in_rewritten() {
 do_pick () {
 	allow_empty_message=y
 	rewrite=
+	rewrite_reset_author=
 	rewrite_amend=
 	rewrite_edit=
 	rewrite_message=
 	while test $# -gt 0
 	do
 		case "$1" in
+		--reset-author)
+			rewrite=y
+			rewrite_reset_author=y
+			;;
 		--amend)
 			if test "$(git rev-parse HEAD)" = "$squash_onto" || ! git rev-parse -q --verify HEAD >/dev/null
 			then
@@ -566,11 +579,16 @@ do_pick () {
 
 	if test -n "$rewrite"
 	then
-		eval $(get_author_ident_from_commit $1)
-		do_with_author output git commit \
+		do_with_author=
+		if test -z "$rewrite_reset_author" && test -z "$rewrite_amend"
+		then
+			eval $(get_author_ident_from_commit $1)
+			do_with_author=do_with_author
+		fi
+		$do_with_author output git commit \
 			   --allow-empty --no-post-rewrite -n --no-edit \
 			   ${allow_empty_message:+--allow-empty-message} \
-			   ${rewrite_amend:+--amend} \
+			   ${rewrite_amend:+--amend ${rewrite_reset_author:+--reset-author}} \
 			   ${rewrite_edit:+--edit --commit-msg} \
 			   ${rewrite_message:+--file "$rewrite_message"} \
 			   ${gpg_sign_opt:+"$gpg_sign_opt"} || return 3
-- 
2.0.1
