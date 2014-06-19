From: Fabian Ruch <bafain@gmail.com>
Subject: [RFC PATCH 7/7] rebase -i: Teach do_pick the options --amend and
 --file
Date: Thu, 19 Jun 2014 05:28:50 +0200
Message-ID: <53A258F2.8050300@gmail.com>
References: <cover.1403146774.git.bafain@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 05:29:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxT22-0003KO-IR
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 05:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757109AbaFSD2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 23:28:54 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:49512 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757039AbaFSD2x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 23:28:53 -0400
Received: by mail-wi0-f171.google.com with SMTP id n15so8615380wiw.4
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 20:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=5M5weJxbTGWLylTVynJbYym+1D1Prt59o5tq5Bnld2k=;
        b=Dz6v2Kq/ViLnQJx9Qu9vTx6OxeTo0rpon6F8qDtKsSoIIdFJ5zqIC4l7cmlqd4DB9a
         y2mm3K3apr8uXYnI25TKeV2NjQHHp89gd7VW15gAnh/HREhY271H/SrkSG4Emstwndnp
         ijuT6LkSMxOc2sqSrfe489maN2uPfXO/6M9NsNV7FzmMjvhun5yT3t1zuMIAjyHUEkYA
         DPdZ3iO5MffIm1MAmoW+pxKvMeiO0/lrpoDxLmc+Vz3wWT5Sxrx1PUbWees2wmAaZa0Y
         s7PThMeN8SunU0wgqrAmRfelhmnN2vsNiALrvDtr6gICxFXPv52UMsCpxKGQkH5mX1t9
         RNNg==
X-Received: by 10.194.10.69 with SMTP id g5mr1901348wjb.116.1403148532567;
        Wed, 18 Jun 2014 20:28:52 -0700 (PDT)
Received: from client.googlemail.com (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id rw4sm5774919wjb.44.2014.06.18.20.28.51
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Jun 2014 20:28:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <cover.1403146774.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252095>

The to-do list command `squash` and its close relative `fixup` replay
the changes of a commit like `pick` but do not recreate the commit.
Instead they replace the previous commit with a new commit that also
introduces the changes of the squashed commit. This is roughly like
cherry-picking without committing and using git-commit to amend the
previous commit.

The to-do list

    pick   a Some changes
    squash b Some more changes

gets translated into the sequence of git commands

    git cherry-pick a
    git cherry-pick -n b
    git commit --amend

and if `cherry-pick` supported `--amend` this would look even more like
the to-do list it is based on

    git cherry-pick a
    git cherry-pick --amend b.

Since `do_pick` takes care of `pick` entries and the above suggests
`squash` as an alias for `pick --amend`, teach `do_pick` to handle the
option `--amend` and reimplement `squash` in terms of `do_pick --amend`.
Also teach it the option `--file` which is used to specify `$squash_msg`
as commit message.

Both `--amend` and `--file` are commit rewriting options. If they are
encountered during options parsing, assign `rewrite` and pass `--amend`
(`--file` respectively) to the rewrite command. Be careful when
`--amend` is used to pick a root commit because HEAD might point to the
sentinel commit but there is still nothing to amend. Be sure to
initialize `$amend` so that commits are squashed even when `rebase` is
interrupted for resolving conflicts. It is not a mistake to do the
initialization regardless of any conflicts because `$amend` is always
cleared before the next to-do item is processed.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---

Notes:
    A question about when to enable the post-rewrite hook.
    
    `rebase` collects the hashes of all processed commits using
    `record_in_rewritten` and runs the post-rewrite script after the rebase
    is complete. Two points seem to confuse me.
    
     1) For a `pick` the hash is `record_in_rewritten` regardless of whether
        the hash changed or not (the commit was recreated or the head was
        fast-forwarded). Ok, the hook can figure that out. Is this behaviour
        intended?
    
     2) For a `reword` the amend disables the post-rewrite hook but for a
        `squash` (or `fixup`) the hook is executed each time the squash
        commit is amended. Does not this result in the hook being executed
        twice for each scheduled `squash` command? Once for the amend and
        once for the rebase. The hook most likely does not figure that out.
    
    This patch never executes the post-rewrite hook when processing the
    to-do list. The execution after the rebase is finished is still
    conducted. I am uncertain whether this is correct. The tests seem to
    succeed with both implementations.

 git-rebase--interactive.sh | 65 ++++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 25 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index ada520d..5ddc59d 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -493,7 +493,7 @@ record_in_rewritten() {
 
 # Apply the changes introduced by the given commit to the current head.
 #
-# do_pick [--edit] <commit>
+# do_pick [--file <file>] [--amend] [--edit] <commit>
 #
 # Wrapper around git-cherry-pick.
 #
@@ -505,6 +505,17 @@ record_in_rewritten() {
 #     commit message. The editor contents becomes the commit message of
 #     the new head.
 #
+# --amend
+#     After picking <commit>, replace the current head commit with a new
+#     commit that also introduces the changes of <commit>.
+#
+#     _This is not a git-cherry-pick option._
+#
+# -F <file>, --file <file>
+#     Take the commit message from the given file.
+#
+#     _This is not a git-cherry-pick option._
+#
 # The return value is 1 if applying the changes resulted in a conflict
 # and 2 if the specified arguments were incorrect. If the changes could
 # be applied successfully but creating the commit failed, a value
@@ -514,9 +525,30 @@ do_pick () {
 	rewrite=
 	rewrite_amend=
 	rewrite_edit=
+	rewrite_message=
 	while test $# -gt 0
 	do
 		case "$1" in
+		-F|--file)
+			if test $# -eq 0
+			then
+				warn "do_pick: option --file specified but no <file> given"
+				return 2
+			fi
+			rewrite=y
+			rewrite_message=$2
+			shift
+			;;
+		--amend)
+			if test "$(git rev-parse HEAD)" = "$squash_onto" || ! git rev-parse --verify HEAD
+			then
+				warn "do_pick: nothing to amend"
+				return 2
+			fi
+			rewrite=y
+			rewrite_amend=y
+			git rev-parse --verify HEAD >"$amend"
+			;;
 		-e|--edit)
 			rewrite=y
 			rewrite_edit=y
@@ -561,6 +593,7 @@ do_pick () {
 		git commit --allow-empty --no-post-rewrite -n -q \
 			   ${rewrite_amend:+--amend} \
 			   ${rewrite_edit:+--edit} \
+			   ${rewrite_message:+--file "$rewrite_message"} \
 			   ${gpg_sign_opt:+"$gpg_sign_opt"} || return 3
 	fi
 }
@@ -617,38 +650,20 @@ do_next () {
 		squash|s|fixup|f)
 			# This is an intermediate commit; its message will only be
 			# used in case of trouble.  So use the long version:
-			if ! pick_one -n $sha1
-			then
-				git rev-parse --verify HEAD >"$amend"
-				die_failed_squash $sha1 "Could not apply $sha1... $rest"
-			fi
-			do_with_author output git commit --amend --no-verify -F "$squash_msg" \
-				${gpg_sign_opt:+"$gpg_sign_opt"} ||
-				die_failed_squash $sha1 "$rest"
+			do_with_author do_pick --amend -F "$squash_msg" $sha1 \
+				|| die_failed_squash $sha1 "Could not apply $sha1... $rest"
 			;;
 		*)
 			# This is the final command of this squash/fixup group
 			if test -f "$fixup_msg"
 			then
-				if ! pick_one -n $sha1
-				then
-					git rev-parse --verify HEAD >"$amend"
-					die_failed_squash $sha1 "Could not apply $sha1... $rest"
-				fi
-				do_with_author git commit --amend --no-verify -F "$fixup_msg" \
-					${gpg_sign_opt:+"$gpg_sign_opt"} ||
-					die_failed_squash $sha1 "$rest"
+				do_with_author do_pick --amend -F "$fixup_msg" $sha1 \
+					|| die_failed_squash $sha1 "Could not apply $sha1... $rest"
 			else
 				cp "$squash_msg" "$GIT_DIR"/SQUASH_MSG || exit
 				rm -f "$GIT_DIR"/MERGE_MSG
-				if ! pick_one -n $sha1
-				then
-					git rev-parse --verify HEAD >"$amend"
-					die_failed_squash $sha1 "Could not apply $sha1... $rest"
-				fi
-				do_with_author git commit --amend --no-verify -F "$GIT_DIR"/SQUASH_MSG -e \
-					${gpg_sign_opt:+"$gpg_sign_opt"} ||
-					die_failed_squash $sha1 "$rest"
+				do_with_author do_pick --amend -F "$GIT_DIR"/SQUASH_MSG -e $sha1 \
+					|| die_failed_squash $sha1 "Could not apply $sha1... $rest"
 			fi
 			rm -f "$squash_msg" "$fixup_msg"
 			;;
-- 
2.0.0
