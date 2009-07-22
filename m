From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] diff --cc: a lost line at the beginning of the file is
 shown incorrectly
Date: Wed, 22 Jul 2009 14:48:29 -0700
Message-ID: <1248299309-10579-3-git-send-email-gitster@pobox.com>
References: <1248299309-10579-1-git-send-email-gitster@pobox.com>
 <1248299309-10579-2-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 22 23:48:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTjg5-0006GE-Vr
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 23:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754162AbZGVVsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 17:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754034AbZGVVsi
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 17:48:38 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53565 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754095AbZGVVsf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 17:48:35 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 26B6C10FDA
	for <git@vger.kernel.org>; Wed, 22 Jul 2009 17:48:35 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 89A1110FD9 for
 <git@vger.kernel.org>; Wed, 22 Jul 2009 17:48:34 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.rc1.10.g2a679
In-Reply-To: <1248299309-10579-2-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 6808267C-7709-11DE-86B4-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123788>

When combine-diff inspected the diff from one parent to the merge result,
it misinterpreted a header in the form @@ -l,k +0,0 @@.

This hunk header means that K lines were removed from the beginning of the
file, so the lost lines must be queued to the sline that represents the
first line of the merge result, but we incremented our pointer incorrectly
and ended up queuing it to the second line, which in turn made the lossage
appear _after_ the first line.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 combine-diff.c           |   16 +++++----
 t/t4038-diff-combined.sh |   84 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+), 7 deletions(-)
 create mode 100755 t/t4038-diff-combined.sh

diff --git a/combine-diff.c b/combine-diff.c
index b82f46c..38f4e2c 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -164,20 +164,22 @@ static void consume_line(void *state_, char *line, unsigned long len)
 				      &state->nb, &state->nn))
 			return;
 		state->lno = state->nb;
-		if (!state->nb)
-			/* @@ -1,2 +0,0 @@ to remove the
-			 * first two lines...
-			 */
-			state->nb = 1;
-		if (state->nn == 0)
+		if (state->nn == 0) {
 			/* @@ -X,Y +N,0 @@ removed Y lines
 			 * that would have come *after* line N
 			 * in the result.  Our lost buckets hang
 			 * to the line after the removed lines,
+			 *
+			 * Note that this is correct even when N == 0,
+			 * in which case the hunk removes the first
+			 * line in the file.
 			 */
 			state->lost_bucket = &state->sline[state->nb];
-		else
+			if (!state->nb)
+				state->nb = 1;
+		} else {
 			state->lost_bucket = &state->sline[state->nb-1];
+		}
 		if (!state->sline[state->nb-1].p_lno)
 			state->sline[state->nb-1].p_lno =
 				xcalloc(state->num_parent,
diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
new file mode 100755
index 0000000..2cf7e01
--- /dev/null
+++ b/t/t4038-diff-combined.sh
@@ -0,0 +1,84 @@
+#!/bin/sh
+
+test_description='combined diff'
+
+. ./test-lib.sh
+
+setup_helper () {
+	one=$1 branch=$2 side=$3 &&
+
+	git branch $side $branch &&
+	for l in $one two three fyra
+	do
+		echo $l
+	done >file &&
+	git add file &&
+	test_tick &&
+	git commit -m $branch &&
+	git checkout $side &&
+	for l in $one two three quatro
+	do
+		echo $l
+	done >file &&
+	git add file &&
+	test_tick &&
+	git commit -m $side &&
+	test_must_fail git merge $branch &&
+	for l in $one three four
+	do
+		echo $l
+	done >file &&
+	git add file &&
+	test_tick &&
+	git commit -m "merge $branch into $side"
+}
+
+verify_helper () {
+	it=$1 &&
+
+	# Ignore lines that were removed only from the other parent
+	sed -e '
+		1,/^@@@/d
+		/^ -/d
+		s/^\(.\)./\1/
+	' "$it" >"$it.actual.1" &&
+	sed -e '
+		1,/^@@@/d
+		/^- /d
+		s/^.\(.\)/\1/
+	' "$it" >"$it.actual.2" &&
+
+	git diff "$it^" "$it" -- | sed -e '1,/^@@/d' >"$it.expect.1" &&
+	test_cmp "$it.expect.1" "$it.actual.1" &&
+
+	git diff "$it^2" "$it" -- | sed -e '1,/^@@/d' >"$it.expect.2" &&
+	test_cmp "$it.expect.2" "$it.actual.2"
+}
+
+test_expect_success setup '
+	>file &&
+	git add file &&
+	test_tick &&
+	git commit -m initial &&
+
+	git branch withone &&
+	git branch sansone &&
+
+	git checkout withone &&
+	setup_helper one withone sidewithone &&
+
+	git checkout sansone &&
+	setup_helper "" sansone sidesansone
+'
+
+test_expect_success 'check combined output (1)' '
+	git show sidewithone -- >sidewithone &&
+	verify_helper sidewithone
+'
+
+test_expect_failure 'check combined output (2)' '
+	git show sidesansone -- >sidesansone &&
+	verify_helper sidesansone
+'
+
+test_done
-- 
1.6.4.rc1.10.g2a679
