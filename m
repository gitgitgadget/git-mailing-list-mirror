From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v1 04/19] rebase -i: teach do_pick the option --edit
Date: Tue, 29 Jul 2014 01:18:04 +0200
Message-ID: <a5d2fe395226f3ef9e9bcbafd2ccc5d32dc87074.1406589435.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1406589435.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 01:20:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBuDv-0006Bf-KT
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 01:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974AbaG1XUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 19:20:45 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:53034 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbaG1XUn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 19:20:43 -0400
Received: by mail-wg0-f46.google.com with SMTP id m15so8085675wgh.29
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 16:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kg5kmzUzkTjM1l8K1ZLsYSXQGzt+dNb8Eo/iYltQNEs=;
        b=AviY40stAsHK+kYmkDJq67+x07vNszRh1vLxGOISyoDhjZkB4Pa/eYv8CM9f7XNutG
         fFJmjLRIoq5UwlyqOHG/LMhjjzpJDOMdZaNR3/Rqd7LGwrn3ThdHibZdYK0iBIHaHWHw
         HFiQg4wDCyAc9rfljaU19S2VXsrI+TFFxc7Dd+t0KYVONdOwgxmcAYShQC0igF0PhKWE
         QsvQOPT3N9LRX0nzl/gxWXQ9Zoi+CPe4ibu3Kz1CIjjiwlqwotlbOOUB2Cv/nYoHKtoV
         5gSs/QxDanoweIwT26t7FNNMMdX3ycWw3BZg4sDNGIzrYP4HIv8Psf+U/Jdw+qQsB0qJ
         j2NA==
X-Received: by 10.194.110.7 with SMTP id hw7mr10933382wjb.38.1406589642339;
        Mon, 28 Jul 2014 16:20:42 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id pj6sm52914690wjb.21.2014.07.28.16.20.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jul 2014 16:20:41 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1406589435.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254366>

`do_pick` is the git-cherry-pick wrapper in git-rebase--interactive
that is used to implement the to-do list command `pick`. To cater for
the different pick behaviours (like `reword`), `do_pick` accepts
several options not only from the git-cherry-pick but also the
git-commit interface. Add the common option `--edit` to let the user
edit the log message of the named commit.

Loop over `$@` to parse the `do_pick` arguments. Assign the local
variable `edit` if one of the options is `--edit` so that the
remainder of `do_pick` can easily check whether the client code asked
to edit the commit message. If one of the options is unknown, mention
it on the console and `die`. Break the loop on the first non-option
and do some sanity checking to ensure that there exactly two
non-options, which are interpreted by the remainder as `<commit>` and
`<title>` like before.

`do_pick` ought to act as a wrapper around `cherry-pick`.
Unfortunately, it cannot just forward `--edit` to the `cherry-pick`
command line. The assembled command line is executed within a command
substitution for controlling the verbosity of `rebase--interactive`.
Passing `--edit` would either hang the terminal or clutter the
substituted command output with control sequences. Execute the
`reword` code from `do_next` instead if the option `--edit` is
specified.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index b50770d..e06d9b6 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -461,7 +461,42 @@ record_in_rewritten() {
 	esac
 }
 
+# Apply the changes introduced by the given commit to the current head.
+#
+# do_pick [--edit] <commit> <title>
+#
+# Wrapper around git-cherry-pick.
+#
+# -e, --edit
+#     After picking <commit>, open an editor and let the user edit the
+#     commit message. The editor contents becomes the commit message of
+#     the new head. This creates a fresh commit.
+#
+# <commit>
+#     The commit to cherry-pick.
+#
+# <title>
+#     The commit message title of <commit>. Used for information
+#     purposes only.
 do_pick () {
+	edit=
+	while test $# -gt 0
+	do
+		case "$1" in
+		-e|--edit)
+			edit=y
+			;;
+		-*)
+			die "do_pick: unrecognized option -- $1"
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done
+	test $# -ne 2 && die "do_pick: wrong number of arguments"
+
 	if test "$(git rev-parse HEAD)" = "$squash_onto"
 	then
 		# Set the correct commit message and author info on the
@@ -483,6 +518,23 @@ do_pick () {
 		pick_one $1 ||
 			die_with_patch $1 "Could not apply $1... $2"
 	fi
+
+	if test -n "$edit"
+	then
+		# TODO: Work around the fact that git-commit lets us
+		# disable either both the pre-commit and the commit-msg
+		# hook or none. Disable the pre-commit hook because the
+		# tree is left unchanged but run the commit-msg hook
+		# from here because the log message is altered.
+		git commit --allow-empty --amend --no-post-rewrite -n ${gpg_sign_opt:+"$gpg_sign_opt"} &&
+			if test -x "$GIT_DIR"/hooks/commit-msg
+			then
+				"$GIT_DIR"/hooks/commit-msg "$GIT_DIR"/COMMIT_EDITMSG
+			fi || {
+				warn "Could not amend commit after successfully picking $1... $2"
+				exit_with_patch $1 1
+			}
+	fi
 }
 
 do_next () {
-- 
2.0.1
