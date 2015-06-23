From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: fix adding new files on i-t-a entries
Date: Tue, 23 Jun 2015 10:37:15 -0700
Message-ID: <xmqqh9pye378.fsf@gitster.dls.corp.google.com>
References: <CACfKtTAvH7FH2AkC5hUNFEQ620gF401SNYaULLy62iE8S55-7A@mail.gmail.com>
	<1435062855-26274-1-git-send-email-pclouds@gmail.com>
	<xmqqoak6e5dx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, phiggins@google.com, snoksrud@gmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 19:37:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7S8R-0004gS-DC
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 19:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754859AbbFWRhT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 13:37:19 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:33131 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754761AbbFWRhR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 13:37:17 -0400
Received: by ieqy10 with SMTP id y10so16809947ieq.0
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 10:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=whnqluL8QLEZUHMvAebzLV0EZkru8L1/wIv082icBzI=;
        b=j5QbbD0UgalvTIhVYPd+GBrgqd0Uvz0NlyntA5mDDeMuS7XcHc/Bqwj9zhXE6Nk8x+
         PEfv50m7MF3uQKrmjRVyuw1oC2tcw9/hDMIrETs4R9slJVEOTtH04ORTuNm088NjUfz2
         TUIJdYvaZfuEDnT0pj69XZLEd7+oTEc/DLy17waooMUzDQt7TiGAUH/QV2mMIhW7GBDM
         GrW5g/y97kCN13DIfkBgjM97NVNkYlZ2dmaa1PMRJaKrKAAjuDJCKIeQFoL915w0iHqP
         1r/ffs9Jlrh1h/4YwOPRBUz73cMD4oulvykZLYreY0BoyyI7/KO5WYuzHtFfIvAnXG7w
         m3vQ==
X-Received: by 10.50.164.233 with SMTP id yt9mr3698796igb.41.1435081036869;
        Tue, 23 Jun 2015 10:37:16 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3c90:65f7:f86b:dfda])
        by mx.google.com with ESMTPSA id ij4sm176185igb.7.2015.06.23.10.37.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 23 Jun 2015 10:37:16 -0700 (PDT)
In-Reply-To: <xmqqoak6e5dx.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 23 Jun 2015 09:50:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272471>

Junio C Hamano <gitster@pobox.com> writes:

>>  I think I'm opening a can of worms with d95d728....
>
> I cannot offhand convince myself that "apply" is the only casualty;
> assuming it is, I think a reasonable way forward is to keep d95d728
> and adjust "apply" to the new world order.  Otherwise, i.e. if there
> are wider fallouts from d95d728, we may instead want to temporarily
> revert it off from 'master', deal with fallouts to "apply" and other
> things, before resurrecting it.
>
> Anything that internally uses "diff-index" is suspect, I think.
>
> What do others think?  You seem to ...
>
>>  So far blame, rm and checkout-entry and "checkout <paths>" are on my
>>  to-think-or-fix list. But this patch can get in early to fix a real
>>  regression instead of waiting for one big series. A lot more
>>  discussions will be had before that series gets in good shape.
>
> ... think that the damage could be quite extensive, so I am inclined
> to say that we first revert d95d728 before going forward.

Let's do this on 'nd/diff-i-t-a' topic and merge the result
immediately to 'master' for now.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Tue, 23 Jun 2015 10:27:47 -0700
Subject: [PATCH] Revert "diff-lib.c: adjust position of i-t-a entries in diff"

This reverts commit d95d728aba06a34394d15466045cbdabdada58a2.

It turns out that many other commands that need to interact with the
result of running diff-files and diff-index, e.g.  "git apply", "git
rm", etc., need to be adjusted to the new world order it brings in.
For example, it would break this sequence to correct a whitespace
breakage in the parts you changed:

	git add -N file
	git diff --cached file | git apply --cached --whitespace=fix
	git checkout file

In the old world order, "diff" showed a patch to modify an existing
empty file by adding its full contents, and "apply" updated the
index by modifying the existing empty blob (which is what an
Intent-to-Add entry records in the index) with that patch.

In the new world order, "diff" shows a patch to create a new file
with its full contents, but because "apply" thinks that the i-t-a
entry already exists in the index, it refused to accept a creation.

Adjusting "apply" to this new world order is easy, but we need to
assess the extent of the damage to the rest of the system the new
world order brought in before going forward and adjust them all,
after which we can resurrect the commit being reverted here.
---
 builtin/add.c           |  1 -
 diff-lib.c              | 12 ------------
 t/t2203-add-intent.sh   | 23 ++++-------------------
 t/t4011-diff-symlink.sh | 10 ++++------
 4 files changed, 8 insertions(+), 38 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index ee370b0..3390933 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -63,7 +63,6 @@ static void update_callback(struct diff_queue_struct *q,
 		switch (fix_unmerged_status(p, data)) {
 		default:
 			die(_("unexpected diff status %c"), p->status);
-		case DIFF_STATUS_ADDED:
 		case DIFF_STATUS_MODIFIED:
 		case DIFF_STATUS_TYPE_CHANGED:
 			if (add_file_to_index(&the_index, path, data->flags)) {
diff --git a/diff-lib.c b/diff-lib.c
index 714501a..a85c497 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -212,11 +212,6 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 					       ce->sha1, !is_null_sha1(ce->sha1),
 					       ce->name, 0);
 				continue;
-			} else if (ce->ce_flags & CE_INTENT_TO_ADD) {
-				diff_addremove(&revs->diffopt, '+', ce->ce_mode,
-					       EMPTY_BLOB_SHA1_BIN, 0,
-					       ce->name, 0);
-				continue;
 			}
 
 			changed = match_stat_with_submodule(&revs->diffopt, ce, &st,
@@ -381,13 +376,6 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 	struct rev_info *revs = o->unpack_data;
 	int match_missing, cached;
 
-	/* i-t-a entries do not actually exist in the index */
-	if (idx && (idx->ce_flags & CE_INTENT_TO_ADD)) {
-		idx = NULL;
-		if (!tree)
-			return;	/* nothing to diff.. */
-	}
-
 	/* if the entry is not checked out, don't examine work tree */
 	cached = o->index_only ||
 		(idx && ((idx->ce_flags & CE_VALID) || ce_skip_worktree(idx)));
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 7c641bf..2a4a749 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -5,24 +5,10 @@ test_description='Intent to add'
 . ./test-lib.sh
 
 test_expect_success 'intent to add' '
-	test_commit 1 &&
-	git rm 1.t &&
-	echo hello >1.t &&
 	echo hello >file &&
 	echo hello >elif &&
 	git add -N file &&
-	git add elif &&
-	git add -N 1.t
-'
-
-test_expect_success 'git status' '
-	git status --porcelain | grep -v actual >actual &&
-	cat >expect <<-\EOF &&
-	DA 1.t
-	A  elif
-	 A file
-	EOF
-	test_cmp expect actual
+	git add elif
 '
 
 test_expect_success 'check result of "add -N"' '
@@ -57,8 +43,7 @@ test_expect_success 'i-t-a entry is simply ignored' '
 	git add -N nitfol &&
 	git commit -m second &&
 	test $(git ls-tree HEAD -- nitfol | wc -l) = 0 &&
-	test $(git diff --name-only HEAD -- nitfol | wc -l) = 0 &&
-	test $(git diff --name-only -- nitfol | wc -l) = 1
+	test $(git diff --name-only HEAD -- nitfol | wc -l) = 1
 '
 
 test_expect_success 'can commit with an unrelated i-t-a entry in index' '
@@ -87,13 +72,13 @@ test_expect_success 'cache-tree invalidates i-t-a paths' '
 	: >dir/bar &&
 	git add -N dir/bar &&
 	git diff --cached --name-only >actual &&
-	>expect &&
+	echo dir/bar >expect &&
 	test_cmp expect actual &&
 
 	git write-tree >/dev/null &&
 
 	git diff --cached --name-only >actual &&
-	>expect &&
+	echo dir/bar >expect &&
 	test_cmp expect actual
 '
 
diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index 7452fce..13e7f62 100755
--- a/t/t4011-diff-symlink.sh
+++ b/t/t4011-diff-symlink.sh
@@ -139,13 +139,11 @@ test_expect_success SYMLINKS 'setup symlinks with attributes' '
 test_expect_success SYMLINKS 'symlinks do not respect userdiff config by path' '
 	cat >expect <<-\EOF &&
 	diff --git a/file.bin b/file.bin
-	new file mode 100644
-	index 0000000..d95f3ad
-	Binary files /dev/null and b/file.bin differ
+	index e69de29..d95f3ad 100644
+	Binary files a/file.bin and b/file.bin differ
 	diff --git a/link.bin b/link.bin
-	new file mode 120000
-	index 0000000..dce41ec
-	--- /dev/null
+	index e69de29..dce41ec 120000
+	--- a/link.bin
 	+++ b/link.bin
 	@@ -0,0 +1 @@
 	+file.bin
-- 
2.4.4-598-g4ab0ce8
