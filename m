Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCE8420323
	for <e@80x24.org>; Thu, 23 Mar 2017 00:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752078AbdCWAnq (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 20:43:46 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36505 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751350AbdCWAnk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 20:43:40 -0400
Received: by mail-pf0-f174.google.com with SMTP id o126so98026167pfb.3
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 17:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3OqgXTmVjgNNIGAVjHqd2CP5Cq2xgeC4weCdLA3vack=;
        b=fyFGrZUrMGe1UfLh4vunk+B3Icz61jvt1YLudZwRy7rtMIySoeBfEirWZg2pHnPv1e
         1x2HwRaq03F09QZJmFtgaQ0h6O7wJSqLCveBKkpaGjio9/J/U9pNVpXAnaslRRqhGGp5
         9ARKKRputK44XbtBETmd8acyUzqApezYTTmeju8ErylMH8j2pCCK2m61L/uiMiunpphL
         LN8rP5I2AogTNq2cKV0pzSjf6SXvCkLJNQ16K2A5TbEBsYBPmD8gJdl7BK/hgSnv493l
         AeXa+kvdLc4QmcZ6eTDW0ShDp2AsEMe7op4CJKiy5pCr+fnpiKakLgL4cEFCWc8Vta/C
         c5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3OqgXTmVjgNNIGAVjHqd2CP5Cq2xgeC4weCdLA3vack=;
        b=cbo7+G9w/K1jEky8z51Pb+yQxwqchl0TBl9IlXHhaV+qbMLPA7DqXi2o6FX0tOOPTP
         OCDOpfDdwInC8VDHP20CrtQ+4G1OFTgutxpTn/R+ffWGu4+rFckeOn2P2HJR4x8Iq6GO
         TI5EUfAeTAjz5zy7XXBXW9zzJX3/GzRQEpALpSBUdYcZgrTAbZM7Oj69C2W3Z4brNrtG
         b1cVz6Dn3wgb3tA+meJEPirQMx1PqlcjUedO2q019J4NVl9HNVH7iWE3xVPc2p4ucDl4
         jd9iBcBicVgjFS5XDRYsl4zSogyoQpek45YIFWNIw8qPRZVoCQfYfoTWyC7IdhxqUHva
         qm/w==
X-Gm-Message-State: AFeK/H1lSE8afRU3BvC36JlRvqDgeWL07B2ifTByE7urVz/z5iDwjcfN7HpL71WU20cg4btV
X-Received: by 10.84.209.194 with SMTP id y60mr16616898plh.44.1490229818505;
        Wed, 22 Mar 2017 17:43:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:1959:c634:6437:385])
        by smtp.gmail.com with ESMTPSA id g64sm6084962pfc.57.2017.03.22.17.43.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Mar 2017 17:43:37 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/3] short status: improve reporting for submodule changes
Date:   Wed, 22 Mar 2017 17:43:29 -0700
Message-Id: <20170323004329.15892-4-sbeller@google.com>
X-Mailer: git-send-email 2.12.1.432.gfe308fe33c.dirty
In-Reply-To: <20170323004329.15892-1-sbeller@google.com>
References: <20170323004329.15892-1-sbeller@google.com>
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
 Documentation/git-status.txt |  9 +++++++++
 t/t3600-rm.sh                | 18 +++++++++++++-----
 t/t7506-status-submodule.sh  | 24 ++++++++++++++++++++++++
 wt-status.c                  | 13 +++++++++++--
 4 files changed, 57 insertions(+), 7 deletions(-)

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
index 5aa6db584c..b58793448b 100755
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
+	test_cmp expect.modified_untracked actual &&
 	git rm -f submod &&
 	test ! -d submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index d31b34da83..98dff01947 100755
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
2.12.1.432.gfe308fe33c.dirty

