Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 844 invoked by uid 107); 4 Jun 2009 20:41:31 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Thu, 04 Jun 2009 16:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487AbZFDUlP (ORCPT <rfc822;peff@peff.net>);
	Thu, 4 Jun 2009 16:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752075AbZFDUlO
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 16:41:14 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:56513 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbZFDUlO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 16:41:14 -0400
Received: by fg-out-1718.google.com with SMTP id d23so65846fga.17
        for <git@vger.kernel.org>; Thu, 04 Jun 2009 13:41:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:to;
        bh=M3ryGICEs8SIcOdst6tTNMSwax2Syq6LhA+YcmdXgoQ=;
        b=leKjn4uzKquU7CaDtKEpmt5mWy61TiEtLSgNCxKkaQMpTrIjjY/sm8es5o1PWt8InL
         mn8pIYT5TuWV8sJgnyl2EMNf/0jWuPmAt07oHZeishugu+wup59x+Vjc0JAcz+chCiNF
         BUoi6MnCwsZtFj5yGDzHAGTZbUB5kA1CPx3Pw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=bO1uCKtWVH9JBTQCivqUoXLapPHmDkGPRacU2HqDZbw2zX3tJQDdBPYP/s3ZDQWXoE
         7Gqn2b+uy1uPCLZ+5ap9m7wzzul/fJZ5gmaRJkOwIyAbXDK3BSpKlZmdL24dCTRM0+XS
         tiykgnt4z8Yfvwr0anUz29GD8hiy/K4R8Q0VA=
Received: by 10.86.26.19 with SMTP id 19mr3064867fgz.48.1244148074896;
        Thu, 04 Jun 2009 13:41:14 -0700 (PDT)
Received: from localhost ([141.76.90.80])
        by mx.google.com with ESMTPS id e20sm713564fga.0.2009.06.04.13.41.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Jun 2009 13:41:14 -0700 (PDT)
From:	Bert Wesarg <bert.wesarg@googlemail.com>
To:	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
Cc:	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
Subject: [TopGit PATCH] hooks/pre-commit: check for cycles in dependencies
Date:	Thu,  4 Jun 2009 22:41:13 +0200
Message-Id: <1244148073-2313-1-git-send-email-bert.wesarg@googlemail.com>
X-Mailer: git-send-email 1.6.3.1.143.g17592
To:	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Only newly added dependencies needs to be considered.  For each of these deps
check if there is a path from this dep to the current HEAD.

Use recursive_dep() for this task.  Even if recursive_dep() uses a DFS-like
traversal it will not run into an infty-loop if there would be a cycle, because
recursive_dep() takes .topdeps only from committed trees.  And it is required
that the committed dependency graph is acyclic.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 hooks/pre-commit.sh |   30 ++++++++++++++++++++++++++++--
 1 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/hooks/pre-commit.sh b/hooks/pre-commit.sh
index 9d677e9..8e05a4e 100644
--- a/hooks/pre-commit.sh
+++ b/hooks/pre-commit.sh
@@ -20,7 +20,8 @@ tg_util
 if head_=$(git symbolic-ref -q HEAD); then
 	case "$head_" in
 		refs/heads/*)
-			git rev-parse -q --verify "refs/top-bases${head_#refs/heads}" >/dev/null || exit 0;;
+			head_="${head_#refs/heads/}"
+			git rev-parse -q --verify "refs/top-bases/$head_" >/dev/null || exit 0;;
 		*)
 			exit 0;;
 	esac
@@ -35,4 +36,29 @@ fi
 [ -s "$root_dir/.topmsg" ] ||
 	die ".topmsg is missing"
 
-# TODO: Verify .topdeps for valid branch names and against cycles
+check_cycle_name()
+{
+	[ "$head_" != "$_dep" ] ||
+		die "TopGit dependencies form a cycle: perpetrator is $_name"
+}
+
+# only check newly added deps
+# check if a path exists to the current HEAD
+git diff --cached "$root_dir/.topdeps" |
+	awk '
+BEGIN      { in_hunk = 0; }
+/^@@ /     { in_hunk = 1; }
+/^\+/      { if (in_hunk == 1) printf("%s\n", substr($0, 2)); }
+/^[^@ +-]/ { in_hunk = 0; }
+' |
+	while read newly_added; do
+		# deps can be non-tgish but we can't run recurse_deps() on them
+		ref_exists "refs/top-bases/$newly_added" ||
+			continue
+		# recurse_deps uses dfs but takes the .topdeps from the tree,
+		# therefor no infty-loop in the cycle-check
+		no_remotes=1 recurse_deps check_cycle_name "$newly_added"
+	done
+
+
+# TODO: Verify .topdeps for valid branch names
-- 
tg: (99f2ef6..) bw/check-for-dep-cycle (depends on: master)
