From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH] rebase -i: Remember merge options beyond continue actions
Date: Tue, 10 Jun 2014 02:02:58 +0200
Message-ID: <53964B32.2090804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 02:03:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu9Wu-0000Xb-Bl
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 02:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933240AbaFJADD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 20:03:03 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:58834 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933217AbaFJADC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 20:03:02 -0400
Received: by mail-wg0-f48.google.com with SMTP id n12so6222525wgh.31
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 17:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=w2QCKml9qwz0PTftrUKNol0YpG28Pi3b+dJKpUzKr0g=;
        b=k7exilYxdkoaxLE23lRq5CUyCjt0Gn3p9CHnoFgPWi7bMjuO3s2GlbR6zkB0itS403
         4RorliLM+bh+Q7L3yd4Dv58UNOhnEBZhagGxjWQnkR5k/aOaHLJ8XbUG6N5O5YtllO7z
         KOaGiCzgOIMIgNA6dZ90jxNd0tGNvCq8qwufrisbr1/FmBcq5UUcataITd0EIvCI6ph8
         TnbIUff60eDOknslMLO5ShSYH/E+bEcxVtjBS6V6JyBKC19gTWJLyhJKImm/P565Vjvy
         kASHyIlLotLX85rv30bzaMpQ/pjnIWtqfmiNom4mA1H68mdKxpqyIGLmjyHUsjsD9g90
         7ZPw==
X-Received: by 10.14.246.68 with SMTP id p44mr4078674eer.8.1402358580371;
        Mon, 09 Jun 2014 17:03:00 -0700 (PDT)
Received: from client.googlemail.com ([2a02:8108:1bc0:1bf4:224:d7ff:fe92:3de1])
        by mx.google.com with ESMTPSA id 49sm20729609eeo.37.2014.06.09.17.02.58
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 09 Jun 2014 17:02:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251147>

If the user explicitly specified a merge strategy or strategy options,
"rebase --interactive" started using the default merge strategy again
after "rebase --continue".

This problem gets fixed by this commit. Add test.

Since the "rebase" options "-s" and "-X" imply "--merge", we can simply
remove the "do_merge" guard in the interactive mode and always compile
the "cherry-pick" arguments from the "rebase" state variables "strategy"
and "strategy_opts".
---
 git-rebase--interactive.sh    | 18 +++++++-----------
 t/t3404-rebase-interactive.sh | 16 ++++++++++++++++
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 6ec9d3c..817c933 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -77,17 +77,13 @@ amend="$state_dir"/amend
 rewritten_list="$state_dir"/rewritten-list
 rewritten_pending="$state_dir"/rewritten-pending
 
-strategy_args=
-if test -n "$do_merge"
-then
-	strategy_args=${strategy:+--strategy=$strategy}
-	eval '
-		for strategy_opt in '"$strategy_opts"'
-		do
-			strategy_args="$strategy_args -X$(git rev-parse --sq-quote "${strategy_opt#--}")"
-		done
-	'
-fi
+strategy_args=${strategy:+--strategy=$strategy}
+eval '
+	for strategy_opt in '"$strategy_opts"'
+	do
+		strategy_args="$strategy_args -X$(git rev-parse --sq-quote "${strategy_opt#--}")"
+	done
+'
 
 GIT_CHERRY_PICK_HELP="$resolvemsg"
 export GIT_CHERRY_PICK_HELP
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index c0023a5..73849f1 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -998,6 +998,22 @@ test_expect_success 'rebase -i with --strategy and -X' '
 	test $(cat file1) = Z
 '
 
+test_expect_success 'interrupted rebase -i with --strategy and -X' '
+	git checkout -b conflict-merge-use-theirs-interrupted conflict-branch &&
+	git reset --hard HEAD^ &&
+	>breakpoint &&
+	git add breakpoint &&
+	git commit -m "breakpoint for interactive mode" &&
+	echo five >conflict &&
+	echo Z >file1 &&
+	git commit -a -m "one file conflict" &&
+	set_fake_editor &&
+	FAKE_LINES="edit 1 2" git rebase -i --strategy=recursive -Xours conflict-branch &&
+	git rebase --continue &&
+	test $(git show conflict-branch:conflict) = $(cat conflict) &&
+	test $(cat file1) = Z
+'
+
 test_expect_success 'rebase -i error on commits with \ in message' '
 	current_head=$(git rev-parse HEAD)
 	test_when_finished "git rebase --abort; git reset --hard $current_head; rm -f error" &&
-- 
2.0.0
