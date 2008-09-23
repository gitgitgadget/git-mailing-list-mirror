From: Andreas Ericsson <ae@op5.se>
Subject: [PATCH 2/3] git rebase: Support non-interactive merge-preserving
 rebase
Date: Tue, 23 Sep 2008 22:58:16 +0200
Message-ID: <48D95868.7040308@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 22:59:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiEyo-0008Ke-Ac
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 22:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166AbYIWU6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 16:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754786AbYIWU6W
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 16:58:22 -0400
Received: from mail.op5.se ([193.201.96.20]:34465 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754771AbYIWU6V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 16:58:21 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id EAFE91B80051;
	Tue, 23 Sep 2008 22:48:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.238
X-Spam-Level: 
X-Spam-Status: No, score=-3.238 tagged_above=-10 required=6.6
	tests=[AWL=-0.739, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LTtB4EF1-Z5i; Tue, 23 Sep 2008 22:48:52 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.6])
	by mail.op5.se (Postfix) with ESMTP id 1E6221B8004D;
	Tue, 23 Sep 2008 22:48:52 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96594>

Previously, 'git rebase --preserve-merges' would only work
in interactive mode. For some workflows, this was quite a
limitation.

This patch adds a workaround, invoking the
git-rebase--interactive helper with GIT_EDITOR set to :
in case the user passes "-p" but not "-i" to the rebase
command.

The effect is that the interactive rebase helper is used,
but the user won't see an editor.

Since this patch fixes the latter of the two expected
testfailures in t3409-rebase-preserve-merges, that test
is now set to expect success.

Signed-off-by: Andreas Ericsson <ae@op5.se>
---
 Documentation/git-rebase.txt      |    3 +--
 git-rebase.sh                     |   22 +++++++++++++++++++---
 t/t3409-rebase-preserve-merges.sh |    2 +-
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 59c1b02..ddec6a6 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -250,8 +250,7 @@ OPTIONS
 
 -p::
 --preserve-merges::
-	Instead of ignoring merges, try to recreate them.  This option
-	only works in interactive mode.
+	Instead of ignoring merges, try to recreate them.
 
 include::merge-strategies.txt[]
 
diff --git a/git-rebase.sh b/git-rebase.sh
index 528b604..03e5f95 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -138,10 +138,26 @@ finish_rb_merge () {
 }
 
 is_interactive () {
-	test -f "$dotest"/interactive ||
-	while :; do case $#,"$1" in 0,|*,-i|*,--interactive) break ;; esac
+	while test $# != 0
+	do
+		case "$1" in
+			-i|--interactive)
+				interactive_rebase=explicit
+				break
+			;;
+			-p|--preserve-merges)
+				interactive_rebase=implied
+			;;
+		esac
 		shift
-	done && test -n "$1"
+	done
+
+	if [ "$interactive_rebase" = implied ]; then
+		GIT_EDITOR=:
+		export GIT_EDITOR
+	fi
+
+	test -n "$interactive_rebase" || test -f "$dotest"/interactive
 }
 
 test -f "$GIT_DIR"/rebase-apply/applying &&
diff --git a/t/t3409-rebase-preserve-merges.sh b/t/t3409-rebase-preserve-merges.sh
index 532b220..21b8c79 100644
--- a/t/t3409-rebase-preserve-merges.sh
+++ b/t/t3409-rebase-preserve-merges.sh
@@ -57,7 +57,7 @@ test_expect_failure 'git pull --rebase -p on moved topic' '
 	test $(git rev-list --all --pretty=oneline | grep "Modify A" | wc -l) = 1
 '
 
-test_expect_failure 'rebase -p merge on moved topic' '
+test_expect_success 'rebase -p merge on moved topic' '
 	cd ../clone2 &&
 	git fetch &&
 	git rebase -p origin/topic &&
-- 
1.6.0.2.307.gc4275.dirty
