From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2] am --skip/--abort: merge HEAD/ORIG_HEAD tree into index
Date: Wed, 19 Aug 2015 16:22:22 +0800
Message-ID: <20150819082222.GA27685@potato.chippynet.com>
References: <CA+55aFwDkQAS8ULiLt9N5NVOYJ242Nd2MOWeiRX8HrVHXf2zog@mail.gmail.com>
 <CA+55aFwwD=K-i9d40N5FtnTLT-ApZOzmgnXhnuA=C0zw2eBt3Q@mail.gmail.com>
 <03631611149f05dbcd862b4c1e8e9d6b@www.dscho.org>
 <20150817094819.GA10375@yoshi.chippynet.com>
 <xmqqsi7hd817.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 10:22:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRydn-0003zP-52
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 10:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814AbbHSIWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 04:22:30 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35803 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752407AbbHSIW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 04:22:28 -0400
Received: by pacgr6 with SMTP id gr6so152463077pac.2
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 01:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NbHFFEuz0xYuQY0qiCQNe0XShS0SkWIgYvdcnr9SmS4=;
        b=MajYp9QMmw35iQqkf0zo/DN0bcRiSbZmO65unla8zJmr+O7VnNX86IY9OywiNC78Fq
         63dCWo3NlOhA+9nrKX28/9GQL3Mmkqrx18byMc9LrlBFbKi8GEzGhAEA0s1uGRBPDl6w
         rkzAWuOLEFYPxuvWrinroS1F9v+sGY/6B1VtHlpj4lbh88ei8595oxuGU0jU3LHgMiu8
         fXKr2XBXBlvQoN5P70PZ20SWSI5KB7Oa1aKLAb7z1wNde/yga1PL+92UlZQ/YOb+esUM
         iuHy5AjswjFsWR8oTLNFWoH4VFynuy3B6Z0TFtTGLgfWzInPNO+FI23NF6M71+MJg5Co
         oAWw==
X-Received: by 10.68.166.97 with SMTP id zf1mr22299848pbb.72.1439972547830;
        Wed, 19 Aug 2015 01:22:27 -0700 (PDT)
Received: from potato.chippynet.com (nusnet-228-5.dynip.nus.edu.sg. [137.132.228.5])
        by smtp.gmail.com with ESMTPSA id y8sm12898175pbt.7.2015.08.19.01.22.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Aug 2015 01:22:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqsi7hd817.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276164>

On Mon, Aug 17, 2015 at 12:33:40PM -0700, Junio C Hamano wrote:
> Have you checked how this change affects that codepath?  To put it
> differently, does "am skip" have the same issue without this fix?

Hmm, I adopted Dscho's test to run "git am --skip" and it did not fail.
I think it's because am_skip() calls am_run(), which calls
refresh_cache(), so the resulting index will have the updated stat info.
However, there should still be a performance penalty because
refresh_cache() would have to scan all files for changes.

> If so, I wonder if we can have a test for that, too?

So yeah, we should have a test for that too.

(In addition, I fixed a small mistake with the "struct tree_desc" array
size.)

Thanks,
Paul

-- >8 --
Subject: [PATCH v2] am --skip/--abort: merge HEAD/ORIG_HEAD tree into index

After running "git am --abort", and then running "git reset --hard",
files that were not modified would still be re-checked out.

This is because clean_index() in builtin/am.c mistakenly called the
read_tree() function, which overwrites all entries in the index,
including the stat info.

"git am --skip" did not seem to have this issue because am_skip() called
am_run(), which called refresh_cache() to update the stat info. However,
there's still a performance penalty as the lack of stat info meant that
refresh_cache() would have to scan all files for changes.

Fix this by using unpack_trees() instead to merge the tree into the
index, so that the stat info from the index is kept.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c        | 49 ++++++++++++++++++++++++++++++++++++-------------
 t/t4151-am-abort.sh | 24 ++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 13 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 1399c8d..3e7e66f 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1940,15 +1940,48 @@ static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
 }
 
 /**
+ * Merges a tree into the index. The index's stat info will take precedence
+ * over the merged tree's. Returns 0 on success, -1 on failure.
+ */
+static int merge_tree(struct tree *tree)
+{
+	struct lock_file *lock_file;
+	struct unpack_trees_options opts;
+	struct tree_desc t[1];
+
+	if (parse_tree(tree))
+		return -1;
+
+	lock_file = xcalloc(1, sizeof(struct lock_file));
+	hold_locked_index(lock_file, 1);
+
+	memset(&opts, 0, sizeof(opts));
+	opts.head_idx = 1;
+	opts.src_index = &the_index;
+	opts.dst_index = &the_index;
+	opts.merge = 1;
+	opts.fn = oneway_merge;
+	init_tree_desc(&t[0], tree->buffer, tree->size);
+
+	if (unpack_trees(1, t, &opts)) {
+		rollback_lock_file(lock_file);
+		return -1;
+	}
+
+	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
+		die(_("unable to write new index file"));
+
+	return 0;
+}
+
+/**
  * Clean the index without touching entries that are not modified between
  * `head` and `remote`.
  */
 static int clean_index(const unsigned char *head, const unsigned char *remote)
 {
-	struct lock_file *lock_file;
 	struct tree *head_tree, *remote_tree, *index_tree;
 	unsigned char index[GIT_SHA1_RAWSZ];
-	struct pathspec pathspec;
 
 	head_tree = parse_tree_indirect(head);
 	if (!head_tree)
@@ -1973,18 +2006,8 @@ static int clean_index(const unsigned char *head, const unsigned char *remote)
 	if (fast_forward_to(index_tree, remote_tree, 0))
 		return -1;
 
-	memset(&pathspec, 0, sizeof(pathspec));
-
-	lock_file = xcalloc(1, sizeof(struct lock_file));
-	hold_locked_index(lock_file, 1);
-
-	if (read_tree(remote_tree, 0, &pathspec)) {
-		rollback_lock_file(lock_file);
+	if (merge_tree(remote_tree))
 		return -1;
-	}
-
-	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
-		die(_("unable to write new index file"));
 
 	remove_branch_state();
 
diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index 05bdc3e..ea5ace9 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -168,4 +168,28 @@ test_expect_success 'am --abort on unborn branch will keep local commits intact'
 	test_cmp expect actual
 '
 
+test_expect_success 'am --skip leaves index stat info alone' '
+	git checkout -f --orphan skip-stat-info &&
+	git reset &&
+	test_commit skip-should-be-untouched &&
+	test-chmtime =0 skip-should-be-untouched.t &&
+	git update-index --refresh &&
+	git diff-files --exit-code --quiet &&
+	test_must_fail git am 0001-*.patch &&
+	git am --skip &&
+	git diff-files --exit-code --quiet
+'
+
+test_expect_success 'am --abort leaves index stat info alone' '
+	git checkout -f --orphan abort-stat-info &&
+	git reset &&
+	test_commit abort-should-be-untouched &&
+	test-chmtime =0 abort-should-be-untouched.t &&
+	git update-index --refresh &&
+	git diff-files --exit-code --quiet &&
+	test_must_fail git am 0001-*.patch &&
+	git am --abort &&
+	git diff-files --exit-code --quiet
+'
+
 test_done
-- 
2.5.0
