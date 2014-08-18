From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v3 10/27] rebase -i: teach do_pick the option --edit
Date: Mon, 18 Aug 2014 23:22:53 +0200
Message-ID: <ec6319e4ee8c594360a0678d05cc9c6e178af7fa.1408396036.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1408396036.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 23:25:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJUQy-0001II-B6
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 23:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359AbaHRVYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 17:24:07 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:63236 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332AbaHRVYA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 17:24:00 -0400
Received: by mail-la0-f50.google.com with SMTP id pi18so5093115lab.23
        for <git@vger.kernel.org>; Mon, 18 Aug 2014 14:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Roxp9M8Hqq0ypEkDTG32F7zQ77RQ21zemfgoVVEiRZo=;
        b=W/jBAeIdhSNp9z7H97JX5EmjCncZYJvNr+OCxIyha4+LMuU027t0hUD8kimI6lWxEw
         6NL/bRZTKnU9dOm3okwQnZvl/6nxZyH7Noouc52BR0Z429bKQaNiBMO8Rbk0RWcaF7Hj
         sLE22qbZ2BaOYT5QSf2ZAHo9kbaz6WPdZreVjv4AUx+GpniJ1GyWxgaCYmwPgdOcuDx8
         PXamrL2Rve5f89j4Lvt/o11ZtW8XYqUbOc6BU67moztHH/g/G4Qb0/5W3pPIyJzmMUGE
         G8sOVZ3W9iuEuukpoKXaoHeprVrG6aFaS2iwD8YszCmqyoQfnQVX3QiXjQ4NqB7ZI6lw
         dlVQ==
X-Received: by 10.112.35.97 with SMTP id g1mr30744092lbj.20.1408397038844;
        Mon, 18 Aug 2014 14:23:58 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id m9sm28852273lbd.28.2014.08.18.14.23.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Aug 2014 14:23:57 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1408396036.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255433>

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
 git-rebase--interactive.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 570c4e9..8a89ced 100644
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
@@ -483,6 +518,14 @@ do_pick () {
 		pick_one $1 ||
 			die_with_patch $1 "Could not apply $1... $2"
 	fi
+
+	if test -n "$edit"
+	then
+		output git commit --allow-empty --amend --no-post-rewrite --no-pre-commit ${gpg_sign_opt:+"$gpg_sign_opt"} || {
+			warn "Could not amend commit after successfully picking $1... $2"
+			exit_with_patch $1 1
+		}
+	fi
 }
 
 do_next () {
-- 
2.0.1
