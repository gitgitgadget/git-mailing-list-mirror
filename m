From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCHv2 3/3] rebase-i: Ignore comments and blank lines in peek_next_command
Date: Tue, 12 Jan 2010 16:38:36 +0100
Message-ID: <39d924c84c79adc0dc0df9933ccf6f19dfa6937c.1263310175.git.mhagger@alum.mit.edu>
References: <7vr5pw3pwp.fsf@alter.siamese.dyndns.org>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 16:40:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUiqt-0004wD-MS
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 16:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753955Ab0ALPkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 10:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753569Ab0ALPkK
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 10:40:10 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:45209 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753571Ab0ALPkH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 10:40:07 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from localhost.localdomain (ssh.berlin.jpk.com [212.222.128.135])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o0CFd2FT019745;
	Tue, 12 Jan 2010 16:39:26 +0100
X-Mailer: git-send-email 1.6.6.140.ga53ad
In-Reply-To: <7vr5pw3pwp.fsf@alter.siamese.dyndns.org>
In-Reply-To: <cover.1263310175.git.mhagger@alum.mit.edu>
References: <cover.1263310175.git.mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136728>

Previously, blank lines and/or comments within a series of
squash/fixup commands would confuse "git rebase -i" into thinking that
the series was finished.  It would therefore require the user to edit
the commit message for the squash/fixup commits seen so far.  Then,
after continuing, it would ask the user to edit the commit message
again.

Ignore comments and blank lines within a group of squash/fixup
commands, allowing them to be processed in one go.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 git-rebase--interactive.sh    |    2 +-
 t/t3404-rebase-interactive.sh |   24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 27479db..2e56e64 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -340,7 +340,7 @@ make_squash_message () {
 }
 
 peek_next_command () {
-	sed -n "1s/ .*$//p" < "$TODO"
+	sed -n -e "/^#/d" -e "/^$/d" -e "s/ .*//p" -e "q" < "$TODO"
 }
 
 do_next () {
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index ea26115..d9382e4 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -265,6 +265,30 @@ test_expect_success 'squash and fixup generate correct log messages' '
 	git branch -D squash-fixup
 '
 
+test_expect_success 'squash ignores comments' '
+	git checkout -b skip-comments E &&
+	base=$(git rev-parse HEAD~4) &&
+	FAKE_COMMIT_AMEND="ONCE" FAKE_LINES="# 1 # squash 2 # squash 3 # squash 4 #" \
+		EXPECT_HEADER_COUNT=4 \
+		git rebase -i $base &&
+	test $base = $(git rev-parse HEAD^) &&
+	test 1 = $(git show | grep ONCE | wc -l) &&
+	git checkout to-be-rebased &&
+	git branch -D skip-comments
+'
+
+test_expect_success 'squash ignores blank lines' '
+	git checkout -b skip-blank-lines E &&
+	base=$(git rev-parse HEAD~4) &&
+	FAKE_COMMIT_AMEND="ONCE" FAKE_LINES="> 1 > squash 2 > squash 3 > squash 4 >" \
+		EXPECT_HEADER_COUNT=4 \
+		git rebase -i $base &&
+	test $base = $(git rev-parse HEAD^) &&
+	test 1 = $(git show | grep ONCE | wc -l) &&
+	git checkout to-be-rebased &&
+	git branch -D skip-blank-lines
+'
+
 test_expect_success 'squash works as expected' '
 	for n in one two three four
 	do
-- 
1.6.6.140.ga53ad
