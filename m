From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] unpack-trees: don't update files with CE_WT_REMOVE set
Date: Tue, 21 Jul 2015 13:52:07 -0700
Message-ID: <xmqqlhe9ters.fsf@gitster.dls.corp.google.com>
References: <xmqqk2ty1reo.fsf@gitster.dls.corp.google.com>
	<1437167967-5933-1-git-send-email-dturner@twopensource.com>
	<20150718083719.GA19676@lanh>
	<xmqqpp3pyxh0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	Anatole Shaw <git-devel@omni.poc.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 22:52:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHeWN-0002CK-Bi
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 22:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755810AbbGUUwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 16:52:11 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34697 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285AbbGUUwK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 16:52:10 -0400
Received: by pacan13 with SMTP id an13so127252007pac.1
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 13:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=1w9Ua5qu5FZ2KEvHszTZYx39I45trTKqWaWCZka1OVk=;
        b=Y6C5a0sa6FaXNCaH7MwmJptFAo1wPpr6vovU0i9v1AECOnP2pttu4+x9EPIL72Bdya
         2b5WHtaFqBVCU4TBYbU06ZsAfTrNOuKRuev0X6ZHdu75CrMnHuWVem6Mhhih+/IXhtEh
         /ugUThSSKVSzq0Kqy5IsN5V/oN60ZIcPSe1yeiin3UogeWPdvifM3V1LQ23v3kFWZd3b
         kMcAZHwEF67znzFC5AkP8zHJVAWatVIBfwgK0Qz0oUE5BYJL5dpkAqLs1hZfx+pjfYwm
         gZMLVpNhHQBnpwenfCHBjWIML/wKOMs4Du6ABP2QFjsuLV+v++ocu9AnvnCU6u8Pt1To
         JmhQ==
X-Received: by 10.70.32.66 with SMTP id g2mr77650516pdi.82.1437511929508;
        Tue, 21 Jul 2015 13:52:09 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3977:fdee:723a:a723])
        by smtp.gmail.com with ESMTPSA id u8sm29134515pdj.46.2015.07.21.13.52.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 21 Jul 2015 13:52:08 -0700 (PDT)
In-Reply-To: <xmqqpp3pyxh0.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Sat, 18 Jul 2015 14:20:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274418>

Junio C Hamano <gitster@pobox.com> writes:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>> Thank you both for catching this. Just a small suggestion. Perhaps we
>> should do this instead. apply_sparse_checkout() is the function where
>> all "action" manipulation (add, delete, update files..) for sparse
>> checkout occurs and it should not ask to delete and update both at the
>> same time.
>
> Sounds good.  The first hunk may merely be a noise, but the second
> one is the true bugfix for the issue observed, I think.

I've replaced as/sparse-checkout-removal with the following.

Thanks, all.

-- >8 --
From: David Turner <dturner@twopensource.com>
Date: Fri, 17 Jul 2015 17:19:27 -0400
Subject: [PATCH] unpack-trees: don't update files with CE_WT_REMOVE set

Don't update files in the worktree from cache entries which are
flagged with CE_WT_REMOVE.

When a user does a sparse checkout, git removes files that are
marked with CE_WT_REMOVE (because they are out-of-scope for the
sparse checkout). If those files are also marked CE_UPDATE (for
instance, because they differ in the branch that is being checked
out and the outgoing branch), git would previously recreate them.
This patch prevents them from being recreated.

These erroneously-created files would also interfere with merges,
causing pre-merge revisions of out-of-scope files to appear in the
worktree.

apply_sparse_checkout() is the function where all "action"
manipulation (add, delete, update files..) for sparse checkout
occurs; it should not ask to delete and update both at the same
time.

Signed-off-by: Anatole Shaw <git-devel@omni.poc.net>
Signed-off-by: David Turner <dturner@twopensource.com>
Helped-by: Duy Nguyen <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1090-sparse-checkout-scope.sh | 52 ++++++++++++++++++++++++++++++++++++++++
 unpack-trees.c                   |  4 ++++
 2 files changed, 56 insertions(+)
 create mode 100755 t/t1090-sparse-checkout-scope.sh

diff --git a/t/t1090-sparse-checkout-scope.sh b/t/t1090-sparse-checkout-scope.sh
new file mode 100755
index 0000000..1f61eb3
--- /dev/null
+++ b/t/t1090-sparse-checkout-scope.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+
+test_description='sparse checkout scope tests'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo "initial" >a &&
+	echo "initial" >b &&
+	echo "initial" >c &&
+	git add a b c &&
+	git commit -m "initial commit"
+'
+
+test_expect_success 'create feature branch' '
+	git checkout -b feature &&
+	echo "modified" >b &&
+	echo "modified" >c &&
+	git add b c &&
+	git commit -m "modification"
+'
+
+test_expect_success 'perform sparse checkout of master' '
+	git config --local --bool core.sparsecheckout true &&
+	echo "!/*" >.git/info/sparse-checkout &&
+	echo "/a" >>.git/info/sparse-checkout &&
+	echo "/c" >>.git/info/sparse-checkout &&
+	git checkout master &&
+	test_path_is_file a &&
+	test_path_is_missing b &&
+	test_path_is_file c
+'
+
+test_expect_success 'merge feature branch into sparse checkout of master' '
+	git merge feature &&
+	test_path_is_file a &&
+	test_path_is_missing b &&
+	test_path_is_file c &&
+	test "$(cat c)" = "modified"
+'
+
+test_expect_success 'return to full checkout of master' '
+	git checkout feature &&
+	echo "/*" >.git/info/sparse-checkout &&
+	git checkout master &&
+	test_path_is_file a &&
+	test_path_is_file b &&
+	test_path_is_file c &&
+	test "$(cat b)" = "modified"
+'
+
+test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 02f69ae..f177c0e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -227,6 +227,9 @@ static int check_updates(struct unpack_trees_options *o)
 		struct cache_entry *ce = index->cache[i];
 
 		if (ce->ce_flags & CE_UPDATE) {
+			if (ce->ce_flags & CE_WT_REMOVE)
+				die("BUG: both update and delete flags are set on %s",
+				    ce->name);
 			display_progress(progress, ++cnt);
 			ce->ce_flags &= ~CE_UPDATE;
 			if (o->update && !o->dry_run) {
@@ -290,6 +293,7 @@ static int apply_sparse_checkout(struct cache_entry *ce, struct unpack_trees_opt
 		if (!(ce->ce_flags & CE_UPDATE) && verify_uptodate_sparse(ce, o))
 			return -1;
 		ce->ce_flags |= CE_WT_REMOVE;
+		ce->ce_flags &= ~CE_UPDATE;
 	}
 	if (was_skip_worktree && !ce_skip_worktree(ce)) {
 		if (verify_absent_sparse(ce, ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o))
-- 
2.5.0-rc2-392-g7dbe568
