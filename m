From: Andrew Pimlott <andrew@pimlott.net>
Subject: Re: [PATCH] rebase -i: fixup fixup! fixup!
Date: Tue, 25 Jun 2013 13:41:48 -0700
Message-ID: <1372190294-sup-1398@pimlott.net>
References: <20130611180530.GA18488@oinkpad.pimlott.net> <87obbc8otc.fsf@hexa.v.cablecom.net> <1371237209-sup-639@pimlott.net> <1371278908-sup-1930@pimlott.net> <7vk3lvlmat.fsf@alter.siamese.dyndns.org> <87ip1e2tzx.fsf@hexa.v.cablecom.net> <7v7ghtjwbb.fsf@alter.siamese.dyndns.org> <8738shi2ht.fsf@linux-k42r.v.cablecom.net> <7vwqpshkxj.fsf@alter.siamese.dyndns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Thomas Rast <trast@inf.ethz.ch>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 25 22:42:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ura3s-00081G-Jy
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 22:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753854Ab3FYUl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 16:41:56 -0400
Received: from pimlott.net ([72.249.23.100]:47711 "EHLO fugue.pimlott.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753585Ab3FYUlz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 16:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pimlott.net; s=default;
	h=Content-Transfer-Encoding:Message-Id:Date:References:In-reply-to:To:From:Subject:Cc:Content-Type; bh=+8xp1mljiOKV7Nt/nc3pcW/tmMmDB1OX2iyudIzXg/M=;
	b=G/u0s1O+Jt1GeL6KvWbqrTgJFR1aqCkD5CgORLjyEux1oCdJdcRb+LUj+6h0ROkkFWqtzj/Bo6PJEvzgAvnhaT/pYHFzU3+7No5UfXWIU/2Xz7+jOWswoSh+1P9lzJyXRsIxpmHRofAUJu5KK/Z20zEMjsEHubK5fZLc1efeFxU=;
Received: from andrew by fugue.pimlott.net with local (Exim 4.72)
	(envelope-from <andrew@pimlott.net>)
	id 1Ura3g-0004Mt-5Y; Tue, 25 Jun 2013 13:41:48 -0700
In-reply-to: <7vwqpshkxj.fsf@alter.siamese.dyndns.org>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228989>

Excerpts from Junio C Hamano's message of Mon Jun 17 07:27:20 -0700 2013:
> Thomas Rast <trast@inf.ethz.ch> writes:
> > I'm not sure it's worth arguing about whether the "fixup! fixup!"  is a
> > symptom of some underlying problem, and changing rebase is only tapering
> > over the symptom; or whether it's actually a useful distinction.
> 
> If they are about the same complexity, then my instict tells me that
> it is a better design not to strip on the writing side.

Thank you for the discussion.  Sorry I have joined recently.

I agree that it is better to preserve information as long as feasible.
If we are going to strip it, it may as well be later.  That is Thomas's
rearrange_squash patch, which I will send again.

The next question is, do we go all the way and respect the nested
fixup!s in rearrange_squash?  I understand the case for it, though it's
hardly compelling to me in practice. :-)  That would be more complicated
than Thomas's patch.  But I'm happy to try it if someone gives me a
nudge.  If not, at least the information is preserved in case someone
wants to do this later.

Regarding patches, I tried to follow the SubmittingPatches guidelines,
but I was confused about how to include a commit in an existing thread.
I think I was mislead by git-format-patch(1), "When a patch is part of
an ongoing discussion...", which says to remove most header fields.

So if I don't want to break the discussion, should I append the unedited
format-patch output to my message after "scissors", or should I send it
as a whole new message with --in-reply-to?  Or something else?  I'll try
the first.

Andrew

---8<---
From 99023bff23f18a341441d6b7c447d9630a11b489 Mon Sep 17 00:00:00 2001
From: Andrew Pimlott <andrew@pimlott.net>
Date: Fri, 14 Jun 2013 10:33:16 -0700
Subject: [PATCH 1/4] rebase -i: handle fixup! fixup! in --autosquash

In rebase -i --autosquash, ignore all "fixup! " or "squash! " after the
first.  Handy in case a git commit --fixup/--squash referred to an earlier
fixup/squash instead of the original commit, for example with :/msg.

Signed-off-by: Andrew Pimlott <andrew@pimlott.net>
---
 Documentation/git-rebase.txt |    4 +++-
 git-rebase--interactive.sh   |   13 ++++++++++-
 t/t3415-rebase-autosquash.sh |   49 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 2 deletions(-)

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
