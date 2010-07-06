From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] rebase -i: use 'read -r' to avoid backslash acting as an
 escape character
Date: Wed, 7 Jul 2010 00:55:22 +0200
Message-ID: <20100706225522.GA31048@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 07 00:55:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWH36-0003yo-6F
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 00:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069Ab0GFWzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 18:55:25 -0400
Received: from virgo.iok.hu ([212.40.97.103]:46664 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751618Ab0GFWzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 18:55:25 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id A55535809C;
	Wed,  7 Jul 2010 00:55:22 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 89D0444659;
	Wed,  7 Jul 2010 00:55:22 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 3E08912D90F0; Wed,  7 Jul 2010 00:55:22 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150415>

The last backslash in the commit message will make 'read' read two lines
without '-r', loosing the next commit, so use it.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 git-rebase--interactive.sh    |    4 ++--
 t/t3404-rebase-interactive.sh |   14 ++++++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 6b86abc..4b822e3 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -591,7 +591,7 @@ do_rest () {
 # skip picking commits whose parents are unchanged
 skip_unnecessary_picks () {
 	fd=3
-	while read command sha1 rest
+	while read -r command sha1 rest
 	do
 		# fd=3 means we skip the command
 		case "$fd,$command,$(git rev-parse --verify --quiet $sha1^)" in
@@ -890,7 +890,7 @@ first and then run 'git rebase --continue' again."
 		git rev-list $MERGES_OPTION --pretty=oneline --abbrev-commit \
 			--abbrev=7 --reverse --left-right --topo-order \
 			$REVISIONS | \
-			sed -n "s/^>//p" | while read shortsha1 rest
+			sed -n "s/^>//p" | while read -r shortsha1 rest
 		do
 			if test t != "$PRESERVE_MERGES"
 			then
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index ee9a1b2..ddfa790 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -630,4 +630,18 @@ test_expect_success 'always cherry-pick with --no-ff' '
 	test_cmp empty out
 '
 
+test_expect_success 'commit message with backslash at the end' '
+	echo a > file &&
+	git add file &&
+	git commit -m 1st &&
+	echo b >> file &&
+	git commit -a -m "escape \\t, \\{, \\} and \\" &&
+	echo c >> file &&
+	git commit -a -m 3rd &&
+	orig=$(git rev-parse HEAD) &&
+	git rebase -i HEAD~2 &&
+	git diff $orig HEAD > out &&
+	test_cmp empty out
+'
+
 test_done
-- 
1.7.1
