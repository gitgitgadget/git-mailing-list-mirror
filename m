Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81A8420958
	for <e@80x24.org>; Thu, 23 Mar 2017 21:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756716AbdCWVJw (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 17:09:52 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:36405 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935922AbdCWVJm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 17:09:42 -0400
Received: by mail-pg0-f50.google.com with SMTP id g2so129053886pge.3
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 14:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UNNxWQj+Ecdw5cTZMrsANyzP65ga+E0QOsL8z1U//LA=;
        b=VfbKbR1oMtJt2bFY33KOUe2nvXmppuolnmxSmOyznWfdEf2nG/u2OZeRasJ9g1BXlI
         Qd2p1KSR/6zo5Xchb9dfS7HeP3MtPzzHrEyO4FqTgibkN9/K+v2upEtVug+2gmqGw36n
         xuMLQZN7bjFmTYK5BUInQzMmB/9+0cKAbHabdWQvtXNdIKxJb2vHBE/3r/vkNd1uo/2V
         gLJUsPK5Xi8neoVcoPwVl08cGS5n3Ho/ChqAbUeEe5jiK5N9XD+1N0inPF7cMyXN4OM9
         W4xZ1B6NuVvaD+I5wC/NQCAH77nsreQM/NcfrN1p/1Fjscz4gbNVIHaCT6V687cANF7h
         sdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UNNxWQj+Ecdw5cTZMrsANyzP65ga+E0QOsL8z1U//LA=;
        b=FSHjwODbXshrfbOBL7pp5t4Cj9Z+H4ERq/CxbtOYfJ5sI+Qa8cmFO/cVs6wPVb+Lma
         yZ10YYolNiTdWFVU4AUcARQBhQF9q1clPrE1RQRpfdwai3cq7KpemAbvS8dFLu6sE/D7
         V8LWBdRnLySNDQ8ouYueeLkK37vHo1q9lbtL73Nmt4/wdQalORTnILP6GOWGlmepxKsH
         S8e3Y4pNn3iPKcbL1LN2JvwlAd37rKc5YqP6kpuX8RqzmJn4tzScIHKgAvg0Ta3kfP4l
         flyJK44bCzAvchHtMjxXbL7sgQWGEpfrBqLcKXR1D9/EOOdk0eBpn04vPMdbw75NeObX
         Yf9Q==
X-Gm-Message-State: AFeK/H0k9rY+5nmsU9nrsBEgXdtwxXsCjUmQ3z0i3jxHDvorkORqA7MDnlkUJOlndkYh9bzN
X-Received: by 10.99.175.7 with SMTP id w7mr5159695pge.170.1490303375420;
        Thu, 23 Mar 2017 14:09:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c402:7caa:e939:6e82])
        by smtp.gmail.com with ESMTPSA id g75sm173449pfj.107.2017.03.23.14.09.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 14:09:34 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 7/8] short status: improve reporting for submodule changes
Date:   Thu, 23 Mar 2017 14:09:23 -0700
Message-Id: <20170323210924.26818-8-sbeller@google.com>
X-Mailer: git-send-email 2.12.1.438.gb674c4c09c
In-Reply-To: <20170323210924.26818-1-sbeller@google.com>
References: <20170323004329.15892-1-sbeller@google.com>
 <20170323210924.26818-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If I add an untracked file to a submodule or modify a tracked file,
currently "git status --short" treats the change in the same way as
changes to the current HEAD of the submodule:

        $ git clone --quiet --recurse-submodules https://gerrit.googlesource.com/gerrit
        $ echo hello >gerrit/plugins/replication/stray-file
        $ sed -i -e 's/.*//' gerrit/plugins/replication/.mailmap
        $ git -C gerrit status --short
         M plugins/replication

This is by analogy with ordinary files, where "M" represents a change
that has not been added yet to the index.  But this change cannot be
added to the index without entering the submodule, "git add"-ing it,
and running "git commit", so the analogy is counterproductive.

Introduce new status letters " ?" and " m" for this.  These are similar
to the existing "??" and " M" but mean that the submodule (not the
parent project) has new untracked files and modified files, respectively.
The user can use "git add" and "git commit" from within the submodule to
add them.

Changes to the submodule's HEAD commit can be recorded in the index with
a plain "git add -u" and are shown with " M", like today.

To avoid excessive clutter, show at most one of " ?", " m", and " M" for
the submodule.  They represent increasing levels of change --- the last
one that applies is shown (e.g., " m" if there are both modified files
and untracked files in the submodule, or " M" if the submodule's HEAD
has been modified and it has untracked files).

While making these changes, we need to make sure to not break porcelain
level 1, which shares code with "status --short".  We only change
"git status --short".

Non-short "git status" and "git status --porcelain=2" already handle
these cases by showing more detail:

        $ git -C gerrit status --porcelain=2
        1 .M S.MU 160000 160000 160000 305c864db28eb0c77c8499bc04c87de3f849cf3c 305c864db28eb0c77c8499bc04c87de3f849cf3c plugins/replication
        $ git -C gerrit status
[...]
        modified:   plugins/replication (modified content, untracked content)

Scripts caring about these distinctions should use --porcelain=2.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-status.txt |  9 +++++++
 t/t3600-rm.sh                | 18 ++++++++++----
 t/t7506-status-submodule.sh  | 57 ++++++++++++++++++++++++++++++++++++++++++++
 wt-status.c                  | 13 ++++++++--
 4 files changed, 90 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index ba873657cf..01b457c322 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -181,6 +181,13 @@ in which case `XY` are `!!`.
     !           !    ignored
     -------------------------------------------------
 
+Submodules have more state and instead report
+		M    the submodule has a different HEAD than
+		     recorded in the index
+		m    the submodule has modified content
+		?    the submodule has untracked files
+
+
 If -b is used the short-format status is preceded by a line
 
     ## branchname tracking info
@@ -210,6 +217,8 @@ field from the first filename).  Third, filenames containing special
 characters are not specially formatted; no quoting or
 backslash-escaping is performed.
 
+Any submodule changes are reported as modified `M` instead of `m` or single `?`.
+
 Porcelain Format Version 2
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 5aa6db584c..a6e5c5bd56 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -268,6 +268,14 @@ cat >expect.modified <<EOF
  M submod
 EOF
 
+cat >expect.modified_inside <<EOF
+ m submod
+EOF
+
+cat >expect.modified_untracked <<EOF
+ ? submod
+EOF
+
 cat >expect.cached <<EOF
 D  submod
 EOF
@@ -421,7 +429,7 @@ test_expect_success 'rm of a populated submodule with modifications fails unless
 	test -d submod &&
 	test -f submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
-	test_cmp expect.modified actual &&
+	test_cmp expect.modified_inside actual &&
 	git rm -f submod &&
 	test ! -d submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
@@ -436,7 +444,7 @@ test_expect_success 'rm of a populated submodule with untracked files fails unle
 	test -d submod &&
 	test -f submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
-	test_cmp expect.modified actual &&
+	test_cmp expect.modified_untracked actual &&
 	git rm -f submod &&
 	test ! -d submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
@@ -621,7 +629,7 @@ test_expect_success 'rm of a populated nested submodule with different nested HE
 	test -d submod &&
 	test -f submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
-	test_cmp expect.modified actual &&
+	test_cmp expect.modified_inside actual &&
 	git rm -f submod &&
 	test ! -d submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
@@ -636,7 +644,7 @@ test_expect_success 'rm of a populated nested submodule with nested modification
 	test -d submod &&
 	test -f submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
-	test_cmp expect.modified actual &&
+	test_cmp expect.modified_inside actual &&
 	git rm -f submod &&
 	test ! -d submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
@@ -651,7 +659,7 @@ test_expect_success 'rm of a populated nested submodule with nested untracked fi
 	test -d submod &&
 	test -f submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
-	test_cmp expect.modified actual &&
+	test_cmp expect.modified_inside actual &&
 	git rm -f submod &&
 	test ! -d submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index d31b34da83..ad46384064 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -50,6 +50,15 @@ test_expect_success 'status with modified file in submodule (porcelain)' '
 	EOF
 '
 
+test_expect_success 'status with modified file in submodule (short)' '
+	(cd sub && git reset --hard) &&
+	echo "changed" >sub/foo &&
+	git status --short >output &&
+	diff output - <<-\EOF
+	 m sub
+	EOF
+'
+
 test_expect_success 'status with added file in submodule' '
 	(cd sub && git reset --hard && echo >foo && git add foo) &&
 	git status >output &&
@@ -64,6 +73,14 @@ test_expect_success 'status with added file in submodule (porcelain)' '
 	EOF
 '
 
+test_expect_success 'status with added file in submodule (short)' '
+	(cd sub && git reset --hard && echo >foo && git add foo) &&
+	git status --short >output &&
+	diff output - <<-\EOF
+	 m sub
+	EOF
+'
+
 test_expect_success 'status with untracked file in submodule' '
 	(cd sub && git reset --hard) &&
 	echo "content" >sub/new-file &&
@@ -83,6 +100,13 @@ test_expect_success 'status with untracked file in submodule (porcelain)' '
 	EOF
 '
 
+test_expect_success 'status with untracked file in submodule (short)' '
+	git status --short >output &&
+	diff output - <<-\EOF
+	 ? sub
+	EOF
+'
+
 test_expect_success 'status with added and untracked file in submodule' '
 	(cd sub && git reset --hard && echo >foo && git add foo) &&
 	echo "content" >sub/new-file &&
@@ -271,4 +295,37 @@ test_expect_success 'diff --submodule with merge conflict in .gitmodules' '
 	test_cmp diff_submodule_actual diff_submodule_expect
 '
 
+test_expect_success 'setup superproject with untracked file in nested submodule' '
+	(
+		cd super &&
+		git clean -dfx &&
+		rm .gitmodules &&
+		git submodule add -f ./sub1 &&
+		git submodule add -f ./sub2 &&
+		git commit -a -m "messy merge in superproject" &&
+		(
+			cd sub1 &&
+			git submodule add ../sub2 &&
+			git commit -a -m "add sub2 to sub1"
+		) &&
+		git add sub1 &&
+		git commit -a -m "update sub1 to contain nested sub"
+	) &&
+	echo untracked >super/sub1/sub2/untracked
+'
+
+test_expect_success 'status with untracked file in nested submodule (porcelain)' '
+	git -C super status --porcelain >output &&
+	diff output - <<-\EOF
+	 M sub1
+	EOF
+'
+
+test_expect_success 'status with untracked file in nested submodule (short)' '
+	git -C super status --short >output &&
+	diff output - <<-\EOF
+	 m sub1
+	EOF
+'
+
 test_done
diff --git a/wt-status.c b/wt-status.c
index 308cf3779e..9909fd0e57 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -431,10 +431,19 @@ static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
 		}
 		if (!d->worktree_status)
 			d->worktree_status = p->status;
-		d->dirty_submodule = p->two->dirty_submodule;
-		if (S_ISGITLINK(p->two->mode))
+		if (S_ISGITLINK(p->two->mode)) {
+			d->dirty_submodule = p->two->dirty_submodule;
 			d->new_submodule_commits = !!oidcmp(&p->one->oid,
 							    &p->two->oid);
+			if (s->status_format == STATUS_FORMAT_SHORT) {
+				if (d->new_submodule_commits)
+					d->worktree_status = 'M';
+				else if (d->dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
+					d->worktree_status = 'm';
+				else if (d->dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
+					d->worktree_status = '?';
+			}
+		}
 
 		switch (p->status) {
 		case DIFF_STATUS_ADDED:
-- 
2.12.1.438.gb674c4c09c

