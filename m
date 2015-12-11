From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH v2] rebase -i: remember merge options beyond continue actions
Date: Fri, 11 Dec 2015 21:30:36 +0100
Message-ID: <1449865836-27180-1-git-send-email-ralf.thielow@gmail.com>
References: <CAPc5daV_tPh9pt4YSpsBSCvrvGOqC7+9eTZkS1bV2ZAE2YoxzA@mail.gmail.com>
Cc: bafain@gmail.com, campos@esss.com.br, mhagger@alum.mit.edu,
	sunshine@sunshineco.com, Ralf Thielow <ralf.thielow@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 11 21:30:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7UL4-0005v6-Kz
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 21:30:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305AbbLKUar (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2015 15:30:47 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38478 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752981AbbLKUaq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2015 15:30:46 -0500
Received: by wmec201 with SMTP id c201so85882524wme.1
        for <git@vger.kernel.org>; Fri, 11 Dec 2015 12:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UzhwG1SPzVh+N04NsUtI91OIStUtWP6uZrGz6ZVr+ho=;
        b=ACAJdMAIknC5IA1VoDH0hed1Jy1bEM12LxMxJDm5/C5cvAq3/Xpo4PY+AyQVXxIlxZ
         67G1EokzHlQ49XW4lzRHL4zb5w4zGZUEPBAYXhQo9+rCCrlWqXTiDSejwR+aDaimhaWu
         RU4XFifDebFHINe3geisk07cXN/CX2zsDoyeuFVpE2eQrL12HxK9P76j3zUEthJnNKvp
         9iJJmjVUKKwkiVj13qkctES+qLIG3DG+a4nhS0uuuYQjdP4B+0ZGXGeUM8bdOxU44Se1
         C+MJFewlIJR9UBuW7yJ9WB6V/0UVR3LK0svYZGs0Zzc41Clx283Wz5Fubt25QI8mauQw
         h+Ig==
X-Received: by 10.28.178.138 with SMTP id b132mr6277645wmf.25.1449865845086;
        Fri, 11 Dec 2015 12:30:45 -0800 (PST)
Received: from localhost (cable-62-117-19-66.cust.telecolumbus.net. [62.117.19.66])
        by smtp.gmail.com with ESMTPSA id kj3sm18384774wjb.19.2015.12.11.12.30.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 11 Dec 2015 12:30:44 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.174.g1b62464
In-Reply-To: <CAPc5daV_tPh9pt4YSpsBSCvrvGOqC7+9eTZkS1bV2ZAE2YoxzA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282278>

From: Fabian Ruch <bafain@gmail.com>

If the user explicitly specified a merge strategy or strategy
options, continue to use that strategy/option after
"rebase --continue".  Add a test of the corrected behavior.

If --merge is specified or implied by -s or -X, then "strategy and
"strategy_opts" are set to values from which "strategy_args" can be
derived; otherwise they are set to empty strings.  Either way,
their values are propagated from one step of an interactive rebase
to the next via state files.

"do_merge", on the other hand, is *not* propagated to later steps of
an interactive rebase.  Therefore, making the initialization of
"strategy_args" conditional on "do_merge" being set prevents later
steps of an interactive rebase from setting it correctly.

Luckily, we don't need the "do_merge" guard at all.  If the rebase
was started without --merge, then "strategy" and "strategy_opts"
are both the empty string, which results in "strategy_args" also
being set to the empty string, which is just what we want in that
situation.  So remove the "do_merge" guard and derive
"strategy_args" from "strategy" and "strategy_opts" every time.

Reported-by: Diogo de Campos <campos@esss.com.br>
Signed-off-by: Fabian Ruch <bafain@gmail.com>
Helped-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
2015-12-11 21:07 GMT+01:00 Junio C Hamano <gitster@pobox.com>:
> On Fri, Dec 11, 2015 at 11:54 AM, Ralf Thielow <ralf.thielow@gmail.com> wrote:

>
> Thanks. I wonder if Michael's rephrasing in $gmane/251386 still applies, which
> I found by far the most readable.
>
> http://thread.gmane.org/gmane.comp.version-control.git/251147/focus=251386
>

Sure.

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
