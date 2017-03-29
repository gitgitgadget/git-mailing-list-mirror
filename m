Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F82220958
	for <e@80x24.org>; Wed, 29 Mar 2017 22:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932566AbdC2W0Z (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 18:26:25 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34196 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752944AbdC2W0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 18:26:24 -0400
Received: by mail-pg0-f41.google.com with SMTP id 21so20047628pgg.1
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 15:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1N65EC5KvuiM06tFXK+7z4BxEw/NO4W1W6fgN11tu0Q=;
        b=dm1qNpUohA6kvwiqpryAVV7ziE9vdImaVt+ARKdA2XZGsRJ/ee+Opk+pj7dnbDNkNr
         uPjxNgENsbt3bQO/5u2WEvGyt+w0FliEAPHTGaRzDL501uDmrostjEHck0lF9+OspO/K
         2XhHyGUaXWJd9b9EdCUrXiBtnins9M5f8EDpfCtoBrgflmAA0cosc5otlNRzIyvkCbA9
         lhKN73SZv7GD2qORYal94Alg7v8QnSGCnY7CQ0U8sCCSvOsF/f/CDzc3VSltAvB8m/hg
         WNczgk9GIWef6Z6qK2MADiT+Et8VR0epy2im3MXk+HjYPY4qFTaEc0Z8/LpsSm92mLpz
         fLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1N65EC5KvuiM06tFXK+7z4BxEw/NO4W1W6fgN11tu0Q=;
        b=WEvXIWAo2vLLwmFxM+P6WAGgmavUhLKABHF8xie8Ul/RKOHPOsbf5S2/b5Cpe+L/Mi
         NS2gyHOm/ZeEpyIcakto0Rnj7RUWoTQ3h+iXB0WKj4Ro5xB9OxiAdhjZaEpdFPNw1euf
         8Q0fw7gBDJBwei5aLksgEpwXiNyC78AOhNlS9M564yCHj30TzWzvlTnbJa3jZ2NYCNoV
         j7tUMHo41Y7Bj28XtcCdVyLrWPLXLXslYQu0SA7eFGanXaADeIfu4hzV3LZEvVk837Hz
         F/ld2H5qDxAIc/XEiXEjO7iBUZLxzaEe43GcVPMWVmaV377uPYQKMJsTx/IBCiKNL5KR
         sybA==
X-Gm-Message-State: AFeK/H3bqSsz2V/vOuNxiFF8A98StV3gpisPGDGK98LqvI7sGFs4cfQHUj0uUjBckimfu9aa
X-Received: by 10.99.121.77 with SMTP id u74mr2859621pgc.200.1490826382876;
        Wed, 29 Mar 2017 15:26:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:cc96:1eab:fd67:9864])
        by smtp.gmail.com with ESMTPSA id 73sm235966pfj.31.2017.03.29.15.26.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 29 Mar 2017 15:26:22 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jrnieder@gmail.com, gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] short status: improve reporting for submodule changes
Date:   Wed, 29 Mar 2017 15:26:15 -0700
Message-Id: <20170329222616.11077-2-sbeller@google.com>
X-Mailer: git-send-email 2.12.1.442.ge9452a8fbc
In-Reply-To: <20170329222616.11077-1-sbeller@google.com>
References: <20170328230938.9887-1-sbeller@google.com>
 <20170329222616.11077-1-sbeller@google.com>
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
 Documentation/git-status.txt |  11 ++++
 t/t3600-rm.sh                |  18 +++++--
 t/t7506-status-submodule.sh  | 117 +++++++++++++++++++++++++++++++++++++++++++
 wt-status.c                  |  17 ++++++-
 4 files changed, 156 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index ba873657cf..67f1a910f3 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -181,6 +181,15 @@ in which case `XY` are `!!`.
     !           !    ignored
     -------------------------------------------------
 
+Submodules have more state and instead report
+		M    the submodule has a different HEAD than
+		     recorded in the index
+		m    the submodule has modified content
+		?    the submodule has untracked files
+since modified content or untracked files in a submodule cannot be added
+via `git add` in the superproject to prepare a commit.
+
+
 If -b is used the short-format status is preceded by a line
 
     ## branchname tracking info
@@ -210,6 +219,8 @@ field from the first filename).  Third, filenames containing special
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
index 51f8d0d034..1fa2ff2909 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -17,6 +17,12 @@ test_create_repo_with_commit () {
 	)
 }
 
+sanitize_output () {
+	sed -e "s/$_x40/HASH/" -e "s/$_x40/HASH/" output >output2 &&
+	mv output2 output
+}
+
+
 test_expect_success 'setup' '
 	test_create_repo_with_commit sub &&
 	echo output > .gitignore &&
@@ -50,6 +56,15 @@ test_expect_success 'status with modified file in submodule (porcelain)' '
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
@@ -64,6 +79,14 @@ test_expect_success 'status with added file in submodule (porcelain)' '
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
@@ -83,6 +106,13 @@ test_expect_success 'status with untracked file in submodule (porcelain)' '
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
@@ -287,4 +317,91 @@ test_expect_success 'diff --submodule with merge conflict in .gitmodules' '
 	test_cmp diff_submodule_actual diff_submodule_expect
 '
 
+# We'll setup different cases for further testing:
+# sub1 will contain a nested submodule,
+# sub2 will have an untracked file
+# sub3 will have an untracked repository
+test_expect_success 'setup superproject with untracked file in nested submodule' '
+	(
+		cd super &&
+		git clean -dfx &&
+		rm .gitmodules &&
+		git submodule add -f ./sub1 &&
+		git submodule add -f ./sub2 &&
+		git submodule add -f ./sub1 sub3 &&
+		git commit -a -m "messy merge in superproject" &&
+		(
+			cd sub1 &&
+			git submodule add ../sub2 &&
+			git commit -a -m "add sub2 to sub1"
+		) &&
+		git add sub1 &&
+		git commit -a -m "update sub1 to contain nested sub"
+	) &&
+	echo content >super/sub1/sub2/file &&
+	echo content >super/sub2/file &&
+	git -C super/sub3 clone ../../sub2 untracked_repository
+'
+
+test_expect_success 'status with untracked file in nested submodule (porcelain)' '
+	git -C super status --porcelain >output &&
+	diff output - <<-\EOF
+	 M sub1
+	 M sub2
+	 M sub3
+	EOF
+'
+
+test_expect_success 'status with untracked file in nested submodule (porcelain=2)' '
+	git -C super status --porcelain=2 >output &&
+	sanitize_output output &&
+	diff output - <<-\EOF
+	1 .M S.M. 160000 160000 160000 HASH HASH sub1
+	1 .M S..U 160000 160000 160000 HASH HASH sub2
+	1 .M S..U 160000 160000 160000 HASH HASH sub3
+	EOF
+'
+
+test_expect_success 'status with untracked file in nested submodule (short)' '
+	git -C super status --short >output &&
+	diff output - <<-\EOF
+	 m sub1
+	 ? sub2
+	 ? sub3
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
+	 M sub3
+	EOF
+'
+
+test_expect_success 'status with added file in nested submodule (porcelain=2)' '
+	git -C super status --porcelain=2 >output &&
+	sanitize_output output &&
+	diff output - <<-\EOF
+	1 .M S.M. 160000 160000 160000 HASH HASH sub1
+	1 .M S.M. 160000 160000 160000 HASH HASH sub2
+	1 .M S..U 160000 160000 160000 HASH HASH sub3
+	EOF
+'
+
+test_expect_success 'status with added file in nested submodule (short)' '
+	git -C super status --short >output &&
+	diff output - <<-\EOF
+	 m sub1
+	 m sub2
+	 ? sub3
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
2.12.1.442.ge9452a8fbc

