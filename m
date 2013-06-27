From: Andrew Pimlott <andrew@pimlott.net>
Subject: Re: [PATCH] rebase -i: fixup fixup! fixup!
Date: Thu, 27 Jun 2013 12:26:31 -0700
Message-ID: <1372359783-sup-4507@pimlott.net>
References: <20130611180530.GA18488@oinkpad.pimlott.net> <87obbc8otc.fsf@hexa.v.cablecom.net> <1371237209-sup-639@pimlott.net> <1371278908-sup-1930@pimlott.net> <7vk3lvlmat.fsf@alter.siamese.dyndns.org> <87ip1e2tzx.fsf@hexa.v.cablecom.net> <7v7ghtjwbb.fsf@alter.siamese.dyndns.org> <8738shi2ht.fsf@linux-k42r.v.cablecom.net> <7vwqpshkxj.fsf@alter.siamese.dyndns.org> <1372190294-sup-1398@pimlott.net> <7v61x127bw.fsf@alter.siamese.dyndns.org> <1372198415-sup-2114@pimlott.net> <1372283778-sup-5704@pimlott.net> <7vd2r8v3fa.fsf@alter.siamese.dyndns.org> <1372291877-sup-8201@pimlott.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>, git <git@vger.kernel.org>
To: Andrew Pimlott <andrew@pimlott.net>
X-From: git-owner@vger.kernel.org Thu Jun 27 21:26:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsHqA-0003wB-4N
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 21:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754052Ab3F0T0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 15:26:41 -0400
Received: from pimlott.net ([72.249.23.100]:59836 "EHLO fugue.pimlott.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753654Ab3F0T0j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 15:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pimlott.net; s=default;
	h=Content-Transfer-Encoding:Message-Id:Date:References:In-reply-to:To:From:Subject:Cc:Content-Type; bh=zlx1u4JTE3WRwr7EUD+pB71Z8UlVRr7fzX+SPKJYP/Q=;
	b=N3v16AnHb+zijZKq+1x2hCPls4QnaIWs4RnaQex0MPTVZ6uEtyJcU1O+qFrzeE6kePcW/U7oXQUuDhtFM7F380dQhLMVKS5UElRs4wUpRUob/A2T9x0kK3PPuhUz5jqYxdG/MuZZ/Ky+Z3+cayx6gBjahwO8bRMZZ+k9+BcUWPY=;
Received: from andrew by fugue.pimlott.net with local (Exim 4.72)
	(envelope-from <andrew@pimlott.net>)
	id 1UsHpv-0006sf-EA; Thu, 27 Jun 2013 12:26:31 -0700
In-reply-to: <1372291877-sup-8201@pimlott.net>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229148>

Excerpts from Andrew Pimlott's message of Wed Jun 26 17:20:32 -0700 2013:
> Excerpts from Junio C Hamano's message of Wed Jun 26 16:48:57 -0700 2013:
> > Andrew Pimlott <andrew@pimlott.net> writes:
> > > In order to test this, I wrote a helper function to dump the rebase -i
> > > todo list.  Would you like this introduced in its own patch, or
> > > combined?  See below.
> > 
> > Depends on how involved the addition of the tests that actually use
> > the helper, but in general it would be a good idea to add it in the
> > first patch that actually uses it.  Unused code added in a separate
> > patch will not point at that patch when bisecting, if that unused
> > code was broken from the beginning (not that I see anything
> > immediately broken in the code the following adds).
> 
> Ok, here is the complete commit, incorporating all feedback.

Updated for recommended here-doc style.

Andrew

---8<---
Subject: [PATCH] rebase -i: handle fixup! fixup! in --autosquash

In rebase -i --autosquash, ignore all "fixup! " or "squash! " after the
first.  This supports the case when a git commit --fixup/--squash referred
to an earlier fixup/squash instead of the original commit (whether
intentionally, as when the user expressly meant to note that the commit
fixes an earlier fixup; or inadvertently, as when the user meant to refer to
the original commit with :/msg; or out of laziness, as when the user could
remember how to refer to the fixup but not the original).

In the todo list, the full commit message is preserved, in case it provides
useful cues to the user.  A test helper set_cat_todo_editor is introduced to
check this.

Helped-by: Thomas Rast <trast@inf.ethz.ch>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Andrew Pimlott <andrew@pimlott.net>
---
 Documentation/git-rebase.txt |    4 ++-
 git-rebase--interactive.sh   |   25 ++++++++++++++----
 t/lib-rebase.sh              |   14 +++++++++++
 t/t3415-rebase-autosquash.sh |   57 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 94 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index c84854a..6b2e1c8 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -389,7 +389,9 @@ squash/fixup series.
 	the same ..., automatically modify the todo list of rebase -i
 	so that the commit marked for squashing comes right after the
 	commit to be modified, and change the action of the moved
-	commit from `pick` to `squash` (or `fixup`).
+	commit from `pick` to `squash` (or `fixup`).  Ignores subsequent
+	"fixup! " or "squash! " after the first, in case you referred to an
+	earlier fixup/squash with `git commit --fixup/--squash`.
 +
 This option is only valid when the '--interactive' option is used.
 +
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index f953d8d..169e876 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -689,8 +689,22 @@ rearrange_squash () {
 		case "$message" in
 		"squash! "*|"fixup! "*)
 			action="${message%%!*}"
-			rest="${message#*! }"
-			echo "$sha1 $action $rest"
+			rest=$message
+			prefix=
+			# skip all squash! or fixup! (but save for later)
+			while :
+			do
+				case "$rest" in
+				"squash! "*|"fixup! "*)
+					prefix="$prefix${rest%%!*},"
+					rest="${rest#*! }"
+					;;
+				*)
+					break
+					;;
+				esac
+			done
+			echo "$sha1 $action $prefix $rest"
 			# if it's a single word, try to resolve to a full sha1 and
 			# emit a second copy. This allows us to match on both message
 			# and on sha1 prefix
@@ -699,7 +713,7 @@ rearrange_squash () {
 				if test -n "$fullsha"; then
 					# prefix the action to uniquely identify this line as
 					# intended for full sha1 match
-					echo "$sha1 +$action $fullsha"
+					echo "$sha1 +$action $prefix $fullsha"
 				fi
 			fi
 		esac
@@ -714,7 +728,7 @@ rearrange_squash () {
 		esac
 		printf '%s\n' "$pick $sha1 $message"
 		used="$used$sha1 "
-		while read -r squash action msg_content
+		while read -r squash action msg_prefix msg_content
 		do
 			case " $used" in
 			*" $squash "*) continue ;;
@@ -730,7 +744,8 @@ rearrange_squash () {
 				case "$message" in "$msg_content"*) emit=1;; esac ;;
 			esac
 			if test $emit = 1; then
-				printf '%s\n' "$action $squash $action! $msg_content"
+				real_prefix=$(echo "$msg_prefix" | sed "s/,/! /g")
+				printf '%s\n' "$action $squash ${real_prefix}$msg_content"
 				used="$used$squash "
 			fi
 		done <"$1.sq"
diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 4b74ae4..cfd3409 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -66,6 +66,20 @@ EOF
 	chmod a+x fake-editor.sh
 }
 
+# After set_cat_todo_editor, rebase -i will write the todo list (ignoring
+# blank lines and comments) to stdout, and exit failure (so you should run
+# it with test_must_fail).  This can be used to verify the expected user
+# experience, for todo list changes that do not affect the outcome of
+# rebase; or as an extra check in addition to checking the outcome.
+
+set_cat_todo_editor () {
+	write_script fake-editor.sh <<-\EOF
+	grep "^[^#]" "$1"
+	exit 1
+	EOF
+	test_set_editor "$(pwd)/fake-editor.sh"
+}
+
 # checks that the revisions in "$2" represent a linear range with the
 # subjects in "$1"
 test_linear_range () {
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index a1e86c4..7c989f9 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -4,6 +4,8 @@ test_description='auto squash'
 
 . ./test-lib.sh
 
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
 test_expect_success setup '
 	echo 0 >file0 &&
 	git add . &&
@@ -193,4 +195,59 @@ test_expect_success 'use commit --squash' '
 	test_auto_commit_flags squash 2
 '
 
+test_auto_fixup_fixup () {
+	git reset --hard base &&
+	echo 1 >file1 &&
+	git add -u &&
+	test_tick &&
+	git commit -m "$1! first" &&
+	echo 2 >file1 &&
+	git add -u &&
+	test_tick &&
+	git commit -m "$1! $2! first" &&
+	git tag "final-$1-$2" &&
+	test_tick &&
+	(
+		set_cat_todo_editor &&
+		test_must_fail git rebase --autosquash -i HEAD^^^^ >actual &&
+		cat >expected <<EOF
+pick $(git rev-parse --short HEAD^^^) first commit
+$1 $(git rev-parse --short HEAD^) $1! first
+$1 $(git rev-parse --short HEAD) $1! $2! first
+pick $(git rev-parse --short HEAD^^) second commit
+EOF
+		test_cmp expected actual
+	) &&
+	git rebase --autosquash -i HEAD^^^^ &&
+	git log --oneline >actual &&
+	test_line_count = 3 actual
+	git diff --exit-code "final-$1-$2" &&
+	test 2 = "$(git cat-file blob HEAD^:file1)" &&
+	if test "$1" = "fixup"
+	then
+		test 1 = $(git cat-file commit HEAD^ | grep first | wc -l)
+	elif test "$1" = "squash"
+	then
+		test 3 = $(git cat-file commit HEAD^ | grep first | wc -l)
+	else
+		false
+	fi
+}
+
+test_expect_success 'fixup! fixup!' '
+	test_auto_fixup_fixup fixup fixup
+'
+
+test_expect_success 'fixup! squash!' '
+	test_auto_fixup_fixup fixup squash
+'
+
+test_expect_success 'squash! squash!' '
+	test_auto_fixup_fixup squash squash
+'
+
+test_expect_success 'squash! fixup!' '
+	test_auto_fixup_fixup squash fixup
+'
+
 test_done
-- 
1.7.10.4
