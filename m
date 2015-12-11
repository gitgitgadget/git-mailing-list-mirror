From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] rebase -i: remember merge options beyond continue actions
Date: Fri, 11 Dec 2015 20:54:06 +0100
Message-ID: <1449863646-26067-1-git-send-email-ralf.thielow@gmail.com>
References: <53965334.3030206@gmail.com>
Cc: bafain@gmail.com, campos@esss.com.br, mhagger@alum.mit.edu,
	sunshine@sunshineco.com, Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 11 20:54:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7Tlv-0004RK-C1
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 20:54:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732AbbLKTyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2015 14:54:23 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:33347 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098AbbLKTyU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2015 14:54:20 -0500
Received: by mail-wm0-f42.google.com with SMTP id c201so87654241wme.0
        for <git@vger.kernel.org>; Fri, 11 Dec 2015 11:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KdQ2WhLdhU4XNuD/syz8LlXju4uDxwZGgFH0V7Rq+JQ=;
        b=DTBsR8XITTYIZ/QJITbi1SS1jLdlx0hWyo90CVFAfMQ19bn4G1lxwqizw9+sLPJYwm
         vz8TEEXoVCTMDZY5ySdYxOmKmJJ4wuP+YuN4YAUv7K5x+HOLEuKCfk9yPFQLJKPWpPeX
         5NC5LFkxG94rIj+9BVUjrQrLSK3AjBDi612lqlogTVvvXnm5dHaOUUa3Eo3mvxW9cND5
         QJmqH8JMZ3F5Bba1b5CSbbaVngJ124kokyCCdil2L5SRunJaVoXx92zc58HYFDEBBlJG
         0Ig7po/aeB1rbGQSR7iuNx+Ne6eaX5XdZ7SwSFuE/3yC57zqftv8A8rs5IYaCV9Aa+9l
         GUYg==
X-Received: by 10.194.200.227 with SMTP id jv3mr22365850wjc.20.1449863659340;
        Fri, 11 Dec 2015 11:54:19 -0800 (PST)
Received: from localhost (cable-62-117-19-66.cust.telecolumbus.net. [62.117.19.66])
        by smtp.gmail.com with ESMTPSA id q4sm18331397wja.6.2015.12.11.11.54.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 11 Dec 2015 11:54:18 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.174.g1b62464
In-Reply-To: <53965334.3030206@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282275>

From: Fabian Ruch <bafain@gmail.com>

If the user specifies a merge strategy or strategy options in
"rebase --interactive", also use these in subsequent calls of
"rebase --continue".

In the implementation, the "do_merge" guard to check for a given
merge strategy or strategy options is implied by passing these
options, but not stored.  This prevents subsequent calls of
"rebase --continue" to use this setting again later.  Remove this
"do_merge" guard to allow a later usage.

Reported-by: Diogo de Campos <campos@esss.com.br>
Signed-off-by: Fabian Ruch <bafain@gmail.com>
Helped-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
I've been applying the original patch for a long time to my tree,
as it helps me to resolve conflicts e.g. when rebasing .po files.
I also think it's a reasonable change for git-rebase.

I've rebased it agains the current master and rewrote the
commit message to try to make this change technically a bit more
easy to understand.

Original patch submit:
http://thread.gmane.org/gmane.comp.version-control.git/251147/

 git-rebase--interactive.sh    | 18 +++++++-----------
 t/t3404-rebase-interactive.sh | 16 ++++++++++++++++
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index b938a6d..c0cfe88 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -81,17 +81,13 @@ rewritten_pending="$state_dir"/rewritten-pending
 # and leaves CR at the end instead.
 cr=$(printf "\015")
 
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
index 98eb49a..9a2461c 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1006,6 +1006,22 @@ test_expect_success 'rebase -i with --strategy and -X' '
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
 	current_head=$(git rev-parse HEAD) &&
 	test_when_finished "git rebase --abort; git reset --hard $current_head; rm -f error" &&
-- 
2.7.0.rc0.174.g1b62464
