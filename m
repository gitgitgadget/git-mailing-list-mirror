From: Fabian Ruch <bafain@gmail.com>
Subject: Re: [PATCH] rebase -i: Remember merge options beyond continue actions
Date: Tue, 10 Jun 2014 02:37:08 +0200
Message-ID: <53965334.3030206@gmail.com>
References: <CAPig+cSHFFPUEQz8==HLQr0My2Bfsth_F16wVf9giytqGwzZww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Diogo de Campos <campos@esss.com.br>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 02:37:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuA41-0001Pl-KV
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 02:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934396AbaFJAhO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 20:37:14 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:50094 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933232AbaFJAhM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 20:37:12 -0400
Received: by mail-wg0-f42.google.com with SMTP id z12so2949549wgg.1
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 17:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=EY3dHMAfq7VOILGkSpQV+XXypwuwi66IEFAQX6WPrbA=;
        b=EF5wj4qKTaxTGkLQPc4Phtq/TEGtTECle5vaZkGAEeuNdaMq5hi40XiOGfG6KEvuTU
         BRjEr+iy0TcjUL4Tvts16KNj17D9BcWe6qGsMedd1Kr3/SAnaSuiQi+wmDb45Go8c9vF
         GztZc6VcMBCrwPxXRn48tnLToFpS0Aomi3WxOXZC3Ul8S/A9qzqgFyfmnep/5GYHCIt4
         L2RXQzwuZ7I325XiwfQDw2yb+y6TwZJRyO7WMkWPYkmFWNqFtvAJopRJwk0BosV5kepv
         h5raOv7/3KuoA//8uSd6YmCNkE4nHnPA5hDkLt+c7z+WdJw4LwqwO68oC83KK/MIaKaX
         q31g==
X-Received: by 10.14.8.199 with SMTP id 47mr874907eer.5.1402360630634;
        Mon, 09 Jun 2014 17:37:10 -0700 (PDT)
Received: from client.googlemail.com ([2a02:8108:1bc0:1bf4:224:d7ff:fe92:3de1])
        by mx.google.com with ESMTPSA id w9sm48504169eev.4.2014.06.09.17.37.08
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 09 Jun 2014 17:37:09 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <CAPig+cSHFFPUEQz8==HLQr0My2Bfsth_F16wVf9giytqGwzZww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251149>

Hi Eric,

thanks a lot for the reference.

I added the Reported-by: and Signed-off-by: lines to the commit message.

   Fabian

-- >8 --
Subject: rebase -i: Remember merge options beyond continue actions

If the user explicitly specified a merge strategy or strategy options,
"rebase --interactive" started using the default merge strategy again
after "rebase --continue".

This problem gets fixed by this commit. Add test.

Since the "rebase" options "-s" and "-X" imply "--merge", we can simply
remove the "do_merge" guard in the interactive mode and always compile
the "cherry-pick" arguments from the "rebase" state variables "strategy"
and "strategy_opts".

Reported-by: Diogo de Campos <campos@esss.com.br>
Signed-off-by: Fabian Ruch <bafain@gmail.com>
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
