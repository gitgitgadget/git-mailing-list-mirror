From: John Keeping <john@keeping.me.uk>
Subject: [RFC/PATCH] rebase: use reflog to find common base with upstream
Date: Sun,  8 Dec 2013 20:06:42 +0000
Message-ID: <9e5fa57b027e1a5cd11a456c14f43b64f8f5386c.1386531376.git.john@keeping.me.uk>
Cc: Martin von Zweigbergk <martinvonz@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 08 21:07:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpkdL-0004NK-Oe
	for gcvg-git-2@plane.gmane.org; Sun, 08 Dec 2013 21:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755416Ab3LHUHD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Dec 2013 15:07:03 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:44283 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755274Ab3LHUHC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Dec 2013 15:07:02 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 56C376064D7;
	Sun,  8 Dec 2013 20:07:01 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=no
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CphWnx60NugE; Sun,  8 Dec 2013 20:07:00 +0000 (GMT)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id CF3436064C9;
	Sun,  8 Dec 2013 20:06:52 +0000 (GMT)
X-Mailer: git-send-email 1.8.5.226.g0d60d77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239047>

Commit 15a147e (rebase: use @{upstream} if no upstream specified,
2011-02-09) says:

	Make it default to 'git rebase @{upstream}'. That is also what
	'git pull [--rebase]' defaults to, so it only makes sense that
	'git rebase' defaults to the same thing.

but that isn't actually the case.  Since commit d44e712 (pull: support
rebased upstream + fetch + pull --rebase, 2009-07-19), pull has actually
chosen the most recent reflog entry which is an ancestor of the current
branch if it can find one.

Change rebase so that it uses the same logic, but only when no upstream
argument is given on the command line.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
Last time this came up [1], there was some discussion about moving the
added block of code to affect upstreams given on the command line as
well as when the upstream is discovered from the config.  Having tried
that, it has some more fallout on the test suite than I like; this
pattern ends up dropping the tip commit of "side" because it's in the
reflog of "master":

	# start on "master"
	git branch side &&
	git reset --hard HEAD^ &&
	git checkout side &&
	git rebase master

I wonder if it would be better to add a --fork-point argument to
git-rebase and default it to true when no upstream is given on the
command line.

[1] http://article.gmane.org/gmane.comp.version-control.git/236252

 git-rebase.sh     | 6 ++++++
 t/t3400-rebase.sh | 6 ++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 226752f..17801ad 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -437,6 +437,12 @@ then
 			error_on_missing_default_upstream "rebase" "rebase" \
 				"against" "git rebase <branch>"
 		fi
+
+		fork_point=$(git merge-base --fork-point "$upstream_name" HEAD)
+		if test -n "$fork_point" && test "$fork_point" != "$upstream"
+		then
+			upstream=$fork_point
+		fi
 		;;
 	*)	upstream_name="$1"
 		shift
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index ebf93b0..998503d 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -134,12 +134,14 @@ test_expect_success 'fail when upstream arg is missing and not configured' '
 	test_must_fail git rebase
 '
 
-test_expect_success 'default to @{upstream} when upstream arg is missing' '
+test_expect_success 'default to common base in @{upstream}s reflog if no upstream arg' '
 	git checkout -b default topic &&
 	git config branch.default.remote . &&
 	git config branch.default.merge refs/heads/master &&
 	git rebase &&
-	test "$(git rev-parse default~1)" = "$(git rev-parse master)"
+	git rev-parse --verify master >expect &&
+	git rev-parse default~1 >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'rebase -q is quiet' '
-- 
1.8.5.226.g0d60d77
