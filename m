From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v3 25/27] rebase -i: do not overwrite user author information
Date: Mon, 18 Aug 2014 23:23:08 +0200
Message-ID: <38063822188190750b20942d242f5826fe97df4f.1408396036.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1408396036.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 23:24:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJUPu-0000iP-2W
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 23:24:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752445AbaHRVYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 17:24:35 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:57149 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418AbaHRVY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 17:24:27 -0400
Received: by mail-lb0-f181.google.com with SMTP id 10so4768398lbg.12
        for <git@vger.kernel.org>; Mon, 18 Aug 2014 14:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qWVwk9eo2BRjQEGmht480ktoKIDSoFjDetnEDsa6GII=;
        b=F2cUx1KTB0o4gn7oBdjWLLCZUwmBcizA/jKg4JfYatkHjRtq5v59yXPwR3advMzHNA
         J9UcnXMvRAcfbnToakrAudn++CEiYNqqt9u/Z5A/pjbx9YUb9AzoSj7nmuUUzqPIC0BY
         Aj8IwY55TGb7Zym1i+tCr0jmGRJ4X+jjytLve/twBQ4RvVNSbzXBKYuFSprHOxW18aEu
         Tk6RwCzItgFZHQt3vMLF5s9KvhOGUhmgi2BnGi8HswGKK1Egh3YP9iUUgA3moJ3I7g78
         NPnXIzxKmRJTAwXiU5d0D8I3qBy162nSOaN8D8SxVq4U4GzEy516cVjtQvKJyCX9K856
         tdIg==
X-Received: by 10.112.72.106 with SMTP id c10mr5135511lbv.100.1408397065968;
        Mon, 18 Aug 2014 14:24:25 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id m9sm28852273lbd.28.2014.08.18.14.24.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Aug 2014 14:24:25 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1408396036.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255428>

The shell function `get_author_ident_from_commit` defined by
git-sh-setup retrieves the author information from the named commit
and returns assignments of the environment variables

    GIT_AUTHOR_NAME
    GIT_AUTHOR_EMAIL
    GIT_AUTHOR_DATE

ready for evaluation by the shell.

This interface is used in conjunction with the so-called author
script which is a git-rebase--interactive state file that contains
the `get_author_ident_from_commit` output. It is sourced when `git
rebase --continue` is executed after conflict resolution to retain
the original commit authorship.

The variable assignments are only exported by the subshell that
executes the git-commit command line that commits the resolved
conflicts. That is taken care of by wrapping the git-commit call in
`do_with_author`. However, this is not enough protection from
modifying the git environment variables unintentionally because the
user running git-rebase could have already exported those herself.
And therefore, a bare git-commit could result in an authorship that
is neither intended by the user nor by git-rebase--interactive.

While it is not an issue now (either `do_with_author`,
git-cherry-pick or `--amend` are used to create commits), the
unnecessary loss of the author name and e-mail copied from the user
environment, and the unneeded fixing of the author date might become
a problem when we decide to support something similar to
`--reset-author` or `--ignore-date in interactive git-rebase.

Do not assign the git environment variables until in the
`do_with_author` subshell.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 73c97a1..8fbfe6d 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -166,7 +166,7 @@ make_patch () {
 	test -f "$msg" ||
 		commit_message "$1" > "$msg"
 	test -f "$author_script" ||
-		get_author_ident_from_commit "$1" > "$author_script"
+		echo "$1" > "$author_script"
 }
 
 die_with_patch () {
@@ -215,9 +215,13 @@ is_merge_commit()
 }
 
 # Run command with GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and
-# GIT_AUTHOR_DATE exported from the current environment.
+# GIT_AUTHOR_DATE assigned the author information extracted from the
+# named commit and exported.
 do_with_author () {
 	(
+		sha1=$1
+		shift
+		eval $(get_author_ident_from_commit $sha1)
 		export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE
 		"$@"
 	)
@@ -348,13 +352,11 @@ pick_one_preserving_merges () {
 			test "a$1" = a-n && die "Refusing to squash a merge: $sha1"
 
 			# redo merge
-			author_script_content=$(get_author_ident_from_commit $sha1)
-			eval "$author_script_content"
 			msg_content="$(commit_message $sha1)"
 			# No point in merging the first parent, that's HEAD
 			new_parents=${new_parents# $first_parent}
 			merge_args="--no-log --no-ff"
-			if ! do_with_author output eval \
+			if ! do_with_author $sha1 output eval \
 			'git merge ${gpg_sign_opt:+"$gpg_sign_opt"} \
 				$merge_args $strategy_args -m "$msg_content" $new_parents'
 			then
@@ -592,8 +594,7 @@ do_pick () {
 		do_with_author=
 		if test -z "$rewrite_reset_author" && test -z "$rewrite_amend"
 		then
-			eval $(get_author_ident_from_commit $1)
-			do_with_author=do_with_author
+			do_with_author="do_with_author $1"
 		fi
 		$do_with_author output git commit \
 			   --allow-empty --no-post-rewrite -n --no-edit \
@@ -1041,9 +1042,9 @@ first and then run 'git rebase --continue' again."
 				${gpg_sign_opt:+"$gpg_sign_opt"} ||
 				die "Could not commit staged changes."
 		else
-			. "$author_script" ||
+			test -r "$author_script" ||
 				die "Error trying to find the author identity to amend commit"
-			do_with_author git commit --no-verify -F "$msg" -e \
+			do_with_author $(cat "$author_script") git commit --no-verify -F "$msg" -e \
 				${gpg_sign_opt:+"$gpg_sign_opt"} ||
 				die "Could not commit staged changes."
 		fi
-- 
2.0.1
