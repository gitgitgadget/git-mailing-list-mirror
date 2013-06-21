From: Arnaud Fontaine <arnau@debian.org>
Subject: [PATCH] Do not ignore merge options in interactive rebase
Date: Fri, 21 Jun 2013 14:23:48 +0900
Organization: Debian
Message-ID: <87bo70dokb.fsf@duckcorp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 21 07:34:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uptz1-0006wu-J4
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 07:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161086Ab3FUFd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 01:33:58 -0400
Received: from Orfeo.duckcorp.org ([193.17.192.211]:53565 "EHLO
	mx1.duckcorp.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935551Ab3FUFd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 01:33:57 -0400
X-Greylist: delayed 600 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Jun 2013 01:33:57 EDT
Received: from localhost (ip6-localhost [IPv6:::1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mx1.duckcorp.org (Postfix) with ESMTPSA id 3bc7bs2Tsxz2J59;
	Fri, 21 Jun 2013 07:23:53 +0200 (CEST)
X-URL: http://www.debian.org
X-Operating-System: Debian GNU/Linux
X-GnuPG-KeyID: 5E3619D3
X-PGP-Fingerprint: D792 B8A5 A567 B001 C342  2613 BDF2 A220 5E36 19D3
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228575>

Merge strategy and its options can be specified in `git rebase`,
but with `--interactive`, they were completely ignored.

Signed-off-by: Arnaud Fontaine <arnau@debian.org>
---
 git-rebase--interactive.sh    | 11 ++++++++++-
 t/t3404-rebase-interactive.sh | 11 +++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)
 mode change 100644 => 100755 git-rebase--interactive.sh

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
old mode 100644
new mode 100755
index f953d8d..c157fdf
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -239,7 +239,16 @@ pick_one () {
 
 	test -d "$rewritten" &&
 		pick_one_preserving_merges "$@" && return
-	output git cherry-pick $empty_args $ff "$@"
+
+	if test -n "$do_merge"
+	then
+		test -z "$strategy" && strategy=recursive
+		output git cherry-pick --strategy=$strategy \
+			$(echo $strategy_opts | sed "s/'--\([^']*\)'/-X\1/g") \
+			$empty_args $ff "$@"
+	else
+		output git cherry-pick $empty_args $ff "$@"
+	fi
 }
 
 pick_one_preserving_merges () {
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 79e8d3c..8b6a36f 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -947,4 +947,15 @@ test_expect_success 'rebase -i respects core.commentchar' '
 	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
 '
 
+test_expect_success 'rebase -i with --strategy and -X' '
+	git checkout -b conflict-merge-use-theirs conflict-branch &&
+	git reset --hard HEAD^ &&
+	echo five >conflict &&
+	echo Z >file1 &&
+	git commit -a -m "one file conflict" &&
+	EDITOR=true git rebase -i --strategy=recursive -Xours conflict-branch &&
+	test $(git show conflict-branch:conflict) = $(cat conflict) &&
+	test $(cat file1) = Z
+'
+
 test_done
-- 
1.8.3.GIT
