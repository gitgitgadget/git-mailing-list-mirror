From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v2 09/23] rebase -i: teach do_pick the option --edit
Date: Thu,  7 Aug 2014 01:59:16 +0200
Message-ID: <7b2e3963355a01519892205116570cbd96f20f5b.1407368621.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1407368621.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 02:00:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFB8Q-0003kY-D6
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 02:00:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754388AbaHGAAm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 20:00:42 -0400
Received: from mail-qa0-f50.google.com ([209.85.216.50]:37259 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754340AbaHGAAk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 20:00:40 -0400
Received: by mail-qa0-f50.google.com with SMTP id s7so3241946qap.37
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 17:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gOQsFUXvb0AwN03054kn3N/IXJDnEq+mu1C0REofSq4=;
        b=Nu3sIcWw2hiS3lMWJ7ijHA5hCfKkMGBLxnA0cr8JihjqazMAxKk3Ai8fqSIBYPHs+2
         cYL0cXRFfdkov3spV8Az73nuEp/wf0NWzrAMqtn769kbMPfFBArwqpnh2OBNtlaqkNjL
         kyiU2s+9pYxpB8nfEnkERUyUDdVxLDtGTnXZzFl4rhiMFGh87RqxUjV56wu6TAAtD0XA
         +lC9KjGRNu438cwKzEE2QebcK0QYSLdENqKfm7tN4erSmyBobtGsfoymPBVDIKg4ov4g
         QfuG7aPbsoBlwRjXwyC9w9LwySTVhpj1PuuRjb7CL1yrqHZMdDiQUQAlcz6rTWk8jVNu
         5MCQ==
X-Received: by 10.224.26.84 with SMTP id d20mr21861086qac.11.1407369639917;
        Wed, 06 Aug 2014 17:00:39 -0700 (PDT)
Received: from puffy.localdomain (HSI-KBW-046-005-203-106.hsi8.kabel-badenwuerttemberg.de. [46.5.203.106])
        by mx.google.com with ESMTPSA id n74sm2637391qga.34.2014.08.06.17.00.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Aug 2014 17:00:39 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1407368621.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254925>

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
index edc323d..aed2f93 100644
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
