From: Andrew Pimlott <andrew@pimlott.net>
Subject: [PATCH] rebase -i: fixup fixup! fixup!
Date: Fri, 14 Jun 2013 12:31:57 -0700
Message-ID: <1371237209-sup-639@pimlott.net>
References: <20130611180530.GA18488@oinkpad.pimlott.net> <87obbc8otc.fsf@hexa.v.cablecom.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jun 14 21:32:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnZjB-0003h8-E4
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 21:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753827Ab3FNTcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 15:32:00 -0400
Received: from pimlott.net ([72.249.23.100]:51090 "EHLO fugue.pimlott.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753778Ab3FNTcA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 15:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pimlott.net; s=default;
	h=Content-Transfer-Encoding:Message-Id:Date:References:In-reply-to:To:From:Subject:Cc:Content-Type; bh=Vx4cz/yjZ0ZJMTP3Mbu7tnWFW7M5g9tqEXHFMPvEMCU=;
	b=AKu2b2VDVKKcLi3KEzOXrMhC+ugKrWcqjl/xtrI8vS/jIAEEIlOHE0Ynm8upOSzjKYFl+13Fz2MFZmZ5l5PfcfOUvA3+9atdsDRVQZLfvB8fU0+m2/Ho9BwXWlfScOztWBfZVNg81J2+1Ghmajd07fcOEeocnGMQX5XetNzLD9k=;
Received: from andrew by fugue.pimlott.net with local (Exim 4.72)
	(envelope-from <andrew@pimlott.net>)
	id 1UnZj3-0005sS-KI; Fri, 14 Jun 2013 12:31:57 -0700
In-reply-to: <87obbc8otc.fsf@hexa.v.cablecom.net>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227914>

Excerpts from Thomas Rast's message of Tue Jun 11 11:50:07 -0700 2013:
> Andrew Pimlott <andrew@pimlott.net> writes:
> >     git commit -m 'fix nasty bug'
> >     ...
> >     git commit --fixup :/nasty
> >     ...
> >     git commit --fixup :/nasty
> >
> > The second :/nasty resolves to the previous fixup, not the initial
> > commit.  I could have made the regular expression more precise, but this
> > would be a hassle.
> >
> > Would a change to support fixup! fixup! be considered?
> 
> Sure, why not.  You could start with something like the patch below
> (untested).  If that happens to work, just add a test and a good commit
> message.

It happened to work and I added a test.  But then it occurred to me that
it might have been better to fix commit --fixup/--squash to strip the
fixup! or squash! from the referenced commit in the first place.
Anyhow, below is my patch for --autosquash, but unles someone has an
objection to doing it in commit, I'll work on that.

Andrew

Ignore subsequent "fixup! " or "squash! " after the first.  Handy in case a
git commit --fixup/--squash referred to a previous fixup/squash instead of
the original commit, for example with :/msg.

Signed-off-by: Andrew Pimlott <andrew@pimlott.net>
---
 Documentation/git-rebase.txt |    4 +++-
 git-rebase--interactive.sh   |   13 ++++++++++-
 t/t3415-rebase-autosquash.sh |   49 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index c84854a..725cf27 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -389,7 +389,9 @@ squash/fixup series.
 	the same ..., automatically modify the todo list of rebase -i
 	so that the commit marked for squashing comes right after the
 	commit to be modified, and change the action of the moved
-	commit from `pick` to `squash` (or `fixup`).
+	commit from `pick` to `squash` (or `fixup`).  Ignores subsequent
+	"fixup! " or "squash! " after the first, in case you referred to a
+	previous fixup/squash with `git commit --fixup/--squash`.
 +
 This option is only valid when the '--interactive' option is used.
 +
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index f953d8d..54ed4c3 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -689,7 +689,18 @@ rearrange_squash () {
 		case "$message" in
 		"squash! "*|"fixup! "*)
 			action="${message%%!*}"
-			rest="${message#*! }"
+			rest=$message
+			# ignore any squash! or fixup! after the first
+			while : ; do
+				case "$rest" in
+				"squash! "*|"fixup! "*)
+					rest="${rest#*! }"
+					;;
+				*)
+					break
+					;;
+				esac
+			done
 			echo "$sha1 $action $rest"
 			# if it's a single word, try to resolve to a full sha1 and
 			# emit a second copy. This allows us to match on both message
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index a1e86c4..1a3f40a 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -193,4 +193,53 @@ test_expect_success 'use commit --squash' '
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
+	git rebase --autosquash -i HEAD^^^^ &&
+	git log --oneline >actual &&
+	test_pause &&
+	if [ "$1" = "fixup" ]; then
+		test_line_count = 3 actual
+	elif [ "$1" = "squash" ]; then
+		test_line_count = 4 actual
+	else
+		false
+	fi &&
+	git diff --exit-code "final-$1-$2" &&
+	test 2 = "$(git cat-file blob HEAD^:file1)" &&
+	if [ "$1" = "fixup" ]; then
+		test 1 = $(git cat-file commit HEAD^ | grep first | wc -l)
+	elif [ "$1" = "squash" ]; then
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
