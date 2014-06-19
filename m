From: Fabian Ruch <bafain@gmail.com>
Subject: [RFC PATCH 2/7] rebase -i: Teach do_pick the option --edit
Date: Thu, 19 Jun 2014 05:28:30 +0200
Message-ID: <53A258DE.10407@gmail.com>
References: <cover.1403146774.git.bafain@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 05:28:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxT1k-0002wl-8P
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 05:28:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756779AbaFSD2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 23:28:35 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35630 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674AbaFSD2e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 23:28:34 -0400
Received: by mail-wi0-f178.google.com with SMTP id n15so2099407wiw.17
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 20:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=tKUy1ndqBYq8lkc3j6S5LHTgFjq9+rlfOqc2xJx8bR4=;
        b=vma2QPFw7aDMO8W06uDKxmC/BAtAZuKCbTBsgMKpCkkCOmCJT1/wJfa9Rw4/lzUYz7
         Id02uo1f3KsgyJ33inpS4Q1mQsa6Ku44X/fJKb5pzKKQ77aEGSMhkBUL5SHYzgqqeiiZ
         dzaaswSOgHZMlCego+rY0cZKuNwDn/f1QRb8ytkYB2J/a0LZSBozCvfVLHOAvU3hfO4w
         5bglo/cTScHxPSOkGUhDkzPuLoVbmwpdd2Wc6lEaFakD7x7gX/8Y/bLRtWE76KevoEi1
         Wgl/W94AuKvmDfTedXQAoQNC0rTiu0DoQJXaZ8dRg67OmhThysFSqLEbThcx5u/XYa8Q
         b5Ig==
X-Received: by 10.180.99.166 with SMTP id er6mr2490982wib.48.1403148512539;
        Wed, 18 Jun 2014 20:28:32 -0700 (PDT)
Received: from client.googlemail.com (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id vc2sm5796834wjc.2.2014.06.18.20.28.30
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Jun 2014 20:28:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <cover.1403146774.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252090>

The to-do list command `reword` replays a commit like `pick` but lets
the user also edit the commit's log message. If one thinks of `pick`
entries as scheduled `cherry-pick` command lines, then `reword` becomes
an alias for the command line `cherry-pick --edit`. The porcelain
`rebase--interactive` defines a function `do_pick` for processing the
`pick` entries on to-do lists. Teach `do_pick` to handle the option
`--edit` and reimplement `reword` in terms of `do_pick --edit`. Refer to
`pick_one` for the way options are parsed.

`do_pick` ought to act as a wrapper around `cherry-pick`. Unfortunately,
it cannot just forward `--edit` to the `cherry-pick` command line. The
assembled command line is executed within a command substitution for
controlling the verbosity of `rebase--interactive`. Passing `--edit`
would either hang the terminal or clutter the substituted command output
with control sequences. Execute the `reword` code from `do_next` instead
if the option `--edit` is specified. Adjust the fragment in two regards.
Firstly, discard the additional message which is printed if an error
occurs because

    Aborting commit due to empty commit message. (Duplicate Signed-off-by lines.)
    Could not amend commit after successfully picking 1234567... Some change

is more readable than and contains (almost) the same information as

    Aborting commit due to empty commit message. (Duplicate Signed-off-by lines.)
    Could not amend commit after successfully picking 1234567... Some change
    This is most likely due to an empty commit message, or the pre-commit hook
    failed. If the pre-commit hook failed, you may need to resolve the issue before
    you are able to reword the commit.

(It is true that a hook might not output any diagnosis but the same
problem arises when using git-commit directly. git-rebase at least
prints a generic message saying that it failed to commit.) Secondly,
sneak in additional git-commit arguments:

 - `--allow-empty` is missing: `rebase--interactive` suddenly fails if
   an empty commit is picked using `reword` instead of `pick`. The
   whether a commit is empty or not is not changed by an altered log
   message, so do as `pick` does. Add test.

 - `-n`: Hide the fact that we are committing several times by not
   executing the pre-commit hook. Caveat: The altered log message is not
   verified because `-n` also skips the commit-msg hook. Either the log
   message verification must be included in the post-rewrite hook or
   git-commit must support more fine-grained control over which hooks
   are executed.

 - `-q`: Hide the fact that we are committing several times by not
   printing the commit summary.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh    | 52 ++++++++++++++++++++++++++++++++++++-------
 t/t3404-rebase-interactive.sh |  8 +++++++
 2 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index ea5514e..fffdfa5 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -490,7 +490,42 @@ record_in_rewritten() {
 	esac
 }
 
+# Apply the changes introduced by the given commit to the current head.
+#
+# do_pick [--edit] <commit> <title>
+#
+# Wrapper around git-cherry-pick.
+#
+# <title>
+#     The commit message title of <commit>. Used for information
+#     purposes only.
+#
+# <commit>
+#     The commit to cherry-pick.
+#
+# -e, --edit
+#     After picking <commit>, open an editor and let the user edit the
+#     commit message. The editor contents becomes the commit message of
+#     the new head.
 do_pick () {
+	edit=
+	while test $# -gt 0
+	do
+		case "$1" in
+		-e|--edit)
+			edit=y
+			;;
+		-*)
+			warn "do_pick: ignored option -- $1"
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
@@ -512,6 +547,14 @@ do_pick () {
 		pick_one $1 ||
 			die_with_patch $1 "Could not apply $1... $2"
 	fi
+
+	if test -n "$edit"
+	then
+		git commit --allow-empty --amend --no-post-rewrite -n -q ${gpg_sign_opt:+"$gpg_sign_opt"} || {
+			warn "Could not amend commit after successfully picking $1... $2"
+			exit_with_patch $1 1
+		}
+	fi
 }
 
 do_next () {
@@ -532,14 +575,7 @@ do_next () {
 		comment_for_reflog reword
 
 		mark_action_done
-		do_pick $sha1 "$rest"
-		git commit --amend --no-post-rewrite ${gpg_sign_opt:+"$gpg_sign_opt"} || {
-			warn "Could not amend commit after successfully picking $sha1... $rest"
-			warn "This is most likely due to an empty commit message, or the pre-commit hook"
-			warn "failed. If the pre-commit hook failed, you may need to resolve the issue before"
-			warn "you are able to reword the commit."
-			exit_with_patch $sha1 1
-		}
+		do_pick --edit $sha1 "$rest"
 		record_in_rewritten $sha1
 		;;
 	edit|e)
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 8197ed2..9931143 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -75,6 +75,14 @@ test_expect_success 'rebase --keep-empty' '
 	test_line_count = 6 actual
 '
 
+test_expect_success 'rebase --keep-empty' '
+	git checkout emptybranch &&
+	set_fake_editor &&
+	FAKE_LINES="1 reword 2" git rebase --keep-empty -i HEAD~2 &&
+	git log --oneline >actual &&
+	test_line_count = 6 actual
+'
+
 test_expect_success 'rebase -i with the exec command' '
 	git checkout master &&
 	(
-- 
2.0.0
