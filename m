Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0956B1FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 23:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753707AbdC1XJq (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 19:09:46 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:34576 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753312AbdC1XJp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 19:09:45 -0400
Received: by mail-it0-f45.google.com with SMTP id y18so30804529itc.1
        for <git@vger.kernel.org>; Tue, 28 Mar 2017 16:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C0M4Ib4Wk2cEJ55RT3Vm5KzAazCzPuPJiljAIPweJYg=;
        b=D43sJiS1iOHFLwOI//eRtIom0bIyTZEgLSQp+MjcpqWWNkdEigC3ARHZIf97i+9u8q
         TCxgtzddf9H+hFS/bJdw+1/BbmAPaD4Kd1pV3onkU86E6z5rBJ08Bww37ILIi16Z/Qdg
         wUZ128PTQcfop7vlK2Y1FG8RNUpsjp1Tr7eb6W74rBn1HAg7msjObN8o6LRaI9BAr/wo
         cefIJtdG8qaL5vvU1xAY1d3+chSQdYlS/yKz0vQViiCeSwqmdD5TzPu+RDOcyPjfzcXi
         n5aDvjVA6ryOyqpURIkmNzYDvQAzNErcpxVl6oM9krn3CRtaVb44CbZvU1qs9J3lWwjd
         C89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C0M4Ib4Wk2cEJ55RT3Vm5KzAazCzPuPJiljAIPweJYg=;
        b=V6S9VQKlNNKsmisRAF0G+2GG4JgH9esKO66l0idKM7hXVppHdaqOJU/AHfIXE4bTZH
         gXhEdmtK6n/1s+rs0WA+1GcjLfgytNfQIh95Ko+2APPol1A/sYJoxxKVIh7jGzUa4bsq
         mtU/gCU+5E15n/4MPHzQ7aUzTmPiRXlIwjw/HlYmiPrkVVQzBH0Li1yqsZpQAboj0rGW
         yGfdXtfjp7hlMRHMwUlh79bj5cqidjOHseo2LNwqXhsx/Ds+rJFJKBpMCyek8kFwzQ/i
         o7LyDi/4DGvccefftDgEQQVUXVERifUPRncCUbEC9cDCDomKHu0V3e8abJuRNgOHm/zw
         zzpg==
X-Gm-Message-State: AFeK/H15zjUrOwwIQ+e2T789qxaSHMxegxyx/Wtjb2resndU/GBAyf5DNgqIHbfQLnGNLa/x
X-Received: by 10.36.40.9 with SMTP id h9mr19070794ith.13.1490742583084;
        Tue, 28 Mar 2017 16:09:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:29b8:aa7b:3641:fc6b])
        by smtp.gmail.com with ESMTPSA id y203sm2776486iod.11.2017.03.28.16.09.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 28 Mar 2017 16:09:42 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] short status: improve reporting for submodule changes
Date:   Tue, 28 Mar 2017 16:09:37 -0700
Message-Id: <20170328230938.9887-2-sbeller@google.com>
X-Mailer: git-send-email 2.12.1.438.g67623a8358
In-Reply-To: <20170328230938.9887-1-sbeller@google.com>
References: <20170325003610.15282-1-sbeller@google.com>
 <20170328230938.9887-1-sbeller@google.com>
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
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-status.txt |   9 ++++
 t/t3600-rm.sh                |  18 +++++---
 t/t7506-status-submodule.sh  | 102 +++++++++++++++++++++++++++++++++++++++++++
 wt-status.c                  |  17 +++++++-
 4 files changed, 139 insertions(+), 7 deletions(-)

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
index 51f8d0d034..fd057751df 100755
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
@@ -287,4 +311,82 @@ test_expect_success 'diff --submodule with merge conflict in .gitmodules' '
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
+	echo "{ \$7=\"HASH\"; \$8=\"HASH\"; print }" >suppress_hashes.awk &&
+	echo "suppress_hashes.awk" >>.git/info/exclude &&
+	echo "output2" >>.git/info/exclude &&
+	echo content >super/sub1/sub2/file &&
+	echo content >super/sub2/file
+'
+
+test_expect_success 'status with untracked file in nested submodule (porcelain)' '
+	git -C super status --porcelain >output &&
+	diff output - <<-\EOF
+	 M sub1
+	 M sub2
+	EOF
+'
+
+test_expect_success 'status with untracked file in nested submodule (porcelain=2)' '
+	git -C super status --porcelain=2 >output &&
+	awk -f suppress_hashes.awk output >output2 &&
+	diff output2 - <<-\EOF
+	1 .M S.M. 160000 160000 160000 HASH HASH sub1
+	1 .M S..U 160000 160000 160000 HASH HASH sub2
+	EOF
+'
+
+test_expect_success 'status with untracked file in nested submodule (short)' '
+	git -C super status --short >output &&
+	diff output - <<-\EOF
+	 m sub1
+	 ? sub2
+	EOF
+'
+
+test_expect_success 'setup superproject with modified file in nested submodule' '
+	git -C super/sub1/sub2 add file &&
+	git -C super/sub2 add file
+'
+
+test_expect_success 'status with added file in nested submodule (porcelain)' '
+	git -C super status --porcelain >output &&
+	diff output - <<-\EOF
+	 M sub1
+	 M sub2
+	EOF
+'
+
+test_expect_success 'status with added file in nested submodule (porcelain=2)' '
+	git -C super status --porcelain=2 >output &&
+	awk -f suppress_hashes.awk output >output2 &&
+	diff output2 - <<-\EOF
+	1 .M S.M. 160000 160000 160000 HASH HASH sub1
+	1 .M S.M. 160000 160000 160000 HASH HASH sub2
+	EOF
+'
+
+test_expect_success 'status with added file in nested submodule (short)' '
+	git -C super status --short >output &&
+	diff output - <<-\EOF
+	 m sub1
+	 m sub2
+	EOF
+'
+
 test_done
diff --git a/wt-status.c b/wt-status.c
index 308cf3779e..0375484962 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -407,6 +407,16 @@ static void wt_longstatus_print_change_data(struct wt_status *s,
 	strbuf_release(&twobuf);
 }
 
+static char short_submodule_status(struct wt_status_change_data *d) {
+	if (d->new_submodule_commits)
+		return 'M';
+	if (d->dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
+		return 'm';
+	if (d->dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
+		return '?';
+	return d->worktree_status;
+}
+
 static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
 					 struct diff_options *options,
 					 void *data)
@@ -431,10 +441,13 @@ static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
 		}
 		if (!d->worktree_status)
 			d->worktree_status = p->status;
-		d->dirty_submodule = p->two->dirty_submodule;
-		if (S_ISGITLINK(p->two->mode))
+		if (S_ISGITLINK(p->two->mode)) {
+			d->dirty_submodule = p->two->dirty_submodule;
 			d->new_submodule_commits = !!oidcmp(&p->one->oid,
 							    &p->two->oid);
+			if (s->status_format == STATUS_FORMAT_SHORT)
+				d->worktree_status = short_submodule_status(d);
+		}
 
 		switch (p->status) {
 		case DIFF_STATUS_ADDED:
-- 
2.12.1.438.g67623a8358

