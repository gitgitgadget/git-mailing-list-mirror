From: Fabian Ruch <bafain@gmail.com>
Subject: [RFC PATCH 4/7] rebase -i: Commit only once when rewriting picks
Date: Thu, 19 Jun 2014 05:28:38 +0200
Message-ID: <53A258E6.5050301@gmail.com>
References: <cover.1403146774.git.bafain@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 05:28:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxT1o-0002z2-Q8
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 05:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756897AbaFSD2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 23:28:42 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:46969 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674AbaFSD2l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 23:28:41 -0400
Received: by mail-wg0-f46.google.com with SMTP id y10so1684458wgg.5
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 20:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=tx+xtyxBLwx7S7cRFo9vBhLW42IaP1kGhJzBzVLVBpg=;
        b=DSEuiwx6BiMvsK9Z7xiNeAsAPMPUu1GTXaOaG1XyVFbe7aHwhv0YWOKfpqA6rhdgVW
         0/VOumjzZa/6DI9nah5B4HNigz05yStmE5rEyT5lH5vH+36SL6Lbc7Hrr/WAqY8qaBnm
         vwa2CxDJfOqm2cDg7p9vyX2c4I7VrgKAIFn0XH5wbDuAg0/jmu7qEAn+a9l1hYD6b+qQ
         GTtVydVesPoJsyUqtf9b2JiaL2kVxQEPEJne6ZWnkJSpn2f1n+3Y27Dpm0NW4A38CA77
         0+7wXL2nLrkTc9W3dMBUYd9smDL6seF46uhpl2txPoa5xS0T7OcRxuL7IYB1QFx4MOfB
         oX8g==
X-Received: by 10.181.12.102 with SMTP id ep6mr2669426wid.0.1403148520006;
        Wed, 18 Jun 2014 20:28:40 -0700 (PDT)
Received: from client.googlemail.com (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id vm8sm5783007wjc.27.2014.06.18.20.28.38
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Jun 2014 20:28:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <cover.1403146774.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252092>

The options passed to `do_pick` determine whether the picked commit will
be rewritten or not. If the commit gets rewritten, because the user
requested to edit the commit message for instance, let `pick_one` merely
apply the changes introduced by the commit and do not commit the
resulting tree yet. If the commit is replayed as is, leave it to
`pick_one` to recreate the commit (possibly by fast-forwarding the
head). This makes it easier to combine git-commit options like `--edit`
and `--amend` in `do_pick` because git-cherry-pick does not support
`--amend`.

In the case of `--edit`, do not `exit_with_patch` but assign `rewrite`
to pick the changes with `-n`. If the pick conflicts, no commit is
created which we would have to amend when continuing the rebase. To
complete the pick after the conflicts are resolved the user just resumes
with `git rebase --continue`.

If `rebase--interactive` is used to rebase a complete branch onto some
head, `rebase` creates a sentinel commit that requires special treatment
by `do_pick`. Do not finalize the pick here either because its commit
message can be altered as for any other pick. Since the orphaned root
commit gets a temporary parent, it is always rewritten. Safely use the
rewrite infrastructure of `do_pick` to create the final commit.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index f09eeae..f903599 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -63,7 +63,8 @@ msgnum="$state_dir"/msgnum
 author_script="$state_dir"/author-script
 
 # When an "edit" rebase command is being processed, the SHA1 of the
-# commit to be edited is recorded in this file.  When "git rebase
+# commit to be edited is recorded in this file.  The same happens when
+# rewriting a commit fails, for instance "reword".  When "git rebase
 # --continue" is executed, if there are any staged changes then they
 # will be amended to the HEAD commit, but only provided the HEAD
 # commit is still the commit to be edited.  When any other rebase
@@ -508,12 +509,15 @@ record_in_rewritten() {
 #     commit message. The editor contents becomes the commit message of
 #     the new head.
 do_pick () {
-	edit=
+	rewrite=
+	rewrite_amend=
+	rewrite_edit=
 	while test $# -gt 0
 	do
 		case "$1" in
 		-e|--edit)
-			edit=y
+			rewrite=y
+			rewrite_edit=y
 			;;
 		-*)
 			warn "do_pick: ignored option -- $1"
@@ -528,6 +532,9 @@ do_pick () {
 
 	if test "$(git rev-parse HEAD)" = "$squash_onto"
 	then
+		rewrite=y
+		rewrite_amend=y
+		git rev-parse --verify HEAD >"$amend"
 		# Set the correct commit message and author info on the
 		# sentinel root before cherry-picking the original changes
 		# without committing (-n).  Finally, update the sentinel again
@@ -538,22 +545,20 @@ do_pick () {
 		# rebase --continue.
 		git commit --allow-empty --allow-empty-message --amend \
 			   --no-post-rewrite -n -q -C $1 &&
-			pick_one -n $1 &&
-			git commit --allow-empty --amend \
-				   --no-post-rewrite -n -q \
-				   ${gpg_sign_opt:+"$gpg_sign_opt"} ||
+			pick_one -n $1 ||
 			die_with_patch $1 "Could not apply $1... $2"
 	else
-		pick_one $1 ||
+		pick_one ${rewrite:+-n} $1 ||
 			die_with_patch $1 "Could not apply $1... $2"
 	fi
 
-	if test -n "$edit"
+	if test -n "$rewrite"
 	then
-		git commit --allow-empty --amend --no-post-rewrite -n -q ${gpg_sign_opt:+"$gpg_sign_opt"} || {
-			warn "Could not amend commit after successfully picking $1... $2"
-			exit_with_patch $1 1
-		}
+		git commit --allow-empty --no-post-rewrite -n -q \
+			   ${rewrite_amend:+--amend} \
+			   ${rewrite_edit:+--edit} \
+			   ${gpg_sign_opt:+"$gpg_sign_opt"} ||
+			die_with_patch $1 "Could not rewrite commit after successfully picking $1... $2"
 	fi
 }
 
-- 
2.0.0
